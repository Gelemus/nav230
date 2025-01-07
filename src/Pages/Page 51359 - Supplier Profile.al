page 51359 "Supplier Profile"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Supplier Profile";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field("Supplier Telephone"; Rec."Supplier Telephone")
                {
                }
                field("Supplier Company Name"; Rec."Supplier Company Name")
                {
                }
                field("Supplier Physical Address"; Rec."Supplier Physical Address")
                {
                }
                field("Supplier Postal Address"; Rec."Supplier Postal Address")
                {
                }
                field("Supplier Email"; Rec."Supplier Email")
                {
                }
                field("Supplier Website"; Rec."Supplier Website")
                {
                }
                field("Supplier Legal Status"; Rec."Supplier Legal Status")
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

