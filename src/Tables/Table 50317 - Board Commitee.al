table 50317 "Board Commitee"
{

    fields
    {
        field(1;"Code";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Description;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Comments;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Mandate;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Start Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"End Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7;Status;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Active,Inactive';
            OptionMembers = Active,Inactive;
        }
        field(8;"Member No";Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No." WHERE ("Board Members"=FILTER(true));

            trigger OnValidate()
            begin
                Employees.Get("Member No");
                "Member Name" := Employees."First Name" +' '+Employees."Middle Name"+' '+Employees."Last Name";
            end;
        }
        field(9;"Member Name";Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employees: Record Employee;
}

