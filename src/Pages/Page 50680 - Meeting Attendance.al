page 50680 "Meeting Attendance"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Meeting Attendance";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Meeting No"; Rec."Meeting No")
                {
                }
                field("Meeting Name"; Rec."Meeting Name")
                {
                }
                field("Meeting Date"; Rec."Meeting Date")
                {
                }
                field("Type of Participant"; Rec."Type of Participant")
                {
                }
                field("Committee Code"; Rec."Committee Code")
                {
                }
                field("Committee Name"; Rec."Committee Name")
                {
                }
                field(Venue; Rec.Venue)
                {
                }
                field("Member No"; Rec."Member No")
                {
                }
                field("Member Name"; Rec."Member Name")
                {
                }
                field("In attendance"; Rec."In attendance")
                {
                }
                field("Visitor Institution"; Rec."Visitor Institution")
                {
                }
                field("Meeting Role"; Rec."Meeting Role")
                {
                }
                field("Attendance during the meeting"; Rec."Attendance during the meeting")
                {
                }
                field("Confirmation of an invitation"; Rec."Confirmation of an invitation")
                {
                }
            }
        }
    }

    actions
    {
    }
}

