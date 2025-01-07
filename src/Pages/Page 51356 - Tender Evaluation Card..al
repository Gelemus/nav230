page 51356 "Tender Evaluation Card."
{
    PageType = Card;
    SourceTable = "Tender Evaluation";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Evaluation No."; Rec."Evaluation No.")
                {
                }
                field("Tender No."; Rec."Tender No.")
                {
                }
                field("Tender Date"; Rec."Tender Date")
                {
                }
                field("Tender Close Date"; Rec."Tender Close Date")
                {
                }
                field("Evaluation Date"; Rec."Evaluation Date")
                {
                }
                field(Supplier; Rec.Supplier)
                {
                }
                field(Marks; Rec.Marks)
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Evaluation Criteria"; Rec."Evaluation Criteria")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field(Eligibility; Rec.Eligibility)
                {
                }
                field("Application No"; Rec."Application No")
                {
                }
                field("Supplier Profile ID"; Rec."Supplier Profile ID")
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field("Evaluator Name"; Rec."Evaluator Name")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
            }
            part(Control22; "Tender Evaluation Subform")
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Submit)
            {
                Caption = 'Submit';
                Image = Migration;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Submitted then Error(AlreadySubmitted);

                    if Confirm(Txt060) = false then exit;

                    Rec.Status := Rec.Status::Submitted;
                    Rec.Modify;
                    CurrPage.Close;
                end;
            }
        }
    }

    var
        Txt060: Label 'Are you sure you want to submit this record?';
        AlreadySubmitted: Label 'Current record has already been submitted.';
}

