table 51192 "Calculation Scheme Master Roll"
{
    LookupPageID = "Calculation Lookup";

    fields
    {
        field(2;"Payroll Code";Code[10])
        {
            TableRelation = Payroll;
        }
        field(10;Number;Integer)
        {
        }
        field(11;"ED Code";Code[20])
        {
            TableRelation = "ED Definitions";

            trigger OnValidate()
            var
                lvSpecialAllowances: Record "Special Allowances";
            begin
            end;
        }
        field(12;Description;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Value Source";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'ED Definition,Total Gross,Total Deduction,Net Pay';
            OptionMembers = "ED Definition","Total Gross","Total Deduction","Net Pay";
        }
        field(14;Negative;Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Payroll Code",Number)
        {
        }
    }

    fieldgroups
    {
    }

    var
        EDDif: Record "ED Definitions";
        Scheme: Record "Calculation Scheme";
        gvPayrollUtilites: Codeunit "Payroll Posting";

    procedure SetUpNewLine(LastReg: Record "Calculation Scheme";BottomLine: Boolean)
    var
        LastReg2: Record "Calculation Scheme";
    begin
    end;
}

