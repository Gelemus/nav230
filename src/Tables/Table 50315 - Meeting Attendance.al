table 50315 "Meeting Attendance"
{

    fields
    {
        field(1;"Meeting No";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Member No";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Committee Code";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Committee Name";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Meeting Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Meeting Name";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7;Venue;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Member Name";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9;"In attendance";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Visitor Institution";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11;Remarks;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Entry No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(13;"Type of Participant";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Committee Member,In Attendance,Member';
            OptionMembers = "Committee Member","In Attendance",Member;
        }
        field(14;"Meeting Role";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Attendance during the meeting";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Present,Absent,Absent With Apology';
            OptionMembers = " ",Present,Absent,"Absent With Apology";
        }
        field(16;"Confirmation of an invitation";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,Maybe,No';
            OptionMembers = " ",Yes,Maybe,No;
        }
        field(17;"Absentism Reason";Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Meeting No","Entry No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        BoardMeeting: Record "Board Meeting";
}

