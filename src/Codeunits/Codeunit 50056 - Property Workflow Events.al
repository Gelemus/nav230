codeunit 50056 "Property Workflow Events"
{

    trigger OnRun()
    begin
    end;

    var
        WFHandler: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        PropertyApprovalRequest: Label 'Approval of a Property document is requested.';
        PropertyCancelApprovalRequest: Label 'Approval of a Property document is Cancelled.';
        TenantApplicationApprovalRequest: Label 'Approval of a Tenant Application document is requested.';
        TenantApplicationCancelApprovalRequest: Label 'Approval of a Tenant Application document is Cancelled.';
        MaintenanceHeaderApprovalRequest: Label 'Approval of a Maintenance Header document is requested.';
        MaintenanceHeaderCancelApprovalRequest: Label 'Approval of a Maintenance Header document is Cancelled.';
        PropertyActivityHeaderApprovalRequest: Label 'Approval of a Property Activity Header document is requested.';
        PropertyActivityHeaderCancelApprovalRequest: Label 'Approval of a Property Activity Header document is Cancelled.';
        ElectricityReadingsApprovalRequest: Label 'Approval of a Electricity Reading document is requested.';
        ElectricityReadingsCancelApprovalRequest: Label 'Approval of a Electricity Reading document is Cancelled.';
        CostAllocationApprovalRequest: Label 'Approval of a Cost Allocation document is requested.';
        CostAllocationCancelApprovalRequest: Label 'Approval of a Cost Allocation document is Cancelled.';
        PropertyLeaseApprovalRequest: Label 'Approval of a Property Lease document is requested.';
        PropertyLeaseCancelApprovalRequest: Label 'Approval of a Property Lease document is Cancelled.';

    procedure AddEventsToLibrary()
    begin
        //---------------------------------------------Property Management Approval Events--------------------------------------------------------------
        //Property
        //   WFHandler.AddEventToLibrary(RunWorkflowOnSendPropertyHeaderForApprovalCode,
        //                               DATABASE::Table50249,PropertyApprovalRequest,0,false);
        //   WFHandler.AddEventToLibrary(RunWorkflowOnCancelPropertyHeaderApprovalRequestCode,
        //                               DATABASE::Table50249,PropertyCancelApprovalRequest,0,false);

        // //Tenant Application
        //   WFHandler.AddEventToLibrary(RunWorkflowOnSendTenantApplicationForApprovalCode,
        //                               DATABASE::Table50260,TenantApplicationApprovalRequest,0,false);
        //   WFHandler.AddEventToLibrary(RunWorkflowOnCancelTenantApplicationApprovalRequestCode,
        //                               DATABASE::Table50260,TenantApplicationCancelApprovalRequest,0,false);

        // //Maintenance Header
        //   WFHandler.AddEventToLibrary(RunWorkflowOnSendMaintenanceHeaderForApprovalCode,
        //                               DATABASE::Table50282,MaintenanceHeaderApprovalRequest,0,false);
        //   WFHandler.AddEventToLibrary(RunWorkflowOnCancelMaintenanceHeaderApprovalRequestCode,
        //                               DATABASE::Table50282,MaintenanceHeaderCancelApprovalRequest,0,false);

        // //Property Activity Header
        //   WFHandler.AddEventToLibrary(RunWorkflowOnSendPropertyActivityHeaderForApprovalCode,
        //                               DATABASE::Table50285,PropertyActivityHeaderApprovalRequest,0,false);
        //   WFHandler.AddEventToLibrary(RunWorkflowOnCancelPropertyActivityHeaderApprovalRequestCode,
        //                               DATABASE::Table50285,PropertyActivityHeaderCancelApprovalRequest,0,false);

        // //Electricity Readings
        //   WFHandler.AddEventToLibrary(RunWorkflowOnSendElectricityReadingsForApprovalCode,
        //                               DATABASE::Table50287,ElectricityReadingsApprovalRequest,0,false);
        //   WFHandler.AddEventToLibrary(RunWorkflowOnCancelElectricityReadingsApprovalRequestCode,
        //                               DATABASE::Table50287,ElectricityReadingsCancelApprovalRequest,0,false);

        // //Cost Allocation
        //   WFHandler.AddEventToLibrary(RunWorkflowOnSendCostAllocationForApprovalCode,
        //                               DATABASE::Table50283,CostAllocationApprovalRequest,0,false);
        //   WFHandler.AddEventToLibrary(RunWorkflowOnCancelCostAllocationApprovalRequestCode,
        //                               DATABASE::Table50283,CostAllocationCancelApprovalRequest,0,false);

        // //Property Lease
        //   WFHandler.AddEventToLibrary(RunWorkflowOnSendPropertyLeaseForApprovalCode,
        //                               DATABASE::Table50261,PropertyLeaseApprovalRequest,0,false);
        //   WFHandler.AddEventToLibrary(RunWorkflowOnCancelPropertyLeaseApprovalRequestCode,
        //                               DATABASE::Table50261,PropertyLeaseCancelApprovalRequest,0,false);



        //-----------------------------------------End Property Management Approval Events--------------------------------------------------------------
    end;

    procedure AddEventsPredecessor()
    begin
        //-----------------------------------HR Management Approval,Rejection,Delegation Predecessors---------------------------------------------

        //PropertyHeader
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPropertyHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPropertyHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPropertyHeaderForApprovalCode);

        //   //Tenant Application
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendTenantApplicationForApprovalCode);
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendTenantApplicationForApprovalCode);
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendTenantApplicationForApprovalCode);

        // //Maintenance Header
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendMaintenanceHeaderForApprovalCode);
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendMaintenanceHeaderForApprovalCode);
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendMaintenanceHeaderForApprovalCode);

        // //Property Activity Header
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendPropertyActivityHeaderForApprovalCode);
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendPropertyActivityHeaderForApprovalCode);
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendPropertyActivityHeaderForApprovalCode);

        // //Electricity Readings
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendElectricityReadingsForApprovalCode);
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendElectricityReadingsForApprovalCode);
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendElectricityReadingsForApprovalCode);

        // //Cost Allocation
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendCostAllocationForApprovalCode);
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendCostAllocationForApprovalCode);
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendCostAllocationForApprovalCode);

        // //Property Lease
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendPropertyLeaseForApprovalCode);
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendPropertyLeaseForApprovalCode);
        //     WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendPropertyLeaseForApprovalCode);




        //-----------------------------------End Property Approval,Rejection,Delegation Predecessors-----------------------------------------
    end;

    procedure RunWorkflowOnSendPropertyHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPropertyHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelPropertyHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPropertyHeaderApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSendPropertyHeaderForApproval', '', false, false)]
    // procedure RunWorkflowOnSendPropertyHeaderForApproval(var PropertyHeader: Record "Payment Terms")
    // begin
    //     //WorkflowManagement.HandleEvent(RunWorkflowOnSendPropertyHeaderForApprovalCode,PropertyHeader);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnCancelPropertyHeaderApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelPropertyHeaderApprovalRequest(var PropertyHeader: Record "Payment Terms")
    // begin
    //     //WorkflowManagement.HandleEvent(RunWorkflowOnCancelPropertyHeaderApprovalRequestCode,PropertyHeader);
    // end;

    // procedure RunWorkflowOnSendTenantApplicationForApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnSendTenantApplicationForApproval'));
    // end;

    // procedure RunWorkflowOnCancelTenantApplicationApprovalRequestCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnCancelTenantApplicationApprovalRequest'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSendTenantApplicationForApproval', '', false, false)]
    // procedure RunWorkflowOnSendTenantApplicationForApproval(TenantApplication: Record "Payment Terms")
    // begin
    //     //WorkflowManagement.HandleEvent(RunWorkflowOnSendTenantApplicationForApprovalCode,TenantApplication);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnCancelTenantApplicationApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelTenantApplicationApprovalRequest(TenantApplication: Record "Payment Terms")
    // begin
    //     //WorkflowManagement.HandleEvent(RunWorkflowOnCancelTenantApplicationApprovalRequestCode,TenantApplication);
    // end;

    // procedure RunWorkflowOnSendMaintenanceHeaderForApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnSendMaintenanceHeaderForApproval'));
    // end;

    // procedure RunWorkflowOnCancelMaintenanceHeaderApprovalRequestCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnCancelMaintenanceHeaderApprovalRequest'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSendMaintenanceHeaderForApproval', '', false, false)]
    // procedure RunWorkflowOnSendMaintenanceHeaderForApproval(MaintenanceHeader: Record "Payment Terms")
    // begin
    //     //WorkflowManagement.HandleEvent(RunWorkflowOnSendMaintenanceHeaderForApprovalCode,MaintenanceHeader);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnCancelMaintenanceHeaderApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelMaintenanceHeaderApprovalRequest(MaintenanceHeader: Record "Payment Terms")
    // begin
    //     //WorkflowManagement.HandleEvent(RunWorkflowOnCancelMaintenanceHeaderApprovalRequestCode,MaintenanceHeader);
    // end;

    // procedure RunWorkflowOnSendPropertyActivityHeaderForApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnSendPropertyActivityHeaderForApproval'));
    // end;

    // procedure RunWorkflowOnCancelPropertyActivityHeaderApprovalRequestCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnCancelPropertyActivityHeaderApprovalRequest'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSendPropertyActivityHeaderForApproval', '', false, false)]
    // procedure RunWorkflowOnSendPropertyActivityHeaderForApproval(PropertyActivityHeader: Record "Payment Terms")
    // begin
    //     //WorkflowManagement.HandleEvent(RunWorkflowOnSendPropertyActivityHeaderForApprovalCode,PropertyActivityHeader);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnCancelPropertyActivityHeaderApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelPropertyActivityHeaderApprovalRequest(PropertyActivityHeader: Record "Payment Terms")
    // begin
    //     //WorkflowManagement.HandleEvent(RunWorkflowOnCancelPropertyActivityHeaderApprovalRequestCode,PropertyActivityHeader);
    // end;

    // procedure RunWorkflowOnSendElectricityReadingsForApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnSendElectricityReadingsForApproval'));
    // end;

    // procedure RunWorkflowOnCancelElectricityReadingsApprovalRequestCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnCancelElectricityReadingsApprovalRequest'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSendElectricityReadingsForApproval', '', false, false)]
    // procedure RunWorkflowOnSendElectricityReadingsForApproval(ElectricityMeterReadings: Record "Payment Terms")
    // begin
    //     //WorkflowManagement.HandleEvent(RunWorkflowOnSendElectricityReadingsForApprovalCode,ElectricityMeterReadings);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnCancelElectricityReadingsApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelElectricityReadingsApprovalRequest(ElectricityMeterReadings: Record "Payment Terms")
    // begin
    //     //WorkflowManagement.HandleEvent(RunWorkflowOnCancelElectricityReadingsApprovalRequestCode,ElectricityMeterReadings);
    // end;

    // procedure RunWorkflowOnSendCostAllocationForApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnSendCostAllocationForApproval'));
    // end;

    // procedure RunWorkflowOnCancelCostAllocationApprovalRequestCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnCancelCostAllocationApprovalRequest'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSendCostAllocationForApproval', '', false, false)]
    // procedure RunWorkflowOnSendCostAllocationForApproval(PropertyCostAllocation: Record "Payment Terms")
    // begin
    //     //WorkflowManagement.HandleEvent(RunWorkflowOnSendCostAllocationForApprovalCode,PropertyCostAllocation);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnCancelCostAllocationApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelCostAllocationApprovalRequest(PropertyCostAllocation: Record "Payment Terms")
    // begin
    //     //WorkflowManagement.HandleEvent(RunWorkflowOnCancelCostAllocationApprovalRequestCode,PropertyCostAllocation);
    // end;

    // procedure RunWorkflowOnSendPropertyLeaseForApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnSendPropertyLeaseForApproval'));
    // end;

    // procedure RunWorkflowOnCancelPropertyLeaseApprovalRequestCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnCancelPropertyLeaseApprovalRequest'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSendPropertyLeaseForApproval', '', false, false)]
    // procedure RunWorkflowOnSendPropertyLeaseForApproval(PropertyLeaseHeader: Record "Payment Terms")
    // begin
    //     //WorkflowManagement.HandleEvent(RunWorkflowOnSendPropertyLeaseForApprovalCode,PropertyLeaseHeader);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnCancelPropertyLeaseApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelPropertyLeaseApprovalRequest(PropertyLeaseHeader: Record "Payment Terms")
    // begin
    //     //WorkflowManagement.HandleEvent(RunWorkflowOnCancelPropertyLeaseApprovalRequestCode,PropertyLeaseHeader);
    // end;
}

