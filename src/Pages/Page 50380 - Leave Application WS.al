page 50380 "Leave Application WS"
{
    DeleteAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "HR Leave Application";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the No.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting date.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the  Employee No.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the  Employee Name.';
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the Leave Type.';
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    ToolTip = 'Specifies the Leave period.';
                }
                field("Leave Start Date"; Rec."Leave Start Date")
                {
                    ToolTip = 'Specifies the Leave start date.';
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ToolTip = 'Specifies the Days applied.';
                }
                field("Days Approved"; Rec."Days Approved")
                {
                    ToolTip = 'Specifies the Days approved.';
                }
                field("Leave End Date"; Rec."Leave End Date")
                {
                    ToolTip = 'Specifies the Leave End date.';
                }
                field("Leave Return Date"; Rec."Leave Return Date")
                {
                    ToolTip = 'Specifies the Leave return date.';
                }
                field("Substitute No."; Rec."Substitute No.")
                {
                    ToolTip = 'Specifies the Employee substitute No.';
                }
                field("Substitute Name"; Rec."Substitute Name")
                {
                    ToolTip = 'Specifies the  Employee substitute Name.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the status.';
                }
                field("Reason for Leave"; Rec."Reason for Leave")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Document Name"; Rec."Document Name")
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
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Specifies the approval request process.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    //
                    Rec.TestField("Substitute No.");

                    HRLeaveManagement.CheckLeaveApplicationMandatoryFields(Rec, false);
                    // if ApprovalsMgmt.CheckHRLeaveApplicationApprovalsWorkflowEnabled(Rec) then
                    //   ApprovalsMgmt.OnSendHRLeaveApplicationForApproval(Rec);
                end;
            }
            action(ReOpen)
            {
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Specifies the process of re-opening a document.';
            }
            action("Post Leave Application")
            {
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Specifies the process of posting a leave application.';

                trigger OnAction()
                begin
                    /*IF UserSetup.GET(USERID) THEN BEGIN
                     IF NOT UserSetup."Post Leave Application" THEN
                       ERROR(PemissionDenied);
                    END;*/
                    LeaveType.Reset;
                    if LeaveType.Get(Rec."Leave Type") then begin
                        Rec.CalcFields("Leave Balance");
                        if Rec."Leave Balance" < Rec."Days Approved" then begin
                            if LeaveType."Allow Negative Days" = false then
                                Error('Negative leave days are not allowed for Leave Type:' + Rec."Leave Type");
                        end;
                    end;

                    if Confirm(ConfirmPostLeaveApplication, false, Rec."No.", Rec."Leave Type", Rec."Leave Period") then begin
                        HRLeaveManagement.CheckLeaveApplicationMandatoryFields(Rec, true);
                        if HRLeaveManagement.PostLeaveApplication(Rec."No.") then begin
                            Message(LeavePostedSuccessfully, Rec."No.");
                        end;
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
                RunPageView = WHERE("Table ID" = CONST(52137055));
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund",Requisition,"Funds Transfer","HR Document";
                begin
                    //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"HR Leave Application","No.");
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

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    //ApprovalsMgmt.CheckHRLeaveApplicationApprovalsWorkflowEnabled(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if HRLeaveManagement.CheckOpenLeaveApplicationExists(UserId) then
            Error(OpenLeaveApplicationExist, UserId);
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("User ID",USERID);
    end;

    var
        HRLeaveApplication: Record "HR Leave Application";
        HRLeaveManagement: Codeunit "HR Leave Management";
        OpenLeaveApplicationExist: Label 'Open Leave Application Exists for User ID:%1';
        ReOpenLeaveApplication: Label 'Reopen Leave Application No.%1, the Status will be changed to Open. Continue?';
        ConfirmPostLeaveApplication: Label 'Post Leave Application. Identification Fields and Values, Document No.:%1,  Leave Type:%2, Leave Period:%3. Continue?';
        LeavePostedSuccessfully: Label 'Leave Application No. %1, Posted Successfully.';
        UserSetup: Record "User Setup";
        PemissionDenied: Label 'You are not setup to post Leave applications. Contact System Administrator';
        LeaveType: Record "HR Leave Types";
}

