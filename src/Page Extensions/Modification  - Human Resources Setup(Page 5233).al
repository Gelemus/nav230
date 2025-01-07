pageextension 60341 pageextension60341 extends "Human Resources Setup"
{
    layout
    {
        // modify(Numbering)
        // {

        //     //Unsupported feature: Property Modification (Name) on "Numbering(Control 1)".

        //     Caption = 'General';

        //     //Unsupported feature: Property Insertion (GroupType) on "Numbering(Control 1)".

        // }

        //Unsupported feature: Property Modification (Name) on ""Employee Nos."(Control 2)".


        //Unsupported feature: Property Modification (SourceExpr) on ""Employee Nos."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Employee Nos."(Control 2)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Employee Nos."(Control 2)".

        addafter("Base Unit of Measure")
        {
            field("Appraisal Max score (Core)"; Rec."Appraisal Max score (Core)")
            {
            }
            field("Appraisal Max Score(None Core)"; Rec."Appraisal Max Score(None Core)")
            {
            }
            field("Default Base Calender"; Rec."Default Base Calender")
            {
            }
            field("Default Imprest Posting Group"; Rec."Default Imprest Posting Group")
            {
            }
            field("Job App. Lower Age Limit"; Rec."Job App. Lower Age Limit")
            {
            }
            field("Job App. Upper Age Limit"; Rec."Job App. Upper Age Limit")
            {
            }
            field("HR Job Applicant Data Dir.Name"; Rec."HR Job Applicant Data Dir.Name")
            {
            }
            field("Permanent Employment Code"; Rec."Permanent Employment Code")
            {
            }
            field("Contract Employment Code"; Rec."Contract Employment Code")
            {
            }
            field("ShortTerm Employment  Code"; Rec."ShortTerm Employment  Code")
            {
            }
            field("Retirement Age"; Rec."Retirement Age")
            {
            }
            field("HR Jobs Data"; Rec."HR Jobs Data")
            {
            }
            field("Principal Journal Template"; Rec."Principal Journal Template")
            {
            }
            field("Principal Journal Batch"; Rec."Principal Journal Batch")
            {
            }
            field("Interest Journal Template"; Rec."Interest Journal Template")
            {
            }
            field("Interest Journal Batch"; Rec."Interest Journal Batch")
            {
            }
            group(Numbering1)
            {
                Caption = 'Numbering';
                // field("Employee Nos."; Rec."Employee Nos.")
                // {
                //     ApplicationArea = BasicHR;
                //     ToolTip = 'Specifies the number series code to use when assigning numbers to employees.';
                // }
                field("Transport Request Nos"; Rec."Transport Request Nos")
                {
                }
                field("Vehicle Filling Nos"; Rec."Vehicle Filling Nos")
                {
                }
                field("Fleet Accident Nos"; Rec."Fleet Accident Nos")
                {
                }
                field("Appraisal Activity Code Nos"; Rec."Appraisal Activity Code Nos")
                {
                }
                field("Employee Data Directory Name"; Rec."Employee Data Directory Name")
                {
                }
                field("Job Nos."; Rec."Job Nos.")
                {
                }
                field("Employee Requisition Nos."; Rec."Employee Requisition Nos.")
                {
                }
                field("Job Application Nos."; Rec."Job Application Nos.")
                {
                }
                field("Shortlisting Nos."; Rec."Shortlisting Nos.")
                {
                }
            }
        }
        addafter("Employee Nos.")
        {
            field("Incident Reference Nos"; Rec."Incident Reference Nos")
            {
            }
            field("Interview Nos."; Rec."Interview Nos.")
            {
            }
            field("Employee Detail Update Nos."; Rec."Employee Detail Update Nos.")
            {
            }
            field("Employee Appraisal Nos."; Rec."Employee Appraisal Nos.")
            {
            }
            field("Employee Evaluation Nos."; Rec."Employee Evaluation Nos.")
            {
            }
            field("Leave Allocation Nos."; Rec."Leave Allocation Nos.")
            {
            }
            field("Leave Planner Nos."; Rec."Leave Planner Nos.")
            {
            }
            field("Leave Application Nos."; Rec."Leave Application Nos.")
            {
            }
            field("Leave Reimbursement Nos."; Rec."Leave Reimbursement Nos.")
            {
            }
            field("Leave Carryover Nos."; Rec."Leave Carryover Nos.")
            {
            }
            field("Leave Allowance Nos."; Rec."Leave Allowance Nos.")
            {
            }
            field("Employee Timesheet Nos."; Rec."Employee Timesheet Nos.")
            {
            }
            field("Disciplinary Cases Nos."; Rec."Disciplinary Cases Nos.")
            {
            }
            field("Employee Transfer Nos."; Rec."Employee Transfer Nos.")
            {
            }
            field("Exit Interview Nos"; Rec."Exit Interview Nos")
            {
            }
            field("Asset Transfer No."; Rec."Asset Transfer No.")
            {
            }
            field("Medical Scheme No."; Rec."Medical Scheme No.")
            {
            }
            field("Training Needs Nos"; Rec."Training Needs Nos")
            {
            }
            field("Training Group Nos"; Rec."Training Group Nos")
            {
            }
            field("Training Application Nos"; Rec."Training Application Nos")
            {
            }
            field("Approved Training Nos"; Rec."Approved Training Nos")
            {
            }
            field("Enable Online Leave App."; Rec."Enable Online Leave App.")
            {
            }
            field("Salary Advance Nos"; Rec."Salary Advance Nos")
            {
            }
            field("Loan Invoice Nos"; Rec."Loan Invoice Nos")
            {
            }
            field("Card Nos"; Rec."Card Nos")
            {
            }
            field("Casual Requisition Nos."; Rec."Casual Requisition Nos.")
            {
            }
            field("Project Request Nos"; Rec."Project Request Nos")
            {
            }
            field("Project FeasibilityStudy Nos"; Rec."Project FeasibilityStudy Nos")
            {
            }
            field("Project ActionPlan Nos"; Rec."Project ActionPlan Nos")
            {
            }
            field("Repair Order Nos"; Rec."Repair Order Nos")
            {
            }
            field("Safari Notice Nos"; Rec."Safari Notice Nos")
            {
            }
            field("Handover Notes Nos"; Rec."Handover Notes Nos")
            {
            }
            field("Pre-Trip Nos"; Rec."Pre-Trip Nos")
            {
            }
            field("Post-Trip Nos"; Rec."Post-Trip Nos")
            {
            }
            field("Project Implementation Nos"; Rec."Project Implementation Nos")
            {
            }
            field("Board Comments Nos"; Rec."Board Comments Nos")
            {
            }
            field("Attendance Nos"; Rec."Attendance Nos")
            {
            }
            field("Attendance Summary Nos"; Rec."Attendance Summary Nos")
            {
            }
            field("Fuel Requisition Nos"; Rec."Fuel Requisition Nos")
            {

            }
        }
        //  moveafter(General; "Base Unit of Measure")
    }
}

