pageextension 60021 pageextension60021 extends "Inventory Posting Groups"
{
    layout
    {
        addafter("Code")
        {
            field("Budget G/L Account"; Rec."Budget G/L Account")
            {
            }
            field("Budget G/L Account Name"; Rec."Budget G/L Account Name")
            {
            }
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "GetSelectionFilter(PROCEDURE 3)".

}

