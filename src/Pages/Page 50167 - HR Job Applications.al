page 50167 "HR Job Applications"
{
    CardPageID = "HR Job Application Card";
    DeleteAllowed = true;
    PageType = List;
    ShowFilter = true;
    SourceTable = "HR Job Applications";
    SourceTableView = WHERE(Status = FILTER(<> Shortlisted));

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
                field(Age; Rec.Age)
                {
                }
                field("National ID No."; Rec."National ID No.")
                {
                    ToolTip = 'Specifies the National ID No.';
                }
                field("Person Living With Disability"; Rec."Person Living With Disability")
                {
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                }
                field("County Name"; Rec."County Name")
                {
                }
                field("SubCounty Name"; Rec."SubCounty Name")
                {
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the document status.';
                }
                field(ShortListed; Rec.ShortListed)
                {
                }
                field("Committee Shortlisted"; Rec."Committee Shortlisted")
                {
                }
                field("Application Date"; Rec."Application Date")
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
                field(Qualified; Rec.Qualified)
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
                PromotedCategory = Category4;
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
                PromotedCategory = Category4;
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
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "HR Job Responsibilities";
                RunPageLink = "Job No." = FIELD("Job No.");
                ToolTip = 'Job Responsibilities';
            }
        }
        area(processing)
        {
            action("Academic Qualifications")
            {
                Caption = 'Applicant Academic Qualifications';
                Image = EmployeeAgreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Applicant Qualification";
                RunPageLink = "Job Application No." = FIELD("No.");
                ToolTip = 'Job Application Qualifications';
            }
            action("Applicant Job Requirements")
            {
                Caption = 'Applicant Job Requirements';
                Image = EmployeeAgreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Applicant Requirements";
                RunPageLink = "Job Application No." = FIELD("No.");
                ToolTip = 'Job Application Requirements';
            }
            action("Applicant Employement History ")
            {
                Caption = 'Applicant Employement History';
                Image = ElectronicRegister;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Applicant Employment Hist.";
                RunPageLink = "Job Application No." = FIELD("No.");
                ToolTip = 'Applicant Employement History';
            }
            action("Applicant Referees")
            {
                Image = ResourceGroup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Applicant Referees";
                RunPageLink = "Job Application  No." = FIELD("No.");
            }
            action("ShortList Applicant")
            {
                Caption = 'ShortList Applicant';
                Image = AddWatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Txt080) = false then exit;
                    Rec.ShortListed := true;
                    Rec.Modify;
                    Message(Txt081);
                end;
            }
        }
        area(reporting)
        {
            action("Print Job Offer Letter")
            {
                Image = Report2;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.SetRange("No.", Rec."No.");
                    // ReportSelections.Print(ReportSelections.Usage::"Job Offer",Rec,0);
                end;
            }
            action("Print Medical Letter")
            {
                Caption = 'Print Medical Examination Letter';
                Image = Report2;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.SetRange("No.", Rec."No.");
                    //ReportSelections.Print(ReportSelections.Usage::"Medical Examination", Rec, 0);
                end;
            }
        }
    }

    var
        Employees: Record Employee;
        EmployeeRecruitment: Codeunit "HR Employee Recruitment";
        Txt080: Label 'Shortlist Applicant?';
        Txt081: Label 'Applicant Shortlisted ';
        UsageReportSelections: Option "Job Offer";
        ReportSelections: Record "Report Selections";
}

