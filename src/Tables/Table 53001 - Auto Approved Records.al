table 53001 "Auto Approved Records"
{

    fields
    {
        field(1;Id;Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;"Leave No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Approver Id";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Delegated To";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Record Id";Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;Id)
        {
        }
    }

    fieldgroups
    {
    }
}

