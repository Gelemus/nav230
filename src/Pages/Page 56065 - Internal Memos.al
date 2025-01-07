page 56065 "Internal Memos"
{
    CardPageID = "Internal Memo";
    PageType = List;
    SourceTable = "Internal Memos";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(RE; Rec.RE)
                {
                }
                field("Employee UserID"; Rec."Employee UserID")
                {
                }
                field(From; Rec.From)
                {
                }
                field("To CEO"; Rec."To CEO")
                {
                }
                field(Through; Rec.Through)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control10; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

