table 50326 "Tender Directors"
{

    fields
    {
        field(1;"Line No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;"Application No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Director Name";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Director Nationality";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Director Shares";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6;Status;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Date Created";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Date Updated";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Created By";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Updated By";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Supplier Profile ID";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12;Description;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Document No";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Attach URL";Text[1000])
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

