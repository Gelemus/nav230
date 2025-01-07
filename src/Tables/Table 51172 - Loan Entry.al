table 51172 "Loan Entry"
{
    DrillDownPageID = "Loan Entry";
    LookupPageID = "Loan Entry";

    fields
    {
        field(1; "No."; Integer)
        {
        }
        field(2; "Loan ID"; Integer)
        {
        }
        field(3; Employee; Code[20])
        {
        }
        field(4; Period; Code[10])
        {
        }
        field(5; Interest; Decimal)
        {
        }
        field(7; Repayment; Decimal)
        {
        }
        field(8; "Transfered To Payroll"; Boolean)
        {
        }
        field(9; "Remaining Debt"; Decimal)
        {
        }
        field(10; "Period Status"; Option)
        {
            CalcFormula = Lookup(Periods.Status WHERE("Period ID" = FIELD(Period)));
            Editable = true;
            FieldClass = FlowField;
            OptionMembers = " ",Open,Posted;
        }
        field(11; Posted; Boolean)
        {
            Editable = true;
        }
        field(12; "Calc Benefit Interest"; Boolean)
        {
        }
        field(13; "Period B4 Suspension"; Code[10])
        {
        }
        field(14; "Payroll Code"; Code[10])
        {
            TableRelation = Payroll;

            trigger OnValidate()
            begin
                //ERROR('Manual Edits not allowed.');
            end;
        }
        field(15; "Interest (LCY)"; Decimal)
        {
        }
        field(16; "Repayment (LCY)"; Decimal)
        {
        }
        field(17; "Remaining Debt (LCY)"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Loan ID")
        {
            SumIndexFields = Interest, "Interest (LCY)";
        }
        key(Key2; "Loan ID", Employee, Period, "Transfered To Payroll", Posted)
        {
            SumIndexFields = Repayment, Interest, "Repayment (LCY)", "Interest (LCY)";
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
        TemplateName: Code[20];
        BatchName: Code[20];
        gvPayrollUtilities: Codeunit "Payroll Posting";
        TableCodeTransfer: Codeunit "Table Code Transferred-Payroll";

    procedure PayoffLoan(LoanEntry: Record "Loan Entry"; PayOffCode: Code[20])
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
    begin
        TableCodeTransfer.LoanAdvancesPayoffLoan(Rec, LoanEntry, PayOffCode);
    end;

    procedure WriteOffLoan()
    begin
    end;
}

