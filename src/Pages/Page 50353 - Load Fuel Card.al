page 50353 "Load Fuel Card"
{
    PageType = Card;
    SourceTable = "Vehicle Filling";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Card Description"; Rec."Card Description")
                {
                }
                field("Card No"; Rec."Card No")
                {
                }
                field("Balance BF"; Rec."Balance BF")
                {
                }
                field("Amount Loaded"; Rec."Amount Loaded")
                {
                }
                field("Balance CF"; Rec."Balance CF")
                {
                }
                field("Loading Date"; Rec."Loading Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

