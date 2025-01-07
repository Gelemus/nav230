pageextension 60421 pageextension60421 extends "Item Category Card"
{
    layout
    {
        addafter(Description)
        {
            field("Item Budget G/L"; Rec."Item Budget G/L")
            {
            }
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
            }
        }
    }
}

