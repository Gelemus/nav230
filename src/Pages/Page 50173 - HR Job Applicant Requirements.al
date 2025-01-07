page 50173 "HR Job Applicant Requirements"
{
    Caption = 'Job Applicant Requirements';
    PageType = List;
    SourceTable = "HR Job Applicant Requirement";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Requirement Code"; Rec."Requirement Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("No. of Years"; Rec."No. of Years")
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
                RunPageLink = "Job No." = FIELD("Job Application No.");
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
                RunPageLink = "Job No." = FIELD("Job Application No.");
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
                RunPageLink = "Job No." = FIELD("Job Application No.");
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
                //RunPageLink ="Job Application No." = FIELD("No. of Years");
                ToolTip = 'Job Application Qualifications';
            }
        }
    }
}

