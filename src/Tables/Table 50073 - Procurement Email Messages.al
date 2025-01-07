table 50073 "Procurement Email Messages"
{

    fields
    {
        field(1;"Entry No.";BigInteger)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;"Sender Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Sender Address";Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(9;Subject;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10;Recipients;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Recipients CC";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Recipients BCC";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(20;Body;BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(25;HtmlFormatted;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27;"Created By";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(28;"Date Created";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(29;"Time Created";Time)
        {
            DataClassification = ToBeClassified;
        }
        field(30;"Email Sent";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31;"Date Sent";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(32;"Time Sent";Time)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

