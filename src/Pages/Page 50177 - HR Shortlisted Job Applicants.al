page 50177 "HR Shortlisted Job Applicants"
{
    CardPageID = "HR Job Application Card";
    DeleteAllowed = false;
    PageType = List;
    ShowFilter = true;
    SourceTable = "HR Job Applications";
    SourceTableView = WHERE("Committee Shortlisted" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the document number.';
                }
                field("Employee Requisition No."; Rec."Employee Requisition No.")
                {
                    ToolTip = 'Specifies the Employee requisition number.';
                }
                field("Job No."; Rec."Job No.")
                {
                    ToolTip = 'Specifies the Job number.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the Job Title.';
                }
                field("Job Grade"; Rec."Job Grade")
                {
                    ToolTip = 'Specifies the Job Grade.';
                }
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the Surname.';
                }
                field(Firstname; Rec.Firstname)
                {
                    ToolTip = 'Specifies the Firstname.';
                }
                field(Middlename; Rec.Middlename)
                {
                    ToolTip = 'Specifies the Middle Name.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the Gender.';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ToolTip = 'Specifies the Date of Birth.';
                }
                field("National ID No."; Rec."National ID No.")
                {
                    ToolTip = 'Specifies the National ID No.';
                }
                field(ShortListed; Rec.ShortListed)
                {
                }
                field("Committee Shortlisted"; Rec."Committee Shortlisted")
                {
                }
                field("Interview Date"; Rec."Interview Date")
                {
                }
                field("Interview Time"; Rec."Interview Time")
                {
                }
                field("Interview Location"; Rec."Interview Location")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Send Approval Request")
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Send Approval Request';
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                ToolTip = 'Cancel Approval Request';
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                ToolTip = 'Approvals';
            }
            action(ReOpen)
            {
                Caption = 'ReOpen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'ReOpen';
            }
        }
        area(navigation)
        {
            action("Job Qualifications")
            {
                Caption = 'Job Qualifications';
                Image = BulletList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Qualifications";
                RunPageLink = "Job No." = FIELD("Job No.");
                ToolTip = 'Job Qualifications';
            }
            action("Job Requirements")
            {
                Caption = 'Job Requirements';
                Image = BusinessRelation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Requirements";
                RunPageLink = "Job No." = FIELD("Job No.");
                ToolTip = 'Job Requirements';
            }
            action("Job Responsibilities")
            {
                Caption = 'Job Responsibilities';
                Image = ResourceSkills;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Responsibilities";
                RunPageLink = "Job No." = FIELD("Job No.");
                ToolTip = 'Job Responsibilities';
            }
        }
        area(processing)
        {
            action("Job Application Qualifications")
            {
                Caption = 'Job Application Qualifications';
                Image = EmployeeAgreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Applicant Qualification";
                RunPageLink = "Job Application No." = FIELD("No.");
                ToolTip = 'Job Application Qualifications';
            }
            action("Transfer Applicant Details to Employee card")
            {
                Caption = 'Transfer Applicant Details to Employee card';
                Image = SendConfirmation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Txt050: Label 'Post Transfer Details?';
                begin
                    Rec.SetRange(Qualified, true);
                    if Confirm(Txt050) = false then exit;
                    EmployeeRecruitment.TransferQualifiedApplicantDetailsToEmployee(Rec);
                end;
            }
        }
    }

    var
        Employees: Record Employee;
        EmployeeRecruitment: Codeunit "HR Employee Recruitment";
        Txt080: Label 'Shortlist Applicant?';
        Txt081: Label 'Applicant Shortlisted ';
}

