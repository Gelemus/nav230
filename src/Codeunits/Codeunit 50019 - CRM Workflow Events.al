codeunit 50019 "CRM Workflow Events"
{

    trigger OnRun()
    begin
    end;

    var
        WFHandler: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";

    procedure AddEventsToLibrary()
    begin
        //---------------------------------------------1. Approval Events--------------------------------------------------------------
        //Marketing Plan
        WFHandler.AddEventToLibrary(RunWorkflowOnSendMarketingPlanForApprovalCode,
                                    DATABASE::"Employee Account Invoice2", 'Approval of a Marketing Plan is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelMarketingPlanApprovalRequestCode,
                                    DATABASE::"Employee Account Invoice2", 'An approval request for a Marketing Plan is canceled.', 0, false);


        //-------------------------------------------End Approval Events-------------------------------------------------------------
    end;

    procedure AddEventsPredecessor()
    begin
        //--------------------------------------1.Approval,Rejection,Delegation Predecessors------------------------------------------------
        //Marketing Plan
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMarketingPlanForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendMarketingPlanForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMarketingPlanForApprovalCode);//Delegate



        //---------------------------------------End Approval,Rejection,Delegation Predecessors---------------------------------------------
    end;

    procedure RunWorkflowOnSendMarketingPlanForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMarketingPlanForApproval'));
    end;

    procedure RunWorkflowOnCancelMarketingPlanApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMarketingPlanApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSendMarketingPlanForApproval', '', false, false)]
    // procedure RunWorkflowOnSendMarketingPlanForApproval(var CRMCampaign: Record "Employee Account Invoice2")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendMarketingPlanForApprovalCode,CRMCampaign);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnCancelMarketingPlanApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelMarketingPlanApprovalRequest(var CRMCampaign: Record "Employee Account Invoice2")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelMarketingPlanApprovalRequestCode,CRMCampaign);
    // end;
}

