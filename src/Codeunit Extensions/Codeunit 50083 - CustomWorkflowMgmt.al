codeunit 50083 "Custom Workflow Mgmt"
{
    var
        WorkflowManagement: Codeunit "Workflow Management";
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
        FundsApprovalManager: Codeunit "Funds Approval Manager";
        FundsWFEvents: Codeunit "Funds Workflow Events";
        InventoryWFEvents: Codeunit "Inventory Workflow Events";
        ProcurementWFEvents: Codeunit "Procurement Workflow Events";
        HRWFEvents: Codeunit "HR Workflow Events";
        FleetWorkflowEventsCu: Codeunit "Fleet Workflow Events";
        ProcurementApprovalManager: Codeunit "Procurement Approval Manager";
        InventoryApprovalManager: Codeunit "Inventory Approval Manager";
        HRApprovalManager: Codeunit "HR Approval Manager";
        FleetApprovalManager: Codeunit "Fleet Approval Manager";

    //----------------------------------------------------------------------------------------------------------
    local procedure GetEmployeeUserId(EmployeeNo: Code[10]) UsrID: Code[50]
    var
        EmployeeRec: Record Employee;
    begin
        IF EmployeeRec.GET(EmployeeNo) THEN
            IF EmployeeRec."User ID" <> '' THEN
                exit(EmployeeRec."User ID")
            ELSE
                exit(USERID);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        PaymentHeader: Record "Payment Header";
        FundsTransfer: Record "Funds Transfer Header";
        ReceiptHeader: Record "Receipt Header";
        ImprestHeader: Record "Imprest Header";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        FundsClaimHeader: Record "Funds Claim Header";
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
        BidAnalysis: Record "Bid Analysis Header";
        StoreRequisitionHeader: Record "Store Requisition Header";
        HRJob: Record "HR Jobs";
        HREmployeeRequisition: Record "HR Employee Requisitions";
        HRJobApplication: Record "HR Job Applications";
        HREmployeeAppraisalHeader: Record "HR Employee Appraisal Header";
        HRLeavePlannerHeader: Record "HR Leave Planner Header";
        HRLeaveApplication: Record "HR Leave Application";
        HRLeaveReimbusment: Record "HR Leave Reimbursement";
        HRLeaveCarryover: Record "HR Leave Carryover";
        HRLeaveAllocationHeader: Record "HR Leave Allocation Header";
        FuelRequisition: Record "Vehicle Filling";
        TransportRequisition: Record "Transport Request";
        HRAssetTransfer: Record "HR Asset Transfer Header";
        HREmployeeTransfer: Record "HR Employee Transfer Header";
        InterviewAttendanceHeader: Record "Interview Attendance Header";
        HRExitInterview: Record "HR Employee Exit Interviews";
        HRTrainingApplications: Record "HR Training Applications";
        HRTrainingNeedsHeader: Record "HR Training Needs Header";
        HRTrainingGroup: Record "HR Training Group";
        TrainingEvaluation: Record "Training Evaluation";
        ProcurementPlanningHeader: Record "Procurement Planning Header";
        DocumentReversalHeader: Record "Document Reversal Header";
        LeaveAllowanceRequest: Record "Leave Allowance Request";
        EmployeeLoanApplications: Record "Employee Loan Applications";
        HRLoanProducts: Record "Employee Loan Products";
        EmployeeLoanDisbursement: Record "Employee Loan Disbursement";
        TenderHeader: Record "Tender Header";
        JournalVoucherHeader: Record "Journal Voucher Header";
        TransportRequestRec: Record "Transport Request";
        SalaryAdvance: Record "Salary Advance";
        AllowanceHeaderRec: Record "Allowance Header";
        FundsGeneralSetup: Record "Funds General Setup";
        TransferHeader: Record "Transfer Header";
        Periods: Record "Periods";
        WorkTicket: Record "Work Ticket";
        VehicleFillingRec: Record "Vehicle Filling";
        InspectionHeader: Record "Inspection Header";
        AllowanceHeader: Record "Allowance Header";
        EmployeeLoanProducts: Record "Employee Loan Products";
        VehicleRequisitionHeader: Record "Vehicle Requisition Header";
        TestDocument: Record "TestDocument";

    begin
        case RecRef.Number of
            Database::"Payment Header":
                begin
                    RecRef.SetTable(PaymentHeader);
                    FundsApprovalManager.ReOpenPaymentHeader(PaymentHeader);
                end;
            //Salary Advance
            //Payment Header
            DATABASE::"Salary Advance":
                begin
                    RecRef.SetTable(SalaryAdvance);
                    FundsApprovalManager.ReleaseSalaryAdvance(SalaryAdvance);
                end;

            //Allowance
            DATABASE::"Allowance Header":
                begin
                    RecRef.SetTable(AllowanceHeader);
                    FundsApprovalManager.ReleaseTransferAllowanceHeader(AllowanceHeader);
                end;
            //Funds Transfer Header
            DATABASE::"Funds Transfer Header":
                begin
                    RecRef.SetTable(FundsTransfer);
                    FundsApprovalManager.ReleaseFundsTransferHeader(FundsTransfer);
                end;
            //Receipt Header
            DATABASE::"Receipt Header":
                begin
                    RecRef.SetTable(ReceiptHeader);
                    FundsApprovalManager.ReleaseReceiptHeader(ReceiptHeader);
                end;

            //Imprest Header
            DATABASE::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestHeader);
                    FundsApprovalManager.ReleaseImprestHeader(ImprestHeader);
                end;

            //Imprest Surrender Header
            DATABASE::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrenderHeader);
                    FundsApprovalManager.ReleaseImprestSurrenderHeader(ImprestSurrenderHeader);
                end;

            //Funds Claim Header
            DATABASE::"Funds Claim Header":
                begin
                    RecRef.SetTable(FundsClaimHeader);
                    FundsApprovalManager.ReleaseFundsClaim(FundsClaimHeader);
                end;

            //Document Reversal Header
            DATABASE::"Document Reversal Header":
                begin
                    RecRef.SetTable(DocumentReversalHeader);
                    FundsApprovalManager.ReleaseDocumentReversal(DocumentReversalHeader);
                end;

            //Journal voucher
            DATABASE::"Journal Voucher Header":
                begin
                    RecRef.SetTable(JournalVoucherHeader);
                    FundsApprovalManager.ReleaseJournalVoucher(JournalVoucherHeader);
                end;
            //
            DATABASE::Periods:
                begin
                    RecRef.SetTable(Periods);
                    FundsApprovalManager.ReleasePayroll(Periods);
                end;


            //-----------------------End Release Funds Management Documents--------------------------


            //----------------------Release Procurement Management Documents-------------------------
            //Purchase Requisition
            DATABASE::"Purchase Requisitions":
                begin
                    RecRef.SetTable(PurchaseRequisitionHeader);
                    ProcurementApprovalManager.ReleasePurchaseRequisitionHeader(PurchaseRequisitionHeader);
                end;

            //Bid Analysis
            DATABASE::"Bid Analysis Header":
                begin
                    RecRef.SetTable(BidAnalysis);
                    ProcurementApprovalManager.ReleaseBidAnalysis(BidAnalysis);
                end;


            //Procurement Plan
            DATABASE::"Procurement Planning Header":
                begin
                    RecRef.SetTable(ProcurementPlanningHeader);
                    ProcurementApprovalManager.ReleaseProcurementPlan(ProcurementPlanningHeader);
                end;

            //Tender Header
            DATABASE::"Tender Header":
                begin
                    RecRef.SetTable(TenderHeader);
                    ProcurementApprovalManager.ReleaseTenderHeader(TenderHeader);
                end;
            //Transfer Header
            DATABASE::"Transfer Header":
                begin
                    RecRef.SetTable(TransferHeader);
                    ProcurementApprovalManager.ReleaseTransferHeader(TransferHeader);
                end;

            //Store Requisition
            DATABASE::"Store Requisition Header":
                begin
                    RecRef.SetTable(StoreRequisitionHeader);
                    InventoryApprovalManager.ReleaseStoreRequisitionHeader(StoreRequisitionHeader);
                end;
            //-------------------End Release Procurement Management Documents------------------------

            //-------------------------Release CRM Management Documents-------------------------------
            //Marketing Plan
            // DATABASE::"Marketing Plan": begin RecRef.SetTable(PaymentHeader);
            //  CRMApprovalManager.ReleaseMarketingPlan(Variant); end; 
            //-------------------------End Release CRM Management Documents-------------------------------

            //-------------------------Release HR Management Documents-------------------------------
            //HR Job
            DATABASE::"HR Jobs":
                begin
                    RecRef.SetTable(HRJob);
                    HRApprovalManager.ReleaseHRJob(HRJob);
                end;

            //HR Employee Requisition
            DATABASE::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(HREmployeeRequisition);
                    HRApprovalManager.ReleaseHREmployeeRequisition(HREmployeeRequisition);
                end;

            //HR Job Application
            DATABASE::"HR Job Applications":
                begin
                    RecRef.SetTable(HRJobApplication);
                    HRApprovalManager.ReleaseHRJobApplication(HRJobApplication);
                end;

            //HR Employee Appraisal Header
            DATABASE::"HR Employee Appraisal Header":
                begin
                    RecRef.SetTable(HREmployeeAppraisalHeader);
                    HRApprovalManager.ReleaseHREmployeeAppraisalHeader(HREmployeeAppraisalHeader);
                end;

            //HR Leave Planner Header
            DATABASE::"HR Leave Planner Header":
                begin
                    RecRef.SetTable(HRLeavePlannerHeader);
                    HRApprovalManager.ReleaseHRLeavePlannerHeader(HRLeavePlannerHeader);
                end;

            //HR Leave Application
            DATABASE::"HR Leave Application":
                begin
                    RecRef.SetTable(HRLeaveApplication);
                    HRApprovalManager.ReleaseHRLeaveApplication(HRLeaveApplication);
                end;

            //HR Leave Reimbusment
            DATABASE::"HR Leave Reimbursement":
                begin
                    RecRef.SetTable(HRLeaveReimbusment);
                    HRApprovalManager.ReleaseHRLeaveReimbusment(HRLeaveReimbusment);
                end;

            //HR Leave Carryover
            DATABASE::"HR Leave Carryover":
                begin
                    RecRef.SetTable(HRLeaveCarryover);
                    HRApprovalManager.ReleaseHRLeaveCarryover(HRLeaveCarryover);
                end;

            //HR Leave Allocation Header
            DATABASE::"HR Leave Allocation Header":
                begin
                    RecRef.SetTable(HRLeaveAllocationHeader);
                    HRApprovalManager.ReleaseHRLeaveAllocationHeader(HRLeaveAllocationHeader);
                end;

            //HR Asset Transfer
            DATABASE::"HR Asset Transfer Header":
                begin
                    RecRef.SetTable(HRAssetTransfer);
                    HRApprovalManager.ReleaseHRAssetTransferHeader(HRAssetTransfer);
                end;

            //HR Employee Transfer
            DATABASE::"HR Employee Transfer Header":
                begin
                    RecRef.SetTable(HREmployeeTransfer);
                    HRApprovalManager.ReleaseHREmployeeTransferHeader(HREmployeeTransfer);
                end;

            //HR Exit Interviews
            DATABASE::"HR Employee Exit Interviews":
                begin
                    RecRef.SetTable(HRExitInterview);
                    HRApprovalManager.ReleaseHRExitInterviewHeader(HRExitInterview);
                end;

            //HR Training Needs
            DATABASE::"HR Training Needs Header":
                begin
                    RecRef.SetTable(HRTrainingNeedsHeader);
                    HRApprovalManager.ReleaseHRTrainingNeedsHeader(HRTrainingNeedsHeader);
                end;

            //HR Training Groups
            DATABASE::"HR Training Group":
                begin
                    RecRef.SetTable(HRTrainingGroup);
                    HRApprovalManager.ReleaseHRTrainingGroup(HRTrainingGroup);
                end;

            //HR Training Applications
            DATABASE::"HR Training Applications":
                begin
                    RecRef.SetTable(HRTrainingApplications);
                    HRApprovalManager.ReleaseHRTrainingHeader(HRTrainingApplications);
                end;

            //HR Training Evaluations
            DATABASE::"Training Evaluation":
                begin
                    RecRef.SetTable(TrainingEvaluation);
                    HRApprovalManager.ReleaseTrainingEvaluation(TrainingEvaluation);
                end;
            //HR Transport Request
            DATABASE::"Transport Request":
                begin
                    RecRef.SetTable(TransportRequestRec);
                    HRApprovalManager.ReleaseTransportRequest(TransportRequestRec);
                end;
            //HR Leave Allowance
            DATABASE::"Leave Allowance Request":
                begin
                    RecRef.SetTable(LeaveAllowanceRequest);
                    HRApprovalManager.ReleaseleaveAllowance(LeaveAllowanceRequest);
                end;

            //HR Loan Application
            DATABASE::"Employee Loan Applications":
                begin
                    RecRef.SetTable(EmployeeLoanApplications);
                    HRApprovalManager.ReleaseHRLoan(EmployeeLoanApplications);
                end;

            //HR Loan Product
            DATABASE::"Employee Loan Products":
                begin
                    RecRef.SetTable(EmployeeLoanProducts);
                    HRApprovalManager.ReleaseHRLoanProduct(EmployeeLoanProducts);
                end;

            //HR Loan Disbursement
            DATABASE::"Employee Loan Disbursement":
                begin
                    RecRef.SetTable(EmployeeLoanDisbursement);
                    HRApprovalManager.ReleaseHRLoanDisbursement(EmployeeLoanDisbursement);
                end;
            //HR Interview Header
            DATABASE::"Interview Attendance Header":
                begin
                    RecRef.SetTable(InterviewAttendanceHeader);
                    HRApprovalManager.ReleaseInterviewHeader(InterviewAttendanceHeader);
                end;

            //FUEL Requisition Header
            DATABASE::"Vehicle Filling":
                begin
                    RecRef.SetTable(VehicleFillingRec);
                    FleetApprovalManager.ReleaseVehicleFilling(VehicleFillingRec);
                end;

            //Transport Requisition Header
            DATABASE::"Vehicle Requisition Header":
                begin
                    RecRef.SetTable(VehicleRequisitionHeader);
                    FleetApprovalManager.ReleaseTransportRequisition(VehicleRequisitionHeader);
                end;
            //Work Ticket Requisition Header
            DATABASE::"Work Ticket":
                begin
                    RecRef.SetTable(WorkTicket);
                    FleetApprovalManager.ReleaseWorkTicketRequisition(WorkTicket);
                end;

            //Inspection
            DATABASE::"Inspection Header":
                begin
                    RecRef.SetTable(InspectionHeader);
                    HRApprovalManager.ReleaseInspectionHeader(InspectionHeader);
                end;
            //Inspection
            DATABASE::"TestDocument":
                begin
                    RecRef.SetTable(TestDocument);
                    HRApprovalManager.ReleaseTestDocument(TestDocument);
                end;
        end;
        Handled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        PaymentHeader: Record "Payment Header";
        FundsTransfer: Record "Funds Transfer Header";
        ReceiptHeader: Record "Receipt Header";
        ImprestHeader: Record "Imprest Header";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        FundsClaimHeader: Record "Funds Claim Header";
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
        BidAnalysis: Record "Bid Analysis Header";
        StoreRequisitionHeader: Record "Store Requisition Header";
        HRJob: Record "HR Jobs";
        HREmployeeRequisition: Record "HR Employee Requisitions";
        HRJobApplication: Record "HR Job Applications";
        HREmployeeAppraisalHeader: Record "HR Employee Appraisal Header";
        HRLeavePlannerHeader: Record "HR Leave Planner Header";
        HRLeaveApplication: Record "HR Leave Application";
        HRLeaveReimbusment: Record "HR Leave Reimbursement";
        HRLeaveCarryover: Record "HR Leave Carryover";
        HRLeaveAllocationHeader: Record "HR Leave Allocation Header";
        FuelRequisition: Record "Vehicle Filling";
        TransportRequisition: Record "Transport Request";
        HRAssetTransfer: Record "HR Asset Transfer Header";
        HREmployeeTransfer: Record "HR Employee Transfer Header";
        InterviewAttendanceHeader: Record "Interview Attendance Header";
        HRExitInterview: Record "HR Employee Exit Interviews";
        HRTrainingApplications: Record "HR Training Applications";
        HRTrainingNeedsHeader: Record "HR Training Needs Header";
        HRTrainingGroup: Record "HR Training Group";
        TrainingEvaluation: Record "Training Evaluation";
        ProcurementPlanningHeader: Record "Procurement Planning Header";
        DocumentReversalHeader: Record "Document Reversal Header";
        LeaveAllowanceRequest: Record "Leave Allowance Request";
        EmployeeLoanApplications: Record "Employee Loan Applications";
        HRLoanProducts: Record "Employee Loan Products";
        EmployeeLoanDisbursement: Record "Employee Loan Disbursement";
        TenderHeader: Record "Tender Header";
        JournalVoucherHeader: Record "Journal Voucher Header";
        TransportRequestRec: Record "Transport Request";
        SalaryAdvance: Record "Salary Advance";
        AllowanceHeaderRec: Record "Allowance Header";
        FundsGeneralSetup: Record "Funds General Setup";
        TransferHeader: Record "Transfer Header";
        Periods: Record "Periods";
        WorkTicket: Record "Work Ticket";
        VehicleFillingRec: Record "Vehicle Filling";
        InspectionHeader: Record "Inspection Header";
        AllowanceHeader: Record "Allowance Header";
        EmployeeLoanProducts: Record "Employee Loan Products";
        VehicleRequisitionHeader: Record "Vehicle Requisition Header";
        TestDocument: Record TestDocument;
    begin
        case RecRef.Number of

            Database::"Payment Header":
                begin
                    RecRef.SetTable(PaymentHeader);
                    FundsApprovalManager.ReOpenPaymentHeader(PaymentHeader);
                end;
            //Salary Advance
            //Payment Header
            DATABASE::"Salary Advance":
                begin
                    RecRef.SetTable(SalaryAdvance);
                    FundsApprovalManager.ReOpenSalaryAdvance(SalaryAdvance);
                end;

            //Allowance
            DATABASE::"Allowance Header":
                begin
                    RecRef.SetTable(AllowanceHeader);
                    FundsApprovalManager.ReOpenTransferAllowanceHeader(AllowanceHeader);
                end;
            //Funds Transfer Header
            DATABASE::"Funds Transfer Header":
                begin
                    RecRef.SetTable(FundsTransfer);
                    FundsApprovalManager.ReOpenFundsTransferHeader(FundsTransfer);
                end;
            //Receipt Header
            DATABASE::"Receipt Header":
                begin
                    RecRef.SetTable(ReceiptHeader);
                    FundsApprovalManager.ReOpenReceiptHeader(ReceiptHeader);
                end;

            //Imprest Header
            DATABASE::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestHeader);
                    FundsApprovalManager.ReOpenImprestHeader(ImprestHeader);
                end;

            //Imprest Surrender Header
            DATABASE::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrenderHeader);
                    FundsApprovalManager.ReOpenImprestSurrenderHeader(ImprestSurrenderHeader);
                end;

            //Funds Claim Header
            DATABASE::"Funds Claim Header":
                begin
                    RecRef.SetTable(FundsClaimHeader);
                    FundsApprovalManager.ReOpenFundsClaim(FundsClaimHeader);
                end;

            //Document Reversal Header
            DATABASE::"Document Reversal Header":
                begin
                    RecRef.SetTable(DocumentReversalHeader);
                    FundsApprovalManager.ReOpenDocumentReversal(DocumentReversalHeader);
                end;

            //Journal voucher
            DATABASE::"Journal Voucher Header":
                begin
                    RecRef.SetTable(JournalVoucherHeader);
                    FundsApprovalManager.ReOpenJournalVoucher(JournalVoucherHeader);
                end;
            //
            DATABASE::Periods:
                begin
                    RecRef.SetTable(Periods);
                    FundsApprovalManager.ReOpenPayroll(Periods);
                end;


            //-----------------------End Release Funds Management Documents--------------------------


            //----------------------Release Procurement Management Documents-------------------------
            //Purchase Requisition
            DATABASE::"Purchase Requisitions":
                begin
                    RecRef.SetTable(PurchaseRequisitionHeader);
                    ProcurementApprovalManager.ReOpenPurchaseRequisitionHeader(PurchaseRequisitionHeader);
                end;

            //Bid Analysis
            DATABASE::"Bid Analysis Header":
                begin
                    RecRef.SetTable(BidAnalysis);
                    ProcurementApprovalManager.ReOpenBidAnalysis(BidAnalysis);
                end;


            //Procurement Plan
            DATABASE::"Procurement Planning Header":
                begin
                    RecRef.SetTable(ProcurementPlanningHeader);
                    ProcurementApprovalManager.ReOpenProcurementPlan(ProcurementPlanningHeader);
                end;

            //Tender Header
            DATABASE::"Tender Header":
                begin
                    RecRef.SetTable(TenderHeader);
                    ProcurementApprovalManager.ReOpenTenderHeader(TenderHeader);
                end;
            //Transfer Header
            DATABASE::"Transfer Header":
                begin
                    RecRef.SetTable(TransferHeader);
                    ProcurementApprovalManager.ReOpenTransferHeader(TransferHeader);
                end;

            //Store Requisition
            DATABASE::"Store Requisition Header":
                begin
                    RecRef.SetTable(StoreRequisitionHeader);
                    InventoryApprovalManager.ReOpenStoreRequisitionHeader(StoreRequisitionHeader);
                end;
            //-------------------End Release Procurement Management Documents------------------------

            //-------------------------Release CRM Management Documents-------------------------------
            //Marketing Plan
            // DATABASE::"Marketing Plan": begin RecRef.SetTable(PaymentHeader);
            //  CRMApprovalManager.ReOpenMarketingPlan(Variant); end; 
            //-------------------------End Release CRM Management Documents-------------------------------

            //-------------------------Release HR Management Documents-------------------------------
            //HR Job
            DATABASE::"HR Jobs":
                begin
                    RecRef.SetTable(HRJob);
                    HRApprovalManager.ReOpenHRJob(HRJob);
                end;

            //HR Employee Requisition
            DATABASE::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(HREmployeeRequisition);
                    HRApprovalManager.ReOpenHREmployeeRequisition(HREmployeeRequisition);
                end;

            //HR Job Application
            DATABASE::"HR Job Applications":
                begin
                    RecRef.SetTable(HRJobApplication);
                    HRApprovalManager.ReOpenHRJobApplication(HRJobApplication);
                end;

            //HR Employee Appraisal Header
            DATABASE::"HR Employee Appraisal Header":
                begin
                    RecRef.SetTable(HREmployeeAppraisalHeader);
                    HRApprovalManager.ReOpenHREmployeeAppraisalHeader(HREmployeeAppraisalHeader);
                end;

            //HR Leave Planner Header
            DATABASE::"HR Leave Planner Header":
                begin
                    RecRef.SetTable(HRLeavePlannerHeader);
                    HRApprovalManager.ReOpenHRLeavePlannerHeader(HRLeavePlannerHeader);
                end;

            //HR Leave Application
            DATABASE::"HR Leave Application":
                begin
                    RecRef.SetTable(HRLeaveApplication);
                    HRApprovalManager.ReOpenHRLeaveApplication(HRLeaveApplication);
                end;

            //HR Leave Reimbusment
            DATABASE::"HR Leave Reimbursement":
                begin
                    RecRef.SetTable(HRLeaveReimbusment);
                    HRApprovalManager.ReOpenHRLeaveReimbusment(HRLeaveReimbusment);
                end;

            //HR Leave Carryover
            DATABASE::"HR Leave Carryover":
                begin
                    RecRef.SetTable(HRLeaveCarryover);
                    HRApprovalManager.ReOpenHRLeaveCarryover(HRLeaveCarryover);
                end;

            //HR Leave Allocation Header
            DATABASE::"HR Leave Allocation Header":
                begin
                    RecRef.SetTable(HRLeaveAllocationHeader);
                    HRApprovalManager.ReOpenHRLeaveAllocationHeader(HRLeaveAllocationHeader);
                end;

            //HR Asset Transfer
            DATABASE::"HR Asset Transfer Header":
                begin
                    RecRef.SetTable(HRAssetTransfer);
                    HRApprovalManager.ReOpenHRAssetTransferHeader(HRAssetTransfer);
                end;

            //HR Employee Transfer
            DATABASE::"HR Employee Transfer Header":
                begin
                    RecRef.SetTable(HREmployeeTransfer);
                    HRApprovalManager.ReOpenHREmployeeTransferHeader(HREmployeeTransfer);
                end;

            //HR Exit Interviews
            DATABASE::"HR Employee Exit Interviews":
                begin
                    RecRef.SetTable(HRExitInterview);
                    HRApprovalManager.ReOpenHRExitInterviewHeader(HRExitInterview);
                end;

            //HR Training Needs
            DATABASE::"HR Training Needs Header":
                begin
                    RecRef.SetTable(HRTrainingNeedsHeader);
                    HRApprovalManager.ReOpenHRTrainingNeedsHeader(HRTrainingNeedsHeader);
                end;

            //HR Training Groups
            DATABASE::"HR Training Group":
                begin
                    RecRef.SetTable(HRTrainingGroup);
                    HRApprovalManager.ReOpenHRTrainingGroup(HRTrainingGroup);
                end;

            //HR Training Applications
            DATABASE::"HR Training Applications":
                begin
                    RecRef.SetTable(HRTrainingApplications);
                    HRApprovalManager.ReOpenHRTrainingHeader(HRTrainingApplications);
                end;

            //HR Training Evaluations
            DATABASE::"Training Evaluation":
                begin
                    RecRef.SetTable(TrainingEvaluation);
                    HRApprovalManager.ReOpenTrainingEvaluation(TrainingEvaluation);
                end;
            //HR Transport Request
            DATABASE::"Transport Request":
                begin
                    RecRef.SetTable(TransportRequestRec);
                    HRApprovalManager.ReOpenHRTransportRequest(TransportRequestRec);
                end;
            //HR Leave Allowance
            DATABASE::"Leave Allowance Request":
                begin
                    RecRef.SetTable(LeaveAllowanceRequest);
                    HRApprovalManager.ReOpenleaveAllowance(LeaveAllowanceRequest);
                end;

            //HR Loan Application
            DATABASE::"Employee Loan Applications":
                begin
                    RecRef.SetTable(EmployeeLoanApplications);
                    HRApprovalManager.ReOpenHRLoan(EmployeeLoanApplications);
                end;

            //HR Loan Product
            DATABASE::"Employee Loan Products":
                begin
                    RecRef.SetTable(EmployeeLoanProducts);
                    HRApprovalManager.ReOpenHRLoanProduct(EmployeeLoanProducts);
                end;

            //HR Loan Disbursement
            DATABASE::"Employee Loan Disbursement":
                begin
                    RecRef.SetTable(EmployeeLoanDisbursement);
                    HRApprovalManager.ReOpenHRLoanDisbursement(EmployeeLoanDisbursement);
                end;
            //HR Interview Header
            DATABASE::"Interview Attendance Header":
                begin
                    RecRef.SetTable(InterviewAttendanceHeader);
                    HRApprovalManager.ReOpenInterviewHeader(InterviewAttendanceHeader);
                end;

            //FUEL Requisition Header
            DATABASE::"Vehicle Filling":
                begin
                    RecRef.SetTable(VehicleFillingRec);
                    FleetApprovalManager.ReOpenVehicleFilling(VehicleFillingRec);
                end;

            //Transport Requisition Header
            DATABASE::"Vehicle Requisition Header":
                begin
                    RecRef.SetTable(VehicleRequisitionHeader);
                    FleetApprovalManager.ReOpenTranportRequisition(VehicleRequisitionHeader);
                end;
            //Work Ticket Requisition Header
            DATABASE::"Work Ticket":
                begin
                    RecRef.SetTable(WorkTicket);
                    FleetApprovalManager.ReOpenWorkTicketRequisition(WorkTicket);
                end;

            //Inspection
            DATABASE::"Inspection Header":
                begin
                    RecRef.SetTable(InspectionHeader);
                    HRApprovalManager.ReOpenInspectionHeader(InspectionHeader);
                end;

            //TestDocument
            DATABASE::TestDocument:
                begin
                    RecRef.SetTable(TestDocument);
                    HRApprovalManager.ReOpenTestDocument(TestDocument);
                end;

        end;
        Handled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        PaymentHeader: Record "Payment Header";
        FundsTransfer: Record "Funds Transfer Header";
        ReceiptHeader: Record "Receipt Header";
        ImprestHeader: Record "Imprest Header";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        FundsClaimHeader: Record "Funds Claim Header";
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
        BidAnalysis: Record "Bid Analysis";
        StoreRequisitionHeader: Record "Store Requisition Header";
        HRJob: Record "HR Jobs";
        HREmployeeRequisition: Record "HR Employee Requisitions";
        HRJobApplication: Record "HR Job Applications";
        HREmployeeAppraisalHeader: Record "HR Employee Appraisal Header";
        HRLeavePlannerHeader: Record "HR Leave Planner Header";
        HRLeaveApplication: Record "HR Leave Application";
        HRLeaveReimbusment: Record "HR Leave Reimbursement";
        HRLeaveCarryover: Record "HR Leave Carryover";
        HRLeaveAllocationHeader: Record "HR Leave Allocation Header";
        FuelRequisition: Record "Vehicle Filling";
        TransportRequisition: Record "Transport Request";
        HRAssetTransfer: Record "HR Asset Transfer Header";
        HREmployeeTransfer: Record "HR Employee Transfer Header";
        InterviewAttendanceHeader: Record "Interview Attendance Header";
        HRExitInterview: Record "HR Employee Exit Interviews";
        HRTrainingApplications: Record "HR Training Applications";
        HRTrainingNeedsHeader: Record "HR Training Needs Header";
        HRTrainingGroup: Record "HR Training Group";
        TrainingEvaluation: Record "Training Evaluation";
        ProcurementPlanningHeader: Record "Procurement Planning Header";
        DocumentReversalHeader: Record "Document Reversal Header";
        LeaveAllowanceRequest: Record "Leave Allowance Request";
        EmployeeLoanApplications: Record "Employee Loan Applications";
        HRLoanProducts: Record "Employee Loan Products";
        EmployeeLoanDisbursement: Record "Employee Loan Disbursement";
        TenderHeader: Record "Tender Header";
        JournalVoucherHeader: Record "Journal Voucher Header";
        TransportRequestRec: Record "Transport Request";
        SalaryAdvance: Record "Salary Advance";
        AllowanceHeaderRec: Record "Allowance Header";
        FundsGeneralSetup: Record "Funds General Setup";
        TransferHeader: Record "Transfer Header";
        Periods: Record "Periods";
        WorkTicket: Record "Work Ticket";
        VehicleFillingRec: Record "Vehicle Filling";
        InspectionHeader: Record "Inspection Header";
        ImprestLine: Record "Imprest Line";
        TestDocument: Record TestDocument;

    begin
        case RecRef.Number of
            Database::"Payment Header":
                begin
                    RecRef.SetTable(PaymentHeader);
                    PaymentHeader.Validate(Status, PaymentHeader.Status::"Pending Approval");
                    PaymentHeader.Modify(true);
                    Variant := PaymentHeader;
                end;
            //Salary Advance
            DATABASE::"Salary Advance":
                BEGIN
                    RecRef.SETTABLE(SalaryAdvance);
                    SalaryAdvance.VALIDATE(Status, SalaryAdvance.Status::"Pending Approval");
                    SalaryAdvance.MODIFY(TRUE);
                    Variant := SalaryAdvance;
                END;
            //Funds Transfer Header
            DATABASE::"Funds Transfer Header":
                BEGIN
                    RecRef.SETTABLE(FundsTransfer);
                    FundsTransfer.VALIDATE(Status, FundsTransfer.Status::"Pending Approval");
                    FundsTransfer.MODIFY(TRUE);
                    Variant := FundsTransfer;
                END;

            //Receipt Header
            DATABASE::"Receipt Header":
                BEGIN
                    RecRef.SETTABLE(ReceiptHeader);
                    ReceiptHeader.VALIDATE(Status, ReceiptHeader.Status::"Pending Approval");
                    ReceiptHeader.MODIFY(TRUE);
                    Variant := ReceiptHeader;
                END;

            //Imprest Header
            DATABASE::"Imprest Header":
                BEGIN
                    RecRef.SETTABLE(ImprestHeader);
                    //Test petty cash and Imprest Amount
                    FundsGeneralSetup.GET;
                    ImprestHeader.CALCFIELDS(Amount, "Amount(LCY)");
                    ImprestHeader.VALIDATE(Status, ImprestHeader.Status::"Pending Approval");
                    ImprestHeader.MODIFY(TRUE);
                    Variant := ImprestHeader;
                END;

            //Imprest Surrender Header
            DATABASE::"Imprest Surrender Header":
                BEGIN
                    RecRef.SETTABLE(ImprestSurrenderHeader);
                    ImprestSurrenderHeader.VALIDATE(Status, ImprestSurrenderHeader.Status::"Pending Approval");
                    ImprestSurrenderHeader.MODIFY(TRUE);
                    Variant := ImprestSurrenderHeader;
                END;

            //Funds Claim Header
            DATABASE::"Funds Claim Header":
                BEGIN
                    RecRef.SETTABLE(FundsClaimHeader);
                    FundsClaimHeader.VALIDATE(Status, FundsClaimHeader.Status::"Pending Approval");
                    FundsClaimHeader.MODIFY(TRUE);
                    Variant := FundsClaimHeader;
                END;
            //Payroll
            DATABASE::Periods:
                BEGIN
                    RecRef.SETTABLE(Periods);
                    Periods.VALIDATE("Approval Status", Periods."Approval Status"::"Pending Approval");
                    Periods.MODIFY(TRUE);
                    Variant := Periods;
                END;

            //Document Reversal Header
            DATABASE::"Document Reversal Header":
                BEGIN
                    RecRef.SETTABLE(DocumentReversalHeader);
                    DocumentReversalHeader.VALIDATE(Status, DocumentReversalHeader.Status::"Pending Approval");
                    DocumentReversalHeader.MODIFY(TRUE);
                    Variant := DocumentReversalHeader;
                END;

            //Journal Voucher
            DATABASE::"Journal Voucher Header":
                BEGIN
                    RecRef.SETTABLE(JournalVoucherHeader);
                    JournalVoucherHeader.VALIDATE(Status, JournalVoucherHeader.Status::"Pending Approval");
                    JournalVoucherHeader.MODIFY(TRUE);
                    Variant := JournalVoucherHeader;
                END;

            //----------------------------End Funds Management Documents---------------------------------

            //---------------------------Procurement Management Documents--------------------------------
            //Purchase Requisition
            DATABASE::"Purchase Requisitions":
                BEGIN
                    RecRef.SETTABLE(PurchaseRequisitionHeader);
                    PurchaseRequisitionHeader.VALIDATE(Status, PurchaseRequisitionHeader.Status::"Pending Approval");
                    PurchaseRequisitionHeader.MODIFY(TRUE);
                    Variant := PurchaseRequisitionHeader;
                END;

            //Bid Analysis
            DATABASE::"Bid Analysis Header":
                BEGIN
                    RecRef.SETTABLE(BidAnalysis);
                    BidAnalysis.VALIDATE(BidAnalysis.Status, BidAnalysis.Status::"Pending Approval");
                    BidAnalysis.MODIFY(TRUE);
                    Variant := BidAnalysis;
                END;

            //Procurement Plan
            DATABASE::"Procurement Planning Header":
                BEGIN
                    RecRef.SETTABLE(ProcurementPlanningHeader);
                    ProcurementPlanningHeader.VALIDATE(Status, ProcurementPlanningHeader.Status::"Pending Approval");
                    ProcurementPlanningHeader.MODIFY(TRUE);
                    Variant := ProcurementPlanningHeader;
                END;

            //Tender Header
            DATABASE::"Tender Header":
                BEGIN
                    RecRef.SETTABLE(TenderHeader);
                    TenderHeader.VALIDATE(Status, TenderHeader.Status::"Pending Approval");
                    TenderHeader.MODIFY(TRUE);
                    Variant := TenderHeader;
                END;
            //Tender Header
            // DATABASE::"Transfer Header":
            //     BEGIN
            //         RecRef.SETTABLE(TransferHeader);
            //         TransferHeader.VALIDATE(Status, TransferHeader.Status::"Pending Approval");
            //         TransferHeader.MODIFY(TRUE);
            //         Variant := TransferHeader;
            //     END;

            //Inspection 
            DATABASE::"Inspection Header":
                BEGIN
                    RecRef.SETTABLE(InspectionHeader);
                    InspectionHeader.VALIDATE(Status, InspectionHeader.Status::"Pending Approval");
                    InspectionHeader.MODIFY(TRUE);
                    Variant := InspectionHeader;
                END;
            //-------------------------End Procurement Management Documents-------------------------------

            //------------------------ Inventory Management Documents-------------------------------

            //Store Requisition
            DATABASE::"Store Requisition Header":
                BEGIN
                    RecRef.SETTABLE(StoreRequisitionHeader);
                    StoreRequisitionHeader.VALIDATE(Status, StoreRequisitionHeader.Status::"Pending Approval");
                    StoreRequisitionHeader.MODIFY(TRUE);
                    Variant := StoreRequisitionHeader;
                END;
            //-------------------------End Inventory Management Documents-------------------------------

            //------------------------ CRM Management Documents-------------------------------

            //Marketing Plan
            // DATABASE::"Marketing Plan":
            //     BEGIN
            //         RecRef.SETTABLE(MarketingPlan);
            //         MarketingPlan.VALIDATE(Status, MarketingPlan.Status::"Pending Approval");
            //         MarketingPlan.MODIFY(TRUE);
            //         Variant := MarketingPlan;
            //     END;

            //-------------------------End CRM Management Documents-------------------------------

            //---------------------------------HR Management Documents------------------------------------
            //HR Job
            DATABASE::"HR Jobs":
                BEGIN
                    RecRef.SETTABLE(HRJob);
                    HRJob.VALIDATE(Status, HRJob.Status::"Pending Approval");
                    HRJob.MODIFY(TRUE);
                    Variant := HRJob;
                END;

            //HR Employee Requisition
            DATABASE::"HR Employee Requisitions":
                BEGIN
                    RecRef.SETTABLE(HREmployeeRequisition);
                    HREmployeeRequisition.VALIDATE(Status, HREmployeeRequisition.Status::"Pending Approval");
                    HREmployeeRequisition.MODIFY(TRUE);
                    Variant := HREmployeeRequisition;
                END;

            //HR Job Application
            DATABASE::"HR Job Applications":
                BEGIN
                    RecRef.SETTABLE(HRJobApplication);
                    HRJobApplication.VALIDATE(Status, HRJobApplication.Status::"Pending Approval");
                    HRJobApplication.MODIFY(TRUE);
                    Variant := HRJobApplication;
                END;

            //HR Employee Appraisal Header
            DATABASE::"HR Employee Appraisal Header":
                BEGIN
                    RecRef.SETTABLE(HREmployeeAppraisalHeader);
                    HREmployeeAppraisalHeader.VALIDATE(Status, HREmployeeAppraisalHeader.Status::"Pending Approval");
                    HREmployeeAppraisalHeader.MODIFY(TRUE);
                    Variant := HREmployeeAppraisalHeader;
                END;

            //HR Leave Planner Header
            DATABASE::"HR Leave Planner Header":
                BEGIN
                    RecRef.SETTABLE(HRLeavePlannerHeader);
                    HRLeavePlannerHeader.VALIDATE(Status, HRLeavePlannerHeader.Status::"Pending Approval");
                    HRLeavePlannerHeader.MODIFY(TRUE);
                    Variant := HRLeavePlannerHeader;
                END;
            //HR Transport Request
            DATABASE::"Transport Request":
                BEGIN
                    RecRef.SETTABLE(TransportRequestRec);
                    TransportRequestRec.VALIDATE(Status, TransportRequestRec.Status::"Pending Approval");
                    TransportRequestRec.MODIFY(TRUE);
                    Variant := TransportRequestRec;
                END;
            //HR Leave Application
            DATABASE::"HR Leave Application":
                BEGIN
                    RecRef.SETTABLE(HRLeaveApplication);
                    HRLeaveApplication.VALIDATE(Status, HRLeaveApplication.Status::"Pending Approval");
                    HRLeaveApplication.MODIFY(TRUE);
                    Variant := HRLeaveApplication;
                END;

            //HR Leave Reimbusment
            DATABASE::"HR Leave Reimbursement":
                BEGIN
                    RecRef.SETTABLE(HRLeaveReimbusment);
                    HRLeaveReimbusment.VALIDATE(Status, HRLeaveReimbusment.Status::"Pending Approval");
                    HRLeaveReimbusment.MODIFY(TRUE);
                    Variant := HRLeaveReimbusment;
                END;

            //HR Leave Carryover
            DATABASE::"HR Leave Carryover":
                BEGIN
                    RecRef.SETTABLE(HRLeaveCarryover);
                    HRLeaveCarryover.VALIDATE(Status, HRLeaveCarryover.Status::"Pending Approval");
                    HRLeaveCarryover.MODIFY(TRUE);
                    Variant := HRLeaveCarryover;
                END;

            //HR Leave Allocation Header
            DATABASE::"HR Leave Allocation Header":
                BEGIN
                    RecRef.SETTABLE(HRLeaveAllocationHeader);
                    HRLeaveAllocationHeader.VALIDATE(Status, HRLeaveAllocationHeader.Status::"Pending Approval");
                    HRLeaveAllocationHeader.MODIFY(TRUE);
                    Variant := HRLeaveAllocationHeader;
                END;

            //HR Asset Transfer Header
            DATABASE::"HR Asset Transfer Header":
                BEGIN
                    RecRef.SETTABLE(HRAssetTransfer);
                    HRAssetTransfer.Status := HRAssetTransfer.Status::"Pending Approval";
                    HRAssetTransfer.MODIFY(TRUE);
                    Variant := HRAssetTransfer;
                END;

            //HR Employee Transfer Header
            DATABASE::"HR Employee Transfer Header":
                BEGIN
                    RecRef.SETTABLE(HREmployeeTransfer);
                    HREmployeeTransfer.Status := HREmployeeTransfer.Status::"Pending Approval";
                    HREmployeeTransfer.MODIFY(TRUE);
                    Variant := HREmployeeTransfer;
                END;


            //HR Interview Header
            DATABASE::"Interview Attendance Header":
                BEGIN
                    RecRef.SETTABLE(InterviewAttendanceHeader);
                    InterviewAttendanceHeader.Status := InterviewAttendanceHeader.Status::"Pending Approval";
                    InterviewAttendanceHeader.MODIFY(TRUE);
                    Variant := InterviewAttendanceHeader;
                END;

            //HR Training Application Header
            DATABASE::"HR Training Applications":
                BEGIN
                    RecRef.SETTABLE(HRTrainingApplications);
                    HRTrainingApplications.Status := HRTrainingApplications.Status::"Pending Approval";
                    HRTrainingApplications.MODIFY(TRUE);
                    Variant := HRTrainingApplications;
                END;

            //HR Training Needs Header
            DATABASE::"HR Training Needs Header":
                BEGIN
                    RecRef.SETTABLE(HRTrainingNeedsHeader);
                    HRTrainingNeedsHeader.Status := HRTrainingNeedsHeader.Status::"Pending Approval";
                    HRTrainingNeedsHeader.MODIFY(TRUE);
                    Variant := HRTrainingNeedsHeader;
                END;

            //HR Training Group
            DATABASE::"HR Training Group":
                BEGIN
                    RecRef.SETTABLE(HRTrainingGroup);
                    HRTrainingGroup.Status := HRTrainingGroup.Status::Approved;
                    HRTrainingGroup.MODIFY(TRUE);
                    Variant := HRTrainingGroup;
                END;


            //HR Training Evaluation
            DATABASE::"Training Evaluation":
                BEGIN
                    RecRef.SETTABLE(TrainingEvaluation);
                    TrainingEvaluation.Status := TrainingEvaluation.Status::Approved;
                    TrainingEvaluation.MODIFY(TRUE);
                    Variant := TrainingEvaluation;
                END;

            //HR Leave Allowance
            DATABASE::"Leave Allowance Request":
                BEGIN
                    RecRef.SETTABLE(LeaveAllowanceRequest);
                    LeaveAllowanceRequest.Status := LeaveAllowanceRequest.Status::"Pending Approval";
                    LeaveAllowanceRequest.MODIFY(TRUE);
                    Variant := LeaveAllowanceRequest;
                END;

            //HR Loan Application
            DATABASE::"Employee Loan Applications":
                BEGIN
                    RecRef.SETTABLE(EmployeeLoanApplications);
                    EmployeeLoanApplications.Status := EmployeeLoanApplications.Status::"Pending Approval";
                    EmployeeLoanApplications.MODIFY(TRUE);
                    Variant := EmployeeLoanApplications;
                END;
            //HR Loan product
            DATABASE::"Employee Loan Products":
                BEGIN
                    RecRef.SETTABLE(HRLoanProducts);
                    HRLoanProducts.VALIDATE(Status, HRLoanProducts.Status::"Pending Approval");
                    HRLoanProducts.MODIFY(TRUE);
                    Variant := HRLoanProducts;
                END;

            //HR Loan Disbursement
            DATABASE::"Employee Loan Disbursement":
                BEGIN
                    RecRef.SETTABLE(EmployeeLoanDisbursement);
                    EmployeeLoanDisbursement.VALIDATE(Status, EmployeeLoanDisbursement.Status::"Pending Approval");
                    EmployeeLoanDisbursement.MODIFY(TRUE);
                    Variant := EmployeeLoanDisbursement;
                END;
            //-------------------------------End HR Management Documents-----------------------------------
            //Fuel Requsition
            DATABASE::"Fuel Requisition":
                BEGIN
                    RecRef.SETTABLE(FuelRequisition);
                    FuelRequisition.Status := FuelRequisition.Status::"Pending Approval";
                    FuelRequisition.MODIFY(TRUE);
                    Variant := FuelRequisition;
                END;
            //Vehicle Filling
            DATABASE::"Vehicle Filling":
                BEGIN
                    RecRef.SETTABLE(VehicleFillingRec);
                    VehicleFillingRec.Status := VehicleFillingRec.Status::"Pending Approval";
                    VehicleFillingRec.MODIFY(TRUE);
                    Variant := VehicleFillingRec;
                END;

            //Transport requisition
            DATABASE::"Vehicle Requisition Header":
                BEGIN
                    RecRef.SETTABLE(TransportRequisition);
                    TransportRequisition.Status := TransportRequisition.Status::"Pending Approval";
                    TransportRequisition.MODIFY(TRUE);
                    Variant := TransportRequisition;
                END;
            // Allowance
            DATABASE::"Allowance Header":
                BEGIN
                    RecRef.SETTABLE(AllowanceHeaderRec);
                    AllowanceHeaderRec.Status := AllowanceHeaderRec.Status::"Pending Approval";
                    AllowanceHeaderRec.MODIFY(TRUE);
                    Variant := AllowanceHeaderRec;
                END;
            DATABASE::"Work Ticket":
                BEGIN
                    RecRef.SETTABLE(WorkTicket);
                    WorkTicket.Status := WorkTicket.Status::"Pending Approval";
                    WorkTicket.MODIFY(TRUE);
                    Variant := WorkTicket;
                END;
            DATABASE::TestDocument:
                BEGIN
                    RecRef.SETTABLE(TestDocument);
                    TestDocument.Status := TestDocument.Status::"Pending Approval";
                    TestDocument.MODIFY(TRUE);
                    Variant := TestDocument;
                END;
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        ImprestHeaderRec: Record "Imprest Header";
        EmployeeRec: Record "Employee";
        TransportRequestRec: Record "Transport Request";
        HRLeaveApplicationRec: Record "HR Leave Application";
        StoreRequisitionHeaderRec: Record "Store Requisition Header";
        PurchaseRequisitionsRec: Record "Purchase Requisitions";
        HRLeavePlannerHeader: Record "HR Leave Planner Header";
        HRLeaveReimbursementRec: Record "HR Leave Reimbursement";
        HREmployeeRequisitionsRec: Record "HR Employee Requisitions";
        ImprestSurrenderHeaderRec: Record "Imprest Surrender Header";
        PaymentHeaderRec: Record "Payment Header";
        SalaryAdvanceRec: Record "Salary Advance";
        AllowanceHeader: Record "Allowance Header";
        HREmployeeAppraisalHeader: Record "HR Employee Appraisal Header";
        Periods: Record "Periods";
        WorkTicketRec: Record "Work Ticket";
        JournalVoucherHeader: Record "Journal Voucher Header";
        VehicleFillingREc: Record "Vehicle Filling";
        InspectionHeader: Record "Inspection Header";
        HRTrainingApplicationsRec: Record "HR Training Applications";
        TransferHeader: Record "Transfer Header";
        TestDocument: Record TestDocument;
    begin
        case RecRef.Number of
            DATABASE::"Imprest Header":
                BEGIN
                    RecRef.SETTABLE(ImprestHeaderRec);
                    ImprestHeaderRec.CALCFIELDS(ImprestHeaderRec."Total Amount", ImprestHeaderRec.Amount);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Imprest; //ImprestHeaderRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := ImprestHeaderRec."No.";
                    IF ImprestHeaderRec.Type = ImprestHeaderRec.Type::Imprest THEN BEGIN
                        ApprovalEntryArgument.Amount := ImprestHeaderRec.Amount;
                        ApprovalEntryArgument."Amount (LCY)" := ImprestHeaderRec."Amount(LCY)";
                    END ELSE
                        IF ImprestHeaderRec.Type = ImprestHeaderRec.Type::"Casuals Payment" THEN BEGIN
                            ApprovalEntryArgument.Amount := ImprestHeaderRec."Total Amount";
                            ApprovalEntryArgument."Amount (LCY)" := ImprestHeaderRec."Total Amount";
                        END ELSE
                            IF ImprestHeaderRec.Type = ImprestHeaderRec.Type::"Board Allowance" THEN BEGIN
                                ApprovalEntryArgument.Amount := ImprestHeaderRec.Amount;
                                ApprovalEntryArgument."Amount (LCY)" := ImprestHeaderRec.Amount;
                            END;
                    ApprovalEntryArgument."Currency Code" := ImprestHeaderRec."Currency Code";
                    //set sender User Id as the employee's user id/the user id on the imprest record.
                    IF ImprestHeaderRec."User ID" <> '' THEN
                        ApprovalEntryArgument."Sender ID" := ImprestHeaderRec."User ID"
                    ELSE
                        ApprovalEntryArgument."Sender ID" := GetEmployeeUserId(ImprestHeaderRec."Employee No.");
                END;


            //Payments Header
            DATABASE::"Payment Header":
                BEGIN
                    RecRef.SETTABLE(PaymentHeaderRec);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Payment; //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := PaymentHeaderRec."No.";

                    ApprovalEntryArgument.Amount := PaymentHeaderRec."Total Amount";
                    ApprovalEntryArgument."Amount (LCY)" := PaymentHeaderRec."Total Amount(LCY)";
                    IF PaymentHeaderRec."User ID" <> '' THEN
                        ApprovalEntryArgument."Sender ID" := PaymentHeaderRec."User ID"

                END;
            //Journal voucher
            DATABASE::"Journal Voucher Header":
                BEGIN
                    RecRef.SETTABLE(JournalVoucherHeader);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Journal Voucher"; //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := JournalVoucherHeader."JV No.";
                    ApprovalEntryArgument.Amount := JournalVoucherHeader."Total Amount";
                    ApprovalEntryArgument."Amount (LCY)" := JournalVoucherHeader."Total Amount";
                    IF JournalVoucherHeader."User ID" <> '' THEN
                        ApprovalEntryArgument."Sender ID" := PaymentHeaderRec."User ID"

                END;

            //Salary Advance
            DATABASE::"Salary Advance":
                BEGIN
                    RecRef.SETTABLE(SalaryAdvanceRec);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Salary Advance"; //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := SalaryAdvanceRec.ID;
                    ApprovalEntryArgument.Amount := SalaryAdvanceRec."Principal (LCY)";
                    ApprovalEntryArgument."Amount (LCY)" := SalaryAdvanceRec."Principal (LCY)";
                    ApprovalEntryArgument."Sender ID" := GetEmployeeUserId(SalaryAdvanceRec.Employee);

                END;
            //Payroll
            DATABASE::Periods:
                BEGIN
                    RecRef.SETTABLE(Periods);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Payroll; //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := Periods."Period ID" + '-' + Periods."Payroll Code";

                END;

            //Tranfer Order
            DATABASE::"Transfer Header":
                BEGIN
                    RecRef.SETTABLE(TransferHeader);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Order; //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := TransferHeader."No.";

                END;
            //work ticket
            DATABASE::"Work Ticket":
                BEGIN
                    RecRef.SETTABLE(WorkTicketRec);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Work Ticket"; //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := WorkTicketRec."Ticket No";
                    ApprovalEntryArgument.Description2 := WorkTicketRec."Registration No";
                    ApprovalEntryArgument.Amount := WorkTicketRec."Kms Covered";
                    ApprovalEntryArgument."Amount (LCY)" := WorkTicketRec."Kms Covered";

                END;

            // Allowance Header
            DATABASE::"Allowance Header":
                BEGIN
                    RecRef.SETTABLE(AllowanceHeader);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Allowance; //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := AllowanceHeader."No.";
                    ApprovalEntryArgument.Amount := AllowanceHeader.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := AllowanceHeader."Amount(LCY)";
                    ApprovalEntryArgument."Sender ID" := GetEmployeeUserId(AllowanceHeader."Employee No.");
                END;
            //Imprest surrender
            DATABASE::"Imprest Surrender Header":
                BEGIN
                    RecRef.SETTABLE(ImprestSurrenderHeaderRec);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Imprest Surrender"; //ImprestSurrenderHeaderRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := ImprestSurrenderHeaderRec."No.";
                    ApprovalEntryArgument.Amount := ImprestSurrenderHeaderRec.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := ImprestSurrenderHeaderRec."Amount(LCY)";
                    ApprovalEntryArgument."Currency Code" := ImprestSurrenderHeaderRec."Currency Code";

                    //set sender User Id as the employee's user id/the user id on the  record.
                    IF ImprestSurrenderHeaderRec."User ID" <> '' THEN
                        ApprovalEntryArgument."Sender ID" := ImprestSurrenderHeaderRec."User ID";
                    //ELSE
                    // ApprovalEntryArgument."Sender ID" := GetEmployeeUserId(ImprestSurrenderHeaderRec."Employee No.");

                END;
            //Transport Request
            //FRS 110919>>
            DATABASE::"Transport Request":
                BEGIN
                    RecRef.SETTABLE(TransportRequestRec);
                    //IF ApprovalEntryArgument."Document Type" = TransportRequestRec."Document Type"::"Pre-Trip" THEN BEGIN //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Transport Request";
                    ApprovalEntryArgument."Document No." := TransportRequestRec."Request No.";
                    // ApprovalEntryArgument.Amount := TransportRequestRec."Trip Planned End Date"-TransportRequestRec."Trip Planned End Date";
                    // END ELSE
                    // IF ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Transport Request" THEN
                    //  BEGIN
                    //   ApprovalEntryArgument."Document No." := TransportRequestRec."Request No.";
                    ApprovalEntryArgument.Amount := TransportRequestRec."Total Amount";
                    ApprovalEntryArgument."Amount (LCY)" := TransportRequestRec."Total Amount";
                    //  END;
                    //set sender User Id as the employee's user id/the user id on the  record.
                    IF TransportRequestRec."User ID" <> '' THEN
                        ApprovalEntryArgument."Sender ID" := TransportRequestRec."User ID";
                    //ELSE
                    //  ApprovalEntryArgument."Sender ID" := GetEmployeeUserId(TransportRequestRec."Employee No.");

                END;
            //Hr appraisal
            DATABASE::"HR Employee Appraisal Header":
                BEGIN
                    RecRef.SETTABLE(HREmployeeAppraisalHeader);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Appraisal;
                    ApprovalEntryArgument."Document No." := HREmployeeAppraisalHeader."No.";
                    IF HREmployeeAppraisalHeader."User ID" <> '' THEN
                        ApprovalEntryArgument."Sender ID" := HREmployeeAppraisalHeader."User ID"
                    ELSE
                        ApprovalEntryArgument."Sender ID" := GetEmployeeUserId(HREmployeeAppraisalHeader."Employee No.");
                END;
            //Leave application
            DATABASE::"HR Leave Application":
                BEGIN
                    RecRef.SETTABLE(HRLeaveApplicationRec);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Leave; //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := HRLeaveApplicationRec."No.";
                    ApprovalEntryArgument.Amount := HRLeaveApplicationRec."Days Applied";

                    IF HRLeaveApplicationRec."User ID" <> '' THEN
                        ApprovalEntryArgument."Sender ID" := HRLeaveApplicationRec."User ID"
                    ELSE
                        ApprovalEntryArgument."Sender ID" := GetEmployeeUserId(HRLeaveApplicationRec."Employee No.");
                END;
            //Store Requisition
            DATABASE::"Store Requisition Header":
                BEGIN
                    RecRef.SETTABLE(StoreRequisitionHeaderRec);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Store Requisition"; //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := StoreRequisitionHeaderRec."No.";
                    ApprovalEntryArgument.Amount := StoreRequisitionHeaderRec."Cost Amount";

                    IF StoreRequisitionHeaderRec."User ID" <> '' THEN
                        ApprovalEntryArgument."Sender ID" := StoreRequisitionHeaderRec."User ID"
                    ELSE
                        ApprovalEntryArgument."Sender ID" := GetEmployeeUserId(StoreRequisitionHeaderRec."Employee No.");
                END;

            //Purchase Requisition
            DATABASE::"Purchase Requisitions":
                BEGIN
                    RecRef.SETTABLE(PurchaseRequisitionsRec);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Requisition; //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := PurchaseRequisitionsRec."No.";
                    ApprovalEntryArgument.Amount := PurchaseRequisitionsRec.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := PurchaseRequisitionsRec."Amount(LCY)";

                    IF PurchaseRequisitionsRec."User ID" <> '' THEN
                        ApprovalEntryArgument."Sender ID" := PurchaseRequisitionsRec."User ID";
                    // ELSE
                    //  ApprovalEntryArgument."Sender ID" := GetEmployeeUserId(PurchaseRequisitionsRec."Employee No.");
                END;
            //Leave Plan    
            DATABASE::"HR Leave Planner Header":
                BEGIN
                    RecRef.SETTABLE(HRLeavePlannerHeader);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Leave Plan"; //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := HRLeavePlannerHeader."No.";
                    //ApprovalEntryArgument.Amount:= HRLeavePlannerHeader.
                    //ApprovalEntryArgument."Amount (LCY)":=HRLeavePlannerHeader."No of Days";

                    IF HRLeavePlannerHeader."User ID" <> '' THEN
                        ApprovalEntryArgument."Sender ID" := HRLeavePlannerHeader."User ID"
                    ELSE
                        ApprovalEntryArgument."Sender ID" := GetEmployeeUserId(HRLeavePlannerHeader."Employee No.");
                END;
            //Leave Reimbursement

            DATABASE::"HR Leave Reimbursement":
                BEGIN
                    RecRef.SETTABLE(HRLeaveReimbursementRec);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Leave Plan"; //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := HRLeaveReimbursementRec."No.";
                    ApprovalEntryArgument.Amount := HRLeaveReimbursementRec."Leave Days Approved";
                    IF HRLeaveReimbursementRec."User ID" <> '' THEN
                        ApprovalEntryArgument."Sender ID" := HRLeaveReimbursementRec."User ID"
                    ELSE
                        ApprovalEntryArgument."Sender ID" := GetEmployeeUserId(HRLeaveReimbursementRec."Employee No.");
                END;

            //Employee Requisitions

            DATABASE::"HR Employee Requisitions":
                BEGIN
                    RecRef.SETTABLE(HREmployeeRequisitionsRec);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Requisition; //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := HREmployeeRequisitionsRec."No.";
                    ApprovalEntryArgument.Amount := HREmployeeRequisitionsRec."Estimated Total Cost of Work";
                    ApprovalEntryArgument."Amount (LCY)" := HREmployeeRequisitionsRec."Estimated Total Cost of Work";
                    IF HREmployeeRequisitionsRec."User ID" <> '' THEN
                        ApprovalEntryArgument."Sender ID" := HREmployeeRequisitionsRec."User ID";
                END;

            //Inspection

            DATABASE::"Inspection Header":
                BEGIN
                    RecRef.SETTABLE(InspectionHeader);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Inspection; //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := InspectionHeader."Inspection No";
                    ApprovalEntryArgument.Amount := InspectionHeader."Amount Invoiced";
                    IF HREmployeeRequisitionsRec."User ID" <> '' THEN
                        ApprovalEntryArgument."Sender ID" := InspectionHeader."Prepared by";
                END;


            //Vehicle Filling

            DATABASE::"Vehicle Filling":
                BEGIN
                    RecRef.SETTABLE(VehicleFillingREc);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Requisition; //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := VehicleFillingREc."Filling No";
                    ApprovalEntryArgument.Amount := VehicleFillingREc."Total Amount";
                    ApprovalEntryArgument."Amount (LCY)" := VehicleFillingREc."Total Amount";
                END;

            //Training Application

            DATABASE::"HR Training Applications":
                BEGIN
                    RecRef.SETTABLE(HRTrainingApplicationsRec);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"HR Training"; //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := HRTrainingApplicationsRec."Application No.";
                    ApprovalEntryArgument.Amount := HRTrainingApplicationsRec."Estimated Cost Of Training";
                    ApprovalEntryArgument."Amount (LCY)" := HRTrainingApplicationsRec."Estimated Cost Of Training";
                END;

            //Training Application

            DATABASE::TestDocument:
                BEGIN
                    RecRef.SETTABLE(TestDocument);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"HR Training"; //TransportRequestRec."Document Type"::Imprest;
                    ApprovalEntryArgument."Document No." := TestDocument."No.";
                END;
        end;
    end;

    procedure CheckPaymentApprovalsWorkflowEnabled(VAR PaymentHeader: Record "Payment Header"): Boolean
    begin
        IF NOT IsPaymentApprovalsWorkflowEnabled(PaymentHeader) THEN
            ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;

    procedure IsPaymentApprovalsWorkflowEnabled(VAR PaymentHeader: Record "Payment Header"): Boolean
    begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(PaymentHeader, FundsWFEvents.RunWorkflowOnSendPaymentHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendPaymentHeaderForApproval(VAR PaymentHeader: Record "Payment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelPaymentHeaderApprovalRequest(VAR PaymentHeader: Record "Payment Header")
    begin
    end;

    procedure CheckReceiptApprovalsWorkflowEnabled(var ReceiptHeader: Record "Receipt Header"): Boolean;
    begin
        if not IsReceiptApprovalsWorkflowEnabled(ReceiptHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsReceiptApprovalsWorkflowEnabled(var ReceiptHeader: Record "Receipt Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ReceiptHeader, FundsWFEvents.RunWorkflowOnSendReceiptHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendReceiptHeaderForApproval(var ReceiptHeader: Record "Receipt Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelReceiptHeaderApprovalRequest(var ReceiptHeader: Record "Receipt Header");
    begin
    end;

    procedure CheckFundsTransferApprovalsWorkflowEnabled(var FundsTransferHeader: Record "Funds Transfer Header"): Boolean;
    begin
        if not IsFundsTransferApprovalsWorkflowEnabled(FundsTransferHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsFundsTransferApprovalsWorkflowEnabled(var FundsTransferHeader: Record "Funds Transfer Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(FundsTransferHeader, FundsWFEvents.RunWorkflowOnSendFundsTransferHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendFundsTransferHeaderForApproval(var FundsTransferHeader: Record "Funds Transfer Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelFundsTransferHeaderApprovalRequest(var FundsTransferHeader: Record "Funds Transfer Header");
    begin
    end;

    procedure CheckImprestApprovalsWorkflowEnabled(var ImprestHeader: Record "Imprest Header"): Boolean;
    begin
        if not IsImprestApprovalsWorkflowEnabled(ImprestHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsImprestApprovalsWorkflowEnabled(var ImprestHeader: Record "Imprest Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ImprestHeader, FundsWFEvents.RunWorkflowOnSendImprestHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendImprestHeaderForApproval(var ImprestHeader: Record "Imprest Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelImprestHeaderApprovalRequest(var ImprestHeader: Record "Imprest Header");
    begin
    end;

    procedure CheckAllowanceApprovalsWorkflowEnabled(var AllowanceHeader: Record "Allowance Header"): Boolean;
    begin
        if not IsAllowanceApprovalsWorkflowEnabled(AllowanceHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsAllowanceApprovalsWorkflowEnabled(var AllowanceHeader: Record "Allowance Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(AllowanceHeader, FundsWFEvents.RunWorkflowOnSendAllowanceHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendAllowanceHeaderForApproval(var AllowanceHeader: Record "Allowance Header");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelAllowanceApprovalRequest(var AllowanceHeader: Record "Allowance Header");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckImprestSurrenderApprovalsWorkflowEnabled(var ImprestSurrender: Record "Imprest Surrender Header"): Boolean;
    begin
        if not IsImprestSurrenderApprovalsWorkflowEnabled(ImprestSurrender) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsImprestSurrenderApprovalsWorkflowEnabled(var ImprestSurrender: Record "Imprest Surrender Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ImprestSurrender, FundsWFEvents.RunWorkflowOnSendImprestSurrenderHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendImprestSurrenderHeaderForApproval(var ImprestSurrender: Record "Imprest Surrender Header");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelImprestSurrenderHeaderApprovalRequest(var ImprestSurrender: Record "Imprest Surrender Header");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckFundsClaimApprovalsWorkflowEnabled(var FundsClaimHeader: Record "Funds Claim Header"): Boolean;
    begin
        if not IsFundsClaimApprovalsWorkflowEnabled(FundsClaimHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsFundsClaimApprovalsWorkflowEnabled(var FundsClaimHeader: Record "Funds Claim Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(FundsClaimHeader, FundsWFEvents.RunWorkflowOnSendFundsClaimHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendFundsClaimHeaderForApproval(var FundsClaimHeader: Record "Funds Claim Header");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelFundsClaimHeaderApprovalRequest(var FundsClaimHeader: Record "Funds Claim Header");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckDocumentReversalApprovalsWorkflowEnabled(var DocumentReversalHeader: Record "Document Reversal Header"): Boolean;
    begin
        if not IsDocumentReversalApprovalsWorkflowEnabled(DocumentReversalHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsDocumentReversalApprovalsWorkflowEnabled(var DocumentReversalHeader: Record "Document Reversal Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(DocumentReversalHeader, FundsWFEvents.RunWorkflowOnSendDocumentReversalHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendDocumentReversalHeaderForApproval(var DocumentReversalHeader: Record "Document Reversal Header");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelDocumentReversalHeaderApprovalRequest(var DocumentReversalHeader: Record "Document Reversal Header");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckJournalVoucherApprovalsWorkflowEnabled(var JournalVoucherHeader: Record "Journal Voucher Header"): Boolean;
    begin
        if not IsJournalVoucherApprovalsWorkflowEnabled(JournalVoucherHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsJournalVoucherApprovalsWorkflowEnabled(var JournalVoucherHeader: Record "Journal Voucher Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(JournalVoucherHeader, FundsWFEvents.RunWorkflowOnSendJournalVoucherForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendJournalVoucherForApproval(var JournalVoucherHeader: Record "Journal Voucher Header");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelJournalVoucherApprovalRequest(var JournalVoucherHeader: Record "Journal Voucher Header");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckPurchaseRequisitionApprovalsWorkflowEnabled(var PurchaseRequisition: Record "Purchase Requisitions"): Boolean;
    begin
        if not IsPurchaseRequisitionApprovalsWorkflowEnabled(PurchaseRequisition) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsPurchaseRequisitionApprovalsWorkflowEnabled(var PurchaseRequisition: Record "Purchase Requisitions"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(PurchaseRequisition, ProcurementWFEvents.RunWorkflowOnSendPurchaseRequisitionForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendPurchaseRequisitionForApproval(var PurchaseRequisition: Record "Purchase Requisitions");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelPurchaseRequisitionApprovalRequest(var PurchaseRequisition: Record "Purchase Requisitions");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckProcurementPlanApprovalsWorkflowEnabled(var ProcurementPlanningHeader: Record "Procurement Planning Header"): Boolean;
    begin
        if not IsProcurementPlanApprovalsWorkflowEnabled(ProcurementPlanningHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsProcurementPlanApprovalsWorkflowEnabled(var ProcurementPlanningHeader: Record "Procurement Planning Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ProcurementPlanningHeader, ProcurementWFEvents.RunWorkflowOnSendProcurementPlanForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendProcurementPlanForApproval(var ProcurementPlanningHeader: Record "Procurement Planning Header");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelProcurementPlanApprovalRequest(var ProcurementPlanningHeader: Record "Procurement Planning Header");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckTenderHeaderApprovalsWorkflowEnabled(var TenderHeader: Record "Tender Header"): Boolean;
    begin
        if not IsTenderHeaderApprovalsWorkflowEnabled(TenderHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsTenderHeaderApprovalsWorkflowEnabled(var TenderHeader: Record "Tender Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(TenderHeader, ProcurementWFEvents.RunWorkflowOnSendTenderHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendTenderHeaderForApproval(var TenderHeader: Record "Tender Header");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelTenderHeaderApprovalRequest(var TenderHeader: Record "Tender Header");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckStoreRequisitionApprovalsWorkflowEnabled(var StoreRequisition: Record "Store Requisition Header"): Boolean;
    begin
        if not IsStoreRequisitionApprovalsWorkflowEnabled(StoreRequisition) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsStoreRequisitionApprovalsWorkflowEnabled(var StoreRequisition: Record "Store Requisition Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(StoreRequisition, InventoryWFEvents.RunWorkflowOnSendStoreRequisitionForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendStoreRequisitionForApproval(var StoreRequisition: Record "Store Requisition Header");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelStoreRequisitionApprovalRequest(var StoreRequisition: Record "Store Requisition Header");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckHRJobApprovalsWorkflowEnabled(var HRJob: Record "HR Jobs"): Boolean;
    begin
        if not IsHRJobApprovalsWorkflowEnabled(HRJob) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsHRJobApprovalsWorkflowEnabled(var HRJob: Record "HR Jobs"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(HRJob, HRWFEvents.RunWorkflowOnSendHRJobForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendHRJobForApproval(var HRJob: Record "HR Jobs");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelHRJobApprovalRequest(var HRJob: Record "HR Jobs");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckHREmployeeRequisitionApprovalsWorkflowEnabled(var HREmployeeRequisition: Record "HR Employee Requisitions"): Boolean;
    begin
        if not IsHREmployeeRequisitionApprovalsWorkflowEnabled(HREmployeeRequisition) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsHREmployeeRequisitionApprovalsWorkflowEnabled(var HREmployeeRequisition: Record "HR Employee Requisitions"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(HREmployeeRequisition, HRWFEvents.RunWorkflowOnSendHREmployeeRequisitionForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendHREmployeeRequisitionForApproval(var HREmployeeRequisition: Record "HR Employee Requisitions");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelHREmployeeRequisitionApprovalRequest(var HREmployeeRequisition: Record "HR Employee Requisitions");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckHRJobApplicationApprovalsWorkflowEnabled(var HRJobApplication: Record "HR Job Applications"): Boolean;
    begin
        if not IsHRJobApplicationApprovalsWorkflowEnabled(HRJobApplication) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsHRJobApplicationApprovalsWorkflowEnabled(var HRJobApplication: Record "HR Job Applications"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(HRJobApplication, HRWFEvents.RunWorkflowOnSendHRJobApplicationForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendHRJobApplicationForApproval(var HRJobApplication: Record "HR Job Applications");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelHRJobApplicationApprovalRequest(var HRJobApplication: Record "HR Job Applications");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckInterviewAttendanceHeaderApprovalsWorkflowEnabled(var InterviewAttendanceHeader: Record "Interview Attendance Header"): Boolean;
    begin
        if not IsInterviewAttendanceHeaderApprovalsWorkflowEnabled(InterviewAttendanceHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsInterviewAttendanceHeaderApprovalsWorkflowEnabled(var InterviewAttendanceHeader: Record "Interview Attendance Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(InterviewAttendanceHeader, HRWFEvents.RunWorkflowOnSendInterviewHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendInterviewHeaderAttendanceForApproval(var InterviewAttendanceHeader: Record "Interview Attendance Header");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelInterviewAttendanceApprovalRequest(var InterviewAttendanceHeader: Record "Interview Attendance Header");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckHRLeavePlannerHeaderApprovalsWorkflowEnabled(var HRLeavePlannerHeader: Record "HR Leave Planner Header"): Boolean;
    begin
        if not IsHRLeavePlannerHeaderApprovalsWorkflowEnabled(HRLeavePlannerHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsHRLeavePlannerHeaderApprovalsWorkflowEnabled(var HRLeavePlannerHeader: Record "HR Leave Planner Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(HRLeavePlannerHeader, HRWFEvents.RunWorkflowOnSendHRLeavePlannerHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendHRLeavePlannerHeaderForApproval(var HRLeavePlannerHeader: Record "HR Leave Planner Header");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelHRLeavePlannerHeaderApprovalRequest(var HRLeavePlannerHeader: Record "HR Leave Planner Header");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckHRLeaveApplicationApprovalsWorkflowEnabled(var HRLeaveApplication: Record "HR Leave Application"): Boolean;
    begin
        if not IsHRLeaveApplicationApprovalsWorkflowEnabled(HRLeaveApplication) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsHRLeaveApplicationApprovalsWorkflowEnabled(var HRLeaveApplication: Record "HR Leave Application"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(HRLeaveApplication, HRWFEvents.RunWorkflowOnSendHRLeaveApplicationForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendHRLeaveApplicationForApproval(var HRLeaveApplication: Record "HR Leave Application");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelHRLeaveApplicationApprovalRequest(var HRLeaveApplication: Record "HR Leave Application");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckHRLeaveReimbusmentApprovalsWorkflowEnabled(var HRLeaveReimbusment: Record "HR Leave Reimbursement"): Boolean;
    begin
        if not IsHRLeaveReimbusmentApprovalsWorkflowEnabled(HRLeaveReimbusment) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsHRLeaveReimbusmentApprovalsWorkflowEnabled(var HRLeaveReimbusment: Record "HR Leave Reimbursement"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(HRLeaveReimbusment, HRWFEvents.RunWorkflowOnSendHRLeaveReimbusmentForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendHRLeaveReimbusmentForApproval(var HRLeaveReimbusment: Record "HR Leave Reimbursement");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelHRLeaveReimbusmentApprovalRequest(var HRLeaveReimbusment: Record "HR Leave Reimbursement");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckHRLeaveCarryoverApprovalsWorkflowEnabled(var HRLeaveCarryover: Record "HR Leave Carryover"): Boolean;
    begin
        if not IsHRLeaveCarryoverApprovalsWorkflowEnabled(HRLeaveCarryover) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsHRLeaveCarryoverApprovalsWorkflowEnabled(var HRLeaveCarryover: Record "HR Leave Carryover"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(HRLeaveCarryover, HRWFEvents.RunWorkflowOnSendHRLeaveCarryoverForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendHRLeaveCarryoverForApproval(var HRLeaveCarryover: Record "HR Leave Carryover");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelHRLeaveCarryoverApprovalRequest(var HRLeaveCarryover: Record "HR Leave Carryover");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckHRLeaveAllocationHeaderApprovalsWorkflowEnabled(var HRLeaveAllocationHeader: Record "HR Leave Allocation Header"): Boolean;
    begin
        if not IsHRLeaveAllocationHeaderApprovalsWorkflowEnabled(HRLeaveAllocationHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsHRLeaveAllocationHeaderApprovalsWorkflowEnabled(var HRLeaveAllocationHeader: Record "HR Leave Allocation Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(HRLeaveAllocationHeader, HRWFEvents.RunWorkflowOnSendHRLeaveAllocationHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendHRLeaveAllocationHeaderForApproval(var HRLeaveAllocationHeader: Record "HR Leave Allocation Header");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelHRLeaveAllocationHeaderApprovalRequest(var HRLeaveAllocationHeader: Record "HR Leave Allocation Header");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckHREmployeeAppraisalHeaderApprovalsWorkflowEnabled(var HREmployeeAppraisalHeader: Record "HR Employee Appraisal Header"): Boolean;
    begin
        if not IsHREmployeeAppraisalHeaderApprovalsWorkflowEnabled(HREmployeeAppraisalHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsHREmployeeAppraisalHeaderApprovalsWorkflowEnabled(var HREmployeeAppraisalHeader: Record "HR Employee Appraisal Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(HREmployeeAppraisalHeader, HRWFEvents.RunWorkflowOnSendHREmployeeAppraisalHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendHREmployeeAppraisalHeaderForApproval(var HREmployeeAppraisalHeader: Record "HR Employee Appraisal Header");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelHREmployeeAppraisalHeaderApprovalRequest(var HREmployeeAppraisalHeader: Record "HR Employee Appraisal Header");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckTrainingEvaluationApprovalsWorkflowEnabled(var TrainingEvaluation: Record "Training Evaluation"): Boolean;
    begin
        if not IsTrainingEvaluationApprovalsWorkflowEnabled(TrainingEvaluation) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsTrainingEvaluationApprovalsWorkflowEnabled(var TrainingEvaluation: Record "Training Evaluation"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(TrainingEvaluation, HRWFEvents.RunWorkflowOnSendTrainingEvaluationForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendTrainingEvaluationForApproval(var TrainingEvaluation: Record "Training Evaluation");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelTrainingEvaluationApprovalRequest(var TrainingEvaluation: Record "Training Evaluation");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckHrTrainingNeedsHeaderApprovalsWorkflowEnabled(var HRTrainingNeedsHeader: Record "HR Training Needs Header"): Boolean;
    begin
        if not IsHRTrainingNeedsHeaderApprovalsWorkflowEnabled(HRTrainingNeedsHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsHRTrainingNeedsHeaderApprovalsWorkflowEnabled(var HRTrainingNeedsHeader: Record "HR Training Needs Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(HRTrainingNeedsHeader, HRWFEvents.RunWorkflowOnSendHRTrainingNeedsHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendHRTrainingNeedsHeaderForApproval(var HRTrainingNeedsHeader: Record "HR Training Needs Header");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelHRTrainingNeedsHeaderApprovalRequest(var HRTrainingNeedsHeader: Record "HR Training Needs Header");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckHrTrainingGroupApprovalsWorkflowEnabled(var HRTrainingGroup: Record "HR Training Group"): Boolean;
    begin
        if not IsHRTrainingGroupApprovalsWorkflowEnabled(HRTrainingGroup) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsHRTrainingGroupApprovalsWorkflowEnabled(var HRTrainingGroup: Record "HR Training Group"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(HRTrainingGroup, HRWFEvents.RunWorkflowOnSendHRTrainingGroupForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendHRTrainingGroupForApproval(var HRTrainingGroup: Record "HR Training Group");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelHRTrainingGroupApprovalRequest(var HRTrainingGroup: Record "HR Training Group");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckHRTrainingApplicationsHeaderApprovalsWorkflowEnabled(var HRTrainingApplications: Record "HR Training Applications"): Boolean;
    begin
        if not IsHRTrainingApplicationsHeaderApprovalsWorkflowEnabled(HRTrainingApplications) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsHRTrainingApplicationsHeaderApprovalsWorkflowEnabled(var HRTrainingApplications: Record "HR Training Applications"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(HRTrainingApplications, HRWFEvents.RunWorkflowOnSendHRTrainingHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendHRTrainingApplicationsHeaderForApproval(var HRTrainingApplications: Record "HR Training Applications");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelHRTrainingApplicationsHeaderApprovalRequest(var HRTrainingApplications: Record "HR Training Applications");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckLeaveAllowanceApprovalsWorkflowEnabled(var LeaveAllowanceRequest: Record "Leave Allowance Request"): Boolean;
    begin
        if not IsLeaveAllowanceApprovalsWorkflowEnabled(LeaveAllowanceRequest) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsLeaveAllowanceApprovalsWorkflowEnabled(var LeaveAllowanceRequest: Record "Leave Allowance Request"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LeaveAllowanceRequest, HRWFEvents.RunWorkflowOnSendLeaveAllowanceForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendLeaveAllowanceForApproval(var LeaveAllowanceRequest: Record "Leave Allowance Request");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveAllowanceApprovalRequest(var LeaveAllowanceRequest: Record "Leave Allowance Request");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckSalaryAdvanceApprovalsWorkflowEnabled(var SalaryAdvance: Record "Salary Advance"): Boolean;
    begin
        if not IsSalaryAdvanceApprovalsWorkflowEnabled(SalaryAdvance) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsSalaryAdvanceApprovalsWorkflowEnabled(var SalaryAdvance: Record "Salary Advance"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(SalaryAdvance, FundsWFEvents.RunWorkflowOnSendSalaryAdvanceForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendSalaryAdvanceForApproval(var SalaryAdvance: Record "Salary Advance");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelSalaryAdvanceApprovalRequest(var SalaryAdvance: Record "Salary Advance");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckHRLoanApprovalsWorkflowEnabled(var EmployeeLoanApplications: Record "Employee Loan Applications"): Boolean;
    begin
        if not IsHRLoanApprovalsWorkflowEnabled(EmployeeLoanApplications) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsHRLoanApprovalsWorkflowEnabled(var EmployeeLoanApplications: Record "Employee Loan Applications"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(EmployeeLoanApplications, HRWFEvents.RunWorkflowOnSendHRLoanForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendHRLoanForApproval(var EmployeeLoanApplications: Record "Employee Loan Applications");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelHRLoanApprovalRequest(var EmployeeLoanApplications: Record "Employee Loan Applications");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckHRLoanDisbursementApprovalsWorkflowEnabled(var EmployeeLoanDisbursement: Record "Employee Loan Disbursement"): Boolean;
    begin
        if not IsHRLoanDisbursementApprovalsWorkflowEnabled(EmployeeLoanDisbursement) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsHRLoanDisbursementApprovalsWorkflowEnabled(var EmployeeLoanDisbursement: Record "Employee Loan Disbursement"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(EmployeeLoanDisbursement, HRWFEvents.RunWorkflowOnSendHRLoanDisbursementForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendHRLoanDisbursementForApproval(var EmployeeLoanDisbursement: Record "Employee Loan Disbursement");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelHRLoanDisbursementApprovalRequest(var EmployeeLoanDisbursement: Record "Employee Loan Disbursement");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckTransportRequestApprovalsWorkflowEnabled(var TransportRequest: Record "Transport Request"): Boolean;
    begin
        if not IsTransportRequestApprovalsWorkflowEnabled(TransportRequest) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsTransportRequestApprovalsWorkflowEnabled(var TransportRequest: Record "Transport Request"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(TransportRequest, HRWFEvents.RunWorkflowOnSendHRTransportRequestForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendTransportRequestForApproval(var TransportRequest: Record "Transport Request");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelTransportRequestApprovalRequest(var TransportRequest: Record "Transport Request");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckTransferOrderApprovalsWorkflowEnabled(var TransferHeader: Record "Transfer Header"): Boolean;
    begin
        if not IsTransferOrderApprovalsWorkflowEnabled(TransferHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsTransferOrderApprovalsWorkflowEnabled(var TransferHeader: Record "Transfer Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(TransferHeader, ProcurementWFEvents.RunWorkflowOnSendTransferOrderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendTransferOrderForApproval(var TransferHeader: Record "Transfer Header");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelTransferOrderApprovalRequest(var TransferHeader: Record "Transfer Header");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckPayrollApprovalsWorkflowEnabled(var Periods: Record "Periods"): Boolean;
    begin
        if not IsPayrollApprovalsWorkflowEnabled(Periods) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsPayrollApprovalsWorkflowEnabled(var Periods: Record "Periods"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(Periods, FundsWFEvents.RunWorkflowOnSendPayrollForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendPayrollForApproval(var Periods: Record "Periods");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelPayrollApprovalRequest(var Periods: Record "Periods");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckWorkTicketApprovalsWorkflowEnabled(var WorkTicket: Record "Work Ticket"): Boolean;
    begin
        if not IsWorkTicketApprovalsWorkflowEnabled(WorkTicket) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsWorkTicketApprovalsWorkflowEnabled(var WorkTicket: Record "Work Ticket"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(WorkTicket, FleetWorkflowEventsCu.RunWorkflowOnSendWorkTicketRequisitionForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendWorkTicketForApproval(var WorkTicket: Record "Work Ticket");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelWorkTicketApprovalRequest(var WorkTicket: Record "Work Ticket");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckVehicleFillingApprovalsWorkflowEnabled(var VehicleFilling: Record "Vehicle Filling"): Boolean;
    begin
        if not IsVehicleFillingApprovalsWorkflowEnabled(VehicleFilling) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsVehicleFillingApprovalsWorkflowEnabled(var VehicleFilling: Record "Vehicle Filling"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(VehicleFilling, FleetWorkflowEventsCu.RunWorkflowOnSendVehicleFillingForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendVehicleFillingForApproval(var VehicleFilling: Record "Vehicle Filling");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelVehicleFillingApprovalRequest(var VehicleFilling: Record "Vehicle Filling");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckInspectionApprovalsWorkflowEnabled(var InspectionHeader: Record "Inspection Header"): Boolean;
    begin
        if not IsInspectionApprovalsWorkflowEnabled(InspectionHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsInspectionApprovalsWorkflowEnabled(var InspectionHeader: Record "Inspection Header"): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(InspectionHeader, ProcurementWFEvents.RunWorkflowOnSendInspectionForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendInspectionForApproval(var InspectionHeader: Record "Inspection Header");
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelInspectionApprovalRequest(var InspectionHeader: Record "Inspection Header");
    begin
        // Add your AL code here to handle the event
    end;

    procedure CheckTestDocumentApprovalsWorkflowEnabled(var TestDocument: Record TestDocument): Boolean;
    begin
        if not IsTestDocumentApprovalsWorkflowEnabled(TestDocument) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsTestDocumentApprovalsWorkflowEnabled(var TestDocument: Record TestDocument): Boolean;
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(TestDocument, HRWFEvents.RunWorkflowOnSendTestDocumentForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendTestDocumentForApproval(var TestDocument: Record TestDocument);
    begin
        // Add your AL code here to handle the event
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelTestDocumentApprovalRequest(var TestDocument: Record TestDocument);
    begin
        // Add your AL code here to handle the event
    end;
}
