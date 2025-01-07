page 50261 "Training Applications"
{
    CardPageID = "Training Application Card";
    PageType = List;
    SourceTable = "HR Training Applications";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                {
                }
                field("Training Need No."; Rec."Training Need No.")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("From Date"; Rec."From Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("To Date"; Rec."To Date")
                {
                }
                field("Number of Days"; Rec."Number of Days")
                {
                }
                field("Estimated Cost Of Training"; Rec."Estimated Cost Of Training")
                {
                }
                field(Location; Rec.Location)
                {
                }
                field("Provider Code"; Rec."Provider Code")
                {
                }
                field("Provider Name"; Rec."Provider Name")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Actual Training Cost"; Rec."Actual Training Cost")
                {
                }
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
                    if ApprovalsMgmt.CheckHRTrainingApplicationsHeaderApprovalsWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendHRTrainingApplicationsHeaderForApproval(Rec);
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
                RunPageLink = "Document No." = FIELD("Application No.");
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
                    ApprovalsMgmt.OnCancelHRTrainingApplicationsHeaderApprovalRequest(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        TrainingApplications.Reset;
        TrainingApplications.SetRange(TrainingApplications."Employee No.", Rec."Employee No.");
        TrainingApplications.SetRange(TrainingApplications."Evaluation Submitted", false);
        if TrainingApplications.FindFirst then
            Error(TrainingApplicationError);

        TrainingEvaluation.Reset;
        TrainingEvaluation.SetRange("Employee No.", Rec."No.");
        if TrainingEvaluation.FindFirst then begin
            repeat
                TrainingEvaluation.Submitted := false;
                Error(TrainingApplicationError);
            until TrainingEvaluation.Next = 0;
        end;
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("User ID","User ID");
    end;

    var
        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
        TrainingEvaluation: Record "Training Evaluation";
        TrainingApplicationError: Label 'You can not apply for another Training if you have not submited your previous Training attendance Evaluation. Please submit your Training Evaluation to proceed';
        TrainingApplications: Record "HR Training Applications";
}

