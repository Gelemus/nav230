page 51340 "Pen.Approv Training Appli Card"
{
    PageType = Card;
    SourceTable = "HR Training Applications";
    SourceTableView = WHERE(Status = CONST("Pending Approval"));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                }
                field("Type of Training"; Rec."Type of Training")
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
                    MultiLine = true;
                }
                field(Description; Rec.Description)
                {
                    MultiLine = true;
                }
                field("Calendar Year"; Rec."Calendar Year")
                {
                }
                field("Training Need No."; Rec."Training Need No.")
                {
                    Visible = TrainingNeedNoVisible;
                }
                field("Development Need"; Rec."Development Need")
                {
                }
                field("From Date"; Rec."From Date")
                {
                }
                field("To Date"; Rec."To Date")
                {
                }
                field("Number of Days"; Rec."Number of Days")
                {
                }
                field(Location; Rec.Location)
                {
                }
                field("Estimated Cost Of Training"; Rec."Estimated Cost Of Training")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Provider Code"; Rec."Provider Code")
                {
                }
                field("Provider Name"; Rec."Provider Name")
                {
                }
                field("Purpose of Training"; Rec."Purpose of Training")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Evaluation Card Created"; Rec."Evaluation Card Created")
                {
                }
                field("Evaluation Submitted"; Rec."Evaluation Submitted")
                {
                }
                field("Total Training Cost"; Rec."Total Training Cost")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
            part(Control22; "Training Attendees")
            {
                SubPageLink = "Application No." = FIELD("Application No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Requisition for Training")
            {
                Caption = 'Requisition for Employee Training';
                Image = ReservationLedger;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Requisition Card";
                RunPageLink = "Reference Document No." = FIELD("Application No.");
                ToolTip = 'Create Purchase Requisition for Employee Training';

                trigger OnAction()
                begin
                    //Create a Purchase Requisition for Training Application
                    PurchaseRequisitions.Reset;
                    PurchaseRequisitions.SetRange(PurchaseRequisitions."Reference Document No.", Rec."Application No.");
                    if PurchaseRequisitions.FindFirst then
                        Error(ERRORPURCHASEREQUISITIONEXISTS);
                    "Purchases&PayablesSetup".Get;
                    PurchaseRequisitions.Init;
                    PurchaseRequisitions."No." := NoSeriesMgt.GetNextNo("Purchases&PayablesSetup"."Purchase Requisition Nos.", 0D, true);
                    PurchaseRequisitions."Document Date" := Today;
                    PurchaseRequisitions."Requested Receipt Date" := Today;
                    PurchaseRequisitions."Reference Document No." := Rec."Application No.";
                    PurchaseRequisitions.Description := Rec.Description;
                    PurchaseRequisitions.Insert;
                end;
            }
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
                RunPageLink = "Document No." = FIELD("No.");
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
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
                    ApprovalsMgmt.OnCancelHRTrainingApplicationsHeaderApprovalRequest(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                end;
            }
            action("Create Evaluation card for Training")
            {
                Caption = 'Create Evaluation card for Training';
                Image = ReturnOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Training Evaluation Card";
                RunPageLink = "Training Application no." = FIELD("Application No.");
                ToolTip = 'Create Training Evaluation for Employee Training';

                trigger OnAction()
                begin
                    //Create and Submit a Training Evaluation
                    TrainingEvaluation.Reset;
                    TrainingEvaluation.SetRange(TrainingEvaluation."Training Application no.", Rec."Application No.");
                    if TrainingEvaluation.FindFirst then
                        Error(ERRORTRAININGEVALUATIONEXISTS);
                    if Confirm(Txt001) = false then exit;
                    HumanResourcesSetup.Get;
                    TrainingEvaluation.Init;
                    TrainingEvaluation."Training Evaluation No." := NoSeriesMgt.GetNextNo(HumanResourcesSetup."Employee Evaluation Nos.", 0D, true);
                    TrainingEvaluation."Employee No." := Rec."Employee No.";
                    TrainingEvaluation.Validate(TrainingEvaluation."Employee No.");
                    TrainingEvaluation."Employee Name" := Rec."Employee Name";
                    TrainingEvaluation.Date := Today;
                    TrainingEvaluation."Training Application no." := Rec."Application No.";
                    TrainingEvaluation."Calendar Year" := Rec."Calendar Year";
                    TrainingEvaluation."Developement Need" := Rec."Development Need";
                    TrainingEvaluation.Objectives := Rec."Purpose of Training";
                    TrainingEvaluation."Training Provider" := Rec."Provider Name";
                    TrainingEvaluation."Training Start Date" := Rec."From Date";
                    TrainingEvaluation."Training End Date" := Rec."To Date";
                    TrainingEvaluation.Submitted := true;
                    TrainingEvaluation.Insert;
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
        TrainingNeedNoVisible := false;

        if Rec."Type of Training" = Rec."Type of Training"::"Individual Training" then
            TrainingNeedNoVisible := true;
    end;

    var
        PurchaseRequisitions: Record "Purchase Requisitions";
        "Purchases&PayablesSetup": Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TrainingNeedNoVisible: Boolean;
        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
        TrainingEvaluation: Record "Training Evaluation";
        HumanResourcesSetup: Record "Human Resources Setup";
        Txt001: Label 'Do you want to proceed to create an Evaluation card for this Training?';
        ERRORTRAININGEVALUATIONEXISTS: Label 'Training Evaluation Card for this Training application Exist! Please use it to submitt your Training Evaluation to proceed';
        ERRORPURCHASEREQUISITIONEXISTS: Label 'A purcahse requisition card for this Training application Exist! Please use it to submitt your requisition for Training to proceed';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
}

