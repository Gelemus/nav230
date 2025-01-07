table 52200 "Temp EMploye"
{

    fields
    {
        field(1;"New No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;OldNo;Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Basic;Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"New No")
        {
        }
    }

    fieldgroups
    {
    }
}

