page 50256 "HR Approved Training Need Card"
{
    Caption = 'HR Approved Training Needs Card';
    PageType = Card;
    SourceTable = "Approved Training Needs Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Calendar Year"; Rec."Calendar Year")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
            part(Control4; "HR Approved Training Line")
            {
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Insert Proposed Trainings")
            {
                Caption = 'Insert Proposed Trainings for Employees';
                Image = Hierarchy;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    HRTrainingManagement.InsertProposedTrainingForEmployees(Rec."Calendar Year", Rec."No.");
                end;
            }
            action("Approved Training Report")
            {
                Caption = 'Management Approved Training Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
            }
        }
    }

    var
        HRTrainingNeedsLine: Record "HR Training Needs Line";
        HRTrainingNeedsHeader: Record "HR Training Needs Header";
        HRTrainingManagement: Codeunit "HR Training Management";
        ApprovedTrainingNeedsLine: Record "Approved Training Needs Line";
}

