page 51372 "Supplier Registrations"
{
    CardPageID = "Supplier Registration CardII";
    PageType = List;
    SourceTable = "Tender Header";
    ApplicationArea = All;
    SourceTableView = WHERE("Document Type" = CONST("Registration of Supplier"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Tender Description"; Rec."Tender Description")
                {
                    Caption = 'Pre-Qualification Description';
                }
                field(Eligibility; Rec.Eligibility)
                {
                }
                field("Tender No"; Rec."Tender No")
                {
                    Caption = '<Prequalification Registration No>';
                }
                field("Tender Submission (From)"; Rec."Tender Submission (From)")
                {
                    Caption = '<Prequalification Submission (From)>';
                }
                field("Tender Submission (To)"; Rec."Tender Submission (To)")
                {
                    Caption = '<Prequalification Submission (To)>';
                }
                field("Tender Status"; Rec."Tender Status")
                {
                    Caption = '<Prequalification Status>';
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Tender Closing Date"; Rec."Tender Closing Date")
                {
                    Caption = '<Prequalification Closing Date>';
                }
                field("Evaluation Date"; Rec."Evaluation Date")
                {
                    Visible = false;
                }
                field("Award Date"; Rec."Award Date")
                {
                    Visible = false;
                }
                field("Supplier Awarded"; Rec."Supplier Awarded")
                {
                    Visible = false;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    Visible = false;
                }
                field("No. Series"; Rec."No. Series")
                {
                    Visible = false;
                }
                field("Tender closed by"; Rec."Tender closed by")
                {
                    Caption = 'Prequalification closed by>';
                    Visible = false;
                }
                field("Supplier Category"; Rec."Supplier Category")
                {
                    Visible = false;
                }
                field("Supplier Category Description"; Rec."Supplier Category Description")
                {
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                }
                field("Tender Preparation Approved"; Rec."Tender Preparation Approved")
                {
                    Caption = '<Prequalification Preparation Approved>';
                    Visible = false;
                }
                field("Name of the Procuring Entity"; Rec."Name of the Procuring Entity")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("View Applications")
            {
                Image = "Page";
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Tender Applications.";
                RunPageView = WHERE("Document Type" = CONST("Registration of Supplier"));
            }
        }
    }
}

