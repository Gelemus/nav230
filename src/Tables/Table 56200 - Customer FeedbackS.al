table 56200 "Customer FeedbackS"
{

    fields
    {
        field(1;No;Code[20])
        {
        }
        field(2;"Customer Name";Text[250])
        {
        }
        field(3;"Feedback Date";Date)
        {
        }
        field(4;Description;Text[250])
        {
        }
        field(5;"Action";Text[250])
        {
        }
        field(6;"Created By";Code[100])
        {
            Editable = false;
            Enabled = true;
        }
        field(7;"Date created";Date)
        {
            Editable = false;
        }
        field(8;"Time created";Time)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;No)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Date created" := Today;
        "Time created" := Time;
        "Feedback Date" := Today;
    end;
}

