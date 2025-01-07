table 50112 "HR Mandatory Doc. Checklist"
{
    Caption = 'HR Mandatory Documents Checklist';

    fields
    {
        field(1;"Line No.";Integer)
        {
            AutoIncrement = true;
        }
        field(2;"Document No.";Code[20])
        {
        }
        field(3;"Mandatory Doc. Code";Code[50])
        {
            Caption = 'Mandatory Document Document Code';
            TableRelation = "HR Job Lookup Value".Code WHERE (Code=FIELD("Mandatory Doc. Code"),
                                                              Option=CONST("Checklist Item"));

            trigger OnValidate()
            begin
                HRJobLookupValue.Reset;
                HRJobLookupValue.SetRange(HRJobLookupValue.Code,"Mandatory Doc. Code");
                if HRJobLookupValue.FindFirst then begin
                  "Mandatory Doc. Description":=HRJobLookupValue.Description;
                end;
            end;
        }
        field(4;"Mandatory Doc. Description";Text[250])
        {
            Caption = 'Mandatory Document Description';
        }
        field(5;"Document Attached";Boolean)
        {
            Enabled = false;
        }
        field(20;"Local File URL";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(21;"SharePoint URL";Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Line No.","Document No.","Mandatory Doc. Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        HRJobLookupValue: Record "HR Job Lookup Value";
}

