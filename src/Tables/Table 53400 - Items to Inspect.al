table 53400 "Items to Inspect"
{

    fields
    {
        field(1;"Line No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;Rank;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Inspection Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,Pre-Trip,Post-Trip';
            OptionMembers = "  ","Pre-Trip","Post-Trip";
        }
        field(4;Description;Text[300])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

