page 50110 "Tender Evaluation Card"
{
    DeleteAllowed = false;
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Tender Evaluation";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Evaluation No."; Rec."Evaluation No.")
                {
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
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
                field("Evaluation Criteria"; Rec."Evaluation Criteria")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            part(Control12; "Tender Evaluation Lines")
            {
                SubPageLink = "Document No." = FIELD("Evaluation No.");
                ApplicationArea =All;
                Caption = 'Tender Evaluation Lines';
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

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Submitted then
            CurrPage.Editable(false);
    end;

    var
        Txt060: Label 'Are you sure you want to submit this record?';
        AlreadySubmitted: Label 'Current record has already been submitted.';
}

