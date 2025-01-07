codeunit 51154 "Table Code Transferred-Payroll"
{
    // Permissions = TableData TableData52021050=rimd,
    //               TableData TableData52021051=rimd,
    //               TableData TableData52021052=rimd,
    //               TableData TableData52021063=rimd;

    trigger OnRun()
    begin
    end;

    var
        Text001: Label 'Replace existing attachment?';
        Text002: Label 'You have canceled the import process.';
        Text006: Label 'Import Attachment';
        Text007: Label 'All Files (*.*)|*.*';
        Text008: Label 'Error during copying file.';
        gvCurrExchRate: Record "Currency Exchange Rate";
        gvPayrollUtilities: Codeunit "Payroll Posting";
        ObjectType2: Option TableData,"Table","Report","Codeunit","XMLPort",Menusuite,"Page";
        Lines: Record "Payroll Lines";
        BasicAmount: Decimal;
        ThirdRule: Decimal;
        Lines2: Record "Payroll Lines";
        TotalGrossPay: Decimal;
        PayrollLines: Record "Payroll Lines";
        TotalDeduction: Decimal;
        TotalNetPay: Decimal;
        NetPayafterLoan: Decimal;
        Variance: Decimal;
        Employee: Record Employee;
        HRCalendarPeriodRec: Record "HR Calendar Period";
        PayrollLinesRec: Record "Payroll Lines";

    procedure PayrollEntryCalcAmount(var prPayrollEntry: Record "Payroll Entry")
    begin
        prPayrollEntry.Validate(Amount, prPayrollEntry."Rate (LCY)" * prPayrollEntry.Quantity);
        prPayrollEntry.SetHeaderFalse;
    end;

    procedure PayrollEntrySetHeaderFalse(var prPayrollEntry: Record "Payroll Entry")
    var
        Header: Record "Payroll Header";
    begin
        if Header.Get(prPayrollEntry."Payroll ID", prPayrollEntry."Employee No.") then begin
            if Header.Calculated = true then begin
                Header.Calculated := false;
                Header.Modify;
            end;
        end;
    end;

    procedure PayrollEntryShowDimensions(var prPayrollEntry: Record "Payroll Entry")
    var
        PayrollDim: Record "Payroll Dimension";
        PayrollDimensions: Page "Payroll Dimensions";
    begin
        prPayrollEntry.TestField("Entry No.");
        prPayrollEntry.TestField("ED Code");
        prPayrollEntry.TestField("Payroll ID");
        prPayrollEntry.TestField("Employee No.");
        prPayrollEntry.TestField("Payroll Code");

        PayrollDim.SetRange("Table ID", DATABASE::"Payroll Entry");
        PayrollDim.SetRange("Payroll ID", prPayrollEntry."Payroll ID");
        PayrollDim.SetRange("Employee No", prPayrollEntry."Employee No.");
        PayrollDim.SetRange("ED Code", prPayrollEntry."ED Code");
        PayrollDim.SetRange("Payroll Code", prPayrollEntry."Payroll Code");
        PayrollDim.SetRange("Entry No", prPayrollEntry."Entry No.");
        PayrollDimensions.SetTableView(PayrollDim);
        PayrollDimensions.RunModal;
    end;

    procedure PayrollEntryEDCodeValidate(var prPayrollEntry: Record "Payroll Entry"; var xprPayrollEntry: Record "Payroll Entry")
    var
        EDCodeRec: Record "ED Definitions";
        Employee: Record Employee;
        CalcSchemes: Record "Calculation Scheme";
        lvPayrollHdr: Record "Payroll Header";
        lvRoundDirection: Text[1];
        PayrollSetupRec: Record "Payroll Setups";
        LineRate: Decimal;
        PayrollUtilities: Codeunit "Payroll Posting";
    begin
        if EDCodeRec.Get(prPayrollEntry."ED Code") then begin
            prPayrollEntry.Text := EDCodeRec.Description;
            prPayrollEntry."Copy to next" := EDCodeRec."Copy to next";
            prPayrollEntry."Reset Amount" := EDCodeRec."Reset Amount";
        end;

        //Leave allowance control
        if EDCodeRec."Leave Allowance Code" then begin
            HRCalendarPeriodRec.Reset;
            HRCalendarPeriodRec.SetRange(Closed, false);
            if HRCalendarPeriodRec.FindFirst then begin
                PayrollLinesRec.Reset;
                PayrollLinesRec.SetRange("Posting Date", HRCalendarPeriodRec."Start Date", Today);
                PayrollLinesRec.SetRange("ED Code", EDCodeRec."ED Code");
                PayrollLinesRec.SetRange("Employee No.", prPayrollEntry."Employee No.");
                if PayrollLinesRec.FindFirst then
                    Error('Leave Allowance already paid on %1', PayrollLinesRec."Payroll ID");
            end;
        end;
        if prPayrollEntry."Employee No." <> '' then begin
            Employee.Get(prPayrollEntry."Employee No.");
            CalcSchemes.SetRange("Scheme ID", Employee."Calculation Scheme");
            CalcSchemes.SetCurrentKey("Payroll Entry");
            CalcSchemes.SetRange("Payroll Entry", EDCodeRec."ED Code");
            if CalcSchemes."Payroll Entry" = 'LAP TRUST' then
                CalcSchemes.Amount := 0.12 * (50000);

            if not CalcSchemes.Find('-') then
                if not EDCodeRec."System Created" then
                    Error('The ED Code %1 does not exits in the Calculation Scheme %2', EDCodeRec."ED Code", Employee."Calculation Scheme");

            //Direct Overtime Entry
            if EDCodeRec.Get(prPayrollEntry."ED Code") then
                if EDCodeRec."Overtime ED" then begin
                    PayrollSetupRec.Get(prPayrollEntry."Payroll Code");
                    case PayrollSetupRec."Hourly Rate Rounding" of
                        PayrollSetupRec."Hourly Rate Rounding"::None:
                            lvRoundDirection := '=';
                        PayrollSetupRec."Hourly Rate Rounding"::Up:
                            lvRoundDirection := '>';
                        PayrollSetupRec."Hourly Rate Rounding"::Down:
                            lvRoundDirection := '<';
                        PayrollSetupRec."Hourly Rate Rounding"::Nearest:
                            lvRoundDirection := '=';
                    end;

                    lvPayrollHdr.Get(prPayrollEntry."Payroll ID", prPayrollEntry."Employee No.");
                    lvPayrollHdr.TestField("Hour Rate");
                    LineRate := Round(EDCodeRec."Overtime ED Weight" * lvPayrollHdr."Hour Rate",
                      PayrollSetupRec."Hourly Rounding Precision", lvRoundDirection);
                    prPayrollEntry.Validate(Rate, LineRate);
                    //MODIFY;
                end;
            //Direct Overtime Entry
        end;

        //skm310506 Advanced Dimensions
        if (xprPayrollEntry."ED Code" <> prPayrollEntry."ED Code") and (prPayrollEntry."Employee No." <> '') then begin
            PayrollUtilities.sDeleteDefaultEDDims(prPayrollEntry);
            PayrollUtilities.sGetDefaultEDDims(prPayrollEntry);
        end;
    end;

    procedure LookupTableLinesCalcCum(var prLookupTableLine: Record "Lookup Table Lines"; var TableLinesRec: Record "Lookup Table Lines")
    var
        TableLines: Record "Lookup Table Lines";
    begin
        if prLookupTableLine.Percent <> 0 then begin
            TableLines.Copy(TableLinesRec);
            TableLines.SetRange("Table ID", TableLinesRec."Table ID");
            if TableLines.Find('<') then
                prLookupTableLine."Cumulate (LCY)" := TableLines."Cumulate (LCY)" + (((prLookupTableLine."Upper Amount (LCY)" -
                prLookupTableLine."Lower Amount (LCY)") * prLookupTableLine.Percent) / 100)
            else
                prLookupTableLine."Cumulate (LCY)" := (((prLookupTableLine."Upper Amount (LCY)" - prLookupTableLine."Lower Amount (LCY)") * prLookupTableLine.Percent) / 100)
        end;
    end;

    procedure LookupTableLinesCalcCumEthiopia(var prLookupTableLine: Record "Lookup Table Lines"; var TableLinesRec: Record "Lookup Table Lines")
    var
        TableLines: Record "Lookup Table Lines";
    begin
        if prLookupTableLine.Percent <> 0 then begin
            TableLines.Copy(TableLinesRec);
            TableLines.SetRange("Table ID", TableLinesRec."Table ID");
            if TableLines.Find('<') then
                prLookupTableLine."Cumulate (LCY)" := (TableLines."Cumulate (LCY)" +
                                 (((prLookupTableLine."Upper Amount (LCY)" - prLookupTableLine."Lower Amount (LCY)") * prLookupTableLine.Percent) / 100)) -
                                 prLookupTableLine."Relief Amount"
            else
                prLookupTableLine."Cumulate (LCY)" := ((((prLookupTableLine."Upper Amount (LCY)" - prLookupTableLine."Lower Amount (LCY)") * prLookupTableLine.Percent) / 100))
                                  - prLookupTableLine."Relief Amount"
        end;
    end;

    procedure PaySetupImport(var prPayrollSetup: Record "Payroll Setups")
    begin
        prPayrollSetup.CalcFields("KRA Tax Logo");
        if prPayrollSetup."KRA Tax Logo".HasValue then begin
            if not Confirm(Text001, false) then
                exit;
            prPayrollSetup.RemoveAttachment(false);
        end;

        if not prPayrollSetup.ImportAttachment('', false, false) then
            Error(Text002);
    end;

    procedure PaySetupImportAttachment(var prPayrollSetup: Record "Payroll Setups"; ImportFromFile: Text[260]; IsTemporary: Boolean; IsInherited: Boolean): Boolean
    var
        FileName: Text[260];
        AttachmentManagement: Codeunit AttachmentManagement;
        ClientFileName: Text[260];
        NewAttachmentNo: Integer;
        // BLOBRef: Record TempBlob;
        RBAutoMgt: Codeunit "File Management";
        ServerFileName: Text[260];
    begin
        if IsTemporary then begin
            //  FileName := RBAutoMgt.BLOBImport(BLOBRef,ImportFromFile);
            //RBAutoMgt.BLOBImport(BLOBRef,ImportFromFile,ImportFromFile = '' );
            if FileName <> '' then begin
                //  prPayrollSetup."KRA Tax Logo" := BLOBRef.Blob;
                prPayrollSetup."File Extension" := CopyStr(UpperCase(RBAutoMgt.GetExtension(FileName)), 1, 250);
                exit(true);
            end else
                exit(false);
        end;
        ClientFileName := '';

        FileName := ImportFromFile;

        // FileName := RBAutoMgt.BLOBImport(BLOBRef,FileName);
        if FileName = '' then
            exit(false);
        //prPayrollSetup."KRA Tax Logo" := BLOBRef.Blob;
        prPayrollSetup."File Extension" := CopyStr(UpperCase(RBAutoMgt.GetExtension(FileName)), 1, 250);
        if prPayrollSetup.Modify then;
        exit(true);
    end;

    procedure PaySetupExportAttachment(var prPayrollSetup: Record "Payroll Setups"; ExportToFile: Text[1024]): Boolean
    var
        // BLOBRef: Record TempBlob;
        RBAutoMgt: Codeunit "File Management";
        FileName: Text[1024];
        FileFilter: Text[260];
        ClientFileName: Text[1024];
        FileMgt: Codeunit "File Management";
    begin
        ClientFileName := '';
        prPayrollSetup.CalcFields("KRA Tax Logo");
        if prPayrollSetup."KRA Tax Logo".HasValue then begin
            // BLOBRef.Blob := prPayrollSetup."KRA Tax Logo";
            if ExportToFile = '' then begin
                FileName := 'Default.' + prPayrollSetup."File Extension";
                //ExportToFile := FileMgt.BLOBExport(BLOBRef,FileName,true);
            end else begin
                // If a filename is provided, the file will be treated as temp file.
                // ExportToFile := FileMgt.BLOBExport(BLOBRef,ExportToFile,false);
            end;
            exit(true);
        end else
            exit(false)
    end;

    procedure PaySetupRemoveAttachment(var prPayrollSetup: Record "Payroll Setups"; Prompt: Boolean)
    begin
        if prPayrollSetup."KRA Tax Logo".HasValue = false then
            Error('No attachment is attached.');
        if Prompt = true then
            if not Confirm('Remove attachment?') then exit;
        Clear(prPayrollSetup."KRA Tax Logo");
        prPayrollSetup."File Extension" := '';
        if prPayrollSetup.Modify then;
        if Prompt = true then Message('Attachment removed');
    end;

    procedure PaySetupDeleteFile(FileName: Text[260]): Boolean
    var
        I: Integer;
    begin
        if FileName = '' then
            exit(false);

        if IsServiceTier then
            exit(true);

        // if not Exists(FileName) then
        //   exit(true);

        // repeat
        //   Sleep(250);
        //   I := I + 1;
        // until Erase(FileName) or (I = 25);
        // exit(not Exists(FileName));
    end;

    procedure RecurLoanScheduleDebtService(Principal: Decimal; Interest: Decimal; PayPeriods: Integer): Decimal
    var
        PeriodInterest: Decimal;
    begin
        PeriodInterest := Interest / 12 / 100;
        exit(PeriodInterest / (1 - Power((1 + PeriodInterest), -PayPeriods)) * Principal);
    end;

    procedure LoanAdvancesCreateLoan(var prLoanAdvances: Record "Loans/Advances")
    var
        PeriodRec: Record Periods;
    begin
        if prLoanAdvances."Start Period" = '' then
            Error('Start Period must be specified');

        if prLoanAdvances."Loan Types" = '' then
            Error('Loan Type must be specified');


        //Check if will exceed a third Rule
        //Get Basic Pay
        if Employee.Get(prLoanAdvances.Employee) then begin
            Lines.Reset;
            Lines.SetRange("Employee No.", prLoanAdvances.Employee);
            Lines.SetRange("Payroll ID", prLoanAdvances."Start Period");
            Lines.SetRange(Lines."ED Code", 'BASIC');
            if Lines.Find('-') then begin
                BasicAmount := Lines.Amount;
                ThirdRule := Round(BasicAmount * 1 / 3, 1, '>');
            end;

            //Get Gross Pay
            Lines2.Reset;
            Lines2.SetRange(Lines2."Employee No.", prLoanAdvances.Employee);
            Lines2.SetRange(Lines2."Payroll ID", prLoanAdvances."Start Period");
            Lines2.SetRange(Lines2."Calculation Group", Lines2."Calculation Group"::Payments);
            if Lines2.Find('-') then begin
                repeat
                    TotalGrossPay += Lines2.Amount;
                until Lines2.Next = 0;
            end;

            //Get Total Deduction
            PayrollLines.Reset;
            PayrollLines.SetRange(PayrollLines."Employee No.", prLoanAdvances.Employee);
            PayrollLines.SetRange(PayrollLines."Payroll ID", prLoanAdvances."Start Period");
            PayrollLines.SetRange(PayrollLines."Calculation Group", PayrollLines."Calculation Group"::Deduction);
            if PayrollLines.Find('-') then begin
                repeat
                    TotalDeduction += PayrollLines.Amount;
                until PayrollLines.Next = 0;
            end;
            //Get Netpay
            TotalNetPay := TotalGrossPay - TotalDeduction;

            NetPayafterLoan := Round((TotalNetPay - prLoanAdvances."Installment Amount"), 1, '>');
            Variance := Round((ThirdRule - NetPayafterLoan), 1, '>');
            if NetPayafterLoan < ThirdRule then
                Error('This Loan Amount will Violate a Third Rule by %1', Variance);
        end;
        //End
        PeriodRec.SetRange(Status, 0, 1);
        PeriodRec.SetRange("Payroll Code", prLoanAdvances."Payroll Code");
        PeriodRec.Get(prLoanAdvances."Start Period", prLoanAdvances."Period Month", prLoanAdvances."Period Year", prLoanAdvances."Payroll Code");
        if PeriodRec.Status = PeriodRec.Status::Posted then
            Error('Start Period selected is posted');

        if prLoanAdvances.Principal <= 0 then
            Error('Principal must be higher than zero');

        if prLoanAdvances."Paid to Employee" then
            Error('Loan is paid');

        case prLoanAdvances.Type of
            prLoanAdvances.Type::Annuity:
                LoanAdvancesCreateAnnuityLoan(prLoanAdvances);
            prLoanAdvances.Type::Serial:
                prLoanAdvances.CreateSerialLoan();
            prLoanAdvances.Type::Advance:
                prLoanAdvances.CreateSerialLoan();
        //prLoanAdvances.CreateAdvance();
        end;

        prLoanAdvances.Created := true;
        prLoanAdvances.Modify;
    end;

    procedure LoanAdvancesCreateAdvance(var prLoanAdvances: Record "Loans/Advances")
    var
        LoanEntryRec: Record "Loan Entry";
    begin
        LoanEntryRec.SetRange("Loan ID", prLoanAdvances.ID);
        LoanEntryRec.SetRange(Employee, prLoanAdvances.Employee);
        LoanEntryRec.DeleteAll;

        LoanEntryRec."No." := 1;
        LoanEntryRec."Loan ID" := prLoanAdvances.ID;
        LoanEntryRec.Employee := prLoanAdvances.Employee;
        LoanEntryRec.Period := prLoanAdvances."Start Period";
        LoanEntryRec.Interest := 0;
        LoanEntryRec.Repayment := prLoanAdvances.Principal;
        LoanEntryRec."Repayment (LCY)" := prLoanAdvances."Principal (LCY)";
        LoanEntryRec."Transfered To Payroll" := false;
        LoanEntryRec."Remaining Debt" := 0;
        LoanEntryRec.Insert(true);

        prLoanAdvances.Installments := 1;
        prLoanAdvances."Interest Rate" := 0;
        prLoanAdvances."Installment Amount" := prLoanAdvances.Principal;
        prLoanAdvances."Installment Amount (LCY)" := prLoanAdvances."Principal (LCY)";
        prLoanAdvances.Created := true;
        prLoanAdvances.Create := false;
        prLoanAdvances.Modify;
    end;

    procedure LoanAdvancesCreateSerialLoan(var prLoanAdvances: Record "Loans/Advances")
    var
        LoanEntryRec: Record "Loan Entry";
        Periodrec: Record Periods;
        LoanTypeRec: Record "Loan Types";
        LoopEndBool: Boolean;
        LineNoInt: Integer;
        PeriodCode: Code[10];
        InterestAmountDec: Decimal;
        RemainingPrincipalAmountDec: Decimal;
        RepaymentAmountDec: Decimal;
        RoundPrecisionDec: Decimal;
        RoundDirectionCode: Code[10];
    begin
        LoanEntryRec.SetRange("Loan ID", prLoanAdvances.ID);
        LoanEntryRec.SetRange(Employee, prLoanAdvances.Employee);
        LoanEntryRec.DeleteAll;

        if prLoanAdvances.Installments <= 0 then
            Error('Instalments must be specified');

        LoopEndBool := false;

        LineNoInt := 0;
        Periodrec.SetCurrentKey("Start Date");
        Periodrec.SetRange("Payroll Code", prLoanAdvances."Payroll Code");
        Periodrec.Get(prLoanAdvances."Start Period", prLoanAdvances."Period Month", prLoanAdvances."Period Year", prLoanAdvances."Payroll Code");

        LoanTypeRec.Get(prLoanAdvances."Loan Types", prLoanAdvances."Payroll Code");

        case LoanTypeRec.Rounding of
            LoanTypeRec.Rounding::Nearest:
                RoundDirectionCode := '=';
            LoanTypeRec.Rounding::Down:
                RoundDirectionCode := '<';
            LoanTypeRec.Rounding::Up:
                RoundDirectionCode := '>';
        end;

        RoundPrecisionDec := LoanTypeRec."Rounding Precision";
        RemainingPrincipalAmountDec := prLoanAdvances.Principal;
        RepaymentAmountDec := Round(prLoanAdvances.Principal / prLoanAdvances.Installments, RoundPrecisionDec, RoundDirectionCode);


        repeat
            if LineNoInt <> 0 then
                if Periodrec.Find('>') then;
            PeriodCode := Periodrec."Period ID";

            LineNoInt := LineNoInt + 1;

            InterestAmountDec := Round(RemainingPrincipalAmountDec / 12 / 100 * prLoanAdvances."Interest Rate", RoundPrecisionDec, RoundDirectionCode);
            LoanEntryRec."No." := LineNoInt;
            LoanEntryRec."Loan ID" := prLoanAdvances.ID;
            LoanEntryRec.Employee := prLoanAdvances.Employee;
            LoanEntryRec.Period := PeriodCode;
            LoanEntryRec.Interest := InterestAmountDec;
            LoanEntryRec."Interest (LCY)" :=
            // ROUND(InterestAmountDec * "Currency Factor", RoundPrecisionDec, RoundDirectionCode);
            Round(gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, prLoanAdvances."Currency Code", InterestAmountDec, prLoanAdvances."Currency Factor"),
            RoundPrecisionDec, RoundDirectionCode);//MESH

            LoanEntryRec."Calc Benefit Interest" := prLoanAdvances."Calculate Interest Benefit";

            if LineNoInt = prLoanAdvances.Installments then begin
                LoanEntryRec.Repayment := RemainingPrincipalAmountDec;
                LoanEntryRec."Repayment (LCY)" :=
                //  ROUND(RemainingPrincipalAmountDec * "Currency Factor", RoundPrecisionDec, RoundDirectionCode);
                Round(gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, prLoanAdvances."Currency Code", RemainingPrincipalAmountDec, prLoanAdvances."Currency Factor"),
                RoundPrecisionDec, RoundDirectionCode);//MESH

                LoanEntryRec."Remaining Debt" := 0;
                LoanEntryRec."Remaining Debt (LCY)" := 0;
            end else begin
                LoanEntryRec.Repayment := prLoanAdvances."Installment Amount";
                LoanEntryRec."Repayment (LCY)" := prLoanAdvances."Installment Amount (LCY)";
                RemainingPrincipalAmountDec := RemainingPrincipalAmountDec - prLoanAdvances."Installment Amount";
                LoanEntryRec."Remaining Debt" := RemainingPrincipalAmountDec;
                LoanEntryRec."Remaining Debt (LCY)" :=
                //  ROUND(RemainingPrincipalAmountDec * "Currency Factor", RoundPrecisionDec, RoundDirectionCode);
                Round(gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, prLoanAdvances."Currency Code", RemainingPrincipalAmountDec, prLoanAdvances."Currency Factor"),
                RoundPrecisionDec, RoundDirectionCode);//MESH

            end;

            LoanEntryRec.Insert(true);
        until LineNoInt = prLoanAdvances.Installments;

        prLoanAdvances.Created := true;
        prLoanAdvances.Create := false;
        prLoanAdvances.Modify;
    end;

    procedure LoanAdvancesCreateAnnuityLoan(var prLoanAdvances: Record "Loans/Advances")
    var
        LoanEntryRec: Record "Loan Entry";
        Periodrec: Record Periods;
        LoanTypeRec: Record "Loan Types";
        LoopEndBool: Boolean;
        LineNoInt: Integer;
        PeriodCode: Code[10];
        InterestAmountDec: Decimal;
        RemainingPrincipalAmountDec: Decimal;
        RepaymentAmountDec: Decimal;
        RoundPrecisionDec: Decimal;
        RoundDirectionCode: Code[10];
    begin
        LoanEntryRec.SetRange("Loan ID", prLoanAdvances.ID);
        LoanEntryRec.SetRange(Employee, prLoanAdvances.Employee);
        LoanEntryRec.DeleteAll;

        if prLoanAdvances."Installment Amount" <= 0 then
            Error('Instalment Amount must be specified');
        if prLoanAdvances."Installment Amount" > prLoanAdvances.Principal then
            Error('Instalment Amount is higher than Principal');

        LoopEndBool := false;

        LineNoInt := 0;
        Periodrec.SetCurrentKey("Start Date");
        Periodrec.SetRange("Payroll Code", prLoanAdvances."Payroll Code");
        Periodrec.Get(prLoanAdvances."Start Period", prLoanAdvances."Period Month", prLoanAdvances."Period Year", prLoanAdvances."Payroll Code");

        LoanTypeRec.Get(prLoanAdvances."Loan Types", prLoanAdvances."Payroll Code");

        case LoanTypeRec.Rounding of
            LoanTypeRec.Rounding::Nearest:
                RoundDirectionCode := '=';
            LoanTypeRec.Rounding::Down:
                RoundDirectionCode := '<';
            LoanTypeRec.Rounding::Up:
                RoundDirectionCode := '>';
        end;

        RoundPrecisionDec := LoanTypeRec."Rounding Precision";
        RemainingPrincipalAmountDec := prLoanAdvances.Principal;

        repeat
            InterestAmountDec := Round(RemainingPrincipalAmountDec / 100 / 12 * prLoanAdvances."Interest Rate", RoundPrecisionDec, '<');
            if InterestAmountDec >= prLoanAdvances."Installment Amount" then
                Error('This Loan is not possible because\the the instalment Amount must\be higher than %1', InterestAmountDec);

            if LineNoInt <> 0 then
                Periodrec.Find('>');
            PeriodCode := Periodrec."Period ID";

            LineNoInt := LineNoInt + 1;

            LoanEntryRec."No." := LineNoInt;
            LoanEntryRec."Loan ID" := prLoanAdvances.ID;
            LoanEntryRec.Employee := prLoanAdvances.Employee;
            LoanEntryRec.Period := PeriodCode;
            LoanEntryRec.Interest := InterestAmountDec;
            LoanEntryRec."Interest (LCY)" :=
            //  ROUND(InterestAmountDec * "Currency Factor", RoundPrecisionDec, '<');
            Round(gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, prLoanAdvances."Currency Code", InterestAmountDec, prLoanAdvances."Currency Factor"),
              RoundPrecisionDec, '<');//MESH

            LoanEntryRec."Calc Benefit Interest" := prLoanAdvances."Calculate Interest Benefit";

            if (prLoanAdvances."Installment Amount" - InterestAmountDec) >= RemainingPrincipalAmountDec then begin
                LoanEntryRec.Repayment := RemainingPrincipalAmountDec;
                LoanEntryRec."Repayment (LCY)" :=
                //  ROUND(RemainingPrincipalAmountDec * "Currency Factor", RoundPrecisionDec, '<');
                Round(gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, prLoanAdvances."Currency Code", RemainingPrincipalAmountDec, prLoanAdvances."Currency Factor"),
                RoundPrecisionDec, '<');//MESH

                LoanEntryRec."Remaining Debt" := 0;
                LoanEntryRec."Remaining Debt (LCY)" := 0;
                LoopEndBool := true;
            end else begin
                LoanEntryRec.Repayment := prLoanAdvances."Installment Amount" - LoanEntryRec.Interest;
                LoanEntryRec."Repayment (LCY)" := prLoanAdvances."Installment Amount (LCY)" - LoanEntryRec."Interest (LCY)";
                RemainingPrincipalAmountDec := RemainingPrincipalAmountDec - LoanEntryRec.Repayment;
                LoanEntryRec."Remaining Debt" := RemainingPrincipalAmountDec;

                LoanEntryRec."Remaining Debt (LCY)" :=
                //  ROUND(RemainingPrincipalAmountDec * "Currency Factor", RoundPrecisionDec, '<');
                Round(gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, prLoanAdvances."Currency Code", RemainingPrincipalAmountDec, prLoanAdvances."Currency Factor"),
                RoundPrecisionDec, '<');//MESH

            end;

            LoanEntryRec."Transfered To Payroll" := false;
            LoanEntryRec.Insert(true);

            prLoanAdvances.Installments := LineNoInt;
            prLoanAdvances.Modify;
        until LoopEndBool;

        prLoanAdvances.Created := true;
        prLoanAdvances.Create := false;
        prLoanAdvances.Modify;
    end;

    procedure LoanAdvancesPayLoan(var prLoanAdvances: Record "Loans/Advances")
    var
        GenJnlLine: Record "Gen. Journal Line";
        Loansetup: Record "Payroll Setups";
        LoanTypeRec: Record "Loan Types";
        LoanPaymentRec: Record "Loan Payments";
        EmployeeRec: Record Employee;
        PeriodRec: Record Periods;
        HeaderRec: Record "Payroll Header";
        TemplateName: Code[10];
        BatchName: Code[10];
        LineNo: Integer;
    begin
        if prLoanAdvances."Paid to Employee" then Error('The Loan is allready paid');
        if not prLoanAdvances.Created then Error('The Loan is not Created');

        PeriodRec.SetRange("Payroll Code", prLoanAdvances."Payroll Code");
        PeriodRec.Get(prLoanAdvances."Start Period", prLoanAdvances."Period Month", prLoanAdvances."Period Year", prLoanAdvances."Payroll Code");
        if PeriodRec.Status = PeriodRec.Status::Posted then Error('Start Period selected is posted');

        LoanTypeRec.Get(prLoanAdvances."Loan Types", prLoanAdvances."Payroll Code");

        if LoanTypeRec."Finance Source" = LoanTypeRec."Finance Source"::Company then begin
            // prLoanAdvances.TESTFIELD("Payments Method");
            // LoanPaymentRec.GET(prLoanAdvances."Payments Method");
            // LoanPaymentRec.TESTFIELD("Account No.");

            EmployeeRec.Get(prLoanAdvances.Employee);

            Loansetup.Get(prLoanAdvances."Payroll Code");
            Loansetup.TestField("Loan Template");
            Loansetup.TestField("Loan Payments Batch");

            TemplateName := Loansetup."Loan Template";
            BatchName := Loansetup."Loan Payments Batch";

            GenJnlLine.SetRange("Journal Template Name", TemplateName);
            GenJnlLine.SetRange("Journal Batch Name", BatchName);
            if GenJnlLine.Find('+') then
                LineNo := GenJnlLine."Line No."
            else
                LineNo := 0;

            LineNo := LineNo + 10000;
            GenJnlLine."Journal Batch Name" := BatchName;
            GenJnlLine."Journal Template Name" := TemplateName;
            GenJnlLine."Line No." := LineNo;
            GenJnlLine."Document No." := StrSubstNo('%1', prLoanAdvances.ID);
            GenJnlLine.Validate("Posting Date", WorkDate);

            case LoanTypeRec."Loan Accounts Type" of
                LoanTypeRec."Loan Accounts Type"::"G/L Account":
                    begin
                        // LoanTypeRec.TESTFIELD("Loan Account");
                        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"G/L Account");
                        GenJnlLine.Validate("Account No.", LoanTypeRec."Loan Account");
                    end;

                LoanTypeRec."Loan Accounts Type"::Customer:
                    begin
                        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Customer);
                        GenJnlLine.Validate("Account No.", gvPayrollUtilities.fGetEmplyeeLoanAccount(EmployeeRec, LoanTypeRec));
                    end;

                LoanTypeRec."Loan Accounts Type"::Vendor:
                    begin
                        LoanTypeRec.TestField("Loan Account");
                        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Vendor);
                        GenJnlLine.Validate("Account No.", LoanTypeRec."Loan Account");
                    end;
            end; //Case

            GenJnlLine.Description := StrSubstNo('Payment of Loan %1', prLoanAdvances.ID);
            GenJnlLine.Validate(Amount, prLoanAdvances.Principal);

            if LoanPaymentRec."Account Type" = LoanPaymentRec."Account Type"::"G/L Account" then
                GenJnlLine.Validate("Bal. Account Type", GenJnlLine."Bal. Account Type"::"G/L Account")
            else
                GenJnlLine.Validate("Bal. Account Type", GenJnlLine."Bal. Account Type"::"Bank Account");
            GenJnlLine.Validate("Bal. Account No.", LoanPaymentRec."Account No.");

            GenJnlLine.Validate("Shortcut Dimension 1 Code", EmployeeRec."Global Dimension 1 Code");
            GenJnlLine.Validate("Shortcut Dimension 2 Code", EmployeeRec."Global Dimension 2 Code");
            GenJnlLine.UpdateLineBalance;
            GenJnlLine.Insert;
        end;

        prLoanAdvances."Paid to Employee" := true;
        prLoanAdvances.Pay := false;

        prLoanAdvances.Modify;

        if HeaderRec.Get(prLoanAdvances."Start Period", prLoanAdvances.Employee) then begin
            if HeaderRec.Calculated then begin
                HeaderRec.Calculated := false;
                HeaderRec.Modify;
            end;
        end;
    end;

    procedure LoanAdvancesDebtService(Principal: Decimal; Interest: Decimal; PayPeriods: Integer): Decimal
    var
        PeriodInterest: Decimal;
    begin
        PeriodInterest := Interest / 12 / 100;
        exit(PeriodInterest / (1 - Power((1 + PeriodInterest), -PayPeriods)) * Principal);
    end;

    procedure LoanAdvancesCreateLoanfromSchedule(var prLoanAdvances: Record "Loans/Advances")
    var
        PeriodRec: Record Periods;
        lvLoansSchedule: Record "Recurring Loans Schedule";
        lvEmp: Record Employee;
    begin
        lvLoansSchedule.SetRange(Skip, false);
        if not lvLoansSchedule.Find('-') then Error('No valid Recurring Loan Schedule line found.');

        PeriodRec.SetCurrentKey("Start Date");
        PeriodRec.SetRange(Status, PeriodRec.Status::Open);
        PeriodRec.SetRange("Payroll Code", prLoanAdvances."Payroll Code");
        if not PeriodRec.Find('+') then Error('No Open payroll period was found.');

        repeat
            lvLoansSchedule.TestField(Employee);
            lvLoansSchedule.TestField("Loan Types");
            if lvLoansSchedule.Type <> lvLoansSchedule.Type::Advance then lvLoansSchedule.TestField("Interest Rate");
            lvLoansSchedule.TestField(Principal);
            lvLoansSchedule.TestField(Installments);
            lvLoansSchedule.TestField("Payments Method");

            prLoanAdvances.Init;
            prLoanAdvances.ID := 0;
            prLoanAdvances.Validate(Employee, lvLoansSchedule.Employee);
            lvEmp.Get(lvLoansSchedule.Employee);
            prLoanAdvances."First Name" := lvEmp."First Name";
            prLoanAdvances."Last Name" := lvEmp."Last Name";
            prLoanAdvances.Validate("Loan Types", lvLoansSchedule."Loan Types");
            prLoanAdvances.Validate("Interest Rate", lvLoansSchedule."Interest Rate");
            prLoanAdvances.Validate(Principal, lvLoansSchedule.Principal);
            prLoanAdvances."Start Period" := PeriodRec."Period ID";
            prLoanAdvances."Period Month" := PeriodRec."Period Month";
            prLoanAdvances."Period Year" := PeriodRec."Period Year";
            prLoanAdvances.Validate(Installments, lvLoansSchedule.Installments);
            prLoanAdvances."Payments Method" := lvLoansSchedule."Payments Method";
            prLoanAdvances."Type Text" := prLoanAdvances.Description;
            prLoanAdvances.Insert(true);
            Commit;

            case prLoanAdvances.Type of
                prLoanAdvances.Type::Annuity:
                    prLoanAdvances.CreateAnnuityLoan();
                prLoanAdvances.Type::Serial:
                    prLoanAdvances.CreateSerialLoan();
                prLoanAdvances.Type::Advance:
                    prLoanAdvances.CreateAdvance();
            end;
        until lvLoansSchedule.Next = 0;
    end;

    procedure LoanAdvancesPayoffLoan(var prLoanEntry: Record "Loan Entry"; LoanEntry: Record "Loan Entry"; PayOffCode: Code[20])
    var
        LoanEntryRecTmp: Record "Loan Entry" temporary;
        LoanPaymentRec: Record "Loan Payments";
        Loansetup: Record "Payroll Setups";
        LoansRec: Record "Loans/Advances";
        LoanTypeRec: Record "Loan Types";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LineNo: Integer;
        TemplateName: Code[20];
        BatchName: Code[20];
        gvPayrollUtilities: Codeunit "Payroll Posting";
    begin
        LoanEntryRecTmp.Copy(prLoanEntry);
        LoanEntryRecTmp.Interest := 0;
        LoanEntryRecTmp.Repayment := prLoanEntry."Remaining Debt" + prLoanEntry.Repayment;
        LoanEntryRecTmp."Transfered To Payroll" := true;
        LoanEntryRecTmp."Remaining Debt" := 0;
        LoanEntryRecTmp.Posted := true;
        LoanEntryRecTmp.Insert;


        LoanEntry.SetFilter("No.", '>=%1', LoanEntryRecTmp."No.");

        LoanEntry.DeleteAll;

        LoanEntry.Copy(LoanEntryRecTmp);
        LoanEntry.Insert;

        LoanEntry.Get(LoanEntryRecTmp."No.", LoanEntryRecTmp."Loan ID");

        LoanPaymentRec.Get(PayOffCode);
        LoanPaymentRec.TestField("Account No.");

        Loansetup.Get;
        Loansetup.TestField("Loan Template");
        Loansetup.TestField("Loan Payments Batch");

        LoansRec.Get(prLoanEntry."Loan ID", prLoanEntry.Employee);

        if not LoansRec."Paid to Employee" then
            Error('The Loan is not paid out to Employee');

        LoanTypeRec.Get(LoansRec."Loan Types", LoansRec."Payroll Code");

        TemplateName := Loansetup."Loan Template";
        BatchName := Loansetup."Loan Payments Batch";

        GenJnlLine.SetRange("Journal Template Name", TemplateName);
        GenJnlLine.SetRange("Journal Batch Name", BatchName);
        if GenJnlLine.Find('+') then
            LineNo := GenJnlLine."Line No."
        else
            LineNo := 0;

        LineNo := LineNo + 10000;
        GenJnlLine.Amount := -LoanEntry.Repayment;
        GenJnlLine.Validate(Amount);
        GenJnlLine."Journal Batch Name" := BatchName;
        GenJnlLine."Journal Template Name" := TemplateName;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := LoanTypeRec."Loan Account";
        GenJnlLine."Posting Date" := WorkDate;
        GenJnlLine.Description := 'Pay off Loan';
        if LoanPaymentRec."Account Type" = LoanPaymentRec."Account Type"::"G/L Account" then
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account"
        else
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        GenJnlLine."Bal. Account No." := LoanPaymentRec."Account No.";
        GenJnlLine."Shortcut Dimension 1 Code" := '';
        GenJnlLine."Shortcut Dimension 2 Code" := '';

        GenJnlBatch.Get(TemplateName, BatchName);
        if GenJnlBatch."No. Series" <> '' then begin
            Clear(NoSeriesMgt);
            GenJnlLine."Document No." := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series", GenJnlLine."Posting Date");
        end;
        GenJnlLine.UpdateLineBalance;
        GenJnlLine.Insert;
    end;

    procedure PayrollAllocationMatrixAllocatedValidate(var prPayrollExpAllocatedMatrix: Record "Payroll Exp Allocation Matrix")
    var
        lvAllocatedTotal: Record "Payroll Exp Allocation Matrix";
        lvStartDate: Date;
        lvEndDate: Date;
    begin
        lvAllocatedTotal.SetCurrentKey("Employee No", "ED Code");
        lvAllocatedTotal.SetRange("Employee No", prPayrollExpAllocatedMatrix."Employee No");
        lvAllocatedTotal.SetRange("ED Code", prPayrollExpAllocatedMatrix."ED Code");
        //cmm VSF PAY 1 Make date to get the allocations for the month
        lvStartDate := CalcDate('-CM', prPayrollExpAllocatedMatrix."Posting Date");
        lvEndDate := CalcDate('CM', prPayrollExpAllocatedMatrix."Posting Date");
        //end cmm

        lvAllocatedTotal.SetRange("Posting Date", lvStartDate, lvEndDate);

        lvAllocatedTotal.SetFilter(lvAllocatedTotal."Entry No", '<>%1', prPayrollExpAllocatedMatrix."Entry No");
        lvAllocatedTotal.CalcSums(Allocated);
        if (lvAllocatedTotal.Allocated + prPayrollExpAllocatedMatrix.Allocated) > 100 then
            Error('Total allocation for %1 ED %2 can not exceed 100 Percent', prPayrollExpAllocatedMatrix."Employee No", prPayrollExpAllocatedMatrix."ED Code")
    end;

    procedure gsSetActivePayroll()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lfrmSelectPayroll: Page "Allowed Payrolls";
        lvAllowedPayrolsCount: Integer;
        lvPayrollUtilities: Codeunit "Payroll Posting";
        lvActiveSession: Record "Active Session";
    begin
        //skm210409 Revised to make it Windows Logins aware

        //skm110506 this function selects the payroll the current user will have access to
        //called by Code Unit 1-CompanyOpen function
        //clear previous setting
        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID", ServiceInstanceId);
        lvActiveSession.SetRange("Session ID", SessionId);
        lvActiveSession.FindFirst;

        lvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        lvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if lvAllowedPayrolls.FindFirst then lvAllowedPayrolls.ModifyAll("Last Active Payroll", false);
        Commit;
        //mesh
        /*lvAllowedPayrolls.RESET;
        lvAllowedPayrolls.SETRANGE("User ID", USERID);
        
        lvAllowedPayrolls.SETRANGE("Valid to Date", 0D);
        lvAllowedPayrolls.FINDFIRST;
        lvAllowedPayrolsCount := lvAllowedPayrolls.COUNT;
        CASE lvAllowedPayrolsCount OF
          1: BEGIN //allowed access to one payroll, set it
            lvAllowedPayrolls.FIND('-');
            lvAllowedPayrolls."Last Active Payroll" := TRUE;
            lvAllowedPayrolls.MODIFY;
            EXIT;
          END;
        
          ELSE IF lvAllowedPayrolsCount > 1 THEN BEGIN //allowed access to multiple payrolls, prompt for selection
            lfrmSelectPayroll.CAPTION := 'Select Payroll';
            lfrmSelectPayroll.SETTABLEVIEW(lvAllowedPayrolls);
            lfrmSelectPayroll.LOOKUPMODE := TRUE;
            IF lfrmSelectPayroll.RUNMODAL = ACTION::LookupOK THEN BEGIN
              lfrmSelectPayroll.GETRECORD(lvAllowedPayrolls);
              lvAllowedPayrolls."Last Active Payroll" := TRUE;
              lvAllowedPayrolls.MODIFY
            END;
            EXIT;
          END
        END;*/ //mesh

        lvAllowedPayrolls.Reset;
        lvAllowedPayrolls.SetRange("User ID", UserId);
        lvAllowedPayrolls.SetFilter("Valid to Date", '%1|>=%1', 0D, Today);
        lvAllowedPayrolsCount := lvAllowedPayrolls.Count;
        case lvAllowedPayrolsCount of
            0:
                exit;
            1:
                begin //allowed access to one payroll, set it
                    lvAllowedPayrolls.Find('-');
                    lvAllowedPayrolls."Last Active Payroll" := true;
                    lvAllowedPayrolls.Modify
                end;

            else
                if lvAllowedPayrolsCount > 1 then begin //allowed access to multiple payrolls, prompt for selection
                    Clear(lfrmSelectPayroll);
                    lfrmSelectPayroll.Caption := 'Select Payroll';
                    lfrmSelectPayroll.SetTableView(lvAllowedPayrolls);
                    lfrmSelectPayroll.SetRecord(lvAllowedPayrolls);
                    lfrmSelectPayroll.LookupMode := true;
                    if lfrmSelectPayroll.RunModal() = ACTION::LookupOK then begin
                        lfrmSelectPayroll.GetRecord(lvAllowedPayrolls);
                        lvAllowedPayrolls."Last Active Payroll" := true;//mesh
                        lvAllowedPayrolls.Modify;
                    end;
                end;
        end;

    end;

    procedure "==="()
    begin
    end;

    procedure CheckLicencePermission(prObjectType: Option TableData,"Table","Report","Codeunit","XMLPort",Menusuite,"Page"; prObjectID: Integer) IsAllowed: Boolean
    var
    // lvPermissionRange: Record "Permission Range";
    begin
        //prObjectType has options:TableData,Table,Report,Codeunit,XMLPort,Menusuite,Page....
        //Permission Range table has options:TableData,Table,Blank,Report,Blank,Codeunit,XMLPort,Menusuite,Page,Query,System,FieldNumber
        // case prObjectType of
        //     prObjectType::TableData,prObjectType::Table:
        //          lvPermissionRange.SetRange("Object Type",prObjectType);
        //     prObjectType::Report:
        //          lvPermissionRange.SetRange("Object Type",prObjectType+1);
        //     prObjectType::Codeunit,prObjectType::XMLPort,prObjectType::Menusuite,prObjectType::Page:
        //          lvPermissionRange.SetRange("Object Type",prObjectType+2);
        // end;
        // lvPermissionRange.SetFilter(From,'<=%1',prObjectID);
        // lvPermissionRange.SetFilter(lvPermissionRange."To",'>=%1',prObjectID);
        // if (lvPermissionRange.FindFirst) and (lvPermissionRange."Execute Permission"=lvPermissionRange."Execute Permission"::Yes) then
        //     exit(true)
        // else exit(false);
    end;
}

