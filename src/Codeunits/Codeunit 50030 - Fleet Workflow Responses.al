codeunit 50030 "Fleet Workflow Responses"
{

    trigger OnRun()
    begin
    end;

    var
        WFEventHandler: Codeunit "Workflow Event Handling";
        WFResponseHandler: Codeunit "Workflow Response Handling";
        FleetWorkflowEvents: Codeunit "Fleet Workflow Events";

    procedure AddResponsesToLibrary()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    procedure AddResponsePredecessors(ResponseFunctionName: Code[128])
    begin
        //--------------------------------------Fleet Response Predecessors------------------------------------------------
        //Transport Requisition
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  FleetWorkflowEvents.RunWorkflowOnSendTransportRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  FleetWorkflowEvents.RunWorkflowOnSendTransportRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  FleetWorkflowEvents.RunWorkflowOnSendTransportRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  FleetWorkflowEvents.RunWorkflowOnCancelTransportRequisitionApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  FleetWorkflowEvents.RunWorkflowOnCancelTransportRequisitionApprovalRequestCode);

        //Fuel Requisition
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  FleetWorkflowEvents.RunWorkflowOnSendFuelRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  FleetWorkflowEvents.RunWorkflowOnSendFuelRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  FleetWorkflowEvents.RunWorkflowOnSendFuelRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  FleetWorkflowEvents.RunWorkflowOnCancelFuelRequisitionApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  FleetWorkflowEvents.RunWorkflowOnCancelFuelRequisitionApprovalRequestCode);

        //Work Ticket Requisition
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  FleetWorkflowEvents.RunWorkflowOnSendWorkTicketRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  FleetWorkflowEvents.RunWorkflowOnSendWorkTicketRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  FleetWorkflowEvents.RunWorkflowOnSendWorkTicketRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  FleetWorkflowEvents.RunWorkflowOnCancelWorkTicketnApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  FleetWorkflowEvents.RunWorkflowOnCancelWorkTicketnApprovalRequestCode);
        //Vehicle Filling
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  FleetWorkflowEvents.RunWorkflowOnSendVehicleFillingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  FleetWorkflowEvents.RunWorkflowOnSendVehicleFillingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  FleetWorkflowEvents.RunWorkflowOnSendVehicleFillingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  FleetWorkflowEvents.RunWorkflowOnCancelVehicleFillingApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  FleetWorkflowEvents.RunWorkflowOnCancelVehicleFillingApprovalRequestCode);
    end;
}

