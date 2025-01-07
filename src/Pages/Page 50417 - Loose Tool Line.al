page 50417 "Loose Tool Line"
{
    PageType = ListPart;
    SourceTable = "Store Requisition Line";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Loose Tool No."; Rec."Loose Tool No.")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                    Visible = false;
                }
                field("Item Description"; Rec."Item Description")
                {
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
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
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
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

