codeunit 50057 "Property Workflow Responses"
{

    trigger OnRun()
    begin
    end;

    var
        WFEventHandler: Codeunit "Workflow Event Handling";
        WFResponseHandler: Codeunit "Workflow Response Handling";
        HRWFEvents: Codeunit "Property Workflow Events";

    procedure AddResponsesToLibrary()
    begin
    end;

    procedure AddResponsePredecessors()
    begin
        //--------------------------------------Property Management Response Predecessors--------------------------------------------------------------------
        //Property Header
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  HRWFEvents.RunWorkflowOnSendPropertyHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  HRWFEvents.RunWorkflowOnSendPropertyHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  HRWFEvents.RunWorkflowOnSendPropertyHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  HRWFEvents.RunWorkflowOnCancelPropertyHeaderApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  HRWFEvents.RunWorkflowOnCancelPropertyHeaderApprovalRequestCode);

        //Tenant Application
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                           HRWFEvents.RunWorkflowOnSendTenantApplicationForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                           HRWFEvents.RunWorkflowOnSendTenantApplicationForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                           HRWFEvents.RunWorkflowOnSendTenantApplicationForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                           HRWFEvents.RunWorkflowOnCancelTenantApplicationApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                           HRWFEvents.RunWorkflowOnCancelTenantApplicationApprovalRequestCode);

        // //Maintenance Header
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                           HRWFEvents.RunWorkflowOnSendMaintenanceHeaderForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                           HRWFEvents.RunWorkflowOnSendMaintenanceHeaderForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                           HRWFEvents.RunWorkflowOnSendMaintenanceHeaderForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                           HRWFEvents.RunWorkflowOnCancelMaintenanceHeaderApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                           HRWFEvents.RunWorkflowOnCancelMaintenanceHeaderApprovalRequestCode);

        // //Property Activity Header
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                           HRWFEvents.RunWorkflowOnSendPropertyActivityHeaderForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                           HRWFEvents.RunWorkflowOnSendPropertyActivityHeaderForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                           HRWFEvents.RunWorkflowOnSendPropertyActivityHeaderForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                           HRWFEvents.RunWorkflowOnCancelPropertyActivityHeaderApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                           HRWFEvents.RunWorkflowOnCancelPropertyActivityHeaderApprovalRequestCode);


        // //Electricity Readings
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                           HRWFEvents.RunWorkflowOnSendElectricityReadingsForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                           HRWFEvents.RunWorkflowOnSendElectricityReadingsForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                           HRWFEvents.RunWorkflowOnSendElectricityReadingsForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                           HRWFEvents.RunWorkflowOnCancelElectricityReadingsApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                           HRWFEvents.RunWorkflowOnCancelElectricityReadingsApprovalRequestCode);

        // //Cost Allocation
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                           HRWFEvents.RunWorkflowOnSendCostAllocationForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                           HRWFEvents.RunWorkflowOnSendCostAllocationForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                           HRWFEvents.RunWorkflowOnSendCostAllocationForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                           HRWFEvents.RunWorkflowOnCancelCostAllocationApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                           HRWFEvents.RunWorkflowOnCancelCostAllocationApprovalRequestCode);

        // //Property Lease
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                           HRWFEvents.RunWorkflowOnSendPropertyLeaseForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                           HRWFEvents.RunWorkflowOnSendPropertyLeaseForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                           HRWFEvents.RunWorkflowOnSendPropertyLeaseForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                           HRWFEvents.RunWorkflowOnCancelPropertyLeaseApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                           HRWFEvents.RunWorkflowOnCancelPropertyLeaseApprovalRequestCode);
    end;
}

