page 50671 "Casual Requisitions Pending"
{
    Caption = 'Casual Requisitions Pending Aproval';
    CardPageID = "Casual Requisition Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "HR Employee Requisitions";
    SourceTableView = WHERE(Status = FILTER("Pending Approval"),
                            "Document Type" = CONST("Casual Request"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number.';
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies Global Dimension 1 code.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies Global Dimension 2 Code.';
                }
                field("Casual Job Title"; Rec."Casual Job Title")
                {
                }
                field("Date Required"; Rec."Date Required")
                {
                }
                field("Number Required"; Rec."Number Required")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field(Voted; Rec.Voted)
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Main Duties"; Rec."Main Duties")
                {
                }
                field("Qualifications Required"; Rec."Qualifications Required")
                {
                }
                field("No of Years of Experience"; Rec."No of Years of Experience")
                {
                }
                field("Specific Experience Required"; Rec."Specific Experience Required")
                {
                }
                field("Specific Skills Required"; Rec."Specific Skills Required")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup24)
            {
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
                        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelHREmployeeRequisitionApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
        }
    }

    var
        ApproveRequisitionForJobApplication: Label 'Approve Employee Requisition Form %1 for Job Application?';
        ApproveRequisitionSuccessful: Label 'Employee Requisition Approved Successfully.';
        HRJobManagement: Codeunit "HR Job Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EmployeeRecruitment: Codeunit "HR Employee Recruitment";
}

