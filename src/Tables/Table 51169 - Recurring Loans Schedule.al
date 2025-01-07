table 51169 "Recurring Loans Schedule"
{
    //DrillDownPageID = 52021083;
    //LookupPageID = 52021083;

    fields
    {
        field(1;"Line No";BigInteger)
        {
        }
        field(2;Employee;Code[20])
        {
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            var
                LoanRec: Record "Salary Scale";
            begin
            end;
        }
        field(3;"Loan Types";Code[20])
        {
            NotBlank = true;
            TableRelation = "Loan Types";

            trigger OnValidate()
            begin
                LoanTypeRec.Get("Loan Types");
                Type := LoanTypeRec.Type;
                Description := LoanTypeRec.Description;
                if Type = Type::Advance then Installments := 1;
            end;
        }
        field(4;"Interest Rate";Decimal)
        {
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                if Type = Type::Advance then "Interest Rate" := 0;
            end;
        }
        field(5;Principal;Decimal)
        {
            MinValue = 0;
        }
        field(6;Description;Text[50])
        {
        }
        field(7;Installments;Integer)
        {
            MinValue = 1;

            trigger OnValidate()
            begin
                if Type = Type::Annuity then begin
                  if "Interest Rate" <= 0 then
                    "Installment Amount" := Round(Principal / Installments, 1,'>')
                  else
                    "Installment Amount" := Round(DebtService(Principal, "Interest Rate", Installments), 1, '>');
                end else if Type = Type::Serial then
                  "Installment Amount" := Round(Principal / Installments, 1,'>')
                else
                  Installments := 1;
            end;
        }
        field(8;"Payments Method";Code[20])
        {
            TableRelation = "Loan Payments";
        }
        field(9;Type;Option)
        {
            Editable = false;
            OptionMembers = Annuity,Serial,Advance;
        }
        field(10;Skip;Boolean)
        {
            Description = 'Skip During Loans Creation';
        }
        field(11;"Installment Amount";Decimal)
        {

            trigger OnValidate()
            begin
                if Type = Type::Annuity then Error('For an annuity enter the number of installments only');
                if Type = Type::Advance then Error('Not valid');
                Installments := Round((Principal / "Installment Amount"), 1, '>');
            end;
        }
        field(12;"Payroll Code";Code[10])
        {
            Editable = false;
            TableRelation = Payroll;

            trigger OnValidate()
            begin
                //ERROR('Manual Edits not allowed.');   //Commented out by SNG240511
            end;
        }
    }

    keys
    {
        key(Key1;"Payroll Code","Line No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Payroll Code" = '' then "Payroll Code" := gvPayrollUtilities.gsAssignPayrollCode; //SNG 130611 payroll data segregation
    end;

    var
        LoanTypeRec: Record "Loan Types";
        gvPayrollUtilities: Codeunit "Payroll Posting";
        TableCodeTransfer: Codeunit "Table Code Transferred-Payroll";

    procedure DebtService(Principal: Decimal;Interest: Decimal;PayPeriods: Integer): Decimal
    var
        PeriodInterest: Decimal;
    begin
        exit(TableCodeTransfer.RecurLoanScheduleDebtService(Principal,Interest,PayPeriods));
    end;
}

