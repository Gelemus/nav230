table 50318 "Board Committee Members"
{

    fields
    {
        field(1; "Committee Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Member No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No." WHERE("Board Members" = FILTER(true));

            trigger OnValidate()
            begin
                Employees.Get("Member No");
                "Member Name" := Employees."Search Name";
                Designation := Employees."Job Title";


            end;
        }
        field(3; "Member Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Comments; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Role; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Chairman,Secretary,Member';
            OptionMembers = " ",Chairman,Secretary,Member;
        }
        field(6; Designation; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Committee Code", "Member No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employees: Record Employee;
}

