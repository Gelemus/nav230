page 50220 "Leave Carryover Card"
{
    DeleteAllowed = false;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "HR Leave Carryover";
    SourceTableView = WHERE(Status = FILTER(<> Posted));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ShowMandatory = true;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    ShowMandatory = true;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ShowMandatory = true;
                }
                field("Maximum Carryover Days"; Rec."Maximum Carryover Days")
                {
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                }
                field("Reason for Carryover"; Rec."Reason for Carryover")
                {
                }
                field("Reasons For Difference in Days"; Rec."Reasons For Difference in Days")
                {
                    Caption = 'Reason For having Days to carryover different from reccomended';
                }
                field("Days to CarryOver"; Rec."Days to CarryOver")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("User ID"; Rec."User ID")
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
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
                Visible = false;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
            }
            systempart(Control27; Links)
            {
                Visible = false;
            }
            systempart(Control26; Notes)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Post Leave Carry Over")
            {
                Image = PriceAdjustment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if UserSetup.Get(UserId) then begin
                        if not UserSetup."Post Leave Application" then
                            Error(PemissionDenied);
                    end;


                    if Confirm(ConfirmPostLeaveReimbursment, false, Rec."No.", Rec."Leave Type", Rec."Leave Period") then begin
                        HRLeaveManagement.CheckCarryOverMandatoryFields(Rec, true);
                        if HRLeaveManagement.PostLeaveCarryover(Rec."No.") then begin
                            Message(PostedSuccessfully, Rec."No.");
                        end;
                    end;
                end;
            }
            action("Send Approval Request")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                begin
                    Rec.TestField(Status, Rec.Status::Open);

                    if ApprovalsMgmt.CheckHRLeaveCarryoverApprovalsWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendHRLeaveCarryoverForApproval(Rec);
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
                    if Confirm(ReOpenLeaveCarryOver, false, Rec."No.") then begin
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
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
                PromotedCategory = Category8;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Cancel the approval request.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    ApprovalsMgmt.CheckHRLeaveCarryoverApprovalsWorkflowEnabled(Rec);
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
        UserSetup: Record "User Setup";
        PemissionDenied: Label 'Contact System Admin to continue with this transaction';
        ConfirmPostLeaveReimbursment: Label 'Post This Leave carryover';
        HRLeaveManagement: Codeunit "HR Leave Management";
        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
        PostedSuccessfully: Label 'Transaction Posted Successfully';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        ReOpenLeaveCarryOver: Label 'Are you sure you want to Re-open the Leave Carryover';
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
}

