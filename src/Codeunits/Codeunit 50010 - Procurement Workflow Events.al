codeunit 50010 "Procurement Workflow Events"
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
        //Purchase Requisition
        WFHandler.AddEventToLibrary(RunWorkflowOnSendPurchaseRequisitionForApprovalCode,
                                    DATABASE::"Purchase Requisitions", 'Approval of a purchase requisition is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode,
                                    DATABASE::"Purchase Requisitions", 'An approval request for a purchase requisition is canceled.', 0, false);

        //Bid Analysis
        WFHandler.AddEventToLibrary(RunWorkflowOnSendBidAnalysisForApprovalCode,
                                    DATABASE::"Bid Analysis Header", 'Approval of a bid analysis document is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelBidAnalysisApprovalRequestCode,
                                    DATABASE::"Bid Analysis Header", 'An approval request for a bid analysis document is canceled.', 0, false);

        //Procurement Plan
        WFHandler.AddEventToLibrary(RunWorkflowOnSendProcurementPlanForApprovalCode,
                                    DATABASE::"Procurement Planning Header", 'Approval of a Procurement Plan Document is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelProcurementPlanApprovalRequestCode,
                                    DATABASE::"Procurement Planning Header", 'An approval request for a Procurement Plan Document is canceled.', 0, false);

        //Tender Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendTenderHeaderForApprovalCode,
                                    DATABASE::"Tender Header", 'Approval of a Tender Header Document is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelTenderHeaderApprovalRequestCode,
                                    DATABASE::"Tender Header", 'An approval request for a Tender Order Document is canceled.', 0, false);
        //Tender Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendTransferOrderForApprovalCode,
                                    DATABASE::"Transfer Header", 'Approval of a Transfer Order Document is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelTransferOrderApprovalRequestCode,
                                    DATABASE::"Transfer Header", 'An approval request for a Transfer order Document is canceled.', 0, false);

        //Inspection Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendInspectionForApprovalCode,
                                    DATABASE::"Inspection Header", 'Approval of an Inspection Document is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelInspectionApprovalRequestCode,
                                    DATABASE::"Inspection Header", 'An approval request for an Inspection Document is canceled.', 0, false);
        //-------------------------------------------End Approval Events-------------------------------------------------------------
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    procedure AddEventsPredecessor(EventFunctionName: Code[128])
    begin
        //--------------------------------------1.Approval,Rejection,Delegation Predecessors------------------------------------------------
        //Purchase Requisition
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPurchaseRequisitionForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPurchaseRequisitionForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPurchaseRequisitionForApprovalCode);//Delegate

        //Bid Analysis
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendBidAnalysisForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendBidAnalysisForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendBidAnalysisForApprovalCode);//Delegate

        //Procurement Plan
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendProcurementPlanForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendProcurementPlanForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendProcurementPlanForApprovalCode);//Delegate

        //Tender Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendTenderHeaderForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendTenderHeaderForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendTenderHeaderForApprovalCode);//Delegate

        //Tender Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendTransferOrderForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendTransferOrderForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendTransferOrderForApprovalCode);//Delegate

        //Inspection Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendInspectionForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendInspectionForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendInspectionForApprovalCode);//Delegate
        //---------------------------------------End Approval,Rejection,Delegation Predecessors---------------------------------------------
    end;

    procedure RunWorkflowOnSendPurchaseRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPurchaseRequisitionForApproval'));
    end;

    procedure RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPurchaseRequisitionApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendPurchaseRequisitionForApproval', '', false, false)]
    procedure RunWorkflowOnSendPurchaseRequisitionForApproval(var PurchaseRequisition: Record "Purchase Requisitions")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPurchaseRequisitionForApprovalCode, PurchaseRequisition);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelPurchaseRequisitionApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelPurchaseRequisitionApprovalRequest(var PurchaseRequisition: Record "Purchase Requisitions")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode, PurchaseRequisition);
    end;

    procedure RunWorkflowOnSendBidAnalysisForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendBidAnalysisForApproval'));
    end;

    procedure RunWorkflowOnCancelBidAnalysisApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelBidAnalysisApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendBidAnalysisForApproval', '', false, false)]
    // procedure RunWorkflowOnSendBidAnalysisForApproval(var BidAnalysis: Record "Bid Analysis Header")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendBidAnalysisForApprovalCode,BidAnalysis);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelBidAnalysisApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelBidAnalysisApprovalRequest(var BidAnalysis: Record "Bid Analysis Header")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelBidAnalysisApprovalRequestCode,BidAnalysis);
    // end;

    procedure RunWorkflowOnSendProcurementPlanForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendProcurementPlanForApproval'));
    end;

    procedure RunWorkflowOnCancelProcurementPlanApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelProcurementPlanApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendProcurementPlanForApproval', '', false, false)]
    procedure RunWorkflowOnSendProcurementPlanForApproval(var ProcurementPlanningHeader: Record "Procurement Planning Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendProcurementPlanForApprovalCode, ProcurementPlanningHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelProcurementPlanApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelProcurementPlanApprovalRequest(var ProcurementPlanningHeader: Record "Procurement Planning Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelProcurementPlanApprovalRequestCode, ProcurementPlanningHeader);
    end;

    procedure RunWorkflowOnSendTenderHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendTenderHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelTenderHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelTenderHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendTenderHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnSendTenderHeaderForApproval(var TenderHeader: Record "Tender Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTenderHeaderForApprovalCode, TenderHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelTenderHeaderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelTenderHeaderApprovalRequest(var TenderHeader: Record "Tender Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTenderHeaderApprovalRequestCode, TenderHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendTransferOrderForApproval', '', false, false)]
    procedure RunWorkflowOnSendTransferOrderForApproval(var TransferHeader: Record "Transfer Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTransferOrderForApprovalCode, TransferHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelTransferOrderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelTransferOrderApprovalRequest(var TransferHeader: Record "Transfer Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTransferOrderApprovalRequestCode, TransferHeader);
    end;

    procedure RunWorkflowOnSendTransferOrderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendTransferOrderForApproval'));
    end;

    procedure RunWorkflowOnCancelTransferOrderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelTransferOrderApprovalRequest'));
    end;

    procedure RunWorkflowOnSendInspectionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendInspectionForApproval'));
    end;

    procedure RunWorkflowOnCancelInspectionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelInspectionApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendInspectionForApproval', '', false, false)]
    procedure RunWorkflowOnSendInspectionForApproval(var InspectionHeader: Record "Inspection Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendInspectionForApprovalCode, InspectionHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelInspectionApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelInspectionApprovalRequest(var InspectionHeader: Record "Inspection Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelInspectionApprovalRequestCode, InspectionHeader);
    end;
}

