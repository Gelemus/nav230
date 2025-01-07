page 51361 "Experience Subform"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Tender Experience";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No"; Rec."Line No")
                {
                }
                field("Attach URL"; Rec."Attach URL")
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
                field(Type; Rec.Type)
                {
                }
                field("Supplier Profile ID"; Rec."Supplier Profile ID")
                {
                }
                field(Description; Rec.Description)
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

