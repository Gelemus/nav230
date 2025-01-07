pageextension 60279 pageextension60279 extends "Purchases & Payables Setup"
{

    layout

    {
        addafter("Posted Invoice Nos.")
        {
            field("Inspection Nos"; Rec."Inspection Nos")
            {
                ApplicationArea = all;
            }
        }
        addafter("Posted Prepmt. Cr. Memo Nos.")
        {
            field("Purchase Requisition Nos."; Rec."Purchase Requisition Nos.")
            {
                ApplicationArea = all;
            }
            field("Requisition Nos."; Rec."Requisition Nos.")
            {
                ApplicationArea = all;

            }
            field("Request for Quotation Nos."; Rec."Request for Quotation Nos.")
            {
                ApplicationArea = All;
            }
            field("Procurement Plan Nos"; Rec."Procurement Plan Nos")
            {
                ApplicationArea = all;
            }
            field("Use Procurement Plan"; Rec."Use Procurement Plan")
            {
            }
            field("Tender Doc No."; Rec."Tender Doc No.")
            {
                ApplicationArea = all;
            }
            field("Prequalification Nos"; Rec."Prequalification Nos")
            {
                ApplicationArea = all;
            }
            field("User to replenish Stock"; Rec."User to replenish Stock")
            {
                ApplicationArea = all;
            }
            field("Tender Evaluation No."; Rec."Tender Evaluation No.")
            {
                ApplicationArea = All;
            }
            field("Request For Proposal"; Rec."Request For Proposal")
            {
                ApplicationArea = All;
            }
        }
    }
}

