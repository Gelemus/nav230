table 56040 "Case Investigator"
{

    fields
    {
        field(1;"Case No";Code[20])
        {
        }
        field(2;"Employee No";Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if emp.Get("Employee No") then
                  "Employee Name":=emp.FullName;
            end;
        }
        field(3;"Employee Name";Text[60])
        {
            Editable = false;
        }
        field(4;"Effective Date";Date)
        {
        }
        field(5;"Allocation Comments";Text[60])
        {
        }
        field(6;"Created By";Code[50])
        {
        }
        field(7;"Date Created";Date)
        {
        }
        field(8;"Time Created";Time)
        {
        }
    }

    keys
    {
        key(Key1;"Case No","Employee No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Date Created":=Today;
        "Time Created":=Time;
        "Created By":=UserId;
    end;

    var
        emp: Record Employee;
}

