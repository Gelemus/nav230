page 50050 "Funds Account Activities"
{
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Funds Management Cue";

    layout
    {
        area(content)
        {
            cuegroup("Accounts Payable")
            {
                Caption = 'Accounts Payable';
                field("Purchase Invoices"; Rec."Purchase Invoices")
                {
                    DrillDownPageID = "Payment List";
                    ToolTip = 'Specifies the payments';
                }
                field("Posted Purchase Invoices"; Rec."Posted Purchase Invoices")
                {
                    DrillDownPageID = "Posted Payment List";
                    ToolTip = 'Specifies the payments';
                }
                field("Purchase Cr. Memos"; Rec."Purchase Cr. Memos")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Posted Purchase Cr. Memos"; Rec."Posted Purchase Cr. Memos")
                {
                    DrillDownPageID = "Payment List";
                    ToolTip = 'Specifies the payments';
                }
            }
            cuegroup(Payments)
            {
                Caption = 'Payments';
                field("Open Payments"; Rec."Open Payments")
                {
                    DrillDownPageID = "Payment List";
                    ToolTip = 'Specifies the payments';
                }
                field("Posted Payments"; Rec."Posted Payments")
                {
                    DrillDownPageID = "Posted Payment List";
                    ToolTip = 'Specifies the payments';
                }
                field("Reversed Payments"; Rec."Reversed Payments")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Open Cash Payments"; Rec."Open Cash Payments")
                {
                    DrillDownPageID = "Payment List";
                    ToolTip = 'Specifies the payments';
                }
                field("Posted Cash Payments"; Rec."Posted Cash Payments")
                {
                }
                field("Reversed Cash Payments"; Rec."Reversed Cash Payments")
                {
                }
            }
            cuegroup("Accounts Receivable")
            {
                Caption = 'Accounts Receivable';
                field("Sales Invoices"; Rec."Sales Invoices")
                {
                    DrillDownPageID = "Payment List";
                    ToolTip = 'Specifies the payments';
                }
                field("Posted Sales Invoices"; Rec."Posted Sales Invoices")
                {
                    DrillDownPageID = "Posted Payment List";
                    ToolTip = 'Specifies the payments';
                }
                field("Sales Cr. Memos"; Rec."Sales Cr. Memos")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Posted Sales Cr. Memos"; Rec."Posted Sales Cr. Memos")
                {
                    DrillDownPageID = "Payment List";
                    ToolTip = 'Specifies the payments';
                }
            }
            cuegroup(Receipt)
            {
                Caption = 'Receipts';
                field(Receipts; Rec.Receipts)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Cash;
                    ToolTip = 'Specifies the field name';
                }
                field("Posted Receipts"; Rec."Posted Receipts")
                {
                }
            }
            cuegroup("Imprest and Surrenders")
            {
                Caption = 'Imprest and Surrenders';
                field(Imprests; Rec.Imprests)
                {
                    DrillDownPageID = "Payment List";
                    ToolTip = 'Specifies the payments';
                }
                field("Posted Imprests"; Rec."Posted Imprests")
                {
                    DrillDownPageID = "Posted Payment List";
                    ToolTip = 'Specifies the payments';
                }
                field("Reversed Imprests"; Rec."Reversed Imprests")
                {
                }
                field("Imprest Surrenders"; Rec."Imprest Surrenders")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Posted Imprest Surrenders"; Rec."Posted Imprest Surrenders")
                {
                    DrillDownPageID = "Payment List";
                    ToolTip = 'Specifies the payments';
                }
                field("Reversed Imprest Surrenders"; Rec."Reversed Imprest Surrenders")
                {
                }
            }
            cuegroup("Funds Transfers")
            {
                Caption = 'Funds Transfers';
                field("Funds Transfer"; Rec."Funds Transfer")
                {
                    DrillDownPageID = "Payment List";
                    ToolTip = 'Specifies the payments';
                }
                field("Posted Funds Transfer"; Rec."Posted Funds Transfer")
                {
                    DrillDownPageID = "Posted Payment List";
                    ToolTip = 'Specifies the payments';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;
}

