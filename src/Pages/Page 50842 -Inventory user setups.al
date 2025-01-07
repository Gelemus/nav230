namespace spaBC.spaBC;

page 50842 "Inventory user setups"
{
    ApplicationArea = All;
    Caption = 'Inventory User  Setups';
    PageType = Card;
    SourceTable = "Inventory User Setup";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                // ApplicationArea = All;
                field("Item Journal Template"; Rec."Item Journal Template")
                {
                    ToolTip = 'Specifies the value of the Item Journal Template field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Item Journal Batch"; Rec."Item Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Item Journal Batch field.', Comment = '%';
                    ApplicationArea = All;
                }
                field(UserID; Rec.UserID)
                {
                    ToolTip = 'Specifies the value of the UserID field.', Comment = '%';
                    ApplicationArea = All;
                }
            }
        }
    }
}

