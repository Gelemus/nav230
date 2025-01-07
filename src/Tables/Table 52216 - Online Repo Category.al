table 52216 "Online Repo Category"
{

    fields
    {
        field(1;No;Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;Name;Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Board Meeting";
        }
        field(3;Description;Text[100])
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
}

