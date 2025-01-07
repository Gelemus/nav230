page 50154 "HR Jobs List"
{
    CardPageID = "HR Job Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HR Jobs";
    SourceTableView = WHERE(Status = FILTER(<> Released));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies a number for the job.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the job title for a job.';
                }
                field("Job Grade"; Rec."Job Grade")
                {
                    ToolTip = 'Specifies the Job grade for a specific Job.';
                }
                field("Maximum Positions"; Rec."Maximum Positions")
                {
                    ToolTip = 'Specifies the maximum positions for a specific Job.';
                }
                field("Occupied Positions"; Rec."Occupied Positions")
                {
                    ToolTip = 'Specifies the occupied number of positions in a specific Job.';
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                }
                field("Supervisor Job No."; Rec."Supervisor Job No.")
                {
                    ToolTip = 'Specifies the supervisor''s Job number.';
                }
                field("Supervisor Job Title"; Rec."Supervisor Job Title")
                {
                    Editable = true;
                    ToolTip = 'Specifies the supervisor''s Job Title.';
                }
                field(Levels; Rec.Levels)
                {
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the Job status.';
                }
                field(Active; Rec.Active)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Job Qualifications")
            {
                Caption = 'Job Qualifications';
                Image = BulletList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Qualifications";
                RunPageLink = "Job No." = FIELD("No.");
                ToolTip = 'Specifies the Job Qualification Requirements';
            }
            action("Job Requirements")
            {
                Caption = 'Performance Indicators KPI''s';
                Image = BusinessRelation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Requirements";
                RunPageLink = "Job No." = FIELD("No.");
                ToolTip = 'Specifies the Job General Requirements';
            }
            action("Job Responsibilities")
            {
                Caption = 'Job Responsibilities';
                Image = ResourceSkills;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Responsibilities";
                RunPageLink = "Job No." = FIELD("No.");
                ToolTip = 'Specifies the Job Responsibilities';
            }
            action("Salary Notch")
            {
                Image = JobLedger;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Values";
                RunPageLink = Option = CONST("Job Grade Level");
            }
            action("Send Approval Request")
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Send Job for Approval';

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    HRJobManagement.CheckHRJobMandatoryFields(Rec);
                    // if ApprovalsMgmt.IsHRJobApprovalsWorkflowEnabled(Rec) then
                    // ApprovalsMgmt.OnSendHRJobForApproval(Rec);
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
                    //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"HR Jobs","No.");
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
                    // ApprovalsMgmt.OnCancelHRJobApprovalRequest(Rec);
                    // WorkflowWebhookMgt.FindAndCancel(RecordId);
                end;
            }
            action("Approve HR Job")
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Approve HR Job for Employee Requisitions';
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm(ApproveHRJobForJobApplication, false, Rec."No.") then begin
                        Rec.Status := Rec.Status::Released;
                        if Rec.Modify then
                            Message(ApproveHRJobSuccessful);
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*IF HRJobManagement.CheckOpenJobExists(USERID) THEN
        ERROR(OpenJobCardExist);*/

    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("User ID",USERID);
        Rec."Vacant Positions" := Rec."Maximum Positions" - Rec."Occupied Positions";
    end;

    var
        ApproveHRJobForJobApplication: Label 'Approve HR Job No. %1 for Employee Requisition?';
        ApproveHRJobSuccessful: Label 'HR Job Approved Successfully, Proceed to Employee Requisitions.';
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        HRJobManagement: Codeunit "HR Job Management";
        OpenJobCardExist: Label 'Open Job Card Exists for User ID:%1. Please use it before opening another one';
}

