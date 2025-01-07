table 56026 "Complaints set-ups"
{

    fields
    {
        field(1;"Code";Code[10])
        {
        }
        field(2;Type;Option)
        {
            OptionCaption = 'Complaint,Feedback,Suggestion,Complimemnt';
            OptionMembers = Complaint,Feedback,Suggestion,Complimemnt;
        }
        field(3;Description;Text[50])
        {
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
    }

    fieldgroups
    {
    }
}

