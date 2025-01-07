namespace spaBC.spaBC;

page 50301 "HR Employee Appraisal Card Ap"
{
    DeleteAllowed = false;
    ApplicationArea = All;
    Caption = 'HR Employee Appraisal Card Ap';
    PageType = Card;
    SourceTable = "50138";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'PART 1:  PERSONAL DETAILS OF EMPLOYEE: (TO BE FILLED BY EMPLOYEE)';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.', Comment = '%';
                }
                field("Date of Appointment"; Rec."Date of Appointment")
                {
                    ToolTip = 'Specifies the value of the Date of Appointment field.', Comment = '%';
                }
                field("Date Assigned Current Position"; Rec."Date Assigned Current Position")
                {
                    ToolTip = 'Specifies the value of the Date Assigned Current Position field.', Comment = '%';
                }
                field("Job Grade"; Rec."Job Grade")
                {
                    ToolTip = 'Specifies the value of the Job Grade field.', Comment = '%';
                }
                field("Job code"; Rec."Job code")
                {
                    ToolTip = 'Specifies the value of the Job code field.', Comment = '%';
                }
                field(Supervisor; Rec.Supervisor)
                {
                    ToolTip = 'Specifies the value of the Supervisor field.', Comment = '%';
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ToolTip = 'Specifies the value of the Supervisor Name field.', Comment = '%';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.', Comment = '%';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.', Comment = '%';
                }
                field("Employment Term"; Rec."Employment Term")
                {
                    ToolTip = 'Specifies the value of the Employment Term field.', Comment = '%';
                }
                field("Date of Last Appraisal"; Rec."Date of Last Appraisal")
                {
                    ToolTip = 'Specifies the value of the Date of Last Appraisal field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ToolTip = 'Specifies the value of the Appraisal Period field.', Comment = '%';
                }
            }
            part("Academic Qualifications"; "HR appraisal Academic Subform")
            {
                Caption = 'Academic Qualifications';
                SubPageLink = "Appraisal Code" = FIELD("No.");
                ApplicationArea = All;
            }
            part("The Job Description"; "HR Job Responsibilities")
            {
                Caption = 'HR Job Responsibilities';
                SubPageLink = "Job No." = FIELD("Job code");
                ApplicationArea = All;
            }
            part("HR Job Qualifications"; "HR Job Qualifications")
            {
                Caption = 'HR Job Qualifications';
                SubPageLink = "Job No." = FIELD("Job code");
                ApplicationArea = All;
            }
            part("HR Appraisal Global Competency"; "HR Appraisal Competency Subfor")
            {
                Caption = 'HR Appraisal Global Competency';
                SubPageLink = "Appraisal No." = FIELD("No.");
                ApplicationArea = All;
            }
            part("PART 2 A: JOB RELATED PERFORMANCE (Weight 65%)"; "HR Appraisal KPI")
            {
                Caption = 'HR Appraisal KPI';
                SubPageLink = "Appraissal Objective" = FIELD("No.");
                ApplicationArea = All;
            }
            part("PART 2 B:  PERSONAL RELATED PERFORMANCE (Weight 35%))"; "HR Appraisal Competency Subfor")
            {
                Caption = 'HR Appraisal Competency Subform';
                SubPageLink = "Appraisal No." = FIELD("No.");
                ApplicationArea = All;
            }
            part("HR Appraisal Main Resp/Duties"; "HR Appraisal Main Resp/Duties ")
            {
                Caption = 'HR Appraisal Main Resp/Duties';
                SubPageLink = "Appraisal Code" = FIELD("No.");
                ApplicationArea = All;
            }
            part(a; "HR Appraisal Special Task")
            {
                Caption = 'HR Appraisal Special Task';
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
            }
            part(b; "HR Appraisal Challenge Subform")
            {
                Caption = 'HR Appraisal Challenge Subform';
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
            }
            part(c; "HR Appraisal Performance Fact")
            {
                Caption = 'HR Appraisal Performance Fact';
                SubPageLink = "Appraisal No." = FIELD("No.");
                ApplicationArea = All;
            }
            part(d; "HR Appraisal Course subform")
            {
                Caption = 'HR Appraisal Course subform';
                SubPageLink = "Appraisal No." = FIELD("No.");
                ApplicationArea = All;
            }
            part(e; "HR Appraisal Challenge Subform")
            {
                Caption = 'HR Appraisal Challenge Subform';
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
            }
            part(f; "HR Appraisal Course subform")
            {
                Caption = 'Hr Appraisal Training Recomm';
                SubPageLink = "Appraisal No." = FIELD("No.");
                ApplicationArea = All;
            }
            part(g; "HR Appraisal Suggest Performan")
            {
                Caption = 'HR Appraisal Suggest Performan';
                SubPageLink = "Appraisal No." = FIELD("No.");
                ApplicationArea = All;
            }
            part(h; "HR Appraisal Objective Subform")
            {
                Caption = 'HR Appraisal Objective Subform';
                SubPageLink = "Appraisal No." = FIELD("No.");
                ApplicationArea = All;
            }
            part(i; "HR Appraisal Competency Subfor")
            {
                Caption = 'HR Appraisal Competency Subfor';
                SubPageLink = "Appraisal No." = FIELD("No.");
                ApplicationArea = All;
            }
            part(j; "HR Appraisal Training Need/Obj")
            {
                Caption = 'HR Appraisal Training Need/Obj';
                SubPageLink = "Appraisal No." = FIELD("No.");
                ApplicationArea = All;
            }
            part(k; "HR Appraisal Identified Potent")
            {
                Caption = 'HR Appraisal Identified Potent';
                SubPageLink = "Appraisal No." = FIELD("No.");
                ApplicationArea = All;
            }
            part(l; "HR Appraisal Recommendation")
            {
                Caption = 'HR Appraisal Recommendation';
                SubPageLink = "Appraisal No." = FIELD("No.");
                ApplicationArea = All;
            }


        }
    }
}
