page 50152 "Human Resource Cues Page"
{
    PageType = CardPart;
    SourceTable = "Human Resource Cue";

    layout
    {
        area(content)
        {
            cuegroup("HR Jobs")
            {
                field("HR Jobs Pending Approval"; Rec."HR Jobs Pending Approval")
                {
                    DrillDownPageID = "HR Jobs List";
                    Image = "None";
                }
                field("HR Jobs Approved"; Rec."HR Jobs Approved")
                {
                    DrillDownPageID = "Approved HR Jobs";
                    Image = "None";
                }
            }
            cuegroup("Employee Requisitions")
            {
                field("Employee Requisition Pending"; Rec."Employee Requisition Pending")
                {
                    DrillDownPageID = "Employee Requisitions";
                    Image = "None";
                }
                field("Employee Requisition Approved"; Rec."Employee Requisition Approved")
                {
                    DrillDownPageID = "Employee Requisitions";
                    Image = "None";
                }
            }
            cuegroup("HR Leave")
            {
                field("Leave Alloc. Pending Approval"; Rec."Leave Alloc. Pending Approval")
                {
                    DrillDownPageID = "Leave Allocations";
                    Image = "None";
                }
                field("Leave Alloc. Appproved"; Rec."Leave Alloc. Appproved")
                {
                    DrillDownPageID = "Leave Allocations";
                    Image = "None";
                }
                field("Leave Planner Pending Approval"; Rec."Leave Planner Pending Approval")
                {
                    DrillDownPageID = "Pending Leave Planner List";
                    Image = "None";
                }
                field("Leave Planner Approved"; Rec."Leave Planner Approved")
                {
                    DrillDownPageID = "Approved Leave Planner List";
                    Image = "None";
                }
                field("Leave Application Pending"; Rec."Leave Application Pending")
                {
                    DrillDownPageID = "Leave Application List";
                    Image = "None";
                }
                field("Leave Applications Approved"; Rec."Leave Applications Approved")
                {
                    DrillDownPageID = "Released Leave Applications";
                    Image = "None";
                }
                field("Leave Reimbursement Pending"; Rec."Leave Reimbursement Pending")
                {
                    DrillDownPageID = "Leave Reimbursements";
                    Image = "None";
                }
                field("Leave Reimbursement Approved"; Rec."Leave Reimbursement Approved")
                {
                    DrillDownPageID = "Leave Reimbursements";
                    Image = "None";
                }
                field("Leave CarryOver Pending Apprv."; Rec."Leave CarryOver Pending Apprv.")
                {
                    DrillDownPageID = "Leave Carryovers";
                    Image = "None";
                }
                field("Leave CarryOver Approved"; Rec."Leave CarryOver Approved")
                {
                    DrillDownPageID = "Leave Carryovers";
                    Image = "None";
                }
            }
            cuegroup("HR Appraisal")
            {
                field("Employee Appraisal Pending App"; Rec."Employee Appraisal Pending App")
                {
                    DrillDownPageID = "HR Employee Appraisals";
                    Image = "None";
                }
                field("Employee Appraisal Approved"; Rec."Employee Appraisal Approved")
                {
                    DrillDownPageID = "HR Employee Appraisals";
                    Image = "None";
                }
            }
            cuegroup("HR Staff Loans")
            {
                Caption = 'HR Staff  Allowance & Salary Advance';
                field("Allowance Pending Approval"; Rec."Allowance Pending Approval")
                {
                }
                field("Salary Advance Pending Apprv"; Rec."Salary Advance Pending Apprv")
                {
                }
                field("Imprest/Petty Pending Approval"; Rec."Imprest/Petty Pending Approval")
                {
                }
            }
            cuegroup("HR Training")
            {
                field("Training Needs Pending"; Rec."Training Needs Pending")
                {
                    DrillDownPageID = "Training Needs";
                    Image = "None";
                }
                field("Training Needs Approved"; Rec."Training Needs Approved")
                {
                    DrillDownPageID = "Training Needs";
                    Image = "None";
                }
                field("Training Group App. Pending"; Rec."Training Group App. Pending")
                {
                    DrillDownPageID = "Training Groups";
                    Image = "None";
                }
                field("Training Group App. Apprvd."; Rec."Training Group App. Apprvd.")
                {
                    DrillDownPageID = "Training Groups";
                    Image = "None";
                }
                field("Training Application Pending"; Rec."Training Application Pending")
                {
                    DrillDownPageID = "Training Applications";
                    Image = "None";
                }
                field("Training Applications Approved"; Rec."Training Applications Approved")
                {
                    DrillDownPageID = "Training Applications";
                    Image = "None";
                }
                field("Training Evaluation Pending"; Rec."Training Evaluation Pending")
                {
                    DrillDownPageID = "Training Evaluation List";
                    Image = "None";
                }
                field("Training Evaluation Approved"; Rec."Training Evaluation Approved")
                {
                    DrillDownPageID = "Training Evaluation List";
                    Image = "None";
                }
            }
            cuegroup("HR Detail Update")
            {
                Visible = false;
                field("Detail Update Open"; Rec."Detail Update Open")
                {
                    DrillDownPageID = "Employee Detail Updates";
                    Image = "None";
                }
                field("Detail Update Pending"; Rec."Detail Update Pending")
                {
                    DrillDownPageID = "Employee Detail Updates";
                    Image = "None";
                }
                field("Detail Update Approved"; Rec."Detail Update Approved")
                {
                    DrillDownPageID = "Employee Detail Updates";
                    Image = "None";
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;
}

