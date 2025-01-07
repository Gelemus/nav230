table 50329 "Tender Personnel"
{

    fields
    {
        field(1;"Line No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;Name;Text[250])
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
        field(8;Age;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Supplier Profile ID";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Date of Birth";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11;Gender;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Academic Qualification";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Professional Qualification";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14;Status;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15;Description;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16;"Attach URL";Text[250])
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

