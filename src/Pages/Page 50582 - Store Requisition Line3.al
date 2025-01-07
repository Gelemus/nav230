page 50582 "Store Requisition Line3"
{
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Store Requisition Line";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field("Item Description"; Rec."Item Description")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                }
                field(Inventory; Rec.Inventory)
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field("Line Amount"; Rec."Line Amount")
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field("Total Sale Amount"; Rec."Total Sale Amount")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        StoreReq: Record "Store Requisition Line";
        StoreReq2: Record "Store Requisition Line";
}

