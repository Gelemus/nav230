table 50325 "Tender Bank Info"
{

    fields
    {
        field(1;"Line No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;"Document No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Bank;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Bank Address";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Supplier Profile ID";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Bank Telephone No";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Bank Email";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Bank Mobile No";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9;TenderNo;Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

