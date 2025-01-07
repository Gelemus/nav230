table 51156 "ED Posting Group"
{
    LookupPageID = "ED Posting Group";

    fields
    {
        field(1;"ED Posting Group Code";Code[20])
        {
            NotBlank = true;
        }
        field(2;Description;Text[40])
        {
        }
        field(3;"Payroll Code";Code[10])
        {
            TableRelation = Payroll;

            trigger OnValidate()
            begin
                //ERROR('Manual Edits not allowed.');
            end;
        }
    }

    keys
    {
        key(Key1;"ED Posting Group Code","Payroll Code")
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
        gvPayrollUtilities: Codeunit "Payroll Posting";
}

