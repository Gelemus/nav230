table 51153 "Calculation Header"
{
    LookupPageID = "Calculation Header";

    fields
    {
        field(1;"Scheme ID";Code[20])
        {
            NotBlank = true;
        }
        field(2;Description;Text[100])
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
        key(Key1;"Scheme ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Employee.SetRange("Calculation Scheme","Scheme ID");
        if Employee.Find('-') then
          Error('This Calculation Scheme is Used')
        else begin
          SchemeLines.SetRange("Scheme ID","Scheme ID");
          SchemeLines.DeleteAll;
        end;
    end;

    trigger OnInsert()
    begin
        if "Payroll Code" = '' then "Payroll Code" := gvPayrollUtilities.gsAssignPayrollCode; //SNG 130611 payroll data segregation
    end;

    var
        Employee: Record Employee;
        SchemeLines: Record "Calculation Scheme";
        gvPayrollUtilities: Codeunit "Payroll Posting";
}

