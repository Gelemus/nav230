page 50354 "Card Ledger Entries"
{
    PageType = List;
    SourceTable = "Card  Ledger Entries";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    Visible = false;
                }
                field("Card no"; Rec."Card no")
                {
                    Caption = 'Card No';
                }
                field("Card Description"; Rec."Card Description")
                {
                }
                field("Balance BF"; Rec."Balance BF")
                {
                }
                field("Amount Loaded"; Rec."Amount Loaded")
                {
                }
                field("Loaded By"; Rec."Loaded By")
                {
                }
                field("Loading Date"; Rec."Loading Date")
                {
                }
                field("Date Filter"; Rec."Date Filter")
                {
                }
            }
        }
    }

    actions
    {
    }
}

