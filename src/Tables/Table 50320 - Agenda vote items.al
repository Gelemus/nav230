table 50320 "Agenda vote items"
{

    fields
    {
        field(1;"Item No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Meeting No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Board Meeting";
        }
        field(3;"Agenda No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Meeting Agenda"."Agenda Code";

            trigger OnValidate()
            begin
                MeetingAgender.Reset;
                MeetingAgender.SetRange("Agenda Code", "Agenda No");
                if MeetingAgender.FindFirst then
                  Description := MeetingAgender."Agenda Item";
            end;
        }
        field(4;Description;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Yes Count";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"No Count";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Abstain Count";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Total Votes";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9;Status;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Planned,Active,Completed';
            OptionMembers = Planned,Active,Completed;
        }
        field(10;"Vote start Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Vote start Time";Time)
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Vote Enda date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Vote Enda Time";Time)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Item No","Agenda No","Meeting No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        MeetingAgender: Record "Meeting Agenda";
}

