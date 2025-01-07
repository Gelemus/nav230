page 51352 "Request for proposals"
{
    CardPageID = "Request for Proposal Card";
    PageType = List;
    SourceTable = "Tender Header";
    ApplicationArea = All;
    SourceTableView = WHERE("Document Type" = CONST("Request for Proposal"));

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
                field("Purchase Requisition"; Rec."Purchase Requisition")
                {
                }
                field("Purchase Req. Description"; Rec."Purchase Req. Description")
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
                field("Held By"; Rec."Held By")
                {
                }
                field("Name of the Procuring Entity"; Rec."Name of the Procuring Entity")
                {
                }
                field("Tender No"; Rec."Tender No")
                {
                }
                field("Date Tender Invited"; Rec."Date Tender Invited")
                {
                }
                field("Date Tender Opened"; Rec."Date Tender Opened")
                {
                }
                field("No. of Tendererd Issued with"; Rec."No. of Tendererd Issued with")
                {
                }
                field("No. of Bids Received"; Rec."No. of Bids Received")
                {
                }
                field("Method of Procurement Applied"; Rec."Method of Procurement Applied")
                {
                }
                field("A brief background statement"; Rec."A brief background statement")
                {
                }
                field("State whether due diligence wa"; Rec."State whether due diligence wa")
                {
                }
                field("State whether the recom"; Rec."State whether the recom")
                {
                }
                field("State how evaluation criteria"; Rec."State how evaluation criteria")
                {
                }
                field("Confirm if adequate funds are"; Rec."Confirm if adequate funds are")
                {
                }
                field("Give opinion whether procureme"; Rec."Give opinion whether procureme")
                {
                }
                field("Any relevant information"; Rec."Any relevant information")
                {
                }
                field("Special Condition"; Rec."Special Condition")
                {
                }
                field("Type of supply"; Rec."Type of supply")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Financial Year Start Date"; Rec."Financial Year Start Date")
                {
                }
                field("Financial Year End Date"; Rec."Financial Year End Date")
                {
                }
                field("Financial Year"; Rec."Financial Year")
                {
                }
                field("Special Group"; Rec."Special Group")
                {
                }
                field("Tender Closing Time"; Rec."Tender Closing Time")
                {
                }
                field("Tender Opening Date"; Rec."Tender Opening Date")
                {
                }
                field("Tender Opening Time"; Rec."Tender Opening Time")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::"Request for Proposal";
    end;
}

