table 52217 "Online Repo Documents"
{

    fields
    {
        field(1;"Entry No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;"Document No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Online Repo Category";
        }
        field(3;"File Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Actual File";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5;FilePath;Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Entry No")
        {
        }
    }

    fieldgroups
    {
    }
}

