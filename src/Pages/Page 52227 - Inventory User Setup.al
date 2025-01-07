page 52227 "Inventory User Setup"
{
    PageType = List;
    SourceTable = "Inventory User Setup";
    CardPageId = "Inventory user setups";
    InsertAllowed = true;
    ModifyAllowed = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(UserID; UserID)
                {
                }
                field("Item Journal Template"; Rec."Item Journal Template")
                {
                }
                field("Item Journal Batch"; Rec."Item Journal Batch")
                {
                }
            }
        }
    }

    actions
    {
    }
}

