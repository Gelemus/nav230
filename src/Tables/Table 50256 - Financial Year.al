table 50256 "Financial Year"
{
    DrillDownPageID = "Financial Year";
    LookupPageID = "Financial Year";

    fields
    {
        field(1;"Financial Year";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Description;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Start Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"End Date";Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Financial Year")
        {
        }
    }

    fieldgroups
    {
    }
}

