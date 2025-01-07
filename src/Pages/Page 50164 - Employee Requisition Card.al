page 50164 "Employee Requisition Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "HR Employee Requisitions";
    SourceTableView = WHERE(Status = FILTER(<> Closed));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number.';
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
                field("Emp. Requisition Description"; Rec."Emp. Requisition Description")
                {
                    ToolTip = 'Specifies the description for the Job Title.';
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("No of days"; Rec."No of days")
                {
                    Visible = false;
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                }
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                    Editable = EmployeeContractCodeEditable;
                }
                field("Maximum Positions"; Rec."Maximum Positions")
                {
                    ToolTip = 'Specifies the Maximum positions for a specific Job.';
                }
                field("Occupied Positions"; Rec."Occupied Positions")
                {
                    ToolTip = 'Specifies the number of occupied positions.';
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ToolTip = 'Specifies the number of vaccant  positions.';
                }
                field("Requested Employees"; Rec."Requested Employees")
                {
                    ToolTip = 'Specifies the number of requested Employees.';
                }
                field("Closing Date"; Rec."Closing Date")
                {
                    Editable = ClosingDateEditable;
                    ToolTip = 'Specifies the closing date for a specific Job requisition.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the Global Dimension 1 code.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field(Comments; Rec.Comments)
                {
                    MultiLine = true;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the Responsibility Centre.';
                    Visible = false;
                }
                field("Job Advert Published"; Rec."Job Advert Published")
                {
                }
                field("Regret Email Sent"; Rec."Regret Email Sent")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                    OptionCaption = 'Open,Pending Approval,Approved,Rejected,Closed';
                    ToolTip = 'Specifies the status.';
                }
                field("Job Advert Dropped"; Rec."Job Advert Dropped")
                {
                    Caption = 'Job Advertisement Dropped';
                }
                field("Purchase Requisition Created"; Rec."Purchase Requisition Created")
                {
                    Editable = false;
                }
                field("Purchase Requisition No."; Rec."Purchase Requisition No.")
                {
                }
                field("Mandatory Docs. Required"; Rec."Mandatory Docs. Required")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the user ID that created the document.';
                }
            }
            part("System Shortlisted Applicants"; "HR Job Applications")
            {
                Caption = 'System Shortlisted Applicants';
                SubPageLink = "Employee Requisition No." = FIELD("No."),
                              ShortListed = CONST(true);
            }
            part(" System Shortlisted Applicants"; "HR Shortlisted Job Applicants")
            {
                Caption = 'System Shortlisted Applicants';
                SubPageLink = "Employee Requisition No." = FIELD("No."),
                              ShortListed = CONST(true);
                Visible = false;
            }
            part(" Committee Shortlisted "; "HR Shortlisted Job Applicants")
            {
                Caption = 'Committee Shortlisted Applicants';
                SubPageLink = "Employee Requisition No." = FIELD("No."),
                              "Committee Shortlisted" = CONST(true);
            }
            group("Interview Details")
            {
                Visible = false;
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
        area(processing)
        {
            group(ActionGroup37)
            {
                action("Print Job Advertisement")
                {
                    Caption = 'Print Job Advertisment';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ToolTip = 'Print Job Advertisment';

                    trigger OnAction()
                    begin
                        HREmployeeRequisitions.Reset;
                        HREmployeeRequisitions.SetRange(HREmployeeRequisitions."No.", Rec."No.");
                        if HREmployeeRequisitions.FindFirst then begin
                            REPORT.RunModal(REPORT::"HR Job Advert", true, true, HREmployeeRequisitions);
                        end;
                    end;
                }
                action("Requisition for Job Advertisment")
                {
                    Caption = 'Requisition for Job Advertisment';
                    Image = ReservationLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Requisition Card";
                    RunPageLink = "Reference Document No." = FIELD("No.");
                    ToolTip = 'Create Purchase Requisition for Job Advertisment';

                    trigger OnAction()
                    begin
                        //Create a Purchase Requisition for Job Advertisement
                        EmployeeRecruitment.CreatePurchaseRequisitionForJobAdvertisement(Rec."No.");
                    end;
                }
                action("Publish Job Advertisement")
                {
                    Image = Web;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //Publish Job for Advertisement in the portal and Send Mail Notification to ICT To Publish Job on the website
                        Rec.TestField(Status, Rec.Status::Released);
                        EmployeeRecruitment.PublishJobAdvertisement(Rec."No.");
                        EmployeeRecruitment.SendEmailNotificationToICTOnPublishingJobAdvert(Rec."No.");
                        Message(Txt083);
                        CurrPage.Close;
                    end;
                }
                separator(Separator60)
                {
                }
                action("Drop Job Advertisement")
                {
                    Image = WorkCenterAbsencexcel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //Drop Job from Advertisement in the portal
                        EmployeeRecruitment.DropJobAdvertisement(Rec."No.");
                        Message(Txt084);
                        CurrPage.Close;
                    end;
                }
                action("Job Qualifications")
                {
                    Caption = 'Job Qualifications';
                    Image = BulletList;
                    Promoted = true;
                    PromotedCategory = Category5;
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
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "HR Job Requirements";
                    RunPageLink = "Job No." = FIELD("Job No.");
                    ToolTip = 'Job Requirements';
                }
                action("Job Details Report")
                {
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        HRJobs.Reset;
                        HRJobs.SetRange("No.", Rec."Job No.");
                        if HRJobs.FindFirst then begin
                            REPORT.Run(REPORT::"HR Job Details", true, true, HRJobs);
                        end;
                    end;
                }
                action("Job Responsibilities")
                {
                    Caption = 'Job Responsibilities';
                    Image = ResourceSkills;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "HR Job Responsibilities";
                    RunPageLink = "Job No." = FIELD("Job No.");
                    ToolTip = 'Job Responsibilities';
                }
                action("Job Applications")
                {
                    Image = Job;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    RunObject = Page "HR Job Applications";
                    RunPageLink = "Employee Requisition No." = FIELD("No.");
                }
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Send Approval Request';

                    trigger OnAction()
                    begin
                        if Rec."Requisition Approved" = false then begin
                            Rec.TestField(Status, Rec.Status::Open);
                        end;
                        Rec.TestField("Requested Employees");


                        HRMandatoryDocChecklist.Reset;
                        HRMandatoryDocChecklist.SetRange(HRMandatoryDocChecklist."Document No.", Rec."No.");
                        if HRMandatoryDocChecklist.FindSet then begin
                            repeat
                            until HRMandatoryDocChecklist.Next = 0;
                        end;

                        if ApprovalsMgmt.CheckHREmployeeRequisitionApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendHREmployeeRequisitionForApproval(Rec);
                        CurrPage.Close
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
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
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"HR Employee Requisitions","No.");
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        // ApprovalsMgmt.OnCancelHREmployeeRequisitionApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                        CurrPage.Close
                    end;
                }
            }
            group("Mandatory Documents")
            {
                Caption = 'Mandatory Documents';
            }
            action("HR Mandatory Document Checklist")
            {
                Caption = 'HR Mandatory Document Checklist';
                Image = Document;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                RunObject = Page "HR Checklist Documents";
                RunPageLink = "Document No." = FIELD("No.");
                ToolTip = 'HR Mandatory Document Checklist';
            }
            action("Insert Mandatory Documents")
            {
                Caption = 'Insert Mandatory Documents for Approval';
                Image = Insert;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                begin
                    HRJobLookupValue.Reset;
                    HRJobLookupValue.SetRange(HRJobLookupValue.Option, HRJobLookupValue.Option::"Checklist Item");
                    HRJobLookupValue.SetRange(HRJobLookupValue."Required Stage", HRJobLookupValue."Required Stage"::"Employee Requisition");
                    if HRJobLookupValue.FindSet then begin
                        repeat
                            HRMandatoryDocChecklist.Init;
                            HRMandatoryDocChecklist."Document No." := Rec."No.";
                            HRMandatoryDocChecklist."Mandatory Doc. Code" := HRJobLookupValue.Code;
                            HRMandatoryDocChecklist."Mandatory Doc. Description" := HRJobLookupValue.Description;
                            HRMandatoryDocChecklist."Document Attached" := false;
                            HRMandatoryDocChecklist.Insert;
                        until HRJobLookupValue.Next = 0;
                        Rec."Mandatory Docs. Required" := true;
                        Rec.Modify;
                    end;
                end;
            }
            group(ActionGroup28)
            {
                action("Email Invitation to Candidates")
                {
                    Caption = 'Send Email Invitation to Successfull Candidates';
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //EmployeeRecruitment.SendInterviewShortlistedApplicantEmail("Job No.","No.","Interview Date","Interview Time","Interview Location");
                        CurrPage.Close
                    end;
                }
                action("Regret Mail to Candidates")
                {
                    Caption = 'Send Regret Email to Unsuccessfull Applicants';
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Regret Email Sent", false);
                        EmployeeRecruitment.SendInterviewRejectedApplicantEmail(Rec."Job No.", Rec."No.");
                        Rec."Regret Email Sent" := true;
                        Rec.Modify;
                        CurrPage.Close
                    end;
                }
                action("Close Requisition")
                {
                    Caption = 'Close Requisition';
                    Image = ClosePeriod;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Regret Email Sent", true);
                        if Rec."Regret Email Sent" = false then
                            Error(ERROR_001);
                        EmployeeRecruitment.CloseEmployeeRequisition(Rec."No.");
                        CurrPage.Close
                    end;
                }
                action("Shortlist Applicants")
                {
                    Caption = 'Shortlist Applicants';
                    Image = AddWatch;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        EmployeeRecruitment.ShortlistApplicants(Rec);
                        //CurrPage.CLOSE
                    end;
                }
                action("Job Application Report")
                {
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "HR Job Applicantion  Report";
                }
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
        if Rec.Status = Rec.Status::Open then begin
            EmployeeContractCodeEditable := false;
            RequisitionTypeEditable := false;
            ClosingDateEditable := false;
            InterviewDateEditable := false;
            InterviewTimeEditable := false;
            InterviewLocationEditable := false;
        end;

        if Rec.Status = Rec.Status::Released then begin
            EmployeeContractCodeEditable := true;
            RequisitionTypeEditable := true;
            ClosingDateEditable := true;
            InterviewDateEditable := true;
            InterviewTimeEditable := true;
            InterviewLocationEditable := true;
        end;
    end;

    var
        ApproveRequisitionForJobApplication: Label 'Approve Employee Requisition Form %1 for Job Application?';
        ApproveRequisitionSuccessful: Label 'Employee Requisition Approved Successfully.';
        JobApplicantShortlisting: Label 'Job Applicant Shortlisting is Successful.';
        HRJobManagement: Codeunit "HR Job Management";
        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
        EmployeeRecruitment: Codeunit "HR Employee Recruitment";
        HREmployeeRequisitions: Record "HR Employee Requisitions";
        PurchaseRequisitions: Record "Purchase Requisitions";
        "Purchases&PayablesSetup": Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRJobApplications: Record "HR Job Applications";
        EmployeeContractCodeEditable: Boolean;
        RequisitionTypeEditable: Boolean;
        ClosingDateEditable: Boolean;
        InterviewDateEditable: Boolean;
        InterviewTimeEditable: Boolean;
        InterviewLocationEditable: Boolean;
        PurchaseRequisitionLine: Record "Purchase Requisition Line";
        Txt080: Label 'Are you sure you want to Publish the Job Advertisement? Please note this will make the Job Advertisement to be visible on the portal for Applications.';
        Txt081: Label 'Are you sure you want to drop the Published Job Advertisement? Please note this will make the Job Advertisement not to be visible on the portal for Applications.';
        ERROR_001: Label 'You need send a regret Email to unsucessful Job applicants before closing the Employee requisition process. Please send a regret Email to unsuccessful candidates to Proceed with the Job Closing process.';
        HRJobs: Record "HR Jobs";
        Txt082: Label 'A purchase requisition has already been created';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        Txt083: Label 'Job succesfully published for advetisement on the portal and an E-mail has been sent to ICT department';
        Txt084: Label 'Job advertisement has succesfully been pulled down from the Job application portal';
        HRJobLookupValue: Record "HR Job Lookup Value";
        HRMandatoryDocChecklist: Record "HR Mandatory Doc. Checklist";
        ERROR_002: Label 'Please Attach the Mandatory Documents required to proceed';
}

