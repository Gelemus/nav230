page 51366 "Tender Questions"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Tender Answers";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No"; Rec."Line No")
                {
                }
                field("Question Description"; Rec."Question Description")
                {
                }
                field(Answer; Rec.Answer)
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Date Update"; Rec."Date Update")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Updated By"; Rec."Updated By")
                {
                }
                field("Document No"; Rec."Document No")
                {
                }
                field("Question ID"; Rec."Question ID")
                {
                }
                field("Supplier Profile ID"; Rec."Supplier Profile ID")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("<Control13>")
                {
                    Caption = 'Reward';
                }
                action("<Control14>")
                {
                    Caption = 'Reject';
                }
            }
        }
    }

    local procedure Reward()
    var
        "Tender Evaluations line": Record "Tender Evaluation Line";
    begin
    end;

    local procedure Reject("Tender Evaluation Line": Record "Tender Evaluation Line")
    begin
    end;
}

