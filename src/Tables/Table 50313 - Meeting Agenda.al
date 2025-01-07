table 50313 "Meeting Agenda"
{

    fields
    {
        field(1;"Meeting No";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Line No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3;"Agenda Code";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Agenda Item";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Agenda Papers";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Scheduled Time";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7;Purpose;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Type of Agenda";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Agenda,Sub-agenda';
            OptionMembers = Agenda,"Sub-agenda";
        }
    }

    keys
    {
        key(Key1;"Agenda Code","Meeting No","Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

