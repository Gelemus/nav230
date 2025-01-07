page 51357 "Tender Evaluation Subform"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Tender Evaluation Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                }
                field("Tender No."; Rec."Tender No.")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field(Requirements; Rec.Requirements)
                {
                }
                field(Marks; Rec.Marks)
                {
                }
                field("Marks Assigned"; Rec."Marks Assigned")
                {
                }
                field("Conformity Status"; Rec."Conformity Status")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field(Evaluator; Rec.Evaluator)
                {
                }
                field("Evaluator Name"; Rec."Evaluator Name")
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

