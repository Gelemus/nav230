pageextension 60760 pageextension60760 extends "Purchase Order Archives"
{
    layout
    {
        addafter("Buy-from Vendor No.")
        {
            field("Reference No"; Rec."Reference No")
            {
            }
        }
    }
}

