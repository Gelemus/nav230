page 50084 "Requisition Line"
{
    PageType = ListPart;
    SourceTable = "Purchase Requisition Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Requisition Type"; Rec."Requisition Type")
                {
                    OptionCaption = ' G/L Account,Item,Fixed Asset';
                    ToolTip = 'Specifies the requisition type( G/L Account,Item or Fixed Asset) selection for the purchase requisition line';
                    Visible = false;
                }
                field("Requisition Code"; Rec."Requisition Code")
                {
                    ToolTip = 'Specifies the requisition code lookup for the purchase requisition line, based on the requisition type selection';
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the item/service/fixed asset being requisitioned';
                }
                field("Vendor No"; Rec."Vendor No")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location for the item on the purchase requisition line';
                }
                field(Inventory; Rec.Inventory)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the quantity of item/service/fixed asset to be purchased';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("Market Price"; Rec."Market Price")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Estimate Cost"; Rec."Unit Cost")
                {
                    Caption = 'Estimate Cost';
                }
                field("Unit Cost(LCY)"; Rec."Unit Cost(LCY)")
                {
                }
                field("Total Cost"; Rec."Total Cost")
                {
                }
                field("Total Cost(LCY)"; Rec."Total Cost(LCY)")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 3, which is one of six shortcut dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                }
                field(Budget; Rec.Budget)
                {
                }
                field("Vat Prod. Posting Group"; Rec."Vat Prod. Posting Group")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Specification Attributes")
            {
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Specifications Attributes";
                RunPageLink = "RFQ No." = FIELD("Document No."),
                              Type = FIELD("Type (Attributes)"),
                              Item = FIELD("No.");
            }
        }
    }
}

