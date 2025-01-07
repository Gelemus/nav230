table 50086 "Employee Loan Product Document"
{

    fields
    {
        field(1; "Product Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            // TableRelation = Table50367.Field1;
        }
        field(2; "Document Code"; Code[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Document Description" := "Document Code";
            end;
        }
        field(3; "Document Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Document Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Mandatory At Application"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Document Mandatory Stage"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Application,Approval,Account Creation';
            OptionMembers = " ",Application,Approval,"Account Creation";
        }
    }

    keys
    {
        key(Key1; "Product Code", "Document Code")
        {
        }
    }

    fieldgroups
    {
    }
}

