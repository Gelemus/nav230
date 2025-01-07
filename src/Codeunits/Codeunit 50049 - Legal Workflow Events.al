codeunit 50049 "Legal Workflow Events"
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
        //Security Preparation
        // WFHandler.AddEventToLibrary(RunWorkflowOnSendSecurityPreparationForApprovalCode,
        //                             DATABASE::Table50245,'Approval of a security preparation document is requested.',0,false);
        // WFHandler.AddEventToLibrary(RunWorkflowOnCancelSecurityPreparationApprovalRequestCode,
        //                             DATABASE::Table50245,'An approval request for a security preparation document is canceled.',0,false);


        //-------------------------------------------End Approval Events-------------------------------------------------------------
    end;

    procedure AddEventsPredecessor()
    begin
        //--------------------------------------1.Approval,Rejection,Delegation Predecessors------------------------------------------------
        //Security Preparation
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendSecurityPreparationForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendSecurityPreparationForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendSecurityPreparationForApprovalCode);//Delegate

        //---------------------------------------End Approval,Rejection,Delegation Predecessors---------------------------------------------
    end;

    procedure RunWorkflowOnSendSecurityPreparationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendSecurityPreparationForApproval'));
    end;

    procedure RunWorkflowOnCancelSecurityPreparationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelSecurityPreparationApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSendSecurityPreparationForApproval', '', false, false)]
    // procedure RunWorkflowOnSendSecurityPreparationForApproval(var SecuritiesPreparations: Record "Payment Terms")
    // begin
    //     //WorkflowManagement.HandleEvent(RunWorkflowOnSendSecurityPreparationForApprovalCode,SecuritiesPreparations);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnCancelSecurityPreparationApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelSecurityPreparationApprovalRequest(var SecuritiesPreparations: Record "Payment Terms")
    // begin
    //     //WorkflowManagement.HandleEvent(RunWorkflowOnCancelSecurityPreparationApprovalRequestCode,SecuritiesPreparations);
    // end;
}

