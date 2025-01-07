page 50156 "Approved HR Jobs"
{
    CardPageID = "Approved HR Job Card";
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = List;
    SourceTable = "HR Jobs";
    SourceTableView = WHERE(Status = CONST(Released));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the Job Title.';
                }
                field("Job Grade"; Rec."Job Grade")
                {
                    ToolTip = 'Specifies the Job Grade.';
                }
                field("Maximum Positions"; Rec."Maximum Positions")
                {
                    ToolTip = 'Specifies the Maximum positions for a specific Job.';
                }
                field("Occupied Positions"; Rec."Occupied Positions")
                {
                    ToolTip = 'Specifies the occupied positions for a specific Job.';
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                }
                field("Supervisor Job No."; Rec."Supervisor Job No.")
                {
                    ToolTip = 'Specifies the Supervisor''s Job Number.';
                }
                field("Supervisor Job Title"; Rec."Supervisor Job Title")
                {
                    ToolTip = 'Specifies the Supervisor''s Job Title.';
                }
                field(Status; Rec.Status)
                {
                    OptionCaption = '<Open,Pending Approval,Approved,Rejected>';
                    ToolTip = 'Specifies the status.';
                }
                field(Active; Rec.Active)
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Job Qualifications")
            {
                Caption = 'Job Qualifications';
                Image = BulletList;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "HR Job Qualifications";
                RunPageLink = "Job No." = FIELD("No.");
                ToolTip = 'Specifies the Job Qualification Requirements';
            }
            action("Job Requirements")
            {
                Image = BusinessRelation;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "HR Job Requirements";
                RunPageLink = "Job No." = FIELD("No.");
                ToolTip = 'Specifies the Job General Requirements';
            }
            action("Job Responsibilities")
            {
                Caption = 'Job Responsibilities';
                Image = ResourceSkills;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "HR Job Responsibilities";
                RunPageLink = "Job No." = FIELD("No.");
                ToolTip = 'Specifies the Job Responsibilities';
            }
            action("Salary Notch")
            {
                Image = JobLedger;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "HR Job Values";
                RunPageLink = Option = CONST("Job Grade Level");
            }
            action(Reopen)
            {
                Caption = 'Reopen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                trigger OnAction()
                begin
                    if Confirm(Txt_001, false, Rec."No.") then begin
                        HRJobManagement.ReOpenReleasedJobs(Rec);
                    end;
                end;
            }
            action("Deactivate Job")
            {
                Caption = 'Deactivate Job';
                Image = DisableAllBreakpoints;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Deactivate Job from being Active. Active has to be false.';

                trigger OnAction()
                begin
                    if Confirm(Txt_002, false, Rec."No.") then begin
                        HRJobManagement.DeactivateReleasedJobs(Rec);
                    end;
                end;
            }
            action("Reactivate Job")
            {
                Caption = 'Reactivate Job';
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Reactivate Job after it has been deactivated. Active has to be true.';

                trigger OnAction()
                begin
                    if Confirm(Txt_003, false, Rec."No.") then begin
                        HRJobManagement.ReactivateReleasedJobs(Rec);
                    end;
                end;
            }
            action("Job Details Report")
            {
                Image = Report2;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    HRJobs.Reset;
                    HRJobs.SetRange(HRJobs."No.", Rec."No.");
                    if HRJobs.FindFirst then begin
                        REPORT.RunModal(REPORT::"HR Job Details", true, false, HRJobs);
                    end;
                end;
            }
            action("HR Establishement Report")
            {
                Image = Report2;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "HR Jobs";

                trigger OnAction()
                begin
                    HRJobs.Reset;
                    REPORT.RunModal(REPORT::"HR Jobs", true, false, HRJobs);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("Occupied Positions");
        Rec."Vacant Positions" := Rec."Maximum Positions" - Rec."Occupied Positions";
        Rec.Modify;
    end;

    var
        Txt_001: Label 'Reopen Approved Job.:%1';
        HRJobManagement: Codeunit "HR Job Management";
        HRJobs: Record "HR Jobs";
        Txt_002: Label 'Are you sure you want to Deactivate Approved Job.:%1';
        Txt_003: Label 'Are you sure you want to Reactivate Approved Job.:%1';
}

