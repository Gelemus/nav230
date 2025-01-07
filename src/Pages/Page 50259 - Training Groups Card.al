page 50259 "Training Groups Card"
{
    PageType = Card;
    SourceTable = "HR Training Group";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Training Group App. No."; Rec."Training Group App. No.")
                {
                }
                field("Training Group Name"; Rec."Training Group Name")
                {
                }
                field("Calendar Year"; Rec."Calendar Year")
                {
                }
                field("Development Need"; Rec."Development Need")
                {
                }
                field(Objective; Rec.Objective)
                {
                }
                field("Training Needs Description"; Rec."Training Needs Description")
                {
                    MultiLine = true;
                }
                field("Proposed Training Provider"; Rec."Proposed Training Provider")
                {
                }
                field("Training Location"; Rec."Training Location")
                {
                }
                field("Proposed Period"; Rec."Proposed Period")
                {
                }
                field("From Date"; Rec."From Date")
                {
                }
                field("To Date"; Rec."To Date")
                {
                }
                field("Total Estimated Cost"; Rec."Total Estimated Cost")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
            }
            part(Control6; "Training Group Line")
            {
                SubPageLink = "Training Group No." = FIELD("Training Group App. No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Send Approval Request")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    // if ApprovalsMgmt.CheckHrTrainingGroupApprovalsWorkflowEnabled(Rec) then
                    //   ApprovalsMgmt.OnSendHRTrainingGroupForApproval(Rec);
                end;
            }
            action(ReOpen)
            {
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    //IF CONFIRM(ReOpenLeaveApplication,FALSE,"No.") THEN BEGIN
                    // Status:=Status::Open;
                    // MODIFY;
                    //END;
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
                RunPageLink = "Document No." = FIELD("Training Group App. No.");
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund",Requisition,"Funds Transfer","HR Document";
                begin
                    //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"Training Needs App. Card","No.");
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
                    // ApprovalsMgmt.OnCancelHRTrainingGroupApprovalRequest(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
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

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
}

