page 50155 "HR Job Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "HR Jobs";
    SourceTableView = WHERE(Status = FILTER(<> Released));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = true;
                    ToolTip = 'Specifies the Job number.';
                }
                field("Maximum Positions"; Rec."Maximum Positions")
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the maximum positions for a specific Job.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the Job Title.';
                }
                field("Job Grade"; Rec."Job Grade")
                {
                }
                field("Occupied Positions"; Rec."Occupied Positions")
                {
                    ToolTip = 'Specifies the occupied positions for a specific Job.';
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ToolTip = 'Specifies vacant Positions for a specific Job.';
                }
                field("Supervisor Job No."; Rec."Supervisor Job No.")
                {
                    ToolTip = 'Specifies the supervisor''s Job Number.';
                }
                field("Supervisor Job Title"; Rec."Supervisor Job Title")
                {
                    ToolTip = 'Specifies supervisor''s Job Title.';
                }
                field(Levels; Rec.Levels)
                {
                    Visible = false;
                }
                field(Active; Rec.Active)
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the Job Status.';
                }
                field("Appraisal Level"; Rec."Appraisal Level")
                {
                    Visible = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the user ID that created the Job.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    Visible = false;
                }
                field("Working Relationships"; Rec."Working Relationships")
                {
                    Visible = false;
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
                Caption = 'Job Requirements';
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
            action("Personal Attribute Required")
            {
                Caption = 'Personal Attribute Required';
                Image = ResourceSkills;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                // RunObject = Page "Personal Attribute Required";
                // RunPageLink = Code = FIELD("No.");
                // ToolTip = 'Specifies the Personal Attribute Required';
            }
            action("Job Details Report")
            {
                Caption = 'Job Details Report';
                Image = ResourceSkills;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Hr Job Purpose";
                RunPageLink = "Job No" = FIELD("No.");

                trigger OnAction()
                begin
                    HRJobs.Reset;
                    HRJobs.SetRange(HRJobs."No.", Rec."No.");
                    if HRJobs.FindFirst then begin
                        REPORT.RunModal(REPORT::"HR Job Details", true, false, HRJobs);
                    end;
                end;
            }
            action("Salary Notch")
            {
                Image = JobLedger;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Values";
                RunPageLink = Option = CONST("Job Grade Level");
                Visible = false;
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
                    // ApprovalsMgmt.CheckHRJobApprovalsWorkflowEnabled(Rec);
                    // WorkflowWebhookMgt.FindAndCancel(RecordId);
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
        HRJobManagement: Codeunit "HR Job Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApproveHRJobForJobApplication: Label 'Approve HR Job No. %1 for Employee Requisition?';
        ApproveHRJobSuccessful: Label 'HR Job Approved Successfully, Proceed to Employee Requisitions.';
        OpenJobCardExist: Label 'Open Job Card Exists for User ID:%1. Please use it before opening another one';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        HRJobs: Record "HR Jobs";
}

