table 51170 "Salary Scale Step"
{
    DrillDownPageID = Employees;
    LookupPageID = Employees;

    fields
    {
        field(1;"Code";Code[20])
        {
            NotBlank = true;
        }
        field(2;Scale;Code[20])
        {
            NotBlank = true;
            TableRelation = "Salary Scale";
        }
        field(3;Description;Text[50])
        {
        }
        field(4;Amount;Decimal)
        {
        }
        field(5;"Payroll Code";Code[10])
        {
            TableRelation = Payroll;

            trigger OnValidate()
            begin
                Error('Manual Edits not allowed.');
            end;
        }
        field(6;"Currency Code";Code[10])
        {
            TableRelation = Currency;
        }
    }

    keys
    {
        key(Key1;"Code",Scale)
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

