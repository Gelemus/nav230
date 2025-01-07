page 50253 "Proposed Training Needs List"
{
    Caption = 'Recommended Training Needs List';
    CardPageID = "Proposed Trn Needs App. Card";
    PageType = List;
    SourceTable = "HR Training Needs Header";
    SourceTableView = WHERE(Status = CONST(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
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
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("HR Collated Training Report")
            {
                Caption = 'Hr Approved Training Report';
                Image = Report2;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Collated Training Needs report";
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec."User ID" := UserId;
    end;

    var
        HRTrainingNeedsLine: Record "HR Training Needs Line";
}

