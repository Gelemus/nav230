table 52214 "Meeting Minutes"
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
        }
        field(3;"Agenda No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Minutes;Text[1000])
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

