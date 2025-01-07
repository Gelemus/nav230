page 50183 "Interview Header Card"
{
    PageType = Card;
    SourceTable = "Interview Attendance Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Interview No"; Rec."Interview No")
                {
                }
                field("Interview Committee code"; Rec."Interview Committee code")
                {
                }
                field("Interview Committee Name"; Rec."Interview Committee Name")
                {
                }
                field("Job Requisition No."; Rec."Job Requisition No.")
                {
                }
                field("Interview Job No."; Rec."Interview Job No.")
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Interview Date from"; Rec."Interview Date from")
                {
                }
                field("Interview Date to"; Rec."Interview Date to")
                {
                }
                field("Interview Time"; Rec."Interview Time")
                {
                }
                field("Interview Location"; Rec."Interview Location")
                {
                }
                field("Interview Chairperson Code"; Rec."Interview Chairperson Code")
                {
                }
                field("Interview Chairperson Name"; Rec."Interview Chairperson Name")
                {
                }
                field("Interview Purpose"; Rec."Interview Purpose")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                }
                field("Committee Remarks"; Rec."Committee Remarks")
                {
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                }
                field("Created by"; Rec."Created by")
                {
                    Editable = false;
                }
                field("Mandatory Docs. Required"; Rec."Mandatory Docs. Required")
                {
                }
                field(Closed; Rec.Closed)
                {
                }
            }
            part(Control4; "Interview Attendance Subform")
            {
                SubPageLink = "Interview No." = FIELD("Interview No");
            }
        }
        area(factboxes)
        {
            systempart(Control2; MyNotes)
            {
            }
            systempart(Control1; Links)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Applicant Results")
            {
                Caption = 'Applicant Results';
                Image = Employee;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Applicant Results";
                RunPageLink = "Job Requistion No" = FIELD("Job Requisition No."),
                              "Job No" = FIELD("Interview Job No.");
            }
            action("Insert Applicant Results")
            {
                Caption = 'Insert Applicant Results';
                Image = Insert;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    InsertApplicantResults;
                end;
            }
            action("Shortlisted Applicants")
            {
                Caption = 'Shortlisted Applicants';
                Image = ElectronicNumber;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Shortlisted Job Applicants";
                RunPageLink = "Employee Requisition No." = FIELD("Job Requisition No.");
                RunPageView = WHERE("To be Interviewed" = FILTER(true));
            }
            action("Email Invitation to Candidates")
            {
                Caption = 'Send Email Invitation to Successfull Candidates';
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //Confirm Interview Date, Time and Location has been filled for the Interviews before sending Invitation Email
                    HRJobApplications.Reset;
                    HRJobApplications.SetRange(HRJobApplications."Employee Requisition No.", Rec."Job Requisition No.");
                    HRJobApplications.SetRange(HRJobApplications."Committee Shortlisted", true);
                    if HRJobApplications.FindSet then begin
                        repeat
                            HRJobApplications.TestField(HRJobApplications."Interview Date");
                            HRJobApplications.TestField(HRJobApplications."Interview Time");
                            HRJobApplications.TestField(HRJobApplications."Interview Location");
                        until HRJobApplications.Next = 0;
                    end;

                    EmployeeRecruitment.SendInterviewShortlistedApplicantEmail(Rec."Interview Job No.", Rec."Job Requisition No.", Rec."Interview Date from", Rec."Interview Time", Rec."Interview Location", Rec."Interview No", Rec."Interview Date to");
                end;
            }
            action("HR Interview Questions")
            {
                Caption = 'HR Interview Questions Panelist Scoring';
                Image = ResourceJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Interview Qns Parameters";
                RunPageLink = "Job Requistion No" = FIELD("Job Requisition No.");
                Visible = false;
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
                    //Check if HR Mandatory checklist documents have been attached.
                    if Rec."Mandatory Docs. Required" = true then
                        HRJobLookupValue.Reset;
                    HRJobLookupValue.SetRange(HRJobLookupValue."Required Stage", HRJobLookupValue."Required Stage"::"Interview Approval");
                    if HRJobLookupValue.FindSet then begin
                        repeat
                            HRMandatoryDocChecklist.Reset;
                            HRMandatoryDocChecklist.SetRange(HRMandatoryDocChecklist."Document No.", Rec."Interview No");
                            HRMandatoryDocChecklist.SetRange(HRMandatoryDocChecklist."Mandatory Doc. Code", HRJobLookupValue.Code);
                            if HRMandatoryDocChecklist.FindFirst then begin
                                if not HRMandatoryDocChecklist.HasLinks then begin
                                    Error(HRJobLookupValue.Code + ' ' + Txt001);
                                    break;
                                    exit;
                                end;
                            end else begin
                                Error(HRJobLookupValue.Code + ' ' + Txt001);
                                break;
                                exit;
                            end;
                        until HRJobLookupValue.Next = 0;
                    end;

                    Rec.TestField(Status, Rec.Status::Open);
                    // if ApprovalsMgmt.CheckInterviewAttendanceHeaderApprovalsWorkflowEnabled(Rec) then
                    // ApprovalsMgmt.OnSendInterviewHeaderAttendanceForApproval(Rec);
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
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Approval Entries";
                RunPageLink = "Document No." = FIELD("Interview No");
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund",Requisition,"Funds Transfer","HR Document";
                begin
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

                    // ApprovalsMgmt.OnCancelInterviewAttendanceApprovalRequest(Rec);
                    // WorkflowWebhookMgt.FindAndCancel(RecordId);
                    CurrPage.Close
                end;
            }
            action("HR Mandatory Document Checklist")
            {
                Caption = 'HR Mandatory Document Checklist';
                Image = Document;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                RunObject = Page "HR Checklist Documents";
                RunPageLink = "Document No." = FIELD("Interview No");
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
                    HRJobLookupValue.SetRange(HRJobLookupValue."Required Stage", HRJobLookupValue."Required Stage"::"Interview Approval");
                    if HRJobLookupValue.FindSet then begin
                        repeat
                            HRMandatoryDocChecklist.Init;
                            HRMandatoryDocChecklist."Document No." := Rec."Interview No";
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

    trigger OnAfterGetRecord()
    begin
        if Rec.Closed = true then
            CurrPage.Editable(false);
    end;

    trigger OnOpenPage()
    begin
        if Rec.Closed = true then
            CurrPage.Editable(false);
    end;

    var
        EmployeeRecruitment: Codeunit "HR Employee Recruitment";
        HRJobApplications: Record "HR Job Applications";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        HRJobLookupValue: Record "HR Job Lookup Value";
        HRMandatoryDocChecklist: Record "HR Mandatory Doc. Checklist";
        Txt001: Label 'has not been attached. This is a required document.';

    local procedure InsertApplicantResults()
    var
        HRJobApplicantResultsRec: Record "HR Job Applicant Results";
        HRJobApplications: Record "HR Job Applications";
    begin
        HRJobApplicantResultsRec.Reset;
        HRJobApplicantResultsRec.SetRange("Job Requistion No", Rec."Job Requisition No.");
        if HRJobApplicantResultsRec.FindSet then
            if not Confirm('Applicant results exists, do you want to delete?') then
                exit;

        HRJobApplicantResultsRec.DeleteAll;
        HRJobApplications.Reset;
        HRJobApplications.SetRange("Employee Requisition No.", Rec."Job Requisition No.");
        HRJobApplications.SetRange("Committee Shortlisted", true);
        HRJobApplications.SetRange("To be Interviewed", true);
        if HRJobApplications.FindFirst then
            repeat
                HRJobApplicantResultsRec.Init;
                HRJobApplicantResultsRec.Validate("Job Applicant No", HRJobApplications."No.");
                HRJobApplicantResultsRec.Validate("Job Requistion No", HRJobApplications."Employee Requisition No.");
                HRJobApplicantResultsRec.Firstname := HRJobApplications.Firstname;
                HRJobApplicantResultsRec.Middlename := HRJobApplications.Middlename;
                HRJobApplicantResultsRec.Surname := HRJobApplications.Surname;
                HRJobApplicantResultsRec.Validate("Job No", HRJobApplications."Job No.");
                HRJobApplicantResultsRec.Insert;


            until HRJobApplications.Next = 0;
    end;
}

