table 50216 "Card Information"
{
    DrillDownPageID = "Card Information List";
    LookupPageID = "Card Information List";

    fields
    {
        field(1;"Card No Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Description;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Date created";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4;"Created By";Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5;"Time created";Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Card No Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Date created" := Today;
        "Time created" := Time;
        "Created By" := UserId;
    end;
}

