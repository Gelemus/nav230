table 56031 "Case Document Sub Types"
{

    fields
    {
        field(1;"Code";Code[10])
        {
        }
        field(2;Description;Text[50])
        {
        }
        field(3;"Case Document Type";Code[20])
        {
            TableRelation = "Case Document Types";
        }
    }

    keys
    {
        key(Key1;"Code","Case Document Type")
        {
        }
    }

    fieldgroups
    {
    }
}

