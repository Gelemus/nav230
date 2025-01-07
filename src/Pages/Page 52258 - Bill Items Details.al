page 52258 "Bill Items Details"
{
    PageType = ListPart;
    SourceTable = "Bill Item";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill Item No."; Rec."Bill Item No.")
                {
                }
                field(Components; Rec.Components)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Bill Item Type"; Rec."Bill Item Type")
                {
                }
                field("% of works done per bill item"; Rec."% of works done per bill item")
                {
                    Visible = false;
                }
                field("Summary works done"; Rec."Summary works done")
                {
                }
                field("Site Deliveries"; Rec."Site Deliveries")
                {
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    Visible = false;
                }
                field("WIP-Total"; Rec."WIP-Total")
                {
                    Visible = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    Caption = 'Date';
                }
                field("End Date"; Rec."End Date")
                {
                    Visible = false;
                }
                field(Indentation; Rec.Indentation)
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

