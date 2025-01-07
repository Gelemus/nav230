page 50679 "Meeting Comments"
{
    PageType = List;
    SourceTable = "Meeting Comments";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                }
                field("Meeting No"; Rec."Meeting No")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Member No"; Rec."Member No")
                {
                }
                field("Time Created"; Rec."Time Created")
                {
                }
            }
        }
    }

    actions
    {
    }
}

