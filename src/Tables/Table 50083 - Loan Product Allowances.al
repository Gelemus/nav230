table 50083 "Loan Product Allowances"
{

    fields
    {
        field(1;"Loan Product Code";Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2;"Payroll Transaction Code";Code[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*"Payroll Transaction Name":='';
                PayrollTransaction.RESET;
                IF PayrollTransaction.GET("Payroll Transaction Code") THEN BEGIN
                  "Payroll Transaction Name":=PayrollTransaction."Line No.";
                END;*/

            end;
        }
        field(3;"Payroll Transaction Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Loan Product Code","Payroll Transaction Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PayrollTransaction: Record "Hr Appraisal Academic/Prof Qua";
}

