page 51373 "Tender Processing Subform"
{
    PageType = ListPart;
    SourceTable = "Tender Lines";
    SourceTableView = WHERE("Document Type" = CONST("Open Tender"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                }
                field("Document No."; Rec."Document No.")
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
                field("Firm Name"; Rec."Firm Name")
                {
                }
                field(Telephone; Rec.Telephone)
                {
                }
                field(Location; Rec.Location)
                {
                }
                field("Legal status"; Rec."Legal status")
                {
                }
                field("Incorporation Year"; Rec."Incorporation Year")
                {
                }
                field("Business Nature"; Rec."Business Nature")
                {
                }
                field("Max Business Value"; Rec."Max Business Value")
                {
                }
                field("Bankers Name"; Rec."Bankers Name")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Date Created"; Rec."Date Created")
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
                field("KRA PIN"; Rec."KRA PIN")
                {
                }
                field("Supplier Profile ID"; Rec."Supplier Profile ID")
                {
                }
                field("Approval Remarks"; Rec."Approval Remarks")
                {
                }
                field("Recommendation Remarks"; Rec."Recommendation Remarks")
                {
                }
                field(Score; Rec.Score)
                {
                }
                field("Recommendation By"; Rec."Recommendation By")
                {
                }
                field("Approved By"; Rec."Approved By")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Updated By"; Rec."Updated By")
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
                field("Document Type"; Rec."Document Type")
                {
                }
            }
        }
    }

    actions
    {
    }
}

