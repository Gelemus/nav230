page 50116 "Store Requisition Line"
{
    PageType = ListPart;
    SourceTable = "Store Requisition Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Item No."; Rec."Item No.")
                {
                }
                field("Item Description"; Rec."Item Description")
                {
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field(Inventory; Rec.Inventory)
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {

                    trigger OnValidate()
                    begin
                        Rec."Quantity to issue" := Rec.Quantity;
                    end;
                }
                field("Quantity to issue"; Rec."Quantity to issue")
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field("Total Sale Amount"; Rec."Total Sale Amount")
                {
                    Editable = false;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Editable = false;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field(Returned; Rec.Returned)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

