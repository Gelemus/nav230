page 50249 "Training Evaluation Card"
{
    PageType = Card;
    SourceTable = "Training Evaluation";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Training Evaluation No."; Rec."Training Evaluation No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Training Application no."; Rec."Training Application no.")
                {
                }
                field("Calendar Year"; Rec."Calendar Year")
                {
                }
                field("Developement Need"; Rec."Developement Need")
                {
                }
                field(Objectives; Rec.Objectives)
                {
                }
                field("Training Provider"; Rec."Training Provider")
                {
                }
                field("Venue/Location"; Rec."Venue/Location")
                {
                }
                field("Training Start Date"; Rec."Training Start Date")
                {
                }
                field("Training End Date"; Rec."Training End Date")
                {
                }
                field("General Comments from Training"; Rec."General Comments from Training")
                {
                    MultiLine = true;
                }
                field("Objective Achieved"; Rec."Objective Achieved")
                {
                }
                field(Submitted; Rec.Submitted)
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
            systempart(Control15; MyNotes)
            {
            }
            systempart(Control16; Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Submit Training Evaluation")
            {
                Image = SelectField;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    if Confirm(Txt080) = false then exit;
                    TrainingApplications.Reset;
                    TrainingApplications.SetRange(TrainingApplications."Employee No.", Rec."Employee No.");
                    TrainingApplications.SetRange(TrainingApplications."Application No.", Rec."Training Application no.");
                    if TrainingApplications.FindFirst then begin
                        TrainingApplications."Evaluation Submitted" := true;
                        TrainingApplications.Modify;
                        Rec.Submitted := true;
                        Rec.Modify;
                        Message(Txt081, Rec."Training Evaluation No.");
                    end;
                end;
            }
            action("HR Mandatory Document Checklist")
            {
                Caption = 'HR Training Evaluation Mandatory Document Checklist';
                Image = Document;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                RunObject = Page "HR Checklist Documents";
                RunPageLink = "Document No." = FIELD("Training Evaluation No.");
                ToolTip = 'HR Training Evaluation Mandatory Document Checklist';
            }
            action("Send Approval Request")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //Check if HR Mandatory checklist documents have been attached.
                    HRJobLookupValue.Reset;
                    HRJobLookupValue.SetRange(HRJobLookupValue."Required Stage", HRJobLookupValue."Required Stage"::"Training Evaluation");
                    if HRJobLookupValue.FindSet then begin
                        repeat
                            HRMandatoryDocChecklist.Reset;
                            HRMandatoryDocChecklist.SetRange(HRMandatoryDocChecklist."Document No.", Rec."Training Evaluation No.");
                            HRMandatoryDocChecklist.SetRange(HRMandatoryDocChecklist."Mandatory Doc. Code", HRJobLookupValue.Code);
                            if HRMandatoryDocChecklist.FindFirst then begin
                                if not HRMandatoryDocChecklist.HasLinks then begin
                                    Error(HRJobLookupValue.Code + ' ' + Txt082);
                                    break;
                                    exit;
                                end;
                            end else begin
                                Error(HRJobLookupValue.Code + ' ' + Txt082);
                                break;
                                exit;
                            end;
                        until HRJobLookupValue.Next = 0;
                    end;

                    if ApprovalsMgmt.CheckTrainingEvaluationApprovalsWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendTrainingEvaluationForApproval(Rec);
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
                    /*IF CONFIRM(ReOpenLeaveApplication,FALSE,"No.") THEN BEGIN
                      Status:=Status::Open;
                      MODIFY;
                    END;*/

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
                RunPageLink = "Document No." = FIELD("No. Series");
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
                    ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    ApprovalsMgmt.OnCancelTrainingEvaluationApprovalRequest(Rec);
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

    trigger OnOpenPage()
    begin
        Rec."User ID" := UserId;
        Rec.Date := Today
    end;

    var
        Txt080: Label 'Are you sure you want to Submit your Training Evaluation';
        Txt081: Label 'Your Training Evaluation %1 has successfully been submitted';
        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        HRJobLookupValue: Record "HR Job Lookup Value";
        HRMandatoryDocChecklist: Record "HR Mandatory Doc. Checklist";
        Txt082: Label 'has not been attached. This is a required document.';
        TrainingApplications: Record "HR Training Applications";
}

