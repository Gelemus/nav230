page 51368 "Applications to Evaluate"
{
    // CardPageID = 51367;
    PageType = List;
    SourceTable = "Tender Header";
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
                }
                field(Eligibility; Rec.Eligibility)
                {
                }
                field("Tender Submission (From)"; Rec."Tender Submission (From)")
                {
                }
                field("Tender Submission (To)"; Rec."Tender Submission (To)")
                {
                }
                field("Tender Status"; Rec."Tender Status")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Tender Closing Date"; Rec."Tender Closing Date")
                {
                }
                field("Evaluation Date"; Rec."Evaluation Date")
                {
                }
                field("Award Date"; Rec."Award Date")
                {
                }
                field("Supplier Awarded"; Rec."Supplier Awarded")
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field("Tender closed by"; Rec."Tender closed by")
                {
                }
                field("Supplier Category"; Rec."Supplier Category")
                {
                }
                field("Supplier Category Description"; Rec."Supplier Category Description")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Tender Preparation Approved"; Rec."Tender Preparation Approved")
                {
                }
                field("Name of the Procuring Entity"; Rec."Name of the Procuring Entity")
                {
                }
                field("Tender No"; Rec."Tender No")
                {
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
            }
        }
    }
}

