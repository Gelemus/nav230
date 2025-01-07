page 50255 "HR Approved Training Need List"
{
    Caption = 'HR Approved Training Needs List';
    CardPageID = "HR Approved Training Need Card";
    PageType = List;
    SourceTable = "Approved Training Needs Header";

    layout
    {
        area(content)
        {
            repeater(General)
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
        }
    }

    actions
    {
        area(processing)
        {
            action("Approved Training Report")
            {
                Caption = 'Management Approved Training Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovedTrainingNeedsLine.Reset;
                    ApprovedTrainingNeedsLine.SetRange(ApprovedTrainingNeedsLine."No.", Rec."No.");
                    if ApprovedTrainingNeedsLine.FindFirst then begin
                        REPORT.RunModal(REPORT::"Approved Training Needs report", true, false, ApprovedTrainingNeedsLine);
                    end;
                end;
            }
        }
    }

    var
        ApprovedTrainingNeedsLine: Record "Approved Training Needs Line";
}

