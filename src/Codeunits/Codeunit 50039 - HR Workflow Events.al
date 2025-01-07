codeunit 50039 "HR Workflow Events"
{

    trigger OnRun()
    begin
    end;

    var
        WFHandler: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        HRJobApprovalRequest: Label 'Approval of a Human Resource Job is requested.';
        HRJobCancelApprovalRequest: Label 'An Approval request for a Human Resource Job is cancelled.';
        HREmployeeRequisitionApprovalRequest: Label 'Approval of an Employee Requisition document is requested.';
        HREmployeeRequisitionCancelApprovalRequest: Label 'An Approval request for an Employee Requisition document is cancelled.';
        HRJobApplicationApprovalRequest: Label 'Approval of a HR Job Application is requested.';
        HRJobApplicationCancelApprovalRequest: Label 'An Approval request for a HR Job Application is cancelled.';
        HREmployeeDetailUpdateApprovalRequest: Label 'Approval of an Employee Detail Update document is requested.';
        HREmployeeDetailUpdateCancelApprovalRequest: Label 'An Approval request for an Employee Detail Update document is cancelled.';
        HREmployeeAppraisalHeaderApprovalRequest: Label 'Approval of an Employee Appraisal document is requested.';
        HREmployeeAppraisalHeaderCancelApprovalRequest: Label 'An Approval request for an Employee Appraisal document is cancelled.';
        HRLeavePlannerHeaderApprovalRequest: Label 'Approval of a Leave Planner document is requested.';
        HRLeavePlannerHeaderCancelApprovalRequest: Label 'An Approval request for a Leave Planner document is cancelled.';
        HRLeaveApplicationApprovalRequest: Label 'Approval of a Leave Application document is requested.';
        HRLeaveApplicationCancelApprovalRequest: Label 'An Approval request for a Leave Application document is cancelled.';
        HRLeaveReimbusmentApprovalRequest: Label 'Approval of a Leave Reimbusment document is requested.';
        HRLeaveReimbusmentCancelApprovalRequest: Label 'An Approval request for a Leave Reimbusment document is cancelled.';
        HRLeaveCarryoverApprovalRequest: Label 'Approval of a Leave Carryover document is requested.';
        HRLeaveCarryoverCancelApprovalRequest: Label 'An Approval request for a Leave Carryover document is cancelled.';
        HRLeaveAllocationHeaderApprovalRequest: Label 'Approval of a Leave Allocation document is requested.';
        HRLeaveAllocationHeaderCancelApprovalRequest: Label 'An Approval request for a Leave Allocation document is cancelled.';
        HRAssetTransferApprovalRequest: Label 'Approval of a Asset Transfer document is requested.';
        HRAssetTransferCancelApprovalRequest: Label 'Approval of a Asset Transfer document is Cancelled.';
        HREmployeeTransferApprovalRequest: Label 'Approval of a Employee Transfer document is requested.';
        HREmployeeTransferCancelApprovalRequest: Label 'Approval of a Employee Transfer document is Cancelled.';
        HRExitInterviewApprovalRequest: Label 'Approval of a Exit Interview document is requested.';
        HRExitInterviewCancelApprovalRequest: Label 'Approval of a Exit Interview document is Cancelled.';
        HRTrainingApplicationApprovalRequest: Label 'Approval of a Training Application document is requested.';
        HRTrainingApplicationsCancelApprovalRequest: Label 'Approval of a Training Application document is Cancelled.';
        HRTrainingNeedsApplicationApprovalRequest: Label 'Approval of a Training Need Application document is requested.';
        HRTrainingNeedsApplicationsCancelApprovalRequest: Label 'Approval of a Training Need Application document is Cancelled.';
        HRTrainingGroupApplicationApprovalRequest: Label 'Approval of a Training Group Application document is requested.';
        HRTrainingGroupApplicationCancelApprovalRequest: Label 'Approval of a Training Group Application document is Cancelled.';
        HRTrainingEvaluationApplicationApprovalRequest: Label 'Approval of a Training Evaluation Application document is requested.';
        HRTrainingEvaluationApplicationCancelApprovalRequest: Label 'Approval of a Training Evaluation Application document is Cancelled.';
        LeaveAllowanceApprovalRequest: Label 'Approval of a Leave Allowance document is requested.';
        LeaveAllowanceCancelApprovalRequest: Label 'Approval of a Leave Allowance document is  Cancelled.';
        HRLoanApprovalRequest: Label 'Approval of a HR Loan Application document is requested.';
        HRLoanCancelApprovalRequest: Label 'Approval of a HR Loan Application document is  Cancelled.';
        HRLoanProductApprovalRequest: Label 'Approval of an HR Loan Product document is requested.';
        HRLoanProductCancelRequest: Label 'An Approval request for an HR Loan Product document is cancelled.';
        HRLoanDisbursementApprovalRequest: Label 'Approval of an HR Loan Disbursement document is requested.';
        HRLoanDisbursementCancelRequest: Label 'An Approval request for an HR Loan Disbursement document is cancelled.';
        InterviewHeaderApprovalRequest: Label 'Approval of an Interview Header document is requested.';
        InterviewHeaderCancelRequest: Label 'An Approval request for an Interview Header document is cancelled.';
        TransportApprovalRequestTxt: Label 'Approval of a Transport document is requested.';
        TransportApprovalCancelRequestTxt: Label 'An Approval request for Transport document is cancelled.';
        TestDocumentApprovalRequestTxt: Label 'Approval of a TestDocument document is requested.';
        TestDocumentApprovalCancelRequestTxt: Label 'An Approval request for TestDocument document is cancelled.';

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddEventsToLibrary()
    begin
        //---------------------------------------------HR Management Approval Events--------------------------------------------------------------
        //HR Job
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHRJobForApprovalCode,
                                    DATABASE::"HR Jobs", HRJobApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRJobApprovalRequestCode,
                                    DATABASE::"HR Jobs", HRJobCancelApprovalRequest, 0, false);
        //HR Employee Requisition
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHREmployeeRequisitionForApprovalCode,
                                    DATABASE::"HR Employee Requisitions", HREmployeeRequisitionApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHREmployeeRequisitionApprovalRequestCode,
                                    DATABASE::"HR Employee Requisitions", HREmployeeRequisitionCancelApprovalRequest, 0, false);
        //HR Job Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHRJobApplicationForApprovalCode,
                                    DATABASE::"HR Job Applications", HRJobApplicationApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRJobApplicationApprovalRequestCode,
                                    DATABASE::"HR Job Applications", HRJobApplicationCancelApprovalRequest, 0, false);
        //HR Employee Detail Update
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHREmployeeDetailUpdateForApprovalCode,
                                    DATABASE::"HR Employee Detail Update", HREmployeeDetailUpdateApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHREmployeeDetailUpdateApprovalRequestCode,
                                    DATABASE::"HR Employee Detail Update", HREmployeeDetailUpdateCancelApprovalRequest, 0, false);
        //HR Employee Appraisal Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHREmployeeAppraisalHeaderForApprovalCode,
                                    DATABASE::"HR Employee Appraisal Header", HREmployeeAppraisalHeaderApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHREmployeeAppraisalHeaderApprovalRequestCode,
                                    DATABASE::"HR Employee Appraisal Header", HREmployeeAppraisalHeaderCancelApprovalRequest, 0, false);
        //HR Leave Planner Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHRLeavePlannerHeaderForApprovalCode,
                                    DATABASE::"HR Leave Planner Header", HRLeavePlannerHeaderApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRLeavePlannerHeaderApprovalRequestCode,
                                    DATABASE::"HR Leave Planner Header", HRLeavePlannerHeaderCancelApprovalRequest, 0, false);
        //HR Leave Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHRLeaveApplicationForApprovalCode,
                                    DATABASE::"HR Leave Application", HRLeaveApplicationApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRLeaveApplicationApprovalRequestCode,
                                    DATABASE::"HR Leave Application", HRLeaveApplicationCancelApprovalRequest, 0, false);
        //HR Leave Reimbusment
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHRLeaveReimbusmentForApprovalCode,
                                    DATABASE::"HR Leave Reimbursement", HRLeaveReimbusmentApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRLeaveReimbusmentApprovalRequestCode,
                                    DATABASE::"HR Leave Reimbursement", HRLeaveReimbusmentCancelApprovalRequest, 0, false);
        //HR Leave Carryover
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHRLeaveCarryoverForApprovalCode,
                                    DATABASE::"HR Leave Carryover", HRLeaveCarryoverApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRLeaveCarryoverApprovalRequestCode,
                                    DATABASE::"HR Leave Carryover", HRLeaveCarryoverCancelApprovalRequest, 0, false);
        //HR Leave Allocation Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHRLeaveAllocationHeaderForApprovalCode,
                                    DATABASE::"HR Leave Allocation Header", HRLeaveAllocationHeaderApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRLeaveAllocationHeaderApprovalRequestCode,
                                    DATABASE::"HR Leave Allocation Header", HRLeaveAllocationHeaderCancelApprovalRequest, 0, false);
        //HR Asset Transfer
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHRAssetTransferHeaderForApprovalCode,
                                    DATABASE::"HR Asset Transfer Header", HRAssetTransferApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRAssetTransferHeaderApprovalRequestCode,
                                    DATABASE::"HR Asset Transfer Header", HRAssetTransferCancelApprovalRequest, 0, false);
        //HR Employee Transfer
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHREmployeeTransferHeaderForApprovalCode,
                                    DATABASE::"HR Employee Transfer Header", HREmployeeTransferApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHREmployeeTransferHeaderApprovalRequestCode,
                                    DATABASE::"HR Employee Transfer Header", HREmployeeTransferCancelApprovalRequest, 0, false);

        //HR Exit Interview
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHRLeaveAllocationHeaderForApprovalCode,
                                    DATABASE::"HR Employee Exit Interviews", HRExitInterviewApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRLeaveAllocationHeaderApprovalRequestCode,
                                    DATABASE::"HR Employee Exit Interviews", HRExitInterviewCancelApprovalRequest, 0, false);

        //HR Training Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHRTrainingHeaderForApprovalCode,
                                    DATABASE::"HR Training Applications", HRTrainingApplicationApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRTrainingHeaderApprovalRequestCode,
                                    DATABASE::"HR Training Applications", HRTrainingApplicationsCancelApprovalRequest, 0, false);

        //HR Training Needs Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHRTrainingNeedsHeaderForApprovalCode,
                                    DATABASE::"HR Training Needs Header", HRTrainingNeedsApplicationApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRTrainingNeedsHeaderApprovalRequestCode,
                                    DATABASE::"HR Training Needs Header", HRTrainingNeedsApplicationsCancelApprovalRequest, 0, false);


        //HR Training Group Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHRTrainingGroupForApprovalCode,
                                    DATABASE::"HR Training Group", HRTrainingGroupApplicationApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRTrainingGroupApprovalRequestCode,
                                    DATABASE::"HR Training Group", HRTrainingGroupApplicationCancelApprovalRequest, 0, false);

        //HR Training Evaluation
        WFHandler.AddEventToLibrary(RunWorkflowOnSendTrainingEvaluationForApprovalCode,
                                    DATABASE::"Training Evaluation", HRTrainingEvaluationApplicationApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelTrainingEvaluationApprovalRequestCode,
                                    DATABASE::"Training Evaluation", HRTrainingEvaluationApplicationCancelApprovalRequest, 0, false);


        //HR Leave Allowance
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLeaveAllowanceForApprovalCode,
                                    DATABASE::"Leave Allowance Request", LeaveAllowanceApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLeaveAllowanceApprovalRequestCode,
                                    DATABASE::"Leave Allowance Request", LeaveAllowanceCancelApprovalRequest, 0, false);

        //HR Loan Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHRLoanForApprovalCode,
                                    DATABASE::"Employee Loan Applications", HRLoanApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRLoanApprovalRequestCode,
                                    DATABASE::"Employee Loan Applications", HRLoanCancelApprovalRequest, 0, false);

        //HR Loan Product
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHRLoanProductForApprovalCode,
                                    DATABASE::"Employee Loan Products", HRLoanProductApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRLoanProductApprovalRequestCode,
                                    DATABASE::"Employee Loan Products", HRLoanProductCancelRequest, 0, false);

        //HR Loan Disbursement
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHRLoanDisbursementForApprovalCode,
                                    DATABASE::"Employee Loan Disbursement", HRLoanDisbursementApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRLoanDisbursementApprovalRequestCode,
                                    DATABASE::"Employee Loan Disbursement", HRLoanDisbursementCancelRequest, 0, false);
        //HR Tranport Request
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHRTransportRequestForApprovalCode,
                                    DATABASE::"Transport Request", TransportApprovalRequestTxt, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRTransportRequestApprovalRequestCode,
                                    DATABASE::"Transport Request", TransportApprovalCancelRequestTxt, 0, false);

        //HR Interview Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendInterviewHeaderForApprovalCode,
                                    DATABASE::"Interview Attendance Header", InterviewHeaderApprovalRequest, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelInterviewHeaderApprovalRequestCode,
                                    DATABASE::"Interview Attendance Header", InterviewHeaderCancelRequest, 0, false);
        //Transport Request
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHRTransportRequestForApprovalCode,
                                    DATABASE::"Transport Request", TransportApprovalRequestTxt, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRTransportRequestApprovalRequestCode,
                                    DATABASE::"Transport Request", TransportApprovalCancelRequestTxt, 0, false);

        //Test Document
        WFHandler.AddEventToLibrary(RunWorkflowOnSendTestDocumentForApprovalCode,
                                    DATABASE::TestDocument, TestDocumentApprovalRequestTxt, 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHRTransportRequestApprovalRequestCode,
                                    DATABASE::TestDocument, TestDocumentApprovalCancelRequestTxt, 0, false);


        //-----------------------------------------End HR Management Approval Events--------------------------------------------------------------
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    procedure AddEventsPredecessor(EventFunctionName: Code[128])
    begin
        //-----------------------------------HR Management Approval,Rejection,Delegation Predecessors---------------------------------------------
        //HR Job
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRJobForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHRJobForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHRJobForApprovalCode);

        //HR Employee Requisition
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHREmployeeRequisitionForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHREmployeeRequisitionForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHREmployeeRequisitionForApprovalCode);

        //HR Job Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRJobApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHRJobApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHRJobApplicationForApprovalCode);

        //HR Employee Detail Update
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHREmployeeDetailUpdateForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHREmployeeDetailUpdateForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHREmployeeDetailUpdateForApprovalCode);

        //HR Employee Appraisal Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHREmployeeAppraisalHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHREmployeeAppraisalHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHREmployeeAppraisalHeaderForApprovalCode);

        //HR Leave Planner Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRLeavePlannerHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHRLeavePlannerHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHRLeavePlannerHeaderForApprovalCode);

        //HR Leave Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRLeaveApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHRLeaveApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHRLeaveApplicationForApprovalCode);

        //HR Leave Reimbusment
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRLeaveReimbusmentForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHRLeaveReimbusmentForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHRLeaveReimbusmentForApprovalCode);

        //HR Leave Carryover
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRLeaveCarryoverForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHRLeaveCarryoverForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHRLeaveCarryoverForApprovalCode);

        //HR Leave Allocation Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRLeaveAllocationHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHRLeaveAllocationHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHRLeaveAllocationHeaderForApprovalCode);

        //HR Asset Transfer
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRAssetTransferHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHRAssetTransferHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHRAssetTransferHeaderForApprovalCode);

        //HR EmployeeTransfer
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHREmployeeTransferHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHREmployeeTransferHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHREmployeeTransferHeaderForApprovalCode);

        //HR Exit Interview
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRExitInterviewHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHRExitInterviewHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHRExitInterviewHeaderForApprovalCode);

        //HR Training Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRTrainingHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHRTrainingHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHRTrainingHeaderForApprovalCode);

        //HR Training Needs Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRTrainingNeedsHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHRTrainingNeedsHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHRTrainingNeedsHeaderForApprovalCode);

        //HR Training Group Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRTrainingGroupForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHRTrainingGroupForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHRTrainingGroupForApprovalCode);

        //HR Leave Allowance
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLeaveAllowanceForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLeaveAllowanceForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLeaveAllowanceForApprovalCode);

        //HR Loan application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRLoanForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHRLoanForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHRLoanForApprovalCode);

        //HR Loan Product
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRLoanProductForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHRLoanProductForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHRLoanProductForApprovalCode);

        //HR Loan Disbursement
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRLoanDisbursementForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHRLoanDisbursementForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHRLoanDisbursementForApprovalCode);

        //HR Inteview Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendInterviewHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendInterviewHeaderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendInterviewHeaderForApprovalCode);
        // HR Transport Request
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRTransportRequestForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHRTransportRequestForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHRTransportRequestForApprovalCode);

        // Test Document
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendTestDocumentForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendTestDocumentForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendTestDocumentForApprovalCode);

        //-----------------------------------End HR Management Approval,Rejection,Delegation Predecessors-----------------------------------------
    end;

    procedure RunWorkflowOnSendHRJobForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHRJobForApproval'));
    end;

    procedure RunWorkflowOnCancelHRJobApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHRJobApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHRJobForApproval', '', false, false)]
    procedure RunWorkflowOnSendHRJobForApproval(var HRJob: Record "HR Jobs")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRJobForApprovalCode, HRJob);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHRJobApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelHRJobApprovalRequest(var HRJob: Record "HR Jobs")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHRJobApprovalRequestCode, HRJob);
    end;

    procedure RunWorkflowOnSendHREmployeeRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHREmployeeRequisitionForApproval'));
    end;

    procedure RunWorkflowOnCancelHREmployeeRequisitionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHREmployeeRequisitionApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHREmployeeRequisitionForApproval', '', false, false)]
    procedure RunWorkflowOnSendHREmployeeRequisitionForApproval(var HREmployeeRequisition: Record "HR Employee Requisitions")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHREmployeeRequisitionForApprovalCode, HREmployeeRequisition);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHREmployeeRequisitionApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelHREmployeeRequisitionApprovalRequest(var HREmployeeRequisition: Record "HR Employee Requisitions")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHREmployeeRequisitionApprovalRequestCode, HREmployeeRequisition);
    end;

    procedure RunWorkflowOnSendHRJobApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHRJobApplicationForApproval'));
    end;

    procedure RunWorkflowOnCancelHRJobApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHRJobApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHRJobApplicationForApproval', '', false, false)]
    procedure RunWorkflowOnSendHRJobApplicationForApproval(var HRJobApplication: Record "HR Job Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRJobApplicationForApprovalCode, HRJobApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHRJobApplicationApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelHRJobApplicationApprovalRequest(var HRJobApplication: Record "HR Job Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHRJobApplicationApprovalRequestCode, HRJobApplication);
    end;

    procedure RunWorkflowOnSendHREmployeeDetailUpdateForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHREmployeeDetailUpdateForApproval'));
    end;

    procedure RunWorkflowOnCancelHREmployeeDetailUpdateApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHREmployeeDetailUpdateApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHREmployeeDetailUpdateForApproval', '', false, false)]
    // procedure RunWorkflowOnSendHREmployeeDetailUpdateForApproval(var HREmployeeDetailUpdate: Record "HR Employee Detail Update")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendHREmployeeDetailUpdateForApprovalCode,HREmployeeDetailUpdate);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHREmployeeDetailUpdateApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelHREmployeeDetailUpdateApprovalRequest(var HREmployeeDetailUpdate: Record "HR Employee Detail Update")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelHREmployeeDetailUpdateApprovalRequestCode,HREmployeeDetailUpdate);
    // end;

    procedure RunWorkflowOnSendHREmployeeAppraisalHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHREmployeeAppraisalHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelHREmployeeAppraisalHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHREmployeeAppraisalHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHREmployeeAppraisalHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnSendHREmployeeAppraisalHeaderForApproval(var HREmployeeAppraisalHeader: Record "HR Employee Appraisal Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHREmployeeAppraisalHeaderForApprovalCode, HREmployeeAppraisalHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHREmployeeAppraisalHeaderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelHREmployeeAppraisalHeaderApprovalRequest(var HREmployeeAppraisalHeader: Record "HR Employee Appraisal Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHREmployeeAppraisalHeaderApprovalRequestCode, HREmployeeAppraisalHeader);
    end;

    procedure RunWorkflowOnSendHRLeavePlannerHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHRLeavePlannerHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelHRLeavePlannerHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHRLeavePlannerHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHRLeavePlannerHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnSendHRLeavePlannerHeaderForApproval(var HRLeavePlannerHeader: Record "HR Leave Planner Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRLeavePlannerHeaderForApprovalCode, HRLeavePlannerHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHRLeavePlannerHeaderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelHRLeavePlannerHeaderApprovalRequest(var HRLeavePlannerHeader: Record "HR Leave Planner Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHRLeavePlannerHeaderApprovalRequestCode, HRLeavePlannerHeader);
    end;

    procedure RunWorkflowOnSendHRLeaveApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHRLeaveApplicationForApproval'));
    end;

    procedure RunWorkflowOnCancelHRLeaveApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHRLeaveApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHRLeaveApplicationForApproval', '', false, false)]
    procedure RunWorkflowOnSendHRLeaveApplicationForApproval(var HRLeaveApplication: Record "HR Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRLeaveApplicationForApprovalCode, HRLeaveApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHRLeaveApplicationApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelHRLeaveApplicationApprovalRequest(var HRLeaveApplication: Record "HR Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHRLeaveApplicationApprovalRequestCode, HRLeaveApplication);
    end;

    procedure RunWorkflowOnSendHRLeaveReimbusmentForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHRLeaveReimbusmentForApproval'));
    end;

    procedure RunWorkflowOnCancelHRLeaveReimbusmentApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHRLeaveReimbusmentApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHRLeaveReimbusmentForApproval', '', false, false)]
    procedure RunWorkflowOnSendHRLeaveReimbusmentForApproval(var HRLeaveReimbusment: Record "HR Leave Reimbursement")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRLeaveReimbusmentForApprovalCode, HRLeaveReimbusment);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHRLeaveReimbusmentApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelHRLeaveReimbusmentApprovalRequest(var HRLeaveReimbusment: Record "HR Leave Reimbursement")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHRLeaveReimbusmentApprovalRequestCode, HRLeaveReimbusment);
    end;

    procedure RunWorkflowOnSendHRLeaveCarryoverForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHRLeaveCarryoverForApproval'));
    end;

    procedure RunWorkflowOnCancelHRLeaveCarryoverApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHRLeaveCarryoverApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHRLeaveCarryoverForApproval', '', false, false)]
    procedure RunWorkflowOnSendHRLeaveCarryoverForApproval(var HRLeaveCarryover: Record "HR Leave Carryover")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRLeaveCarryoverForApprovalCode, HRLeaveCarryover);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHRLeaveCarryoverApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelHRLeaveCarryoverApprovalRequest(var HRLeaveCarryover: Record "HR Leave Carryover")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHRLeaveCarryoverApprovalRequestCode, HRLeaveCarryover);
    end;

    procedure RunWorkflowOnSendHRLeaveAllocationHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHRLeaveAllocationHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelHRLeaveAllocationHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHRLeaveAllocationHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHRLeaveAllocationHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnSendHRLeaveAllocationHeaderForApproval(var HRLeaveAllocationHeader: Record "HR Leave Allocation Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRLeaveAllocationHeaderForApprovalCode, HRLeaveAllocationHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHRLeaveAllocationHeaderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelHRLeaveAllocationHeaderApprovalRequest(var HRLeaveAllocationHeader: Record "HR Leave Allocation Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHRLeaveAllocationHeaderApprovalRequestCode, HRLeaveAllocationHeader);
    end;

    procedure RunWorkflowOnSendHRAssetTransferHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHRAssetTransferHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelHRAssetTransferHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHRAssetTransferHeaderApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHRAssetTransferHeaderForApproval', '', false, false)]
    // procedure RunWorkflowOnSendHRAssetTransferHeaderForApproval(var AssetTransferHeader: Record "HR Asset Transfer Header")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendHRAssetTransferHeaderForApprovalCode,AssetTransferHeader);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHRAssetTransferHeaderApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelHRAssetTransferHeaderApprovalRequest(var AssetransferHeader: Record "HR Asset Transfer Header")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelHRAssetTransferHeaderApprovalRequestCode,AssetransferHeader);
    // end;

    procedure RunWorkflowOnSendHREmployeeTransferHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHREmployeeTransferHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelHREmployeeTransferHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHREmployeeTransferHeaderApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHREmployeeTransferHeaderForApproval', '', false, false)]
    // procedure RunWorkflowOnSendHREmployeeTransferHeaderForApproval(var EmployeeTransferHeader: Record "HR Employee Transfer Header")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendHREmployeeTransferHeaderForApprovalCode,EmployeeTransferHeader);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHREmployeeTransferHeaderApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelHREmployeeTransferHeaderApprovalRequest(var EmployeeTransferHeader: Record "HR Employee Transfer Header")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelHREmployeeTransferHeaderApprovalRequestCode,EmployeeTransferHeader);
    // end;

    procedure RunWorkflowOnSendHRExitInterviewHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHRExitInterviewHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelHRExitInterviewHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHRExitInterviewHeaderApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHRExitInterviewHeaderForApproval', '', false, false)]
    // procedure RunWorkflowOnSendHRExitInterviewHeaderForApproval(var ExitInterviewHeader: Record "HR Exit Interview Checklist")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendHRExitInterviewHeaderForApprovalCode,ExitInterviewHeader);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHRExitInterviewHeaderApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelHRExitInterviewHeaderApprovalRequest(var ExitInterviewHeader: Record "HR Exit Interview Checklist")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelHRExitInterviewHeaderApprovalRequestCode,ExitInterviewHeader);
    // end;

    procedure RunWorkflowOnSendHRTrainingHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHRTrainingHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelHRTrainingHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHRTrainingHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHRTrainingApplicationsHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnSendHRTrainingHeaderForApproval(var HRTrainingApplications: Record "HR Training Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRTrainingHeaderForApprovalCode, HRTrainingApplications);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHRTrainingApplicationsHeaderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelHRTrainingHeaderApprovalRequest(var HRTrainingApplications: Record "HR Training Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHRTrainingHeaderApprovalRequestCode, HRTrainingApplications);
    end;

    procedure RunWorkflowOnSendHRTrainingNeedsHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHRTrainingNeedsHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelHRTrainingNeedsHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHRTrainingNeedsHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHRTrainingNeedsHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnSendHRTrainingNeedsHeaderForApproval(var HRTrainingNeedsHeader: Record "HR Training Needs Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRTrainingNeedsHeaderForApprovalCode, HRTrainingNeedsHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHRTrainingNeedsHeaderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelHRTrainingNeedsHeaderApprovalRequest(var HRTrainingNeedsHeader: Record "HR Training Needs Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHRTrainingNeedsHeaderApprovalRequestCode, HRTrainingNeedsHeader);
    end;

    procedure RunWorkflowOnCancelTrainingEvaluationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHRTrainingEvaluationHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendTrainingEvaluationForApproval', '', false, false)]
    procedure RunWorkflowOnSendTrainingEvaluationForApproval(var TrainingEvaluation: Record "Training Evaluation")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTrainingEvaluationForApprovalCode, TrainingEvaluation);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelTrainingEvaluationApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelTrainingEvaluationApprovalRequest(var TrainingEvaluation: Record "Training Evaluation")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTrainingEvaluationApprovalRequestCode, TrainingEvaluation);
    end;

    procedure RunWorkflowOnSendTrainingEvaluationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHRTrainingEvaluationForApproval'));
    end;

    procedure RunWorkflowOnSendHRTrainingGroupForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHRTrainingGroupForApproval'));
    end;

    procedure RunWorkflowOnCancelHRTrainingGroupApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHRTrainingGroupApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHRTrainingGroupForApproval', '', false, false)]
    procedure RunWorkflowOnSendHRTrainingGroupForApproval(var HRTrainingGroup: Record "HR Training Group")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRTrainingGroupForApprovalCode, HRTrainingGroup);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHRTrainingGroupApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelHRTrainingGroupApprovalRequest(var HRTrainingGroup: Record "HR Training Group")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHRTrainingGroupApprovalRequestCode, HRTrainingGroup);
    end;

    procedure RunWorkflowOnSendLeaveAllowanceForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLeaveAllowanceForApproval'));
    end;

    procedure RunWorkflowOnCancelLeaveAllowanceApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelSendLeaveAllowanceApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendLeaveAllowanceForApproval', '', false, false)]
    procedure RunWorkflowOnSendLeaveAllowanceForApproval(var LeaveAllowanceRequest: Record "Leave Allowance Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLeaveAllowanceForApprovalCode, LeaveAllowanceRequest);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelLeaveAllowanceApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelLeaveAllowanceApprovalRequest(var LeaveAllowanceRequest: Record "Leave Allowance Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLeaveAllowanceApprovalRequestCode, LeaveAllowanceRequest);
    end;

    procedure RunWorkflowOnSendHRLoanForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHRLoanForApproval'));
    end;

    procedure RunWorkflowOnCancelHRLoanApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHRLoanApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHRLoanForApproval', '', false, false)]
    procedure RunWorkflowOnSendHRLoanForApproval(var EmployeeLoanApplications: Record "Employee Loan Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRLoanForApprovalCode, EmployeeLoanApplications);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHRLoanApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelHRLoanApprovalRequest(var EmployeeLoanApplications: Record "Employee Loan Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHRLoanApprovalRequestCode, EmployeeLoanApplications);
    end;

    procedure RunWorkflowOnSendHRLoanProductForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHRLoanProductForApproval'));
    end;

    procedure RunWorkflowOnCancelHRLoanProductApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHRLoanProductApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHRLoanProductForApproval', '', false, false)]
    // procedure RunWorkflowOnSendHRLoanProductForApproval(var HRLoanProducts: Record "Employee Loan Products")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendHRLoanProductForApprovalCode,HRLoanProducts);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHRLoanProductApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelHRLoanProductApprovalRequest(var HRLoanProducts: Record "Employee Loan Products")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelHRLoanProductApprovalRequestCode,HRLoanProducts);
    // end;

    procedure RunWorkflowOnSendHRLoanDisbursementForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHRLoanDisbursementForApproval'));
    end;

    procedure RunWorkflowOnCancelHRLoanDisbursementApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHRLoanDisbursementApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendHRLoanDisbursementForApproval', '', false, false)]
    procedure RunWorkflowOnSendHRLoanDisbursementForApproval(var EmployeeLoanDisbursement: Record "Employee Loan Disbursement")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRLoanDisbursementForApprovalCode, EmployeeLoanDisbursement);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelHRLoanDisbursementApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelHRLoanDisbursementApprovalRequest(var EmployeeLoanDisbursement: Record "Employee Loan Disbursement")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHRLoanDisbursementApprovalRequestCode, EmployeeLoanDisbursement);
    end;

    procedure RunWorkflowOnSendInterviewHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendInterviewHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelInterviewHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelInterviewHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendInterviewHeaderAttendanceForApproval', '', false, false)]
    procedure "`"(var InterviewAttendanceHeader: Record "Interview Attendance Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendInterviewHeaderForApprovalCode, InterviewAttendanceHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelInterviewAttendanceApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelInterviewHeaderApprovalRequest(var InterviewAttendanceHeader: Record "Interview Attendance Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelInterviewHeaderApprovalRequestCode, InterviewAttendanceHeader);
    end;

    procedure RunWorkflowOnSendHRTransportRequestForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHRTransportRequestForApproval'));
    end;

    procedure RunWorkflowOnCancelHRTransportRequestApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHRTransportRequestApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendTransportRequestForApproval', '', false, false)]
    procedure RunWorkflowOnSendHRTransportRequestForApproval(var TransportRequest: Record "Transport Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRTransportRequestForApprovalCode, TransportRequest);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelTransportRequestApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelHRTransportRequestApprovalRequest(var TransportRequest: Record "Transport Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHRTransportRequestApprovalRequestCode, TransportRequest);
    end;

    procedure RunWorkflowOnSendTestDocumentForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendTestDocumentForApproval'));
    end;

    procedure RunWorkflowOnCancelTestDocumentApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelTestDocumentApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendTestDocumentForApproval', '', false, false)]
    procedure RunWorkflowOnSendTestDocumentForApproval(var TestDocument: Record TestDocument)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTestDocumentForApprovalCode, TestDocument);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelTestDocumentApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelTestDocumentApprovalRequest(var TestDocument: Record TestDocument)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTestDocumentApprovalRequestCode, TestDocument);
    end;
}

