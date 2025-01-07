page 50168 "HR Job Application Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "HR Job Applications";
    SourceTableView = WHERE(Status = FILTER(<> Shortlisted));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the document number.';
                }
                field("Employee Requisition No."; Rec."Employee Requisition No.")
                {
                    ToolTip = 'Specifies the employee requisition number.';
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
                field("Salary Notch"; Rec."Salary Notch")
                {
                }
                field("HR Salary Notch"; Rec."HR Salary Notch")
                {
                    Visible = HRSalaryNotchVisible;
                }
                field("Emp. Requisition Description"; Rec."Emp. Requisition Description")
                {
                    ToolTip = 'Specifies the Job description.';
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the Global Dimension 1 Code.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the Global Dimesion 2 Code.';
                }
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the document Status.';
                }
                field(ShortListed; Rec.ShortListed)
                {
                }
                field("Committee Shortlisted"; Rec."Committee Shortlisted")
                {
                }
                field(Qualified; Rec.Qualified)
                {
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the User ID that raised the document.';
                }
                field("Employee Created"; Rec."Employee Created")
                {
                    Editable = false;
                }
            }
            group("Applicant Information")
            {
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the Surname.';
                }
                field(Firstname; Rec.Firstname)
                {
                    ToolTip = 'Specifies the Surname';
                }
                field(Middlename; Rec.Middlename)
                {
                    ToolTip = 'Specifies the middle name.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the Gender';
                }
                field("Person Living With Disability"; Rec."Person Living With Disability")
                {
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ToolTip = 'Specifies the Date of Birth.';
                }
                field(Age; Rec.Age)
                {
                    ToolTip = 'Specifies the Age';
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ToolTip = 'Specifies the address';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the Post Code. ';
                }
                field("City/Town"; Rec."City/Town")
                {
                    ToolTip = 'Specifies the City.';
                }
                field(Country; Rec.Country)
                {
                    ToolTip = 'Specifies the Country Name.';
                }
                field(County; Rec.County)
                {
                    Caption = 'County of Origin';
                    ToolTip = 'Specifies the County';
                }
                field("County Name"; Rec."County Name")
                {
                    ToolTip = 'Specifies the County Name.';
                }
                field(SubCounty; Rec.SubCounty)
                {
                    Caption = 'SubCounty of Origin';
                    ToolTip = 'Specifies the Subcounty Code.';
                }
                field("SubCounty Name"; Rec."SubCounty Name")
                {
                    ToolTip = 'Specifies the Subcounty Name.';
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    ToolTip = 'Specifies the address 2. ';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ToolTip = 'Specifies the Mobile Phone Number.';
                }
                field("Alternative Phone No."; Rec."Alternative Phone No.")
                {
                    ToolTip = 'Specifies the Home Phone Number.';
                }
                field("Birth Certificate No."; Rec."Birth Certificate No.")
                {
                    ToolTip = 'Specifies the Birth Certificate No.';
                }
                field("National ID No."; Rec."National ID No.")
                {
                    ToolTip = 'Specifies the National ID No.';
                }
                field("Huduma No."; Rec."Huduma No.")
                {
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ToolTip = 'Specifies the Passport Number.';
                }
                field("PIN  No."; Rec."PIN  No.")
                {
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                }
                field("Personal Email Address"; Rec."Personal Email Address")
                {
                    ToolTip = 'Specifies Persoanal Email address.';
                }
                field("Driving Licence No."; Rec."Driving Licence No.")
                {
                    ToolTip = 'Specifies the driving license No.';
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ToolTip = 'Specifies the Marital status.';
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ToolTip = 'Specifies Citizenship.';
                }
                field("Ethnic Group"; Rec."Ethnic Group")
                {
                }
                field(Religion; Rec.Religion)
                {
                    ToolTip = 'Specifies the Religion.';
                }
            }
            group("Bank Information")
            {
                field("Bank Code"; Rec."Bank Code")
                {
                }
                field("Bank Name"; Rec."Bank Name")
                {
                }
                field("Bank Branch Code"; Rec."Bank Branch Code")
                {
                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                }
            }
            group("Important Dates")
            {
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                }
                field("Probation Start Date"; Rec."Probation Start Date")
                {
                }
                field("Probation Period"; Rec."Probation Period")
                {
                }
                field("Probation End date"; Rec."Probation End date")
                {
                }
            }
            group("Interview Details")
            {
                Visible = InterviewDetailsVisible;
                field("Interview Date"; Rec."Interview Date")
                {
                    Editable = InterviewDateEditable;
                }
                field("Interview Time"; Rec."Interview Time")
                {
                    Editable = InterviewTimeEditable;
                }
                field("Interview Location"; Rec."Interview Location")
                {
                    Editable = InterviewLocationEditable;
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
                PromotedCategory = Category10;
                PromotedIsBig = true;
                ToolTip = 'Send Approval Request';

                trigger OnAction()
                begin
                    //Rec.TestField(Status, Rec.Status::Open);
                    if ApprovalsMgmt.IsHRJobApplicationApprovalsWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendHRJobApplicationForApproval(Rec);
                    CurrPage.Close;
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category10;
                PromotedIsBig = true;
                ToolTip = 'Cancel Approval Request';

                trigger OnAction()
                begin
                    //  ApprovalsMgmt.CheckHRJobApplicationApprovalsWorkflowEnabled(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    CurrPage.Close;
                end;
            }
            action(Approvals)
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category10;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Approval Entries";
                RunPageLink = "Document No." = FIELD("No.");
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund",Requisition,"Funds Transfer","HR Document";
                begin
                end;
            }
            action(ReOpen)
            {
                Caption = 'ReOpen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'ReOpen';
                Visible = false;
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
                PromotedCategory = Category5;
                PromotedIsBig = true;
                RunObject = Page "HR Job Applicant Qualification";
                RunPageLink = "E-mail" = FIELD("Personal Email Address"),
                              "Job Application No." = FIELD("No.");
                ToolTip = 'Job Application Qualifications';
            }
            action("Applicant Job Requirements")
            {
                Caption = 'Applicant Job Requirements';
                Image = EmployeeAgreement;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                RunObject = Page "HR Job Applicant Requirements";
                RunPageLink = "E-mail" = FIELD("Personal Email Address"),
                              "Job Application No." = FIELD("No.");
                ToolTip = 'Job Application Requirements';
            }
            action("Applicant Employement History ")
            {
                Caption = 'Applicant Employement History';
                Image = ElectronicRegister;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                RunObject = Page "HR Applicant Employment Hist.";
                RunPageLink = "E-mail" = FIELD("Personal Email Address"),
                              "Job Application No." = FIELD("No.");
                ToolTip = 'Applicant Employement History';
            }
            action("Applicant Referees")
            {
                Image = ResourceGroup;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                RunObject = Page "HR Job Applicant Referees";
                RunPageLink = "Job Application  No." = FIELD("No.");
            }
            action("HR Mandatory Document Checklist")
            {
                Caption = 'HR Mandatory Document Checklist';
                Image = Document;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                RunObject = Page "HR Checklist Documents";
                RunPageLink = "Document No." = FIELD("No.");
                ToolTip = 'HR Mandatory Document Checklist';
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
                    Rec.TestField(Qualified, true);
                    if Rec."Employee Created" = true then
                        Error(Txt087);

                    //Check if HR Mandatory checklist documents have been attached.
                    /*HRJobLookupValue.RESET;
                    HRJobLookupValue.SETRANGE(HRJobLookupValue."Required Stage",HRJobLookupValue."Required Stage"::"Employee Creation");
                    IF HRJobLookupValue.FINDSET THEN BEGIN
                      REPEAT
                        HRMandatoryDocChecklist.RESET;
                        HRMandatoryDocChecklist.SETRANGE(HRMandatoryDocChecklist."Document No.","No.");
                        HRMandatoryDocChecklist.SETRANGE(HRMandatoryDocChecklist."Mandatory Doc. Code",HRJobLookupValue.Code);
                        IF HRMandatoryDocChecklist.FINDFIRST THEN BEGIN
                          IF NOT HRMandatoryDocChecklist.HASLINKS THEN BEGIN
                            ERROR(HRJobLookupValue.Code+' '+Txt092);
                            BREAK;
                            EXIT;
                          END;
                        END ELSE BEGIN
                            ERROR(HRJobLookupValue.Code+' '+Txt092);
                            BREAK;
                            EXIT;
                        END;
                      UNTIL HRJobLookupValue.NEXT=0;
                    END;*/

                    if Confirm(Txt091) = false then exit;
                    EmployeeRecruitment.TransferQualifiedApplicantDetailsToEmployee(Rec);

                end;
            }
            action("ShortList Applicant")
            {
                Caption = 'ShortList Applicant';
                Image = AddWatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm(Txt080) = false then exit;
                    Rec.ShortListed := true;
                    Rec."To be Interviewed" := true;
                    Rec.Modify;
                    Message(Txt081);
                end;
            }
            action("ShortList For Interview")
            {
                Caption = 'ShortList For Interview';
                Image = AddWatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Txt084) = false then exit;
                    Rec."Committee Shortlisted" := true;
                    Rec.ShortListed := true;
                    Rec."To be Interviewed" := true;
                    Rec.Modify;
                    Message(Txt081);
                end;
            }
            action("Drop Applicant from Shortlist ")
            {
                Caption = 'Drop Applicant from Shortlisted list';
                Image = DeleteAllBreakpoints;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec.Qualified = true then begin
                        Error(Txt088);
                    end;
                    if Confirm(Txt085) = false then exit;
                    Rec.ShortListed := false;
                    Rec.Modify;
                    Message(Txt086);
                end;
            }
            action("Drop Applicant From Interview")
            {
                Caption = 'Drop Applicant for Next Interview';
                Image = DeleteExpiredComponents;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec.Qualified = true then begin
                        Error(Txt088);
                    end;
                    if Confirm(Txt090) = false then exit;
                    Rec."To be Interviewed" := false;
                    Rec.Modify;
                    Message(Txt089);
                end;
            }
            action("Qualify Applicant")
            {
                Caption = 'Qualify Applicant';
                Image = Opportunity;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Txt082) = false then exit;
                    Rec.Qualified := true;
                    Rec.Modify;
                    Message(Txt083, Rec."Employee Requisition No.");


                    HRJobLookupValue.Reset;
                    HRJobLookupValue.SetRange(HRJobLookupValue.Option, HRJobLookupValue.Option::"Checklist Item");
                    HRJobLookupValue.SetRange(HRJobLookupValue."Required Stage", HRJobLookupValue."Required Stage"::"Employee Creation");
                    if HRJobLookupValue.FindSet then begin
                        repeat
                            HRMandatoryDocChecklist.Init;
                            HRMandatoryDocChecklist."Document No." := Rec."No.";
                            HRMandatoryDocChecklist."Mandatory Doc. Code" := HRJobLookupValue.Code;
                            HRMandatoryDocChecklist."Mandatory Doc. Description" := HRJobLookupValue.Description;
                            HRMandatoryDocChecklist."Document Attached" := false;
                            HRMandatoryDocChecklist.Insert;
                        until HRJobLookupValue.Next = 0;
                    end;
                end;
            }
            action("Print Job Offer Letter")
            {
                Caption = 'Print Job Offer Letter Permanent';
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
            action("Print Job Offer Letter 2")
            {
                Caption = 'Print Job Offer Letter Contract';
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
                    //  ReportSelections.Print(ReportSelections.Usage::"Medical Examination",Rec,0);
                end;
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec."Committee Shortlisted" = false then begin
            InterviewDetailsVisible := false;
            InterviewDateEditable := false;
            InterviewTimeEditable := false;
            InterviewLocationEditable := false;
        end;

        if Rec."Committee Shortlisted" = true then begin
            InterviewDetailsVisible := true;
            InterviewDateEditable := true;
            InterviewTimeEditable := true;
            InterviewLocationEditable := true;
        end;

        if Rec.Qualified = false then begin
            HRSalaryNotchVisible := false;
        end;

        if Rec.Qualified = true then begin
            HRSalaryNotchVisible := true;
        end;
    end;

    var
        EmployeeRecruitment: Codeunit "HR Employee Recruitment";
        Txt080: Label 'Shortlist Applicant?';
        Txt081: Label 'Applicant Shortlisted ';
        Txt082: Label 'Are you sure you Want to Qualify this Applicant for the Job Position, do you confirm the Job Applicant has appeared in person and Signed the Job Offer Letter? If Yes proceed to Qualify the Applicant';
        Txt083: Label 'Applicant for %1 has been qualified for the Job Position';
        HRWebManage: Codeunit "HR Management WS";
        Txt084: Label 'Do you want to shortlist Applicant as Approved by Committee?';
        Txt085: Label 'Are you sure you want to drop the Applicant from the shortlisted applicants list?';
        Txt086: Label 'Applicant has been droped from the list of the shortlisted Applicant';
        Txt087: Label 'Employee Is already created.';
        HRSalaryNotchVisible: Boolean;
        InterviewDetailsVisible: Boolean;
        InterviewDateEditable: Boolean;
        InterviewTimeEditable: Boolean;
        InterviewLocationEditable: Boolean;
        Txt088: Label 'You cannot drop an applicant who has been qualified for the Job!';
        Txt089: Label 'Applicant has been droped from the list of candidates to be interviewed';
        Txt090: Label 'Are you sure you want to drop the Applicant from the Interview applicants list?';
        HRJobApplications: Record "HR Job Applications";
        UsageReportSelections: Option "Job Offer";
        ReportSelections: Record "Report Selections";
        Txt091: Label 'Are you sure you want to transfer the Job Applicants details to Employee Biodata?';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        HRJobLookupValue: Record "HR Job Lookup Value";
        HRMandatoryDocChecklist: Record "HR Mandatory Doc. Checklist";
        Txt092: Label 'has not been attached. This is a required document.';
}

