page 51371 "Pre-Qualification Subform"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Tender Lines";
    SourceTableView = WHERE("Document Type" = CONST("Registration of Supplier"));

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
                field("Document Type"; Rec."Document Type")
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
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Reward1)
            {
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*CONFIRM('Do you wish to initaite Evaluation for this Tender') THEN BEGIN
                    Employee.RESET;
                    IF Employee.FINDFIRST THEN BEGIN
                      Employee.SETRANGE("No.",Employee."User ID",USERID);
                    MESSAGE(EprocurementCodeunit.CreateTenderEvaluations(Rec."No.",TODAY,Employee."No."));
                    END;
                    END;*/

                end;
            }
            action(Reject1)
            {
                Image = "Page";
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Tender Evaluation Card.";
            }
        }
    }

    local procedure Reward()
    begin
    end;

    local procedure Reject()
    begin
    end;
}

