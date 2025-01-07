page 51191 "Change Loan"
{
    InsertAllowed = false;
    PageType = Card;
    Permissions = TableData "Loan Entry" = rimd;
    SourceTable = "Loan Entry";
    SourceTableView = SORTING("No.", "Loan ID")
                      WHERE(Posted = FILTER(false));

    layout
    {
        area(content)
        {
            field(OldInterest; OldInterest)
            {
                Caption = 'Old Interest Rate';
                Editable = false;
            }
            field(OldInstalments; OldInstalments)
            {
                Caption = 'Old Installments';
                Editable = false;
            }
            field(OLD; OldInstallmentAmount)
            {
                Caption = 'Old Installment Amount';
                Editable = false;
                Visible = OLDVisible;
            }
            field(NewInterest; NewInterest)
            {
                Caption = 'New Interest Rate';

                trigger OnValidate()
                begin
                    if AnnuityYN then
                        if (NewInterest > 0) and (NewInstalments > 0) then
                            NewInstallmentAmount := Round(LoansRec.DebtService((Rec."Remaining Debt" + Rec.Repayment), NewInterest, NewInstalments), 1, '>')
                        else
                            if (NewInstalments > 0) then
                                NewInstallmentAmount := Round((Rec."Remaining Debt" + Rec.Repayment) / NewInstalments, 1, '>');
                end;
            }
            field(NewInstalments; NewInstalments)
            {
                Caption = 'New Installments';

                trigger OnValidate()
                begin
                    if AnnuityYN then
                        if (NewInterest > 0) and (NewInstalments > 0) then
                            NewInstallmentAmount := Round(LoansRec.DebtService((Rec."Remaining Debt" + Rec.Repayment), NewInterest, NewInstalments), 1, '>')
                        else
                            if (NewInstalments > 0) then
                                NewInstallmentAmount := Round((Rec."Remaining Debt" + Rec.Repayment) / NewInstalments, 1, '>');
                end;
            }
            field(NEW; NewInstallmentAmount)
            {
                Caption = 'New Installment Amount';
                Visible = NEWVisible;

                trigger OnValidate()
                begin
                    NewInstalments := 0;
                end;
            }
            field(SuspensionMonths; SuspensionMonths)
            {
                Caption = 'Suspension Period (Months)';
            }
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;
                field(Employee; Rec.Employee)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Loan ID"; Rec."Loan ID")
                {
                    Editable = false;
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Period; Rec.Period)
                {
                    Editable = false;
                }
                field("Period B4 Suspension"; Rec."Period B4 Suspension")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Interest; Rec.Interest)
                {
                    Editable = false;
                }
                field("Interest (LCY)"; Rec."Interest (LCY)")
                {
                }
                field(Repayment; Rec.Repayment)
                {
                    Editable = false;
                }
                field("Repayment (LCY)"; Rec."Repayment (LCY)")
                {
                }
                field("Remaining Debt"; Rec."Remaining Debt")
                {
                    Editable = false;
                }
                field("Remaining Debt (LCY)"; Rec."Remaining Debt (LCY)")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Suspension)
            {
                Caption = 'Suspension';
                action("Suspend Loan")
                {
                    Caption = 'Suspend Loan';

                    trigger OnAction()
                    begin
                        if SuspensionMonths = 0 then
                            Error('Please enter the number of months by which\' +
'to suspend the loan as at ' + Rec.Period);
                        SuspendLoan();
                    end;
                }
                separator(Separator37)
                {
                    Caption = '';
                }
                action("Reverse Suspension")
                {
                    Caption = 'Reverse Suspension';

                    trigger OnAction()
                    begin
                        ReverseLoanSuspension();
                    end;
                }
            }
        }
        area(processing)
        {
            action(Change)
            {
                Caption = 'Change';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    PeriodRec: Record "Payroll Lines";
                begin
                    LoanEntryRecTmp.DeleteAll;

                    LoanEntryRecTmp.Copy(Rec);
                    LoanEntryRecTmp.Insert;

                    Rec.SetFilter("No.", '>=%1', LoanEntryRecTmp."No.");
                    Rec.DeleteAll;

                    Rec.SetRange("No.");

                    if AnnuityYN then
                        CreateAnnuityLoan
                    else
                        CreateSerialLoan;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        NEWVisible := true;
        OLDVisible := true;
    end;

    trigger OnOpenPage()
    begin
        gsSegmentPayrollData;
        if Rec.Find('-') then;

        OldInstalments := Rec.Count;
        LoansRec.Get(Rec."Loan ID");
        OldInterest := LoansRec."Interest Rate";

        NewInstalments := Rec.Count;
        NewInterest := LoansRec."Interest Rate";

        case LoansRec.Type of
            0:
                begin
                    OldInstallmentAmount := LoansRec."Installment Amount";
                    AnnuityYN := true;
                end;
            1:
                begin
                    OLDVisible := false;
                    NEWVisible := false;
                    AnnuityYN := false;
                end;
            2:
                Error('You Cannot Change an Advance');
        end;

        if AnnuityYN then
            if (NewInterest > 0) and (NewInstalments > 0) then
                NewInstallmentAmount := Round(LoansRec.DebtService((Rec."Remaining Debt" + Rec.Repayment), NewInterest, NewInstalments), 1, '>')
            else
                if (NewInstalments > 0) then
                    NewInstallmentAmount := Round((Rec."Remaining Debt" + Rec.Repayment) / NewInstalments, 1, '>');
    end;

    var
        LoanEntryRecTmp: Record "Loan Entry" temporary;
        LoanEntryRec: Record "Loan Entry";
        Loansetup: Record "Payroll Setups";
        LoanTypeRec: Record "Loan Types";
        LoansRec: Record "Loans/Advances";
        OldInterest: Decimal;
        NewInterest: Decimal;
        OldInstalments: Integer;
        NewInstalments: Integer;
        OldInstallmentAmount: Decimal;
        NewInstallmentAmount: Decimal;
        AnnuityYN: Boolean;
        EntryNo: Integer;
        LoanId: Code[20];
        SuspensionMonths: Integer;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        gvCurrExchangeRate: Record "Currency Exchange Rate";
        [InDataSet]
        OLDVisible: Boolean;
        [InDataSet]
        NEWVisible: Boolean;

    procedure CreateSerialLoan()
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
        LoopEndBool := false;

        LineNoInt := 0;
        Periodrec.SetCurrentKey("Start Date");
        Periodrec.SetRange("Period ID", LoanEntryRecTmp.Period);
        Periodrec.SetRange("Payroll Code", LoanEntryRecTmp."Payroll Code"); //PMC290729 Added this line
        //Periodrec.SETRANGE("Payroll Code", gvAllowedPayrolls."Payroll Code"); //This is the Original line commented
        Periodrec.Find('-');
        Periodrec.SetRange("Period ID");

        LoansRec.Get(LoanEntryRecTmp."Loan ID");
        LoanTypeRec.Get(LoansRec."Loan Types", Rec."Payroll Code");

        case LoanTypeRec.Rounding of
            LoanTypeRec.Rounding::Nearest:
                RoundDirectionCode := '=';
            LoanTypeRec.Rounding::Down:
                RoundDirectionCode := '<';
            LoanTypeRec.Rounding::Up:
                RoundDirectionCode := '>';
        end;

        RoundPrecisionDec := LoanTypeRec."Rounding Precision";

        RemainingPrincipalAmountDec := LoanEntryRecTmp.Repayment + LoanEntryRecTmp."Remaining Debt";

        RepaymentAmountDec := Round(RemainingPrincipalAmountDec / NewInstalments, RoundPrecisionDec, RoundDirectionCode);

        repeat
            if LineNoInt <> 0 then begin
                Periodrec.Find('>');
                PeriodCode := Periodrec."Period ID";
            end else
                PeriodCode := LoanEntryRecTmp.Period;

            LineNoInt := LineNoInt + 1;

            InterestAmountDec := Round(RemainingPrincipalAmountDec / 12 / 100 * NewInterest, RoundPrecisionDec, RoundDirectionCode);
            LoanEntryRec."No." := LineNoInt + LoanEntryRecTmp."No." - 1;
            LoanEntryRec."Loan ID" := LoanEntryRecTmp."Loan ID";
            LoanEntryRec.Employee := LoanEntryRecTmp.Employee;
            LoanEntryRec.Period := PeriodCode;
            LoanEntryRec.Interest := InterestAmountDec;
            LoanEntryRec."Interest (LCY)" :=
            //  ROUND(InterestAmountDec * LoansRec."Currency Factor", RoundPrecisionDec, RoundDirectionCode);
            Round(gvCurrExchangeRate.ExchangeAmtFCYToLCY(WorkDate, LoansRec."Currency Code", InterestAmountDec, //SNG
            LoansRec."Currency Factor"), RoundPrecisionDec, RoundDirectionCode);


            LoanEntryRec."Calc Benefit Interest" := LoanEntryRecTmp."Calc Benefit Interest";

            if LineNoInt = NewInstalments then begin
                LoanEntryRec.Repayment := RemainingPrincipalAmountDec;
                LoanEntryRec."Repayment (LCY)" :=
                // ROUND(RemainingPrincipalAmountDec * LoansRec."Currency Factor", RoundPrecisionDec, RoundDirectionCode);
                Round(gvCurrExchangeRate.ExchangeAmtFCYToLCY(WorkDate, LoansRec."Currency Code", RemainingPrincipalAmountDec,
                LoansRec."Currency Factor"), RoundPrecisionDec, RoundDirectionCode);

                LoanEntryRec."Remaining Debt (LCY)" := 0;
                LoanEntryRec."Remaining Debt" := 0;
            end else begin
                LoanEntryRec.Repayment := RepaymentAmountDec;

                LoanEntryRec."Repayment (LCY)" :=
                Round(gvCurrExchangeRate.ExchangeAmtFCYToLCY(WorkDate, LoansRec."Currency Code", RepaymentAmountDec, //SNG 300511
                LoansRec."Currency Factor"), RoundPrecisionDec, RoundDirectionCode);
                //  ROUND(RepaymentAmountDec * LoansRec."Currency Factor",RoundPrecisionDec,RoundDirectionCode);

                RemainingPrincipalAmountDec := RemainingPrincipalAmountDec - RepaymentAmountDec;
                LoanEntryRec."Remaining Debt" := RemainingPrincipalAmountDec;

                LoanEntryRec."Remaining Debt (LCY)" :=
                // ROUND(RemainingPrincipalAmountDec * LoansRec."Currency Factor", RoundPrecisionDec, RoundDirectionCode);
                Round(gvCurrExchangeRate.ExchangeAmtFCYToLCY(WorkDate, LoansRec."Currency Code", RemainingPrincipalAmountDec, //SNG 300511
                LoansRec."Currency Factor"), RoundPrecisionDec, RoundDirectionCode);

            end;

            LoanEntryRec."Payroll Code" := LoanEntryRecTmp."Payroll Code";//PMC290710 Added this line
                                                                          //LoanEntryRec."Payroll Code" := gvAllowedPayrolls."Payroll Code";//The original line commented
            LoanEntryRec.Insert;

        until LineNoInt = NewInstalments;
    end;

    procedure CreateAnnuityLoan()
    var
        Periodrec: Record Periods;
        LoopEndBool: Boolean;
        LineNoInt: Integer;
        PeriodCode: Code[10];
        InterestAmountDec: Decimal;
        RemainingPrincipalAmountDec: Decimal;
        RepaymentAmountDec: Decimal;
        RoundPrecisionDec: Decimal;
        RoundDirectionCode: Code[10];
    begin
        if NewInstallmentAmount <= 0 then
            Error('Instalment Amount must be specified');

        RemainingPrincipalAmountDec := LoanEntryRecTmp.Repayment + LoanEntryRecTmp."Remaining Debt";

        if NewInstallmentAmount > RemainingPrincipalAmountDec then
            Error('Instalment Amount is higher than Principal');

        LoopEndBool := false;

        LineNoInt := LoanEntryRecTmp."No.";

        Periodrec.SetCurrentKey("Start Date");
        Periodrec.SetRange("Period ID", LoanEntryRecTmp.Period);
        Periodrec.SetRange("Payroll Code", LoanEntryRecTmp."Payroll Code"); //PMC290729 Added this
        //Periodrec.SETRANGE("Payroll Code", gvAllowedPayrolls."Payroll Code"); //This is the Original line commented
        Periodrec.Find('-');
        Periodrec.SetRange("Period ID");

        LoansRec.Get(LoanEntryRecTmp."Loan ID");
        LoanTypeRec.Get(LoansRec."Loan Types");

        case LoanTypeRec.Rounding of
            LoanTypeRec.Rounding::Nearest:
                RoundDirectionCode := '=';
            LoanTypeRec.Rounding::Down:
                RoundDirectionCode := '<';
            LoanTypeRec.Rounding::Up:
                RoundDirectionCode := '>';
        end;

        RoundPrecisionDec := LoanTypeRec."Rounding Precision";

        repeat
            InterestAmountDec := Round(RemainingPrincipalAmountDec / 100 / 12 * NewInterest, RoundPrecisionDec, RoundDirectionCode);
            if InterestAmountDec >= NewInstallmentAmount then
                Error('This Loan is not possible because\the the instalment Amount must\be higher than %1', InterestAmountDec);


            if LineNoInt <> LoanEntryRecTmp."No." then begin
                Periodrec.Find('>');
                PeriodCode := Periodrec."Period ID";
            end else
                PeriodCode := LoanEntryRecTmp.Period;

            LoanEntryRec."No." := LineNoInt;
            LoanEntryRec."Loan ID" := LoanEntryRecTmp."Loan ID";
            LoanEntryRec.Employee := LoanEntryRecTmp.Employee;
            LoanEntryRec.Period := PeriodCode;
            LoanEntryRec.Interest := InterestAmountDec;

            LoanEntryRec."Interest (LCY)" :=
            //  ROUND(InterestAmountDec * LoansRec."Currency Factor", RoundPrecisionDec, '<');
            Round(gvCurrExchangeRate.ExchangeAmtFCYToLCY(WorkDate, LoansRec."Currency Code", InterestAmountDec,   //SNG  300511
            LoansRec."Currency Factor"), RoundPrecisionDec, '<');

            LoanEntryRec."Calc Benefit Interest" := LoanEntryRecTmp."Calc Benefit Interest";

            if (NewInstallmentAmount - InterestAmountDec) >= RemainingPrincipalAmountDec then begin
                LoanEntryRec.Repayment := RemainingPrincipalAmountDec;

                LoanEntryRec."Repayment (LCY)" :=
                //  ROUND(RemainingPrincipalAmountDec * LoansRec."Currency Factor", RoundPrecisionDec, '<');
                Round(gvCurrExchangeRate.ExchangeAmtFCYToLCY(WorkDate, LoansRec."Currency Code", RemainingPrincipalAmountDec,   //SNG 300511
                LoansRec."Currency Factor"), RoundPrecisionDec, '<');


                LoanEntryRec."Remaining Debt" := 0;
                LoanEntryRec."Remaining Debt (LCY)" := 0;
                LoopEndBool := true;
            end else begin
                LoanEntryRec.Repayment := NewInstallmentAmount - InterestAmountDec;

                LoanEntryRec."Repayment (LCY)" :=
                //ROUND(LoanEntryRec.Repayment * LoansRec."Currency Factor", RoundPrecisionDec, '<');
                Round(gvCurrExchangeRate.ExchangeAmtFCYToLCY(WorkDate, LoansRec."Currency Code", LoanEntryRec.Repayment,   //SNG  300511
                LoansRec."Currency Factor"), RoundPrecisionDec, '<');

                RemainingPrincipalAmountDec := RemainingPrincipalAmountDec - (NewInstallmentAmount - InterestAmountDec);
                LoanEntryRec."Remaining Debt" := RemainingPrincipalAmountDec;
                LoanEntryRec."Remaining Debt (LCY)" :=
                //  ROUND(RemainingPrincipalAmountDec * LoansRec."Currency Factor", RoundPrecisionDec, '<');
                Round(gvCurrExchangeRate.ExchangeAmtFCYToLCY(WorkDate, LoansRec."Currency Code", RemainingPrincipalAmountDec,   //SNG  300511
                LoansRec."Currency Factor"), RoundPrecisionDec, '<');


            end;

            LoanEntryRec."Transfered To Payroll" := false;
            LoanEntryRec."Payroll Code" := LoanEntryRecTmp."Payroll Code";//PMC290710 Added this line
                                                                          //LoanEntryRec."Payroll Code" := gvAllowedPayrolls."Payroll Code";//The original line commented
            LoanEntryRec.Insert;

            LineNoInt := LineNoInt + 1;
        until LoopEndBool;
    end;

    procedure SuspendLoan()
    var
        Periods: Record Periods;
        PeriodsTemp: Record Periods;
        SuspendedMnths: Integer;
    begin
        //SKM 30/03/00 This function suspends a loan as at current installment for the specified
        //payroll months(periods)
        //only open installments

        //Determine resumption period

        PeriodsTemp.SetRange("Period ID", Rec.Period);
        PeriodsTemp.SetRange("Payroll Code", Rec."Payroll Code");
        //PeriodsTemp.SETRANGE("Payroll Code", gvAllowedPayrolls."Payroll Code"); Original Line commented by CSm
        PeriodsTemp.Find('-');

        Periods.SetCurrentKey(Periods."Start Date");
        Periods.Get(PeriodsTemp."Period ID", PeriodsTemp."Period Month", PeriodsTemp."Period Year",
         Rec."Payroll Code");
        repeat
            SuspendedMnths := SuspendedMnths + 1
        until (Periods.Next = 0) or (SuspendedMnths = SuspensionMonths);
        if SuspendedMnths <> SuspensionMonths then
            Error('There aren''t enough payroll periods setup in the periods table.\' +
              'Available periods = %1 (months), suspending by %2 (months)', SuspendedMnths, SuspensionMonths);

        if Confirm(
            StrSubstNo('You are just about to postphone the repayment of this repayment\' +
                       'for %1 to %2. All the subsequent repayments will be adjusted\' +
                       'accordingly.\\' +
                       'Proceed anyway?', Rec.Period, Periods."Period ID")) = false then
            exit;
        if Confirm('Are you sure you want to suspend this loan?') = false then exit;

        //Suspend
        LoanEntryRec.Reset;
        LoanEntryRec.SetFilter("No.", '>=%1', Rec."No.");
        LoanEntryRec.SetRange("Loan ID", Rec."Loan ID");
        LoanEntryRec.SetRange(Employee, Rec.Employee);
        LoanEntryRec.Find('-');
        repeat
            LoanEntryRec."Period B4 Suspension" := LoanEntryRec.Period;
            LoanEntryRec.Period := Periods."Period ID";
            if Periods.Next = 0 then
                Error('There aren''t enough payroll periods setup in the periods table.');
            LoanEntryRec.Modify;
        until LoanEntryRec.Next = 0;

        LoansRec.Get(LoanEntryRec."Loan ID");
        LoansRec."Last Suspension Date" := Today;
        LoansRec."Last Suspension Duration" := SuspensionMonths;
        Message('Loan suspended sucessfully.');
    end;

    procedure ReverseLoanSuspension()
    var
        Periods: Record Periods;
        PeriodsTemp: Record Periods;
        SuspendedMnths: Integer;
    begin
        //SKM 30/03/00 This function reverses a loan suspension as at current installment
        //only open installments

        if Rec."Period B4 Suspension" = '' then Error('Repayment was not suspended.');
        if Confirm(
            StrSubstNo('You are just about to reverse the suspension of this repayment\' +
                       'for %1 to %2. All the subsequent repayments will be adjusted\' +
                       'accordingly.\\' +
                       'Proceed anyway?', Rec.Period, Rec."Period B4 Suspension")) = false then
            exit;
        if Confirm('Are you sure you want reverse the suspension of this loan?') = false then exit;

        //Reverse Suspension
        LoanEntryRec.Reset;
        LoanEntryRec.SetFilter("No.", '>=%1', Rec."No.");
        LoanEntryRec.SetRange("Loan ID", Rec."Loan ID");
        LoanEntryRec.SetRange(Employee, Rec.Employee);
        LoanEntryRec.Find('-');
        repeat
            LoanEntryRec.Period := LoanEntryRec."Period B4 Suspension";
            LoanEntryRec."Period B4 Suspension" := '';
            LoanEntryRec.Modify;
        until LoanEntryRec.Next = 0;

        LoansRec.Get(LoanEntryRec."Loan ID");
        LoansRec."Last Suspension Date" := 0D;
        LoansRec."Last Suspension Duration" := 0;
        Message('Suspension reversed sucessfully.');
    end;

    procedure gsSegmentPayrollData()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lvPayrollUtilities: Codeunit "Payroll Posting";
        UsrID: Code[10];
        UsrID2: Code[10];
        StringLen: Integer;
        lvActiveSession: Record "Active Session";
    begin
        /*lvSession.SETRANGE("My Session", TRUE);
        lvSession.FINDFIRST; //fire error in absence of a login
        IF lvSession."Login Type" = lvSession."Login Type"::Database THEN
          lvAllowedPayrolls.SETRANGE("User ID", USERID)
        ELSE*/

        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID", ServiceInstanceId);
        lvActiveSession.SetRange("Session ID", SessionId);
        lvActiveSession.FindFirst;


        lvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        lvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if lvAllowedPayrolls.FindFirst then
            Rec.SetRange("Payroll Code", lvAllowedPayrolls."Payroll Code")
        else
            Error('You are not allowed access to this payroll dataset.');
        Rec.FilterGroup(100);

    end;
}

