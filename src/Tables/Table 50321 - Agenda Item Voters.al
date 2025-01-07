table 50321 "Agenda Item Voters"
{

    fields
    {
        field(1;"Voter ID";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Agenda Vote Item code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Agenda vote items";
        }
        field(3;Name;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Voted;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Vote decision";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Yes,No,Abstain';
            OptionMembers = Yes,No,Abstain;
        }
        field(6;"Meeting No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Board Meeting";
        }
        field(7;"Agenda No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Meeting Agenda";
        }
        field(8;"Entry No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Entry No","Voter ID","Agenda Vote Item code","Agenda No","Meeting No")
        {
        }
    }

    fieldgroups
    {
    }
}

