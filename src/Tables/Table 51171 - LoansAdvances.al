table 51171 "Loans/Advances"
{
    DrillDownPageID = "Loans/Advances";
    LookupPageID = "Loans/Advances";
    Permissions = TableData "Payroll Header"=rimd,
                  TableData "Payroll Lines"=rimd,
                  TableData "Payroll Entry"=rimd,
                  TableData "Special Payments"=rimd,
                  TableData "Loan Entry"=rimd;

    fields
    {
        field(1;ID;Integer)
        {
            AutoIncrement = true;
        }
        field(2;Employee;Code[20])
        {
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            var
                lvEmployee: Record Employee;
            begin
            end;
        }
        field(3;Type;Option)
        {
            Editable = false;
            OptionMembers = Annuity,Serial,Advance;

            trigger OnValidate()
            begin
                if Type = Type::Advance then  "Interest Rate" := 0;
            end;
        }
        field(4;"Loan Types";Code[20])
        {
            NotBlank = true;
            TableRelation = IF (Type=CONST(Advance)) "Loan Types" WHERE (Type=CONST(Advance))
                            ELSE IF (Type=FILTER(Annuity|Serial)) "Loan Types" WHERE (Type=FILTER(Annuity|Serial));

            trigger OnValidate()
            begin
                LoanTypeRec.Get("Loan Types","Payroll Code");
                //LoanTypeRec.GET("Loan Types");
                Type := LoanTypeRec.Type;
                "Calculate Interest Benefit" := LoanTypeRec."Calculate Interest Benefit";
                Description := LoanTypeRec.Description;
            end;
        }
        field(5;"Interest Rate";Decimal)
        {
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                if Type = Type::Advance then "Interest Rate" := 0;
                Validate(Installments);
            end;
        }
        field(6;Principal;Decimal)
        {

            trigger OnValidate()
            begin
                gsGetCurrency;
                if "Currency Code" = '' then
                  "Principal (LCY)" := Principal
                else
                  "Principal (LCY)" := Round(gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, "Currency Code", Principal, "Currency Factor"));

                Principal := Round(Principal, gvCurrency."Amount Rounding Precision");
                Validate(Installments);
            end;
        }
        field(7;"Remaining Debt";Decimal)
        {
            CalcFormula = Sum("Loan Entry".Repayment WHERE ("Loan ID"=FIELD(ID),
                                                            "Transfered To Payroll"=CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8;"Number of Installments";Integer)
        {
            CalcFormula = Count("Loan Entry" WHERE ("Loan ID"=FIELD(ID)));
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(9;Repaid;Decimal)
        {
            CalcFormula = Sum("Loan Entry".Repayment WHERE ("Loan ID"=FIELD(ID),
                                                            "Transfered To Payroll"=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10;"Start Period";Code[10])
        {
            TableRelation = Periods."Period ID" WHERE (Status=CONST(Open));

            trigger OnValidate()
            var
                PeriodRec: Record Periods;
                PayrollHeaderrec: Record "Payroll Header";
            begin
                PeriodRec.SetRange("Period ID", "Start Period");
                PeriodRec.SetRange("Payroll Code", "Payroll Code");
                PeriodRec.Find('-');
                "Period Month" := PeriodRec."Period Month";
                "Period Year" := PeriodRec."Period Year";
                if PayrollHeaderrec.Get("Start Period",Employee) then begin
                  if PayrollHeaderrec.Calculated = true then begin
                     PayrollHeaderrec.Calculated := false;
                     PayrollHeaderrec.Modify;
                  end;
                end;
            end;
        }
        field(11;"Payment Date";Date)
        {
        }
        field(12;Description;Text[50])
        {
        }
        field(13;"First Name";Text[30])
        {
            CalcFormula = Lookup(Employee."First Name" WHERE ("No."=FIELD(Employee)));
            FieldClass = FlowField;
        }
        field(14;"Last Name";Text[30])
        {
            CalcFormula = Lookup(Employee."Last Name" WHERE ("No."=FIELD(Employee)));
            FieldClass = FlowField;
        }
        field(15;"Type Text";Text[50])
        {
            CalcFormula = Lookup("Loan Types".Description WHERE (Code=FIELD("Loan Types")));
            FieldClass = FlowField;
        }
        field(16;Created;Boolean)
        {
            InitValue = false;
        }
        field(17;"Period Month";Integer)
        {
        }
        field(18;"Period Year";Integer)
        {
        }
        field(19;Changed;Boolean)
        {
            InitValue = false;
        }
        field(20;"Total Interest";Decimal)
        {
            CalcFormula = Sum("Loan Entry".Interest WHERE ("Loan ID"=FIELD(ID)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21;"Interest Paid";Decimal)
        {
            CalcFormula = Sum("Loan Entry".Interest WHERE ("Loan ID"=FIELD(ID),
                                                           "Transfered To Payroll"=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22;Installments;Integer)
        {

            trigger OnValidate()
            begin
                if Installments = 0 then exit;
                if Type = Type::Annuity then begin
                  if "Interest Rate" <= 0 then
                    "Installment Amount" := Round(Principal / Installments, 1,'>')
                  else
                    "Installment Amount" := Round(DebtService(Principal, "Interest Rate", Installments), 1, '>');
                end else if Type = Type::Serial then
                  "Installment Amount" := Round(Principal / Installments, 1,'>')
                else if Type = Type::Advance then
                  "Installment Amount" := Round(Principal / Installments, 1,'>');

                //ELSE
                 // Installments := 1;

                gsGetCurrency;
                if "Currency Code" = '' then
                  "Installment Amount (LCY)" := "Installment Amount"
                else
                  "Installment Amount (LCY)" :=
                  Round(gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, "Currency Code", "Installment Amount", "Currency Factor"));

                "Installment Amount" := Round("Installment Amount", gvCurrency."Amount Rounding Precision");
            end;
        }
        field(23;"Installment Amount";Decimal)
        {

            trigger OnValidate()
            begin
                if Type = Type::Annuity then Error('For an annuity enter the number of installments only');
                //IF Type = Type::Advance THEN ERROR('Not valid');
                Installments := Round((Principal / "Installment Amount"), 1, '>');

                gsGetCurrency;
                if "Currency Code" = '' then
                  "Installment Amount (LCY)" := "Installment Amount"
                else
                  "Installment Amount (LCY)" := Round(
                    gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, "Currency Code", "Installment Amount", "Currency Factor"));

                "Installment Amount" := Round("Installment Amount", gvCurrency."Amount Rounding Precision");
            end;
        }
        field(24;"Paid to Employee";Boolean)
        {
            InitValue = false;
        }
        field(26;"Payments Method";Code[20])
        {
            TableRelation = "Loan Payments";
        }
        field(27;"Calculate Interest Benefit";Boolean)
        {
            Editable = false;
        }
        field(28;"Last Suspension Date";Date)
        {
        }
        field(29;"Last Suspension Duration";Integer)
        {
            Description = 'In months';
        }
        field(30;Cleared;Boolean)
        {
            Editable = false;
        }
        field(31;"Payroll Code";Code[10])
        {
            TableRelation = Payroll;

            trigger OnValidate()
            begin
                //ERROR('Manual Edits not allowed.');
            end;
        }
        field(32;Create;Boolean)
        {
            InitValue = true;

            trigger OnValidate()
            begin
                TestField(Created, false);
            end;
        }
        field(33;Pay;Boolean)
        {
            InitValue = true;

            trigger OnValidate()
            begin
                TestField("Paid to Employee", false);
            end;
        }
        field(34;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if "Currency Code" <> '' then begin
                  gsGetCurrency;
                  if ("Currency Code" <> xRec."Currency Code") or (CurrFieldNo = FieldNo("Currency Code")) or ("Currency Factor" = 0) then
                    "Currency Factor" := gvCurrExchRate.ExchangeRate(WorkDate, "Currency Code");
                end else
                  "Currency Factor" := 0;
                Validate("Currency Factor");
                Validate(Installments);
            end;
        }
        field(35;"Principal (LCY)";Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                if "Currency Code" = '' then begin
                  Principal := "Principal (LCY)";
                  Validate(Principal);
                end else begin
                  TestField("Principal (LCY)");
                  TestField(Principal);
                  "Currency Factor" := Principal / "Principal (LCY)";
                end;
            end;
        }
        field(36;"Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0:15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                if ("Currency Code" = '') and ("Currency Factor" <> 0) then
                  FieldError("Currency Factor", StrSubstNo(Text002, FieldCaption("Currency Code")));
                Validate(Principal);
            end;
        }
        field(37;"Remaining Debt (LCY)";Decimal)
        {
            CalcFormula = Sum("Loan Entry"."Repayment (LCY)" WHERE ("Loan ID"=FIELD(ID),
                                                                    "Transfered To Payroll"=CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(38;"Repaid (LCY)";Decimal)
        {
            CalcFormula = Sum("Loan Entry"."Repayment (LCY)" WHERE ("Loan ID"=FIELD(ID),
                                                                    "Transfered To Payroll"=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39;"Total Interest (LCY)";Decimal)
        {
            CalcFormula = Sum("Loan Entry"."Interest (LCY)" WHERE ("Loan ID"=FIELD(ID)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(40;"Interest Paid (LCY)";Decimal)
        {
            CalcFormula = Sum("Loan Entry"."Interest (LCY)" WHERE ("Loan ID"=FIELD(ID),
                                                                   "Transfered To Payroll"=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(41;"Installment Amount (LCY)";Decimal)
        {

            trigger OnValidate()
            begin
                if Type = Type::Annuity then Error('For an annuity enter the number of installments only');
                //IF Type = Type::Advance THEN ERROR('Not valid');
                "Installment Amount (LCY)" := Round(("Principal (LCY)" / "Installment Amount (LCY)"), 1, '>');

                if "Currency Code" = '' then begin
                  "Installment Amount" := "Installment Amount (LCY)";
                  Validate("Installment Amount");
                end;
            end;
        }
        field(42;Status;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(43;"Loan ID";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(44;"Salary Advance Request No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;ID)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*GlobalLoanEntryRec.SETRANGE(Posted,FALSE);
        
        IF (NOT "Paid to Employee") OR (NOT GlobalLoanEntryRec.FIND('-')) THEN BEGIN
          GlobalLoanEntryRec.SETRANGE(Posted);
         // GlobalLoanEntryRec.SETRANGE("Loan ID",ID);
          GlobalLoanEntryRec.DELETEALL;
        END ELSE
          ERROR('Loan is already paid to employee');
        
          */

    end;

    trigger OnInsert()
    var
        LoanRec: Record "Loans/Advances";
    begin
        if ID = 0 then begin
          if LoanRec.Find('+') then
            ID := LoanRec.ID + 1
          else
            ID := 1;
        end;
        if "Payroll Code" = '' then "Payroll Code" := gvPayrollUtilities.gsAssignPayrollCode; //SNG 130611 payroll data segregation
        "Loan ID":= Format(ID);
    end;

    trigger OnModify()
    begin
        if not "Paid to Employee" then Created := false;
    end;

    var
        LoanTypeRec: Record "Loan Types";
        GlobalLoanEntryRec: Record "Loan Entry";
        gvPayrollUtilities: Codeunit "Payroll Posting";
        gvCurrencyCode: Code[10];
        gvCurrency: Record Currency;
        gvCurrExchRate: Record "Currency Exchange Rate";
        Text002: Label 'cannot be specified without %1';
        TableCodeTransfer: Codeunit "Table Code Transferred-Payroll";

    procedure CreateLoan()
    var
        PeriodRec: Record Periods;
    begin

        TableCodeTransfer.LoanAdvancesCreateLoan(Rec);
    end;

    procedure CreateAdvance()
    var
        LoanEntryRec: Record "Loan Entry";
    begin
        TableCodeTransfer.LoanAdvancesCreateAdvance(Rec);
    end;

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
        TableCodeTransfer.LoanAdvancesCreateSerialLoan(Rec);
    end;

    procedure CreateAnnuityLoan()
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
        TableCodeTransfer.LoanAdvancesCreateAnnuityLoan(Rec);
    end;

    procedure PayLoan()
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
        TableCodeTransfer.LoanAdvancesPayLoan(Rec);
    end;

    procedure DebtService(Principal: Decimal;Interest: Decimal;PayPeriods: Integer): Decimal
    var
        PeriodInterest: Decimal;
    begin
        exit(TableCodeTransfer.LoanAdvancesDebtService(Principal,Interest,PayPeriods));
    end;

    procedure CreateLoanfromSchedule()
    var
        PeriodRec: Record Periods;
        lvLoansSchedule: Record "Recurring Loans Schedule";
        lvEmp: Record Employee;
    begin
        TableCodeTransfer.LoanAdvancesCreateLoanfromSchedule(Rec);
    end;

    local procedure gsGetCurrency()
    begin
        gvCurrencyCode := "Currency Code";

        if gvCurrencyCode = '' then begin
          Clear(gvCurrency);
          gvCurrency.InitRoundingPrecision
        end else if gvCurrencyCode <> gvCurrency.Code then begin
          gvCurrency.Get(gvCurrencyCode);
          gvCurrency.TestField("Amount Rounding Precision");
        end;
    end;
}

