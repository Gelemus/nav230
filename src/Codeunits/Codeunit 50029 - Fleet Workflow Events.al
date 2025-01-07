codeunit 50029 "Fleet Workflow Events"
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
        //Fuel Requisition
        WFHandler.AddEventToLibrary(RunWorkflowOnSendFuelRequisitionForApprovalCode,
                                    DATABASE::"Fuel Requisition", 'Approval of a fuel requisition is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelFuelRequisitionApprovalRequestCode,
                                    DATABASE::"Fuel Requisition", 'An approval request for a fuel requisition is canceled.', 0, false);

        //Transport Requisition
        WFHandler.AddEventToLibrary(RunWorkflowOnSendTransportRequisitionForApprovalCode,
                                    DATABASE::"Vehicle Requisition Header", 'Approval of a transport requisition is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelTransportRequisitionApprovalRequestCode,
                                    DATABASE::"Vehicle Requisition Header", 'An approval request for a transport requisition is canceled.', 0, false);
        //Work Ticket Requisition
        WFHandler.AddEventToLibrary(RunWorkflowOnSendWorkTicketRequisitionForApprovalCode,
                                    DATABASE::"Work Ticket", 'Approval of a Work Ticket requisition is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelWorkTicketnApprovalRequestCode,
                                    DATABASE::"Work Ticket", 'An approval request for a Work Ticket requisition is canceled.', 0, false);
        //Fuel

        WFHandler.AddEventToLibrary(RunWorkflowOnSendVehicleFillingForApprovalCode,
                                    DATABASE::"Vehicle Filling", 'Approval of Vehicle Filling requisition is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelVehicleFillingApprovalRequestCode,
                                    DATABASE::"Vehicle Filling", 'An approval request for Vehicle Filling requisition is canceled.', 0, false);

        //-------------------------------------------End Approval Events-------------------------------------------------------------
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    procedure AddEventsPredecessor(EventFunctionName: Code[128])
    begin
        //--------------------------------------1.Approval,Rejection,Delegation Predecessors------------------------------------------------
        //Fuel Requisition
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendFuelRequisitionForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendFuelRequisitionForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendFuelRequisitionForApprovalCode);//Delegate

        //Transport Requisition
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendTransportRequisitionForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendTransportRequisitionForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendTransportRequisitionForApprovalCode);//Delegate
        //WorkTicket Requisition
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendWorkTicketRequisitionForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendWorkTicketRequisitionForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendWorkTicketRequisitionForApprovalCode);//Delegate

        //Vehicle Filling
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendVehicleFillingForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendVehicleFillingForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendVehicleFillingForApprovalCode);//Delegate

        //---------------------------------------End Approval,Rejection,Delegation Predecessors---------------------------------------------
    end;

    procedure RunWorkflowOnSendFuelRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendFuelRequisitionForApproval'));
    end;

    procedure RunWorkflowOnCancelFuelRequisitionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelFuelRequisitionApprovalRequest'));
    end;

    //[EventSubscriber(ObjectType::Codeunit, 1535, 'OnSendFuelRequisitionForApproval', '', false, false)]
    procedure RunWorkflowOnSendFuelRequisitionForApproval(var FuelRequisition: Record "Fuel Requisition")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendFuelRequisitionForApprovalCode, FuelRequisition);
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnCancelFuelRequisitionApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelFuelRequisitionApprovalRequest(var FuelRequisition: Record "Fuel Requisition")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelFuelRequisitionApprovalRequestCode, FuelRequisition);
    end;

    procedure RunWorkflowOnSendTransportRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendTransportRequisitionForApproval'));
    end;

    procedure RunWorkflowOnCancelTransportRequisitionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelTransportRequisitionApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSendTransportRequisitionForApproval', '', false, false)]
    procedure RunWorkflowOnSendTransportRequisitionForApproval(var TransportRequisition: Record "Vehicle Requisition Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTransportRequisitionForApprovalCode, TransportRequisition);
    end;

    //[EventSubscriber(ObjectType::Codeunit, 1535, 'OnCancelTransportRequisitionApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelTransportRequisitionApprovalRequest(var WorkTicket: Record "Work Ticket")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTransportRequisitionApprovalRequestCode, WorkTicket);
    end;

    procedure RunWorkflowOnSendWorkTicketRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendWorkTicketForApproval'));
    end;

    procedure RunWorkflowOnCancelWorkTicketnApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelWorkTicketApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSendWorkTicketForApproval', '', false, false)]
    // procedure RunWorkflowOnSendWorkTicketForApproval(var WorkTicket: Record "Work Ticket")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendWorkTicketRequisitionForApprovalCode,WorkTicket);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnCancelWorkTicketApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelWorkTicketApprovalRequest(var WorkTicket: Record "Work Ticket")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelWorkTicketnApprovalRequestCode,WorkTicket);
    // end;

    procedure RunWorkflowOnSendVehicleFillingForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendVehicleFillingForApproval'));
    end;

    procedure RunWorkflowOnCancelVehicleFillingApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelVehicleFillingApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSendVehicleFillingForApproval', '', false, false)]
    // procedure RunWorkflowOnSendVehicleFillingForApproval(var VehicleFilling: Record "Vehicle Filling")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendVehicleFillingForApprovalCode,VehicleFilling);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnCancelVehicleFillingApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelVehicleFillingApprovalRequest(var VehicleFilling: Record "Vehicle Filling")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelVehicleFillingApprovalRequestCode,VehicleFilling);
    // end;
}

