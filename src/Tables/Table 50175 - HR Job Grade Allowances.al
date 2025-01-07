table 50175 "HR Job Grade Allowances"
{

    fields
    {
        field(10;"Job Grade";Code[30])
        {
            TableRelation = "HR Job Lookup Value".Code WHERE (Option=CONST("Job Grade"));
        }
        field(11;"Allowance Code";Code[30])
        {
            TableRelation = "Funds Transaction Code"."Transaction Type" WHERE ("Transaction Type"=CONST(Imprest));

            trigger OnValidate()
            begin
                if PayrollTransactionCodes.Get("Allowance Code") then
                  "Allowance Description":=PayrollTransactionCodes.Description;
            end;
        }
        field(12;"Allowance Description";Text[100])
        {
            Editable = false;
        }
        field(13;"Allowance Amount";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Job Grade","Allowance Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Error0001: Label 'The Allowance Code Exists under this Job Grade';
        Error0002: Label 'Job Grade Level exists under this Job Gade';
        PayrollTransactionCodes: Record "Funds Transaction Code";
}

