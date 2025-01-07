page 50090 "Bid Analysis Line"
{
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Bid Analysis Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                }
                field("Purchase Quote No."; Rec."Purchase Quote No.")
                {
                }
                field("Purchase Quote Date"; Rec."Purchase Quote Date")
                {
                }
                field("Quote Amount Incl VAT"; Rec."Quote Amount Incl VAT")
                {
                }
                field("Meets Specifications"; Rec."Meets Specifications")
                {
                }
                field("Delivery/Lead Time"; Rec."Delivery/Lead Time")
                {
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                }
                field(Award; Rec.Award)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Quote Lines")
            {
                Caption = 'Quote Lines';
                action("Purchase Quote Line")
                {
                    Caption = 'Purchase Quote Line';
                    RunObject = Page "Purchase Quote Subform";
                    RunPageLink = "Buy-from Vendor No." = FIELD("Vendor No."),
                                  "Document No." = FIELD("Purchase Quote No.");
                }
            }
        }
    }
}

