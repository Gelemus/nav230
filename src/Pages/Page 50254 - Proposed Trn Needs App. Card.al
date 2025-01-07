page 50254 "Proposed Trn Needs App. Card"
{
    Caption = 'Proposed Training Needs  Card';
    PageType = Card;
    SourceTable = "HR Training Needs Header";
    SourceTableView = WHERE(Status = CONST(Approved));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Job No."; Rec."Job No.")
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Date of Request"; Rec."Date of Request")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
            part(Control4; "Training Needs App. Line")
            {
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Employee Appraisal Card")
            {
                Image = AnalysisView;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Employee Appraisals";
                RunPageLink = "Employee No." = FIELD("Employee No.");
                ToolTip = 'Specifies the  Employee Appraisal card';
            }
        }
    }
}

