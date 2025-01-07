page 51354 "Tender Applications Card"
{
    PageType = Card;
    SourceTable = "Tender Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Line No."; Rec."Line No.")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Reason for Disqualification"; Rec."Reason for Disqualification")
                {
                }
                field(Disqualified; Rec.Disqualified)
                {
                }
                field("Disqualification point"; Rec."Disqualification point")
                {
                }
                field("Bid Amount"; Rec."Bid Amount")
                {
                }
                field("Supplier No."; Rec."Supplier No.")
                {
                }
                field("Application No"; Rec."Application No")
                {
                }
                field("Date Updated"; Rec."Date Updated")
                {
                }
                field("Business Registration Name"; Rec."Business Registration Name")
                {
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                }
                field(Website; Rec.Website)
                {
                }
                field("Recommendation Date"; Rec."Recommendation Date")
                {
                }
                field("Recommendation Status"; Rec."Recommendation Status")
                {
                }
                field("Approval status"; Rec."Approval status")
                {
                }
            }
            part(Control16; "Supplier Profile")
            {
                // SubPageLink = No=FIELD("Supplier Profile ID");
            }
            part("Supplier Profile Document"; "Supplier Profile Document")
            {
                Caption = 'Supplier Profile Document';
            }
            part("Supplier Bank Information"; "Bank Infor Subform")
            {
                Caption = 'Supplier Bank Information';
                SubPageLink = "Document No" = FIELD("Application No");
            }
            part(Control22; Directors)
            {
                SubPageLink = "Application No" = FIELD("Application No");
            }
            part("Supplier Competence"; "Tender Questions")
            {
                Caption = 'Supplier Competence';
                SubPageLink = "Document No" = FIELD("Application No");
            }
            part("Supplier Experience"; "Experience Subform")
            {
                Caption = 'Supplier Experience';
                SubPageLink = "Document No" = FIELD("Application No");
            }
            part(Control20; "Financial Capability Subform")
            {
                SubPageLink = "Document No" = FIELD("Application No");
            }
            part(Control19; "Personnel Subform")
            {
                SubPageLink = "Document No" = FIELD("Application No");
            }
            part(Control21; "Litigation History")
            {
                SubPageLink = "Document No" = FIELD("Application No");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Tender Evaluations")
            {
                Caption = 'View Tender Evaluation';
            }
            action("View Tender Evaluation")
            {
                Image = "page";
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Supplier Evaluation";
                RunPageLink = "Application No" = FIELD("Application No");
                RunPageOnRec = true;
            }
        }
    }
}

