page 50331 "Load Fuel Card List"
{
    CardPageID = "Load Fuel Card";
    PageType = List;
    SourceTable = "Vehicle Filling";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loading Date"; Rec."Loading Date")
                {
                    Caption = '<Loading Date>';
                }
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
            }
        }
    }

    actions
    {
    }
}

