page 51360 Directors
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Tender Directors";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No"; Rec."Line No")
                {
                }
                field("Application No"; Rec."Application No")
                {
                }
                field("Director Name"; Rec."Director Name")
                {
                }
                field("Director Nationality"; Rec."Director Nationality")
                {
                }
                field("Director Shares"; Rec."Director Shares")
                {
                }
                field(Status; Rec.Status)
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

