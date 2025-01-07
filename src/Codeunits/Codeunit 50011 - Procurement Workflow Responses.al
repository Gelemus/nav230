codeunit 50011 "Procurement Workflow Responses"
{

    trigger OnRun()
    begin
    end;

    var
        WFEventHandler: Codeunit "Workflow Event Handling";
        WFResponseHandler: Codeunit "Workflow Response Handling";
        ProcurementWorkflowEvents: Codeunit "Procurement Workflow Events";

    procedure AddResponsesToLibrary()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    procedure AddResponsePredecessors(ResponseFunctionName: Code[128])
    begin
        //--------------------------------------Procurement Response Predecessors------------------------------------------------
        //Purchase Requisition
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendPurchaseRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendPurchaseRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendPurchaseRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode);

        //Bid Analysis
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendBidAnalysisForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendBidAnalysisForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendBidAnalysisForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnCancelBidAnalysisApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnCancelBidAnalysisApprovalRequestCode);


        //Procurement Plan
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendProcurementPlanForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendProcurementPlanForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendProcurementPlanForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnCancelProcurementPlanApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnCancelProcurementPlanApprovalRequestCode);

        //Tender Header
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendTenderHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendTenderHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendTenderHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnCancelTenderHeaderApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnCancelTenderHeaderApprovalRequestCode);


        //Tender Header
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendTransferOrderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendTransferOrderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendTransferOrderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnCancelTransferOrderApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnCancelTransferOrderApprovalRequestCode);


        //Inspection
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendInspectionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendInspectionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnSendInspectionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnCancelInspectionApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  ProcurementWorkflowEvents.RunWorkflowOnCancelInspectionApprovalRequestCode);
    end;
}

