table 50311 "Mileage Registration"
{

    fields
    {
        field(1;"Vehicle No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Work Ticket No.";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Work Ticket";
        }
        field(3;Date;Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"User ID";Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(5;"Previous Reading";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Curent Reading";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Vehicle No.","Work Ticket No.")
        {
        }
    }

    fieldgroups
    {
    }
}

