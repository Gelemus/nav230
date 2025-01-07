codeunit 50015 "Inventory Workflow Events"
{

    trigger OnRun()
    begin
    end;

    var
        WFHandler: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddEventsToLibrary()
    begin
        //---------------------------------------------1. Approval Events--------------------------------------------------------------
        //Store Requisition
        WFHandler.AddEventToLibrary(RunWorkflowOnSendStoreRequisitionForApprovalCode,
                                    DATABASE::"Store Requisition Header", 'Approval of a store requisition is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelStoreRequisitionApprovalRequestCode,
                                    DATABASE::"Store Requisition Header", 'An approval request for a store requisition is canceled.', 0, false);

        //Transfer Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendTransferHeaderForApprovalCode,
                                    DATABASE::"Transfer Header", 'Approval of a transfer order is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelTransferHeaderApprovalRequestCode,
                                    DATABASE::"Transfer Header", 'An approval request for a transfer order is canceled.', 0, false);
        //-------------------------------------------End Approval Events-------------------------------------------------------------
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    procedure AddEventsPredecessor(EventFunctionName: Code[128])
    begin
        //--------------------------------------1.Approval,Rejection,Delegation Predecessors------------------------------------------------
        //Store Requisition
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendStoreRequisitionForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendStoreRequisitionForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendStoreRequisitionForApprovalCode);//Delegate

        //Transfer Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendTransferHeaderForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendTransferHeaderForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendTransferHeaderForApprovalCode);//Delegate

        //---------------------------------------End Approval,Rejection,Delegation Predecessors---------------------------------------------
    end;

    procedure RunWorkflowOnSendStoreRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendStoreRequisitionForApproval'));
    end;

    procedure RunWorkflowOnCancelStoreRequisitionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelStoreRequisitionApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendStoreRequisitionForApproval', '', false, false)]
    procedure RunWorkflowOnSendStoreRequisitionForApproval(var StoreRequisition: Record "Store Requisition Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendStoreRequisitionForApprovalCode, StoreRequisition);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelStoreRequisitionApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelStoreRequisitionApprovalRequest(var StoreRequisition: Record "Store Requisition Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelStoreRequisitionApprovalRequestCode, StoreRequisition);
    end;

    procedure RunWorkflowOnSendTransferHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendTransferHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelTransferHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelTransferHeaderApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendPurchaseRequisitionForApproval', '', false, false)]
    // procedure RunWorkflowOnSendTransferHeaderForApproval(var TransferHeader: Record "Transfer Header")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendTransferHeaderForApprovalCode,TransferHeader);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelPurchaseRequisitionApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelTransferHeaderApprovalRequest(var TransferHeader: Record "Transfer Header")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelTransferHeaderApprovalRequestCode,TransferHeader);
    // end;
}

