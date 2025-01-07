table 50316 "Meeting Attachment"
{

    fields
    {
        field(1;"Doc No";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Document Description";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Meeting No";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Attachment;Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Attachment No";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Document Link";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"No. Series";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8;Type;Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Meeting No","Doc No")
        {
        }
    }

    fieldgroups
    {
    }
}

