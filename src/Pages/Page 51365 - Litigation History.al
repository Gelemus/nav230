page 51365 "Litigation History"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Tender Litigation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No"; Rec."Line No")
                {
                }
                field(Year; Rec.Year)
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Supplier Profile ID"; Rec."Supplier Profile ID")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Disputed Amount"; Rec."Disputed Amount")
                {
                }
                field("Award for/or Aganist"; Rec."Award for/or Aganist")
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

