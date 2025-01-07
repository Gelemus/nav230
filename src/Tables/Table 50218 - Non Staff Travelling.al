table 50218 "Non Staff Travelling"
{

    fields
    {
        field(1;"Request No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"ID No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Name;Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Request No.","ID No")
        {
        }
    }

    fieldgroups
    {
    }
}

