table 51191 "Employee Grades2"
{
    //LookupPageID = 52021099;

    fields
    {
        field(1;"Grade Code";Code[10])
        {
            NotBlank = true;
        }
        field(2;Description;Text[30])
        {
        }
        field(3;"OT Qualifying";Boolean)
        {
            Description = 'Added for OT Calculations GJ';
        }
        field(4;"Leave Travel Allowance";Decimal)
        {
        }
        field(5;"Grade 0";Boolean)
        {
            Description = 'Added for HR2-2 - GJ';

            trigger OnValidate()
            begin
                if "Grade 0" then begin
                  "Grade 1 - 5" := false;
                  Management := false;
                end;
            end;
        }
        field(6;"Grade 1 - 5";Boolean)
        {
            Description = 'Added for HR2-2 - GJ';

            trigger OnValidate()
            begin
                if "Grade 1 - 5" then begin
                  "Grade 0" := false;
                  Management := false;
                end;
            end;
        }
        field(7;Management;Boolean)
        {
            Description = 'Added for HR2-2 - GJ';

            trigger OnValidate()
            begin
                if  Management then begin
                  "Grade 0" := false;
                  "Grade 1 - 5" := false;
                end;
            end;
        }
    }

    keys
    {
        key(Key1;"Grade Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        gvEmp.SetRange("Employee Grade", "Grade Code");
        if gvEmp.FindFirst then Error('Employee No. %1 is assigned this grade',gvEmp."No.");
    end;

    var
        gvEmp: Record Employee;
}

