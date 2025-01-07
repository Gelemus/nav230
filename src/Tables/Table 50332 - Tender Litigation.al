table 50332 "Tender Litigation"
{

    fields
    {
        field(1;"Line No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;Year;Text[250])
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
        field(8;"Name of Client";Text[250])
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
        field(11;"Disputed Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Award for/or Aganist";Text[250])
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

