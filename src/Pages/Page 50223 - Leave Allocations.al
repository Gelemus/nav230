page 50223 "Leave Allocations"
{
    CardPageID = "Leave Allocation Card";
    DeleteAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "HR Leave Allocation Header";
    SourceTableView = WHERE(Status = FILTER(<> Posted));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting Date.';
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the Leave Type.';
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    ToolTip = 'Species the Leave period.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Species the Global Dimension 1 Code.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Species the status.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Species the User ID that created the document.';
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
            systempart(Control17; Links)
            {
                Visible = false;
            }
            systempart(Control16; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Auto Generate Allocation Lines")
            {
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Auto Generate Leave Allocation Lines based on Employee Default Annual Leave Type';

                trigger OnAction()
                begin
                    Rec.TestField("Leave Type");
                    Rec.TestField("Leave Period");
                    Rec.TestField(Description);
                    if HRLeaveManagement.AutoFillLeaveAllocationLines(Rec."No.") then begin
                        Message(AutoGenerateAllocationLineSuccessful);
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
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    // if ApprovalsMgmt.CheckHRLeaveAllocationHeaderApprovalsWorkflowEnabled(Rec) then
                    //   ApprovalsMgmt.OnSendHRLeaveAllocationHeaderForApproval(Rec);
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
                    if Confirm(ReOpenLeaveAllocation, false, Rec."No.") then begin
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
                    //  ApprovalsMgmt.CheckHRLeaveAllocationHeaderApprovalsWorkflowEnabled(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if HRLeaveManagement.CheckOpenLeaveAllocationExists(UserId) then
            Error(OpenLeaveAllocationExist, UserId);
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("User ID",USERID);
    end;

    var
        HRLeaveManagement: Codeunit "HR Leave Management";
        AutoGenerateAllocationLineSuccessful: Label 'Leave Allocation Lines Generated Successully';
        OpenLeaveAllocationExist: Label 'Open Leave Allocation Exists for User ID:%1';
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ReOpenLeaveAllocation: Label 'Reopen Leave Allocation No.%1, the Status will be changed to Open. Continue?';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
}

