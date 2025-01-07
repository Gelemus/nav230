table 50330 "Tender Experience"
{

    fields
    {
        field(1;"Line No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;"Attach URL";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Date Created";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Date Update";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Created By";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Updated By";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Document No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8;Type;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Supplier Profile ID";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10;Description;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11;Status;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Start Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13;"End Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14;Institution;Text[250])
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

