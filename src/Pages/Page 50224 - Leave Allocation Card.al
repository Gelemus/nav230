page 50224 "Leave Allocation Card"
{
    DeleteAllowed = false;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "HR Leave Allocation Header";
    SourceTableView = WHERE(Status = FILTER(<> Posted));

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
                    ToolTip = 'Specifies the document Date.';
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
                    ToolTip = 'Specifies the Leave Period.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the status.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the User ID that created the document.';
                }
            }
            part(Control16; "Leave Allocation Line")
            {
                SubPageLink = "Leave Allocation No." = FIELD("No.");
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
            systempart(Control24; Links)
            {
                Visible = false;
            }
            systempart(Control23; Notes)
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
                    CheckRequiredFields;
                    if Confirm(ConfirmAutoGenerateAllocationLines, false, Rec."Leave Type", Rec."Leave Period") then begin
                        if HRLeaveManagement.AutoFillLeaveAllocationLines(Rec."No.") then begin
                            HRLeaveAllocationLine.Reset;
                            HRLeaveAllocationLine.SetRange(HRLeaveAllocationLine."Leave Allocation No.", Rec."No.");
                            if HRLeaveAllocationLine.FindSet then
                                Message(AutoGenerateAllocationLineSuccessful)
                            else
                                Error(AutoGenerateAllocationLineFail, Rec."Leave Type", Rec."Leave Period");
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
                ToolTip = 'Send Approval Request for the document';

                trigger OnAction()
                begin
                    CheckRequiredFields;
                    // if ApprovalsMgmt.CheckHRLeaveAllocationHeaderApprovalsWorkflowEnabled(Rec) then
                    //   ApprovalsMgmt.OnSendHRLeaveAllocationHeaderForApproval(Rec);
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
                    // ApprovalsMgmt.OnCancelHRLeaveAllocationHeaderApprovalRequest(Rec);
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
            action("Post Leave Allocation")
            {
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Helps to Post Leave Allocation.';

                trigger OnAction()
                begin
                    CheckRequiredFields;
                    if Confirm(ConfirmPostLeaveAllocation, false, Rec."No.", Rec."Leave Type", Rec."Leave Period") then begin
                        HRLeaveAllocationLine.Reset;
                        HRLeaveAllocationLine.SetRange(HRLeaveAllocationLine."Leave Allocation No.", Rec."No.");
                        //HRLeaveAllocationLine.SetFilter(HRLeaveAllocationLine."New Days Approved", '>%1', 0);
                        if HRLeaveAllocationLine.FindSet then begin
                            if HRLeaveManagement.PostLeaveAllocation(Rec."No.") then begin
                                Message(LeaveAllocationPostedSuccessfully, Rec."No.");
                            end;
                        end else begin
                            Error(EmptyAllocationLines, Rec."No.");
                        end;
                    end;
                end;
            }

            action("Import Leave Allocation ")
            {
                //The property 'Caption' cannot be empty.
                //Caption = '';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //RunObject = XMLport XMLport52137125;
                ToolTip = 'Import Leave Allocation for Employees';
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*IF HRLeaveManagement.CheckOpenLeaveAllocationExists(USERID) THEN
          ERROR(OpenLeaveAllocationExist,USERID);*/

    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("User ID", USERID);
    end;

    var
        HRLeaveManagement: Codeunit "HR Leave Management";
        AutoGenerateAllocationLineSuccessful: Label 'Leave Allocation Lines Generated Successully';
        AutoGenerateAllocationLineFail: Label 'Leave Allocation Lines Not Generated, The Leave Allocation for Leave type:%1 and Leave Period:%2, is already Posted for all Employees.';
        LeaveAllocationPostedSuccessfully: Label 'Leave Allocation No. %1, Posted Successfully ';
        OpenLeaveAllocationExist: Label 'Open Leave Allocation Exists for User ID:%1';
        HRLeaveAllocationLine: Record "HR Leave Allocation Line";
        EmptyAllocationLines: Label 'Error Posting Leave Allocation Document:%1. Fault Code: Empty Leave Allocation Lines.';
        ConfirmAutoGenerateAllocationLines: Label 'Auto Generate Leave Allocation Lines. Identification Fields and Values, Leave Type:%1, Leave Period:%2. Continue?';
        ConfirmPostLeaveAllocation: Label 'Post Leave Allocation. Identification Fields and Values, Document No.:%1,  Leave Type:%2, Leave Period:%3. Continue?';
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

    local procedure CheckRequiredFields()
    begin
        Rec.TestField("Posting Date");
        Rec.TestField("Leave Type");
        Rec.TestField("Leave Period");
        Rec.TestField(Description);
    end;
}

