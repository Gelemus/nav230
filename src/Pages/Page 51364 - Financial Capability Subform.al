page 51364 "Financial Capability Subform"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Tender Financial Capability";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No"; Rec."Line No")
                {
                }
                field("Total Assets"; Rec."Total Assets")
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
                field("Current Assets"; Rec."Current Assets")
                {
                }
                field("Supplier Profile ID"; Rec."Supplier Profile ID")
                {
                }
                field("Total Liabities"; Rec."Total Liabities")
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

