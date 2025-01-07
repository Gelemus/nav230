page 52668 "Leave Application Card C"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "HR Leave Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the Document Date.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the posting Date.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Employee No.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the Employee Name.';
                }
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Editable = false;
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Leave Period.';
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Leave Type.';
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                    Caption = 'Leave Balance ';
                    ToolTip = 'Specifies the Leave Balance.';
                }
                field("Substitute No."; Rec."Substitute No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Substitute Employee Number.';
                }
                field("Substitute Name"; Rec."Substitute Name")
                {
                    ToolTip = 'Specifies the Employee Name.';
                }
                field("Leave Start Date"; Rec."Leave Start Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Leave start Date.';
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Days Applied.';
                }
                field("Days Approved"; Rec."Days Approved")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Days approved.';
                }
                field("Leave End Date"; Rec."Leave End Date")
                {
                    ToolTip = 'Specifies the Leave End Date.';
                }
                field("Leave Return Date"; Rec."Leave Return Date")
                {
                    ToolTip = 'Specifies the Leave return date.';
                }
                field("Reason for Leave"; Rec."Reason for Leave")
                {
                    Editable = false;
                    ToolTip = 'Specifies the reason for Leave.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the status.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the User ID that created the document.';
                }
                field("Reason for Cancellation"; Rec."Reason for Cancellation")
                {
                }
            }
        }
        area(factboxes)
        {
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Cancel ")
            {
                Caption = 'Cancel';
                Image = CancelledEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Cancel Document';

                trigger OnAction()
                begin
                    if (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Released) then begin
                        Rec.TestField("Reason for Cancellation");
                        if Confirm('Are you sure you want to cancel?', true) then begin
                            Rec."Cancelled By" := UserId;
                            Rec."Date Cancelled" := Today;
                            Rec."Time Cancelled" := Time;
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                            Message('Cancelled Successfully');
                        end;
                    end;
                end;
            }
            action(ReOpen)
            {
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(ReOpenLeaveApplication, false, Rec."No.") then begin
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                end;
            }
            action("Print Leave Application")
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    HRLeaveApplication.Reset;
                    HRLeaveApplication.SetRange(HRLeaveApplication."No.", Rec."No.");
                    if HRLeaveApplication.FindFirst then begin
                        REPORT.RunModal(REPORT::"HR Leave Application Report", true, false, HRLeaveApplication);
                    end;
                end;
            }
            separator(Separator45)
            {
            }
            action("Send Approval Request")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    //check substitute
                    //TESTFIELD("Substitute No.");
                    Rec.TestField(Status, Rec.Status::Open);

                    HRLeaveManagement.CheckLeaveApplicationMandatoryFields(Rec, false);

                    if ApprovalsMgmt.CheckHRLeaveApplicationApprovalsWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendHRLeaveApplicationForApproval(Rec);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Cancel the approval request.';
                Visible = false;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    ApprovalsMgmt.CheckHRLeaveApplicationApprovalsWorkflowEnabled(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                end;
            }
            action(Approvals)
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category8;
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
                    //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"HR Leave Application","No.");
                end;
            }
            separator(Separator46)
            {
            }
            action("Post Leave Application")
            {
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if UserSetup.Get(UserId) then begin
                        if not UserSetup."Post Leave Application" then
                            Error(PemissionDenied);
                    end;
                    /*LeaveType.RESET;
                    IF LeaveType.GET("Leave Type") THEN BEGIN
                      CALCFIELDS("Leave Balance");
                      IF "Leave Balance"<"Days Approved" THEN BEGIN
                        IF LeaveType."Allow Negative Days"=FALSE THEN
                          ERROR(ErrorNegativeDaysNotAllowed +"Leave Type");
                      END;
                    END;
                    */

                    if Confirm(ConfirmPostLeaveApplication, false, Rec."No.", Rec."Leave Type", Rec."Leave Period") then begin
                        HRLeaveManagement.CheckLeaveApplicationMandatoryFields(Rec, true);
                        if HRLeaveManagement.PostLeaveApplication(Rec."No.") then begin
                            Message(LeavePostedSuccessfully, Rec."No.");
                        end;
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
        area(navigation)
        {
            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                Image = Documents;
                action(IncomingDocCard)
                {
                    ApplicationArea = Suite;
                    Caption = 'View Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = ViewOrder;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                    end;
                }
                action(SelectIncomingDoc)
                {
                    AccessByPermission = TableData "Incoming Document" = R;
                    ApplicationArea = Suite;
                    Caption = 'Select Incoming Document';
                    Image = SelectLineToApply;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        Rec.Validate("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RecordId));
                    end;
                }
                action(IncomingDocAttachFile)
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Incoming Document from File';
                    Ellipsis = true;
                    Enabled = CreateIncomingDocumentEnabled;
                    Image = Attach;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ToolTip = 'Create an incoming document from a file that you select from the disk. The file will be attached to the incoming document record.';

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record "Incoming Document Attachment";
                    begin
                        IncomingDocumentAttachment.NewAttachmentFromLeaveAllowanceDocument(Rec);
                    end;
                }
                action(RemoveIncomingDoc)
                {
                    ApplicationArea = Suite;
                    Caption = 'Remove Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = RemoveLine;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ToolTip = 'Remove any incoming document records and file attachments.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        if IncomingDocument.Get(Rec."Incoming Document Entry No.") then
                            IncomingDocument.RemoveLinkToRelatedRecord;
                        Rec."Incoming Document Entry No." := 0;
                        Rec.Modify(true);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlappearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RecordId);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
    end;

    var
        HRLeaveManagement: Codeunit "HR Leave Management";
        OpenLeaveApplicationExist: Label 'Open Leave Application Exists for User ID:%1';
        ReOpenLeaveApplication: Label 'Reopen Leave Application No.%1, the Status will be changed to Open. Continue?';
        ConfirmPostLeaveApplication: Label 'Post Leave Application. Identification Fields and Values, Document No.:%1,  Leave Type:%2, Leave Period:%3. Continue?';
        LeavePostedSuccessfully: Label 'Leave Application No. %1, Posted Successfully.';
        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
        UserSetup: Record "User Setup";
        PemissionDenied: Label 'You are not setup to Post Leave Applications. Contact System Administrator';
        HRLeaveApplication: Record "HR Leave Application";
        LeaveType: Record "HR Leave Types";
        ErrorNegativeDaysNotAllowed: Label 'Negative leave days are not allowed for Leave Type:';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;

    local procedure SetControlappearance()
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."No." <> '');
    end;
}

