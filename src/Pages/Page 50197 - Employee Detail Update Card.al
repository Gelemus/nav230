page 50197 "Employee Detail Update Card"
{
    PageType = Card;
    SourceTable = "HR Employee Detail Update";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the No.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the  Employee No.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the  Employee Name.';
                }
                field("Update Option"; Rec."Update Option")
                {
                    ToolTip = 'Specifies the  update option.';
                }
                field(Description; Rec.Description)
                {
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the  status.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the User ID that created the document.';
                }
            }
            group("Job Details")
            {
                field("Current Job Grade"; Rec."Current Job Grade")
                {
                    ToolTip = 'Specifies the  Current Job Grades.';
                }
                field("New Job Grade"; Rec."New Job Grade")
                {
                    ToolTip = 'Specifies the  New Job Grade.';
                }
            }
            group("Contact Information")
            {
            }
            group("Employee Status")
            {
                field("Current Employee Status"; Rec."Current Employee Status")
                {
                    ToolTip = 'Specifies the current Employee status.';
                }
                field("New Employee Status"; Rec."New Employee Status")
                {
                    ToolTip = 'Specifies the New Employee status.';
                }
            }
            group("Employee Transfer")
            {
                field("Current HR Location"; Rec."Current HR Location")
                {
                    ToolTip = 'Specifies Current HR location';
                }
                field("New HR Location"; Rec."New HR Location")
                {
                    ToolTip = 'Specifies New HR Location.';
                }
                field("Current HR Department"; Rec."Current HR Department")
                {
                    ToolTip = 'Specifies the current HR Deparment.';
                }
                field("New HR Department"; Rec."New HR Department")
                {
                    ToolTip = 'Specifies the New HR deparment.';
                }
            }
            group("Bank Information")
            {
                field("Current Bank Code"; Rec."Current Bank Code")
                {
                    ToolTip = 'Specifies the current Bank code.';
                }
                field("Current Bank Name"; Rec."Current Bank Name")
                {
                    ToolTip = 'Specifies the  current Bank Name.';
                }
                field("Current Bank Branch Code"; Rec."Current Bank Branch Code")
                {
                    ToolTip = 'Specifies the  current Bank Branch Code.';
                }
                field("Current Bank Branch Name"; Rec."Current Bank Branch Name")
                {
                    ToolTip = 'Specifies the current Bank Branch Name.';
                }
                field("Current Bank Account No."; Rec."Current Bank Account No.")
                {
                    ToolTip = 'Specifies the  current Bank Account Number.';
                }
                field("New Bank Code"; Rec."New Bank Code")
                {
                    ToolTip = 'Specifies the New Bank Code';
                }
                field("New Bank Name"; Rec."New Bank Name")
                {
                    ToolTip = 'Specifies the  New Bank Name.';
                }
                field("New Bank Branch Code"; Rec."New Bank Branch Code")
                {
                    ToolTip = 'Specifies the new Bank Branch Code.';
                }
                field("New Bank Branch Name"; Rec."New Bank Branch Name")
                {
                    ToolTip = 'Specifies the New Bank Branch Name.';
                }
                field("New Bank Account No."; Rec."New Bank Account No.")
                {
                    ToolTip = 'Specifies the new Bank Account.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
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
                    Rec.TestField(Status, Rec.Status::Open);

                    /*IF ApprovalsMgmt.CheckHREmployeeRequisitionApprovalsWorkflowEnabled(Rec) THEN
                    ApprovalsMgmt.OnSendHREmployeeRequisitionForApproval(Rec);*/

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
                    //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"HR Employee Requisitions","No.");
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
                    /*ApprovalsMgmt."OnCancelHREmployee RequisitionApprovalRequest"(Rec);
                    WorkflowWebhookMgt.FindAndCancel(RECORDID);*/

                end;
            }
        }
    }

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
}

