table 51155 "Employee Posting Groups"
{
    LookupPageID = "Employee Posting Group";

    fields
    {
        field(1;"Posting Group";Code[20])
        {
            NotBlank = true;
        }
        field(2;Description;Text[40])
        {
        }
        field(3;"Payroll Code";Code[10])
        {
            TableRelation = Payroll;
        }
    }

    keys
    {
        key(Key1;"Posting Group")
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

