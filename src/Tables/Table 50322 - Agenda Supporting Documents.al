table 50322 "Agenda Supporting Documents"
{

    fields
    {
        field(1;"Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Meeting code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Board Meeting";
        }
        field(3;"Agenda No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Agenda vote items";
        }
        field(4;Type;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Document,URL';
            OptionMembers = Document,URL;
        }
        field(5;Description;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Link/Location";Text[250])
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
}

