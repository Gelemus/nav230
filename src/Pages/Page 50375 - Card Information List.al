page 50375 "Card Information List"
{
    CardPageID = "Card Information";
    PageType = List;
    SourceTable = "Card Information";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Card No Code"; Rec."Card No Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Date created"; Rec."Date created")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Time created"; Rec."Time created")
                {
                }
            }
        }
    }

    actions
    {
    }
}

