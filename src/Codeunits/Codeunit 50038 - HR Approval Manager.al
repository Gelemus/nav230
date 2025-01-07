codeunit 50038 "HR Approval Manager"
{

    trigger OnRun()
    begin
    end;

    var
        HRLeaveManagementCu: Codeunit "HR Leave Management";

    procedure ReleaseHRJob(var "HR Job": Record "HR Jobs")
    var
        HRJob: Record "HR Jobs";
        JobSuccessfullyCreated: Label 'Job position has succesfully been approved.';
    begin
        HRJob.Reset;
        HRJob.SetRange(HRJob."No.", "HR Job"."No.");
        if HRJob.FindFirst then begin
            HRJob.Status := HRJob.Status::Released;
            HRJob.Validate(HRJob.Status);
            HRJob.Active := true;
            HRJob.Modify;
            Message(JobSuccessfullyCreated);
        end;
    end;

    procedure ReOpenHRJob(var "HR Job": Record "HR Jobs")
    var
        HRJob: Record "HR Jobs";
    begin
        HRJob.Reset;
        HRJob.SetRange(HRJob."No.", "HR Job"."No.");
        if HRJob.FindFirst then begin
            HRJob.Status := HRJob.Status::Open;
            HRJob.Validate(HRJob.Status);
            "HR Job".Active := false;
            HRJob.Modify;
        end;
    end;

    procedure ReleaseHREmployeeRequisition(var "HR Employee Requisition": Record "HR Employee Requisitions")
    var
        HREmployeeRequisition: Record "HR Employee Requisitions";
        EmployeeRequisitionApproved: Label 'Employee Requisition has sucessfully been Approved';
    begin
        HREmployeeRequisition.Reset;
        HREmployeeRequisition.SetRange(HREmployeeRequisition."No.", "HR Employee Requisition"."No.");
        if HREmployeeRequisition.FindFirst then begin
            HREmployeeRequisition.Status := HREmployeeRequisition.Status::Released;
            HREmployeeRequisition.Validate(HREmployeeRequisition.Status);
            HREmployeeRequisition.Modify;
            Message(EmployeeRequisitionApproved);
        end;
    end;

    procedure ReOpenHREmployeeRequisition(var "HR Employee Requisition": Record "HR Employee Requisitions")
    var
        HREmployeeRequisition: Record "HR Employee Requisitions";
    begin
        HREmployeeRequisition.Reset;
        HREmployeeRequisition.SetRange(HREmployeeRequisition."No.", "HR Employee Requisition"."No.");
        if HREmployeeRequisition.FindFirst then begin
            HREmployeeRequisition.Status := HREmployeeRequisition.Status::Open;
            HREmployeeRequisition.Validate(HREmployeeRequisition.Status);
            HREmployeeRequisition.Modify;
        end;
    end;

    procedure ReleaseHRJobApplication(var "HR Job Application": Record "HR Job Applications")
    var
        HRJobApplication: Record "HR Job Applications";
        JobApplicationApproved: Label 'Job Application has sucessfully been Approved';
    begin
        HRJobApplication.Reset;
        HRJobApplication.SetRange(HRJobApplication."No.", "HR Job Application"."No.");
        if HRJobApplication.FindFirst then begin
            HRJobApplication.Status := HRJobApplication.Status::Approved;
            HRJobApplication.Validate(HRJobApplication.Status);
            HRJobApplication.Modify;
            Message(JobApplicationApproved);
        end;
    end;

    procedure ReOpenHRJobApplication(var "HR Job Application": Record "HR Job Applications")
    var
        HRJobApplication: Record "HR Job Applications";
    begin
        HRJobApplication.Reset;
        HRJobApplication.SetRange(HRJobApplication."No.", "HR Job Application"."No.");
        if HRJobApplication.FindFirst then begin
            HRJobApplication.Status := HRJobApplication.Status::Open;
            HRJobApplication.Validate(HRJobApplication.Status);
            HRJobApplication.Modify;
        end;
    end;

    procedure ReleaseHREmployeeAppraisalHeader(var "HR Employee Appraisal Header": Record "HR Employee Appraisal Header")
    var
        HREmployeeAppraisalHeader: Record "HR Employee Appraisal Header";
        AppraisalApprovalMessage: Label 'Appraisal Card has sucessfully been approved';
    begin
        HREmployeeAppraisalHeader.Reset;
        HREmployeeAppraisalHeader.SetRange(HREmployeeAppraisalHeader."No.", "HR Employee Appraisal Header"."No.");
        if HREmployeeAppraisalHeader.FindFirst then begin
            HREmployeeAppraisalHeader.Status := HREmployeeAppraisalHeader.Status::Released;
            HREmployeeAppraisalHeader.Validate(HREmployeeAppraisalHeader.Status);
            HREmployeeAppraisalHeader.Modify;
            Message(AppraisalApprovalMessage);
        end;
    end;

    procedure ReOpenHREmployeeAppraisalHeader(var "HR Employee Appraisal Header": Record "HR Employee Appraisal Header")
    var
        HREmployeeAppraisalHeader: Record "HR Employee Appraisal Header";
    begin
        HREmployeeAppraisalHeader.Reset;
        HREmployeeAppraisalHeader.SetRange(HREmployeeAppraisalHeader."No.", "HR Employee Appraisal Header"."No.");
        if HREmployeeAppraisalHeader.FindFirst then begin
            HREmployeeAppraisalHeader.Status := HREmployeeAppraisalHeader.Status::Open;
            HREmployeeAppraisalHeader.Validate(HREmployeeAppraisalHeader.Status);
            HREmployeeAppraisalHeader.Modify;
        end;
    end;

    procedure ReleaseHRLeavePlannerHeader(var "HR Leave Planner Header": Record "HR Leave Planner Header")
    var
        HRLeavePlannerHeader: Record "HR Leave Planner Header";
        LeavePlannerApprovalMessage: Label 'Leave Planner has successfully been Approved';
    begin
        HRLeavePlannerHeader.Reset;
        HRLeavePlannerHeader.SetRange(HRLeavePlannerHeader."No.", "HR Leave Planner Header"."No.");
        if HRLeavePlannerHeader.FindFirst then begin
            HRLeavePlannerHeader.Status := HRLeavePlannerHeader.Status::Released;
            HRLeavePlannerHeader.Validate(HRLeavePlannerHeader.Status);
            HRLeavePlannerHeader.Modify;
            Message(LeavePlannerApprovalMessage);
        end;
    end;

    procedure ReOpenHRLeavePlannerHeader(var "HR Leave Planner Header": Record "HR Leave Planner Header")
    var
        HRLeavePlannerHeader: Record "HR Leave Planner Header";
    begin
        HRLeavePlannerHeader.Reset;
        HRLeavePlannerHeader.SetRange(HRLeavePlannerHeader."No.", "HR Leave Planner Header"."No.");
        if HRLeavePlannerHeader.FindFirst then begin
            HRLeavePlannerHeader.Status := HRLeavePlannerHeader.Status::Open;
            HRLeavePlannerHeader.Validate(HRLeavePlannerHeader.Status);
            HRLeavePlannerHeader.Modify;
        end;
    end;

    procedure ReleaseHRLeaveApplication(var "HR Leave Application": Record "HR Leave Application")
    var
        HRLeaveApplication: Record "HR Leave Application";
        LeaveApplicationMessage: Label 'Leave Application has sucessfully been Approved';
    begin
        HRLeaveApplication.Reset;
        HRLeaveApplication.SetRange(HRLeaveApplication."No.", "HR Leave Application"."No.");
        if HRLeaveApplication.FindFirst then begin
            HRLeaveApplication.Status := HRLeaveApplication.Status::Released;
            HRLeaveApplication.Validate(HRLeaveApplication.Status);
            HRLeaveApplication.Modify;
            //post leave application
            HRLeaveManagementCu.PostLeaveApplication(HRLeaveApplication."No.");
            //Message(LeaveApplicationMessage);
        end;
    end;

    procedure ReOpenHRLeaveApplication(var "HR Leave Application": Record "HR Leave Application")
    var
        HRLeaveApplication: Record "HR Leave Application";
    begin
        HRLeaveApplication.Reset;
        HRLeaveApplication.SetRange(HRLeaveApplication."No.", "HR Leave Application"."No.");
        if HRLeaveApplication.FindFirst then begin
            HRLeaveApplication.Status := HRLeaveApplication.Status::Open;
            HRLeaveApplication.Validate(HRLeaveApplication.Status);
            HRLeaveApplication.Modify;
        end;
    end;

    procedure ReleaseHRLeaveReimbusment(var "HR Leave Reimbusment": Record "HR Leave Reimbursement")
    var
        HRLeaveReimbusment: Record "HR Leave Reimbursement";
        LeaveReimbursementMessage: Label 'Leave Reimbursement has sucessfully been approved';
    begin
        HRLeaveReimbusment.Reset;
        HRLeaveReimbusment.SetRange(HRLeaveReimbusment."No.", "HR Leave Reimbusment"."No.");
        if HRLeaveReimbusment.FindFirst then begin
            HRLeaveReimbusment.Status := HRLeaveReimbusment.Status::Released;
            HRLeaveReimbusment.Validate(HRLeaveReimbusment.Status);
            HRLeaveReimbusment.Modify;
            Message(LeaveReimbursementMessage);
        end;
    end;

    procedure ReOpenHRLeaveReimbusment(var "HR Leave Reimbusment": Record "HR Leave Reimbursement")
    var
        HRLeaveReimbusment: Record "HR Leave Reimbursement";
    begin
        HRLeaveReimbusment.Reset;
        HRLeaveReimbusment.SetRange(HRLeaveReimbusment."No.", "HR Leave Reimbusment"."No.");
        if HRLeaveReimbusment.FindFirst then begin
            HRLeaveReimbusment.Status := HRLeaveReimbusment.Status::Open;
            HRLeaveReimbusment.Validate(HRLeaveReimbusment.Status);
            HRLeaveReimbusment.Modify;
        end;
    end;

    procedure ReleaseHRLeaveCarryover(var "HR Leave Carryover": Record "HR Leave Carryover")
    var
        HRLeaveCarryover: Record "HR Leave Carryover";
        LeaveCarryoverMessage: Label 'Leave Carryover has sucessfully been approved';
    begin
        HRLeaveCarryover.Reset;
        HRLeaveCarryover.SetRange(HRLeaveCarryover."No.", "HR Leave Carryover"."No.");
        if HRLeaveCarryover.FindFirst then begin
            HRLeaveCarryover.Status := HRLeaveCarryover.Status::Released;
            HRLeaveCarryover.Validate(HRLeaveCarryover.Status);
            HRLeaveCarryover.Modify;
            Message(LeaveCarryoverMessage);
        end;
    end;

    procedure ReOpenHRLeaveCarryover(var "HR Leave Carryover": Record "HR Leave Carryover")
    var
        HRLeaveCarryover: Record "HR Leave Carryover";
    begin
        HRLeaveCarryover.Reset;
        HRLeaveCarryover.SetRange(HRLeaveCarryover."No.", "HR Leave Carryover"."No.");
        if HRLeaveCarryover.FindFirst then begin
            HRLeaveCarryover.Status := HRLeaveCarryover.Status::Open;
            HRLeaveCarryover.Validate(HRLeaveCarryover.Status);
            HRLeaveCarryover.Modify;
        end;
    end;

    procedure ReleaseHRLeaveAllocationHeader(var "HR Leave Allocation Header": Record "HR Leave Allocation Header")
    var
        HRLeaveAllocationHeader: Record "HR Leave Allocation Header";
        LeaveAllocationMessage: Label 'Leave Allocation has successfully been approved.';
    begin
        HRLeaveAllocationHeader.Reset;
        HRLeaveAllocationHeader.SetRange(HRLeaveAllocationHeader."No.", "HR Leave Allocation Header"."No.");
        if HRLeaveAllocationHeader.FindFirst then begin
            HRLeaveAllocationHeader.Status := HRLeaveAllocationHeader.Status::Released;
            HRLeaveAllocationHeader.Validate(HRLeaveAllocationHeader.Status);
            HRLeaveAllocationHeader.Modify;
            Message(LeaveAllocationMessage);
        end;
    end;

    procedure ReOpenHRLeaveAllocationHeader(var "HR Leave Allocation Header": Record "HR Leave Allocation Header")
    var
        HRLeaveAllocationHeader: Record "HR Leave Allocation Header";
    begin
        HRLeaveAllocationHeader.Reset;
        HRLeaveAllocationHeader.SetRange(HRLeaveAllocationHeader."No.", "HR Leave Allocation Header"."No.");
        if HRLeaveAllocationHeader.FindFirst then begin
            HRLeaveAllocationHeader.Status := HRLeaveAllocationHeader.Status::Open;
            HRLeaveAllocationHeader.Validate(HRLeaveAllocationHeader.Status);
            HRLeaveAllocationHeader.Modify;
        end;
    end;

    procedure ReleaseHRAssetTransferHeader(var "HR Asset Transfer Header": Record "HR Asset Transfer Header")
    var
        HRAssetTransferHeader: Record "HR Asset Transfer Header";
        AssetTransferMessage: Label 'Employee Asset transfer has sucessfully been Approved';
    begin
        HRAssetTransferHeader.Reset;
        HRAssetTransferHeader.SetRange(HRAssetTransferHeader."No.", "HR Asset Transfer Header"."No.");
        if HRAssetTransferHeader.FindFirst then begin
            HRAssetTransferHeader.Status := HRAssetTransferHeader.Status::Approved;
            HRAssetTransferHeader.Validate(HRAssetTransferHeader.Status);
            HRAssetTransferHeader.Modify;
            Message(AssetTransferMessage);
        end;
    end;

    procedure ReOpenHRAssetTransferHeader(var "HR Asset Transfer Header": Record "HR Asset Transfer Header")
    var
        HRAssetTransferHeader: Record "HR Asset Transfer Header";
    begin
        HRAssetTransferHeader.Reset;
        HRAssetTransferHeader.SetRange(HRAssetTransferHeader."No.", "HR Asset Transfer Header"."No.");
        if HRAssetTransferHeader.FindFirst then begin
            HRAssetTransferHeader.Status := HRAssetTransferHeader.Status::Open;
            HRAssetTransferHeader.Validate(HRAssetTransferHeader.Status);
            HRAssetTransferHeader.Modify;
        end;
    end;

    procedure ReleaseHREmployeeTransferHeader(var "HR Employee Transfer Header": Record "HR Employee Transfer Header")
    var
        HREmployeeTransferHeader: Record "HR Employee Transfer Header";
    begin
        HREmployeeTransferHeader.Reset;
        HREmployeeTransferHeader.SetRange(HREmployeeTransferHeader."Request No", "HR Employee Transfer Header"."Request No");
        if HREmployeeTransferHeader.FindFirst then begin
            HREmployeeTransferHeader.Status := HREmployeeTransferHeader.Status::Approved;
            HREmployeeTransferHeader.Validate(HREmployeeTransferHeader.Status);
            HREmployeeTransferHeader.Modify;
        end;
    end;

    procedure ReOpenHREmployeeTransferHeader(var "HR Employee Transfer Header": Record "HR Employee Transfer Header")
    var
        HREmployeeTransferHeader: Record "HR Employee Transfer Header";
    begin
        HREmployeeTransferHeader.Reset;
        HREmployeeTransferHeader.SetRange(HREmployeeTransferHeader."Request No", "HR Employee Transfer Header"."Request No");
        if HREmployeeTransferHeader.FindFirst then begin
            HREmployeeTransferHeader.Status := HREmployeeTransferHeader.Status::Open;
            HREmployeeTransferHeader.Validate(HREmployeeTransferHeader.Status);
            HREmployeeTransferHeader.Modify;
        end;
    end;

    procedure ReleaseHRExitInterviewHeader(var "HR Exit Interview Header": Record "HR Employee Exit Interviews")
    var
        HRExitInterviewHeader: Record "HR Employee Exit Interviews";
        ExitInterviewMessage: Label 'Employee Exit Interview has sucessfully been Approved';
    begin
        HRExitInterviewHeader.Reset;
        HRExitInterviewHeader.SetRange(HRExitInterviewHeader."Exit Interview No", "HR Exit Interview Header"."Exit Interview No");
        if HRExitInterviewHeader.FindFirst then begin
            HRExitInterviewHeader.Status := HRExitInterviewHeader.Status::Approved;
            HRExitInterviewHeader.Validate(HRExitInterviewHeader.Status);
            HRExitInterviewHeader.Modify;
            Message(ExitInterviewMessage);
        end;
    end;

    procedure ReOpenHRExitInterviewHeader(var "HR Exit Interview Header": Record "HR Employee Exit Interviews")
    var
        HRExitInterviewHeader: Record "HR Employee Exit Interviews";
    begin
        HRExitInterviewHeader.Reset;
        HRExitInterviewHeader.SetRange(HRExitInterviewHeader."Exit Interview No", "HR Exit Interview Header"."Exit Interview No");
        if HRExitInterviewHeader.FindFirst then begin
            HRExitInterviewHeader.Status := HRExitInterviewHeader.Status::Open;
            HRExitInterviewHeader.Validate(HRExitInterviewHeader.Status);
            HRExitInterviewHeader.Modify;
        end;
    end;

    procedure ReleaseHRTrainingHeader(var HRTrainingApplications: Record "HR Training Applications")
    var
        TrainingApplications: Record "HR Training Applications";
        HRTrainingApplicationMessage: Label 'Employee Training Application has sucessfully been approved';
    begin
        TrainingApplications.Reset;
        TrainingApplications.SetRange(TrainingApplications."Application No.", HRTrainingApplications."Application No.");
        if TrainingApplications.FindFirst then begin
            TrainingApplications.Status := TrainingApplications.Status::Approved;
            TrainingApplications.Validate(TrainingApplications.Status);
            TrainingApplications.Modify;
            Message(HRTrainingApplicationMessage);
        end;
    end;

    procedure ReOpenHRTrainingHeader(var HRTrainingApplications: Record "HR Training Applications")
    var
        TrainingApplications: Record "HR Training Applications";
    begin
        TrainingApplications.Reset;
        TrainingApplications.SetRange(TrainingApplications."Application No.", HRTrainingApplications."Application No.");
        if TrainingApplications.FindFirst then begin
            TrainingApplications.Status := TrainingApplications.Status::Open;
            TrainingApplications.Validate(TrainingApplications.Status);
            TrainingApplications.Modify;
        end;
    end;

    procedure ReleaseHRTrainingNeedsHeader(var HRTrainingNeedsHeader: Record "HR Training Needs Header")
    var
        TrainingNeedsHeader: Record "HR Training Needs Header";
        HRTrainingNeedsMessage: Label 'Employee Training Needs Application has sucessfully been approved';
    begin
        TrainingNeedsHeader.Reset;
        TrainingNeedsHeader.SetRange(TrainingNeedsHeader."No.", HRTrainingNeedsHeader."No.");
        if TrainingNeedsHeader.FindFirst then begin
            TrainingNeedsHeader.Status := TrainingNeedsHeader.Status::Approved;
            TrainingNeedsHeader.Validate(TrainingNeedsHeader.Status);
            TrainingNeedsHeader.Modify;
            Message(HRTrainingNeedsMessage);
        end;
    end;

    procedure ReOpenHRTrainingNeedsHeader(var HRTrainingNeedsHeader: Record "HR Training Needs Header")
    var
        TrainingNeedsHeader: Record "HR Training Needs Header";
    begin
        TrainingNeedsHeader.Reset;
        TrainingNeedsHeader.SetRange(TrainingNeedsHeader."No.", HRTrainingNeedsHeader."No.");
        if TrainingNeedsHeader.FindFirst then begin
            TrainingNeedsHeader.Status := TrainingNeedsHeader.Status::Open;
            TrainingNeedsHeader.Validate(TrainingNeedsHeader.Status);
            TrainingNeedsHeader.Modify;
        end;
    end;

    procedure ReleaseHRTrainingGroup(var HRTrainingGroup: Record "HR Training Group")
    var
        TrainingGroup: Record "HR Training Group";
        HRTrainingGroupMessage: Label 'The Group Training Application has sucessfully been Approved';
    begin
        TrainingGroup.Reset;
        TrainingGroup.SetRange(TrainingGroup."Training Group App. No.", HRTrainingGroup."Training Group App. No.");
        if TrainingGroup.FindFirst then begin
            TrainingGroup.Status := TrainingGroup.Status::Approved;
            TrainingGroup.Validate(TrainingGroup.Status);
            TrainingGroup.Modify;
            Message(HRTrainingGroupMessage);
        end;
    end;

    procedure ReOpenHRTrainingGroup(var HRTrainingGroup: Record "HR Training Group")
    var
        TrainingGroup: Record "HR Training Group";
    begin
        TrainingGroup.Reset;
        TrainingGroup.SetRange(TrainingGroup."Training Group App. No.", HRTrainingGroup."Training Group App. No.");
        if TrainingGroup.FindFirst then begin
            TrainingGroup.Status := TrainingGroup.Status::Open;
            TrainingGroup.Validate(TrainingGroup.Status);
            TrainingGroup.Modify;
        end;
    end;

    procedure ReleaseTrainingEvaluation(var TrainingEvaluation: Record "Training Evaluation")
    var
        HRTrainingEvaluation: Record "Training Evaluation";
        TrainingEvalutionMessage: Label 'Empolyee Training Evalution has successfully been Approved';
    begin
        TrainingEvaluation.Reset;
        TrainingEvaluation.SetRange(TrainingEvaluation."Training Evaluation No.", HRTrainingEvaluation."Training Evaluation No.");
        if TrainingEvaluation.FindFirst then begin
            TrainingEvaluation.Status := TrainingEvaluation.Status::Approved;
            TrainingEvaluation.Validate(TrainingEvaluation.Status);
            TrainingEvaluation.Modify;
            Message(TrainingEvalutionMessage);
        end;
    end;

    procedure ReOpenTrainingEvaluation(var TrainingEvaluation: Record "Training Evaluation")
    var
        HRTrainingEvaluation: Record "Training Evaluation";
    begin
        TrainingEvaluation.Reset;
        TrainingEvaluation.SetRange(TrainingEvaluation."Training Evaluation No.", HRTrainingEvaluation."Training Evaluation No.");
        if TrainingEvaluation.FindFirst then begin
            TrainingEvaluation.Status := TrainingEvaluation.Status::Open;
            TrainingEvaluation.Validate(TrainingEvaluation.Status);
            TrainingEvaluation.Modify;
        end;
    end;

    procedure ReleaseleaveAllowance(var LeaveAllowanceRequest: Record "Leave Allowance Request")
    var
        LeaveAllowanceRequest2: Record "Leave Allowance Request";
        LeaveAllowanceMessage: Label 'Employee Leave Allowance application has succesfully been approved';
    begin
        LeaveAllowanceRequest2.Reset;
        LeaveAllowanceRequest2.SetRange(LeaveAllowanceRequest2."No.", LeaveAllowanceRequest."No.");
        if LeaveAllowanceRequest2.FindFirst then begin
            LeaveAllowanceRequest2.Status := LeaveAllowanceRequest2.Status::Approved;
            LeaveAllowanceRequest2.Validate(LeaveAllowanceRequest2.Status);
            LeaveAllowanceRequest2.Modify;
            Message(LeaveAllowanceMessage);
        end;
    end;

    procedure ReOpenLeaveAllowance(var LeaveAllowanceRequest: Record "Leave Allowance Request")
    var
        LeaveAllowanceRequest2: Record "Leave Allowance Request";
    begin
        LeaveAllowanceRequest2.Reset;
        LeaveAllowanceRequest2.SetRange(LeaveAllowanceRequest2."No.", LeaveAllowanceRequest."No.");
        if LeaveAllowanceRequest2.FindFirst then begin
            LeaveAllowanceRequest2.Status := LeaveAllowanceRequest2.Status::Open;
            LeaveAllowanceRequest2.Modify;
        end;
    end;

    procedure ReleaseHRLoan(var EmployeeLoanApplications: Record "Employee Loan Applications")
    var
        EmployeeLoanApplication: Record "Employee Loan Applications";
        LoanApplicationMessage: Label 'Employee Loan Application has sucessfully been Approved';
    begin
        EmployeeLoanApplication.Reset;
        EmployeeLoanApplication.SetRange(EmployeeLoanApplication."No.", EmployeeLoanApplications."No.");
        if EmployeeLoanApplication.FindFirst then begin
            EmployeeLoanApplication.Status := EmployeeLoanApplication.Status::Approved;
            EmployeeLoanApplication.Validate(EmployeeLoanApplication.Status);
            EmployeeLoanApplication.Modify;
            Message(LoanApplicationMessage);
        end;
    end;

    procedure ReOpenHRLoan(var EmployeeLoanApplications: Record "Employee Loan Applications")
    var
        EmployeeLoanApplication: Record "Employee Loan Applications";
    begin
        EmployeeLoanApplication.Reset;
        EmployeeLoanApplication.SetRange(EmployeeLoanApplication."No.", EmployeeLoanApplications."No.");
        if EmployeeLoanApplication.FindFirst then begin
            EmployeeLoanApplication.Status := EmployeeLoanApplication.Status::Rejected;
            EmployeeLoanApplication.Validate(EmployeeLoanApplication.Status);
            EmployeeLoanApplication.Modify;
        end;
    end;

    procedure InsertLoanRejectionComments(var ApprovalEntry: Record "Approval Entry")
    var
        EmployeeLoanApplication: Record "Employee Loan Applications";
    begin
        EmployeeLoanApplication.Reset;
        EmployeeLoanApplication.SetRange(EmployeeLoanApplication."No.", ApprovalEntry."Document No.");
        if EmployeeLoanApplication.FindFirst then begin
            EmployeeLoanApplication."Rejection Comment" := ApprovalEntry."Rejection Comments";
            EmployeeLoanApplication.Modify;
        end;
    end;

    procedure ReleaseHRLoanProduct(var HRLoanProducts: Record "Employee Loan Products")
    var
        HRLoanProduct: Record "Employee Loan Products";
        HRLoanProductMessage: Label 'Human Resource, Loan Product has successfully been approved';
    begin
        HRLoanProduct.Reset;
        HRLoanProduct.SetRange(HRLoanProduct.Code, HRLoanProducts.Code);
        if HRLoanProduct.FindFirst then begin
            HRLoanProduct.Status := HRLoanProduct.Status::Approved;
            HRLoanProduct.Validate(HRLoanProduct.Status);
            HRLoanProduct.Modify;
            Message(HRLoanProductMessage);
        end;
    end;

    procedure ReOpenHRLoanProduct(var HRLoanProducts: Record "Employee Loan Products")
    var
        HRLoanProduct: Record "Employee Loan Products";
    begin
        HRLoanProduct.Reset;
        HRLoanProduct.SetRange(HRLoanProduct.Code, HRLoanProducts.Code);
        if HRLoanProduct.FindFirst then begin
            HRLoanProduct.Status := HRLoanProduct.Status::Open;
            HRLoanProduct.Validate(HRLoanProduct.Status);
            HRLoanProduct.Modify;
        end;
    end;

    procedure ReleaseHRLoanDisbursement(var EmployeeLoanDisbursements: Record "Employee Loan Disbursement")
    var
        EmployeeLoanDisbursement: Record "Employee Loan Disbursement";
        EmployeeLoanDisbursementMessage: Label 'Employee Loan disbursement request has sucessfully been approved';
    begin
        EmployeeLoanDisbursement.Reset;
        EmployeeLoanDisbursement.SetRange(EmployeeLoanDisbursement."No.", EmployeeLoanDisbursements."No.");
        if EmployeeLoanDisbursement.FindFirst then begin
            EmployeeLoanDisbursement.Status := EmployeeLoanDisbursement.Status::Released;
            EmployeeLoanDisbursement.Validate(EmployeeLoanDisbursement.Status);
            EmployeeLoanDisbursement.Modify;
            Message(EmployeeLoanDisbursementMessage);
        end;
    end;

    procedure ReOpenHRLoanDisbursement(var EmployeeLoanDisbursements: Record "Employee Loan Disbursement")
    var
        EmployeeLoanDisbursement: Record "Employee Loan Disbursement";
    begin
        EmployeeLoanDisbursement.Reset;
        EmployeeLoanDisbursement.SetRange(EmployeeLoanDisbursement."No.", EmployeeLoanDisbursements."No.");
        if EmployeeLoanDisbursement.FindFirst then begin
            EmployeeLoanDisbursement.Status := EmployeeLoanDisbursement.Status::Open;
            EmployeeLoanDisbursement.Validate(EmployeeLoanDisbursement.Status);
            EmployeeLoanDisbursement.Modify;
        end;
    end;

    procedure ReleaseInterviewHeader(var InterviewAttendanceHeader: Record "Interview Attendance Header")
    var
        HRInterviewAttendanceHeader: Record "Interview Attendance Header";
        InterviewAttendanceHeaderMessage: Label 'Interview Attendance request has sucessfully been approved';
    begin
        HRInterviewAttendanceHeader.Reset;
        HRInterviewAttendanceHeader.SetRange(HRInterviewAttendanceHeader."Interview No", InterviewAttendanceHeader."Interview No");
        if HRInterviewAttendanceHeader.FindFirst then begin
            HRInterviewAttendanceHeader.Status := HRInterviewAttendanceHeader.Status::Approved;
            HRInterviewAttendanceHeader.Validate(HRInterviewAttendanceHeader.Status);
            HRInterviewAttendanceHeader.Modify;
            Message(InterviewAttendanceHeaderMessage);
        end;
    end;

    procedure ReOpenInterviewHeader(var HRInterviewAttendanceHeader: Record "Interview Attendance Header")
    var
        InterviewAttendanceHeader: Record "Interview Attendance Header";
    begin
        HRInterviewAttendanceHeader.Reset;
        HRInterviewAttendanceHeader.SetRange(HRInterviewAttendanceHeader."Interview No", HRInterviewAttendanceHeader."Interview No");
        if HRInterviewAttendanceHeader.FindFirst then begin
            HRInterviewAttendanceHeader.Status := HRInterviewAttendanceHeader.Status::Open;
            HRInterviewAttendanceHeader.Validate(HRInterviewAttendanceHeader.Status);
            HRInterviewAttendanceHeader.Modify;
        end;
    end;

    procedure ReOpenHRTransportRequest(var HRTransportRequest: Record "Transport Request")
    var
        TransportRequestRec: Record "Transport Request";
    begin
        TransportRequestRec.Reset;
        TransportRequestRec.SetRange(TransportRequestRec."Request No.", HRTransportRequest."Request No.");
        if TransportRequestRec.FindFirst then begin
            TransportRequestRec.Status := TransportRequestRec.Status::Open;
            TransportRequestRec.Validate(TransportRequestRec.Status);
            TransportRequestRec.Modify;
        end;
    end;

    procedure ReleaseTransportRequest(var TransportRequest: Record "Transport Request")
    var
        TransportRequestRec: Record "Transport Request";
        LeaveAllowanceMessage: Label 'Employee Leave Allowance application has succesfully been approved';
    begin
        TransportRequestRec.Reset;
        TransportRequestRec.SetRange(TransportRequestRec."Request No.", TransportRequest."Request No.");
        if TransportRequestRec.FindFirst then begin
            TransportRequestRec.Status := TransportRequestRec.Status::Released;
            TransportRequestRec.Validate(TransportRequestRec.Status);
            TransportRequestRec.Modify;
        end;
    end;

    procedure ReleaseInspectionHeader(var InspectionHeader: Record "Inspection Header")
    var
        InspectionHeaderRec: Record "Inspection Header";
    begin
        InspectionHeaderRec.Reset;
        InspectionHeaderRec.SetRange(InspectionHeaderRec."Inspection No", InspectionHeader."Inspection No");
        if InspectionHeaderRec.FindFirst then begin
            InspectionHeaderRec.Status := InspectionHeaderRec.Status::Released;
            InspectionHeaderRec.Validate(InspectionHeaderRec.Status);
            InspectionHeaderRec.Modify;
        end;
    end;

    procedure ReopenInspectionHeader(var InspectionHeader: Record "Inspection Header")
    var
        InspectionHeaderRec: Record "Inspection Header";
    begin
        InspectionHeaderRec.Reset;
        InspectionHeaderRec.SetRange(InspectionHeaderRec."Inspection No", InspectionHeader."Inspection No");
        if InspectionHeaderRec.FindFirst then begin
            InspectionHeaderRec.Status := InspectionHeaderRec.Status::Open;
            InspectionHeaderRec.Validate(InspectionHeaderRec.Status);
            InspectionHeaderRec.Modify;
        end;
    end;

    procedure ReopenTestDocument(var TestDocument: Record TestDocument)
    var
        TestDocumentRec: Record TestDocument;
    begin
        TestDocumentRec.Reset;
        TestDocumentRec.SetRange(TestDocumentRec."No.", TestDocument."No.");
        if TestDocumentRec.FindFirst then begin
            TestDocumentRec.Status := TestDocumentRec.Status::Open;
            TestDocumentRec.Validate(TestDocumentRec.Status);
            TestDocumentRec.Modify;
        end;
    end;

    procedure ReleaseTestDocument(var TestDocument: Record TestDocument)
    var
        TestDocumentRec: Record TestDocument;
    begin
        TestDocumentRec.Reset;
        TestDocumentRec.SetRange(TestDocumentRec."No.", TestDocument."No.");
        if TestDocumentRec.FindFirst then begin
            TestDocumentRec.Status := TestDocumentRec.Status::Approved;
            TestDocumentRec.Validate(TestDocumentRec.Status);
            TestDocumentRec.Modify;
        end;
    end;
}

