page 50163 "Employee Requisitions"
{
    CardPageID = "Employee Requisition Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "HR Employee Requisitions";
    SourceTableView = WHERE(Status = FILTER(<> Closed));

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
                field("Days for Engagement - Skilled"; Rec."Days for Engagement - Skilled")
                {
                }
                field("Days for Engagement - Unkilled"; Rec."Days for Engagement - Unkilled")
                {
                }
                field("Total Skilled"; Rec."Total Skilled")
                {
                }
                field("Total Unskilled"; Rec."Total Unskilled")
                {
                }
                field("Total Piece Work"; Rec."Total Piece Work")
                {
                }
                field("Reason for Requisition"; Rec."Reason for Requisition")
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
                action(Advertise)
                {
                    Caption = 'Advertise';
                    Image = Web;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Advertise Job Online';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //Advertise to Web Site
                    end;
                }
                action("Job Qualifications")
                {
                    Caption = 'Job Qualifications';
                    Image = BulletList;
                    Promoted = true;
                    PromotedCategory = Process;
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
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HR Job Requirements";
                    RunPageLink = "Job No." = FIELD("Job No.");
                    ToolTip = 'Job Requirements';
                }
                action("Job Responsibilities")
                {
                    Caption = 'Job Responsibilities';
                    Image = ResourceSkills;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HR Job Responsibilities";
                    RunPageLink = "Job No." = FIELD("Job No.");
                    ToolTip = 'Job Responsibilities';
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
                        Rec.TestField(Status, Rec.Status::Open);

                        // if ApprovalsMgmt.CheckHREmployeeRequisitionApprovalsWorkflowEnabled(Rec) then
                        // ApprovalsMgmt.OnSendHREmployeeRequisitionForApproval(Rec);
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
                        // ApprovalsMgmt.OnCancelHREmployeeRequisitionApprovalRequest(Rec);
                        // WorkflowWebhookMgt.FindAndCancel(RecordId);
                    end;
                }
            }
            group(ActionGroup15)
            {
                action("Email Invitation to Candidates")
                {
                    Caption = 'Send Email Invitation to Successful Applicants';
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        EmployeeRecruitment.SendInterviewShortlistedApplicantEmail(Rec."Job No.", Rec."No.", Rec."Interview Date", Rec."Interview Time", Rec."Interview Location", '', Rec."Interview Date");
                    end;
                }
                action("Regret Mail to Candiates")
                {
                    Caption = 'Send Regret Email to Unsuccessful Applicants';
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        EmployeeRecruitment.SendInterviewRejectedApplicantEmail(Rec."Job No.", Rec."No.");
                    end;
                }
                action("Close Requisition")
                {
                    Caption = 'Close Requisition';
                    Image = ClosePeriod;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        EmployeeRecruitment.CloseEmployeeRequisition(Rec."No.");
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

