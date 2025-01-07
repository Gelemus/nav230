table 52221 "Attendance Punches"
{

    fields
    {
        field(1;No;Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Employee No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                EmployeeRec.Reset;
                EmployeeRec.SetRange("No.", "Employee No");
                if EmployeeRec.FindFirst then
                  "Employee Name" := EmployeeRec."First Name" +' ' +EmployeeRec."Last Name";
            end;
        }
        field(3;"Employee Name";Code[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Time;DateTime)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "String Time" := Format(Time);
            end;
        }
        field(5;"Work Status";Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Check In"," Check Out"," Break Out"," Break In"," Overtime In"," Overtime Out";
        }
        field(6;Type;Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Unknown," Weekend","Day Off","Normal Work",Holiday,Leave," Overtime";
        }
        field(7;"Terminal No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Attendance Punches";
        }
        field(8;"Terminal Name";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Terminal Location";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Attendance Status";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11;"String Time";Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12;Names;Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;No)
        {
        }
    }

    fieldgroups
    {
    }

    var
        EmployeeRec: Record Employee;
}

