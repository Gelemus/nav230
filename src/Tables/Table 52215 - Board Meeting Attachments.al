table 52215 "Board Meeting Attachments"
{

    fields
    {
        field(1;"Entry No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;"Meeting No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Board Meeting";
        }
        field(3;Description;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4;FileName;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5;Comments;Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(6;FilePath;Text[100])
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

