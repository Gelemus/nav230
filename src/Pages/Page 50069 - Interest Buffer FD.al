page 50069 "Interest Buffer FD"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Interest Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No"; Rec."Account No")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Interest Date"; Rec."Interest Date")
                {
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field(Transferred; Rec.Transferred)
                {
                }
            }
        }
    }

    actions
    {
    }
}

