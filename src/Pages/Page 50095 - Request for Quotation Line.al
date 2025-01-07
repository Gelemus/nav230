page 50095 "Request for Quotation Line"
{
    PageType = ListPart;
    SourceTable = "Request for Quotation Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ToolTip = 'Specifies the field name';
                    Visible = false;
                }
                field("Requisition Code"; Rec."Requisition Code")
                {
                    ToolTip = 'Specifies the field name';
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the field name';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Market Price"; Rec."Market Price")
                {
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    Visible = false;
                }
                field("Total Cost(LCY)"; Rec."Total Cost(LCY)")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the field name';
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the field name';
                    Visible = false;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the field name';
                    Visible = false;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the field name';
                    Visible = false;
                }
                field("Purchase Requisition No."; Rec."Purchase Requisition No.")
                {
                }
                field("Purchase Requisition Line"; Rec."Purchase Requisition Line")
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

