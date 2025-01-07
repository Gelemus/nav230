codeunit 50024 "HR Management WS"
{

    trigger OnRun()
    begin

        //**************************************** Leave Management Services ************************************************************************************************************************
        //MESSAGE(FORMAT(GetLeaveEndDate('E0010','ANNUAL',111119D,5)));
        //MESSAGE(FORMAT(GetLeaveReturnDate('E0010','ANNUAL',111119D,5)))

        //MESSAGE(FORMAT(GetEmployeeLeaveBalance('INT036','ANNUAL')));
        HyperLink(GenerateP9('B0002', 2023));
        //HYPERLINK(GenerateApprovalPrintOut(1,'WHT0046'));
        //MESSAGE(SendLeaveApplicationApprovalRequest('LVAP000196'));
        //HYPERLINK(FORMAT(GeneratePayslip('0580','7-2023')))

        //MESSAGE(SendLeavePlanApprovalRequest('LVPLAN012'));
    end;

    var
        CompanyInformation: Record "Company Information";
        Employee: Record Employee;
        HRLeavePlannerHeader: Record "HR Leave Planner Header";
        HRLeaveApplication: Record "HR Leave Application";
        HRLeaveReimbursement: Record "HR Leave Reimbursement";
        HumanResourcesSetup: Record "Human Resources Setup";
        ApprovalEntry: Record "Approval Entry";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
        ApprovalsMgmtMain: Codeunit "Approvals Mgmt.";
        HRApprovalManager: Codeunit "HR Approval Manager";
        HRLeaveMgmt: Codeunit "HR Leave Management";
        SERVERDIRECTORYPATH: Label 'C:\inetpub\wwwroot\ICDC\TenantData';
        TxtCharsToKeep: Label 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.@';
        Dates: Codeunit Dates;
        HRTrainingApplication: Record "HR Training Applications";
        HRTrainingNeedsHeader: Record "HR Training Needs Header";
        HRTrainingNeedsLine: Record "HR Training Needs Line";
        HRTrainingEvaluation: Record "Training Evaluation";
        FundsGeneralSetup: Record "Funds General Setup";
        CompanyDataDirectory: Text[50];
        EmployeeDataDirectory: Text[50];
        HRRequiredDocumentChecklist: Record "HR Required Document Checklist";
        HRJobLookupValue: Record "HR Job Lookup Value";
        Text_0001: Label 'You cannot apply for another leave before another one ends';
        TrainingApplicationError: Label 'You can not apply for another Training if you have not submited your previous Training attendance Evaluation. Please submit your Training Evaluation to proceed';
        Success: Label 'Success';
        HREmployeeAppraisalHeaderRec: Record "HR Employee Appraisal Header";
        HrAppraisalAcademicProfQuaRec: Record "Hr Appraisal Academic/Prof Qua";
        HRAppraisalCompetencyFactor: Record "HR Appraisal Competency Factor";
        HRAppraisalProblemsChalleng: Record "HR Appraisal Problems/Challeng";
        HRAppraisalCourseTraining: Record "HR Appraisal Course/Training";
        HRAppraisalPerformanceFacto: Record "HR Appraisal Performance Facto";
        HrAppraisalPerformaceSugge: Record "Hr Appraisal Performace Sugge";
        HRAppraisalTrainingNeedOb: Record "HR Appraisal Training Need &Ob";
        HRAppraisalIdentifiedPotent: Record "HR Appraisal Identified Potent";
        HRAppraisalRecommendation: Record "HR Appraisal Recommendation";
        HRAppraisalSpecialTask: Record "HR Appraisal Special Task";
        LineNoInt: Integer;
        HrAppraisalResponsibility: Record "HR Appraisal Resp/Duties";
        HREmployeeAppraisalHeader: Record "HR Employee Appraisal Header";
        HrLeaveAllLin: Record "HR Leave Allocation Line";
        PayrollEntry: Record "Payroll Entry";
        HRCasualRequisitions: Record "HR Employee Requisitions";
        HRCasualRequisitionsLine: Record "HR Employee Requisitions Lines";
        HRLeavePlannerHeader2: Record "HR Leave Planner Header";
        HRLeavePlannerLine: Record "HR Leave Planner Line";
        AttendanceTerminal: Record "Attendance Terminal";
        AttendanceRecord: Record "Attendance Punches";
        AttendanceTimetable: Record AttendanceTimetable;
        AttendanceSummary: Record "Attendance Summary";
        TransferOrderPortal: Report "Transfer Order Portal";
        Month: Integer;

    [Scope('Personalization')]
    procedure CheckOpenLeavePlannerExists("EmployeeNo.": Code[20]) OpenLeavePlannerExist: Boolean
    begin
        OpenLeavePlannerExist := false;
        HRLeavePlannerHeader.Reset;
        HRLeavePlannerHeader.SetRange(HRLeavePlannerHeader."User ID", "EmployeeNo.");
        HRLeavePlannerHeader.SetRange(HRLeavePlannerHeader.Status, HRLeavePlannerHeader.Status::Open);
        if HRLeavePlannerHeader.FindFirst then begin
            OpenLeavePlannerExist := true;
        end;
    end;

    [Scope('Personalization')]
    procedure CheckOpenLeaveApplicationExists("EmployeeNo.": Code[20]) OpenLeaveApplicationExist: Boolean
    begin
        OpenLeaveApplicationExist := false;
        HRLeaveApplication.Reset;
        HRLeaveApplication.SetRange(HRLeaveApplication."Employee No.", "EmployeeNo.");
        HRLeaveApplication.SetFilter(HRLeaveApplication.Status, '=%1|%2', 1, 2);
        if HRLeaveApplication.FindFirst then begin
            OpenLeaveApplicationExist := true;
        end;
    end;

    procedure CheckLeaveApplicationExists("LeaveApplicationNo.": Code[20]; "EmployeeNo.": Code[20]) LeaveApplicationExist: Boolean
    begin
        LeaveApplicationExist := false;
        HRLeaveApplication.Reset;
        HRLeaveApplication.SetRange(HRLeaveApplication."Employee No.", "EmployeeNo.");
        HRLeaveApplication.SetRange(HRLeaveApplication."No.", "LeaveApplicationNo.");
        if HRLeaveApplication.FindFirst then begin
            LeaveApplicationExist := true;
        end;
    end;

    [Scope('Personalization')]
    procedure CreateLeaveApplication("EmployeeNo.": Code[20]; LeaveType: Code[50]; LeaveStartDate: Date; DaysApplied: Integer; ReasonForLeave: Text; "SubstituteEmployeeNo.": Code[20]; DocumentName: Text) LeaveApplicationCreated: Text
    var
        HRLeaveType: Record "HR Leave Types";
        Text101: Label 'Applied number of days must be equal to %1';
    begin
        LeaveApplicationCreated := '';

        HumanResourcesSetup.Get;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        //check running leaves
        //CheckRunningLeaves("EmployeeNo.",LeaveStartDate);

        HRLeaveApplication.Init;
        HRLeaveApplication."No." := NoSeriesMgt.GetNextNo(HumanResourcesSetup."Leave Application Nos.", 0D, true);
        HRLeaveApplication."Document Date" := Today;
        HRLeaveApplication."Posting Date" := LeaveStartDate;
        HRLeaveApplication."Employee No." := "EmployeeNo.";
        HRLeaveApplication."Document Name" := DocumentName;
        HRLeaveApplication.Validate(HRLeaveApplication."Employee No.");
        HRLeaveApplication."Substitute No." := "SubstituteEmployeeNo.";
        HRLeaveApplication.Validate(HRLeaveApplication."Substitute No.");

        //check mandatory number of days
        HRLeaveType.Reset;
        HRLeaveType.SetRange(Code, LeaveType);
        HRLeaveType.SetRange("Take as Block", true);
        if HRLeaveType.FindFirst then begin
            if HRLeaveType.Days <> DaysApplied then
                Error(Text101, Format(HRLeaveType.Days));
        end;
        // End check mandatory number of days

        HRLeaveApplication."Leave Type" := LeaveType;
        HRLeaveApplication.Validate(HRLeaveApplication."Leave Type");
        HRLeaveApplication."Leave Start Date" := LeaveStartDate;
        HRLeaveApplication.Validate(HRLeaveApplication."Leave Start Date");
        HRLeaveApplication."Days Applied" := DaysApplied;
        HRLeaveApplication.Validate(HRLeaveApplication."Days Applied");

        HRLeaveApplication."Reason for Leave" := ReasonForLeave;
        HRLeaveApplication."User ID" := Employee."User ID";
        if HRLeaveApplication.Insert then begin
            LeaveApplicationCreated := '200: Leave Application No ' + HRLeaveApplication."No." + ' Created Successfully';
        end else
            LeaveApplicationCreated := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyLeaveApplication("LeaveApplicationNo.": Code[20]; "EmployeeNo.": Code[20]; LeaveType: Code[50]; LeaveStartDate: Date; DaysApplied: Integer; ReasonForLeave: Text; "SubstituteEmployeeNo.": Code[20]; DocumentName: Text) LeaveApplicationModified: Text
    var
        Text101: Label 'Applied number of days must be equal to %1';
        HRLeaveType: Record "HR Leave Types";
    begin
        //ERROR(Text_0001);
        LeaveApplicationModified := '';
        HumanResourcesSetup.Get;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        HRLeaveApplication.Reset;
        HRLeaveApplication.SetRange(HRLeaveApplication."No.", "LeaveApplicationNo.");
        if HRLeaveApplication.FindFirst then begin
            HRLeaveApplication."Posting Date" := LeaveStartDate;
            //HRLeaveApplication."Employee No.":="EmployeeNo.";
            //HRLeaveApplication.VALIDATE(HRLeaveApplication."Employee No.");
            HRLeaveApplication."Document Name" := DocumentName;
            //check mandatory number of days
            HRLeaveType.Reset;
            HRLeaveType.SetRange(Code, LeaveType);
            HRLeaveType.SetRange("Take as Block", true);
            if HRLeaveType.FindFirst then begin
                if HRLeaveType.Days <> DaysApplied then
                    Error(Text101, Format(HRLeaveType.Days));
            end;
            // End check mandatory number of days
            HRLeaveApplication."Leave Start Date" := LeaveStartDate;
            HRLeaveApplication.Validate(HRLeaveApplication."Leave Start Date");

            HRLeaveApplication."Days Applied" := DaysApplied;
            HRLeaveApplication.Validate(HRLeaveApplication."Days Applied");
            if HRLeaveApplication."Leave Type" <> LeaveType then
                HRLeaveApplication.Validate(HRLeaveApplication."Leave Type", LeaveType);

            HRLeaveApplication."Substitute No." := "SubstituteEmployeeNo.";
            HRLeaveApplication.Validate(HRLeaveApplication."Substitute No.");
            HRLeaveApplication."Reason for Leave" := ReasonForLeave;
            HRLeaveApplication."User ID" := Employee."User ID";
            HRLeaveApplication.Modify;
            LeaveApplicationModified := '200: Leave Application No ' + HRLeaveApplication."No." + ' Modified Successfully';
        end else
            LeaveApplicationModified := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    procedure CheckRunningLeaves("EmployeeNo.": Code[20]; StartDate: Date)
    begin
        HRLeaveApplication.Reset;
        HRLeaveApplication.SetRange("Employee No.", "EmployeeNo.");
        HRLeaveApplication.SetRange(Posted, true);
        if HRLeaveApplication.FindSet then begin
            repeat
                if (StartDate <= HRLeaveApplication."Leave End Date") then
                    Error(Text_0001);
            until HRLeaveApplication.Next = 0;
        end;
    end;

    [Scope('Personalization')]
    procedure GetLeaveEndDate("EmployeeNo.": Code[20]; LeaveType: Code[50]; LeaveStartDate: Date; DaysApplied: Integer) LeaveEndDate: Date
    var
        LeaveStartDateD: Date;
    begin
        LeaveEndDate := 0D;
        //EVALUATE(LeaveStartDateD,LeaveStartDate);
        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            LeaveEndDate := HRLeaveMgmt.CalculateLeaveEndDate(LeaveType, '', LeaveStartDate, DaysApplied, Employee."Leave Calendar");
            //MESSAGE(FORMAT(LeaveEndDate));
        end;
    end;

    [Scope('Personalization')]
    procedure GetLeaveReturnDate("EmployeeNo.": Code[20]; LeaveType: Code[50]; LeaveStartDate: Date; DaysApplied: Integer) LeaveReturnDate: Date
    begin
        LeaveReturnDate := 0D;

        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            LeaveReturnDate := HRLeaveMgmt.CalculateLeaveReturnDate(LeaveType, '',
                                                                  HRLeaveMgmt.CalculateLeaveEndDate(LeaveType, '', LeaveStartDate, DaysApplied,
                                                                  Employee."Leave Calendar"), Employee."Leave Calendar");
        end;
    end;

    procedure GetOpenLeaveApplication("EmployeeNo.": Code[20]) "OpenLeaveApplicationNo.": Code[20]
    begin
        "OpenLeaveApplicationNo." := '';
        HRLeaveApplication.Reset;
        HRLeaveApplication.SetRange(HRLeaveApplication."Employee No.", "EmployeeNo.");
        HRLeaveApplication.SetRange(HRLeaveApplication.Status, HRLeaveApplication.Status::Open);
        if HRLeaveApplication.FindLast then begin
            "OpenLeaveApplicationNo." := HRLeaveApplication."No.";
        end;
    end;

    [Scope('Personalization')]
    procedure GetLeaveApplicationStatus("LeaveApplicationNo.": Code[20]) LeaveApplicationStatus: Text
    begin
        LeaveApplicationStatus := '';
        HRLeaveApplication.Reset;
        HRLeaveApplication.SetRange(HRLeaveApplication."No.", "LeaveApplicationNo.");
        if HRLeaveApplication.FindFirst then begin
            LeaveApplicationStatus := Format(HRLeaveApplication.Status);
        end;
    end;

    [Scope('Personalization')]
    procedure CheckLeaveApplicationApprovalWorkflowEnabled("HRLeaveApplicationNo.": Code[20]) ApprovalWorkflowEnabled: Boolean
    begin
        ApprovalWorkflowEnabled := false;

        HRLeaveApplication.Reset;
        if HRLeaveApplication.Get("HRLeaveApplicationNo.") then
            ApprovalWorkflowEnabled := ApprovalsMgmt.CheckHRLeaveApplicationApprovalsWorkflowEnabled(HRLeaveApplication);
    end;

    [Scope('Personalization')]
    procedure SendLeaveApplicationApprovalRequest("HRLeaveApplicationNo.": Code[20]) LeaveApplicationApprovalRequestSent: Text
    begin
        LeaveApplicationApprovalRequestSent := '';

        HRLeaveApplication.Reset;
        if HRLeaveApplication.Get("HRLeaveApplicationNo.") then begin
            // //HRLeaveApplication.VALIDATE(HRLeaveApplication."Leave Start Date");
            // Month := Date2DMY(HRLeaveApplication."Leave Start Date", 2);
            // if Month = 12 then begin
            //     Error('RESTRICTED YOU CANNOT PROCEED FOR LEAVE IN DECEMBER');
            // end;
            if ApprovalsMgmt.CheckHRLeaveApplicationApprovalsWorkflowEnabled(HRLeaveApplication) then
                ApprovalsMgmt.OnSendHRLeaveApplicationForApproval(HRLeaveApplication);
            //ApprovalsMgmt.OnSendHRLeaveApplicationForApproval(HRLeaveApplication);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", HRLeaveApplication."No.");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst then
                LeaveApplicationApprovalRequestSent := '200: Leave Approval Request sent Successfully '
            else
                LeaveApplicationApprovalRequestSent := '400:' + GetLastErrorCode + '-' + GetLastErrorText;

        end;
    end;

    [Scope('Personalization')]
    procedure CancelLeaveApplicationApprovalRequest("LeaveApplicationNo.": Code[20]) LeaveApplicationApprovalRequestCanceled: Text
    begin
        LeaveApplicationApprovalRequestCanceled := '';

        HRLeaveApplication.Reset;
        if HRLeaveApplication.Get("LeaveApplicationNo.") then begin
            ApprovalsMgmt.OnCancelHRLeaveApplicationApprovalRequest(HRLeaveApplication);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", HRLeaveApplication."No.");
            if ApprovalEntry.FindLast then begin
                if ApprovalEntry.FindFirst then
                    LeaveApplicationApprovalRequestCanceled := '200: Leave Approval Request Cancelled Successfully '
                else
                    LeaveApplicationApprovalRequestCanceled := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
            end;
        end;
    end;

    [Scope('Personalization')]
    procedure ReopenLeaveApplication("LeaveApplicationNo.": Code[20]) LeaveApplicationOpened: Boolean
    begin
        LeaveApplicationOpened := false;

        HRLeaveApplication.Reset;
        HRLeaveApplication.SetRange(HRLeaveApplication."No.", "LeaveApplicationNo.");
        if HRLeaveApplication.FindFirst then begin
            HRApprovalManager.ReOpenHRLeaveApplication(HRLeaveApplication);
            LeaveApplicationOpened := true;
        end;
    end;

    [Scope('Personalization')]
    procedure ApproveLeaveApplication("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]) Approved: Text
    var
        "EntryNo.": Integer;
    begin

        Approved := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.ApproveApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);

        if ApprovalEntry.FindFirst then
            Approved := '200: Leave Approved Successfully '
        else
            Approved := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure RejectLeaveApplication("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]; RejectionComments: Text) Rejected: Text
    var
        "EntryNo.": Integer;
    begin
        Rejected := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry."Rejection Comments" := RejectionComments;
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.RejectApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Rejected);
        if ApprovalEntry.FindFirst then
            Rejected := '200: Leave Rejected Successfully '
        else
            Rejected := '400:' + GetLastErrorCode + '-' + GetLastErrorText;


        //**************************************** HR Leave Reimbursement ********************************************************************************************************************************************************
    end;

    [Scope('Personalization')]
    procedure GetEmployeeLeaveBalance(EmployeeNo: Code[20]; LeaveType: Code[50]) LeaveBalance: Decimal
    var
        LeaveLedgerEntries: Record "HR Leave Ledger Entries";
        LeavePeriods: Record "HR Leave Periods";
        LeaveYear: Integer;
    begin
        //Calculate Leave Balance
        LeavePeriods.Reset;
        LeavePeriods.SetRange(Closed, false);
        if LeavePeriods.FindFirst then
            LeaveYear := LeavePeriods."Leave Year";

        LeaveLedgerEntries.Reset;
        LeaveLedgerEntries.SetRange(LeaveLedgerEntries."Employee No.", EmployeeNo);
        LeaveLedgerEntries.SetRange(LeaveLedgerEntries."Leave Type", LeaveType);
        //LeaveLedgerEntries.SETRANGE("Leave Year 2",LeaveYear);
        LeaveLedgerEntries.SetRange("Leave Period", LeavePeriods.Code);
        LeaveLedgerEntries.CalcSums(LeaveLedgerEntries.Days);
        LeaveBalance := LeaveLedgerEntries.Days;
    end;

    procedure CheckLeaveReimbursementExists(LeaveReimbursementNo: Code[20]; "EmployeeNo.": Code[20]) LeaveReimbursementExist: Boolean
    begin
        LeaveReimbursementExist := false;
        HRLeaveReimbursement.Reset;
        HRLeaveReimbursement.SetRange(HRLeaveReimbursement."Employee No.", "EmployeeNo.");
        HRLeaveReimbursement.SetRange(HRLeaveReimbursement."No.", LeaveReimbursementNo);
        if HRLeaveReimbursement.FindFirst then begin
            LeaveReimbursementExist := true;
        end;
    end;

    procedure CreateLeaveReimbursement("EmployeeNo.": Code[20]) LeaveReimbursementCreated: Boolean
    var
        "DocNo.": Code[30];
    begin
        LeaveReimbursementCreated := false;

        HumanResourcesSetup.Get;

        "DocNo." := NoSeriesMgt.GetNextNo(HumanResourcesSetup."Leave Reimbursement Nos.", 0D, true);
        if "DocNo." <> '' then begin
            HRLeaveReimbursement.Reset;
            HRLeaveReimbursement."No." := "DocNo.";
            HRLeaveReimbursement."Document Date" := Today;
            HRLeaveReimbursement."Employee No." := "EmployeeNo.";
            HRLeaveReimbursement.Validate(HRLeaveReimbursement."Employee No.");
            if HRLeaveReimbursement.Insert then begin
                LeaveReimbursementCreated := true;
            end;
        end;
    end;

    procedure GetLeaveReimbursementNo("EmployeeNo.": Code[20]) "OpenLeaveReimbursementNo.": Code[20]
    begin
        "OpenLeaveReimbursementNo." := '';
        HRLeaveReimbursement.Reset;
        HRLeaveReimbursement.SetRange(HRLeaveReimbursement."Employee No.", "EmployeeNo.");
        HRLeaveReimbursement.SetRange(HRLeaveReimbursement.Status, HRLeaveReimbursement.Status::Open);
        if HRLeaveReimbursement.FindLast then begin
            "OpenLeaveReimbursementNo." := HRLeaveReimbursement."No.";
        end;
    end;

    procedure ModifyLeaveReimbursement("LeaveReimbursementNo.": Code[20]; "EmployeeNo.": Code[20]; "LeaveApplicationNo.": Code[20]; ActualReturnDate: Date; ReasonForReimbursement: Text[250]) LeaveReimbursementModified: Boolean
    begin
        LeaveReimbursementModified := false;
        HRLeaveReimbursement.Reset;
        HRLeaveReimbursement.SetRange(HRLeaveReimbursement."No.", "LeaveReimbursementNo.");
        if HRLeaveReimbursement.FindFirst then begin
            HRLeaveReimbursement."Document Date" := Today;
            HRLeaveReimbursement."Posting Date" := Today;
            HRLeaveReimbursement."Leave Application No." := "LeaveApplicationNo.";
            HRLeaveReimbursement.Validate(HRLeaveReimbursement."Leave Application No.");
            HRLeaveReimbursement."Actual Return Date" := ActualReturnDate;
            HRLeaveReimbursement.Validate(HRLeaveReimbursement."Actual Return Date");
            HRLeaveReimbursement."Reason for Reimbursement" := ReasonForReimbursement;
            if HRLeaveReimbursement.Modify then
                LeaveReimbursementModified := true;
        end;
    end;

    procedure GetLeaveReimbursementStatus("LeaveReimbursementNo.": Code[20]) LeaveReimbursementStatus: Text
    begin
        LeaveReimbursementStatus := '';
        HRLeaveReimbursement.Reset;
        HRLeaveReimbursement.SetRange(HRLeaveReimbursement."No.", "LeaveReimbursementNo.");
        if HRLeaveReimbursement.FindFirst then begin
            LeaveReimbursementStatus := Format(HRLeaveReimbursement.Status);
        end;
    end;

    procedure CheckLeaveReimbursementApprovalWorkflowEnabled("HRLeaveReimbursementNo.": Code[20]) ApprovalWorkflowEnabled: Boolean
    begin
        ApprovalWorkflowEnabled := false;
        HRLeaveReimbursement.Reset;
        if HRLeaveReimbursement.Get("HRLeaveReimbursementNo.") then
            ApprovalWorkflowEnabled := ApprovalsMgmt.CheckHRLeaveReimbusmentApprovalsWorkflowEnabled(HRLeaveReimbursement);
    end;

    procedure SendLeaveReimbursementApprovalRequest("HRLeaveReimbursementNo.": Code[20]) LeaveReimbursementApprovalRequestSent: Boolean
    begin
        LeaveReimbursementApprovalRequestSent := false;

        HRLeaveReimbursement.Reset;
        if HRLeaveReimbursement.Get("HRLeaveReimbursementNo.") then begin
            ApprovalsMgmt.OnSendHRLeaveReimbusmentForApproval(HRLeaveReimbursement);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", HRLeaveReimbursement."No.");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst then
                LeaveReimbursementApprovalRequestSent := true;
        end;
    end;

    procedure CancelLeaveReimbursementApprovalRequest("LeaveReimbursementNo.": Code[20]) LeaveReimbursementApprovalRequestCanceled: Boolean
    begin
        LeaveReimbursementApprovalRequestCanceled := false;

        HRLeaveReimbursement.Reset;
        if HRLeaveReimbursement.Get("LeaveReimbursementNo.") then begin
            ApprovalsMgmt.OnCancelHRLeaveReimbusmentApprovalRequest(HRLeaveReimbursement);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", HRLeaveReimbursement."No.");
            if ApprovalEntry.FindLast then begin
                if ApprovalEntry.Status = ApprovalEntry.Status::Canceled then
                    LeaveReimbursementApprovalRequestCanceled := true;
            end;
        end;

        //**************************************************** HR Employee Target Setting && Appraisal *****************************************************************************************************************************************************
    end;

    procedure CheckOpenTrainingNeedApplicationExists("EmployeeNo.": Code[20]) OpenTrainingNeedApplicationExist: Boolean
    begin
        OpenTrainingNeedApplicationExist := false;
        HRTrainingNeedsHeader.Reset;
        HRTrainingNeedsHeader.SetRange(HRTrainingNeedsHeader."Employee No.", "EmployeeNo.");
        HRTrainingNeedsHeader.SetRange(HRTrainingNeedsHeader.Status, HRTrainingNeedsHeader.Status::Open);
        if HRTrainingNeedsHeader.FindFirst then begin
            OpenTrainingNeedApplicationExist := true;
        end;
    end;

    procedure CheckTrainingNeedApplicationExists("TrainingNeedApplicationNo.": Code[20]; "EmployeeNo.": Code[20]) TrainingNeedApplicationExist: Boolean
    begin
        TrainingNeedApplicationExist := false;
        HRTrainingNeedsHeader.Reset;
        HRTrainingNeedsHeader.SetRange(HRTrainingNeedsHeader."Employee No.", "EmployeeNo.");
        HRTrainingNeedsHeader.SetRange(HRTrainingNeedsHeader."No.", "TrainingNeedApplicationNo.");
        if HRTrainingNeedsHeader.FindFirst then begin
            TrainingNeedApplicationExist := true;
        end;
    end;

    procedure CreateTrainingNeedApplication("EmployeeNo.": Code[20]) TrainingNeedApplicationCreated: Boolean
    begin
        TrainingNeedApplicationCreated := false;

        HumanResourcesSetup.Get;

        HRTrainingNeedsHeader.Init;
        HRTrainingNeedsHeader."No." := NoSeriesMgt.GetNextNo(HumanResourcesSetup."Training Needs Nos", 0D, true);
        HRTrainingNeedsHeader."Date of Request" := Today;
        HRTrainingNeedsHeader."Employee No." := "EmployeeNo.";
        HRTrainingNeedsHeader.Validate(HRTrainingNeedsHeader."Employee No.");
        if HRTrainingNeedsHeader.Insert then begin
            TrainingNeedApplicationCreated := true;
        end;
    end;

    procedure GetTrainingNeedApplicationNo("EmployeeNo.": Code[20]) "OpenTrainingNeedApplicationNo.": Code[20]
    begin
        "OpenTrainingNeedApplicationNo." := '';
        HRTrainingNeedsHeader.Reset;
        HRTrainingNeedsHeader.SetRange(HRTrainingNeedsHeader."Employee No.", "EmployeeNo.");
        HRTrainingNeedsHeader.SetRange(HRTrainingNeedsHeader.Status, HRTrainingNeedsHeader.Status::Open);
        if HRTrainingNeedsHeader.FindFirst then begin
            "OpenTrainingNeedApplicationNo." := HRTrainingNeedsHeader."No.";
        end;
    end;

    procedure CreateTrainingNeedsApplicationLine(EmployeeNo: Code[20]; DevelopmentNeeds: Text[100]; InterventionRequired: Text[100]; Objectives: Text[100]; ProposedTrainingProvider: Code[20]; "Location&Venue": Text[100]; ProposedPeriod: Option " ",Q1,Q2,Q3,Q4; Description: Text[250]; TrainingScheduleFrom: Date; TrainingScheduleTo: Date; EstimatedCost: Decimal) HRTrainingNeedsApplicationLineCreated: Boolean
    begin
        HRTrainingNeedsApplicationLineCreated := false;

        HRTrainingNeedsHeader.Reset;
        HRTrainingNeedsHeader.SetRange(HRTrainingNeedsHeader."Employee No.", EmployeeNo);
        HRTrainingNeedsHeader.SetRange(HRTrainingNeedsHeader.Status, HRTrainingNeedsHeader.Status::Open);

        if HRTrainingNeedsHeader.FindFirst then begin
            HRTrainingNeedsLine.Init;
            HRTrainingNeedsLine."No." := HRTrainingNeedsHeader."No.";
            HRTrainingNeedsLine."Employee No." := HRTrainingNeedsHeader."Employee No.";
            HRTrainingNeedsLine.Validate(HRTrainingNeedsLine."Employee No.");
            HRTrainingNeedsLine."Development Needs" := DevelopmentNeeds;
            HRTrainingNeedsLine.Objectives := Objectives;
            HRTrainingNeedsLine."Proposed Training Provider" := ProposedTrainingProvider;
            HRTrainingNeedsLine."Training Location & Venue" := "Location&Venue";
            HRTrainingNeedsLine."Proposed Period" := ProposedPeriod;
            HRTrainingNeedsLine.Description := Description;
            HRTrainingNeedsLine."Training Scheduled Date" := TrainingScheduleFrom;
            HRTrainingNeedsLine."Training Scheduled Date To" := TrainingScheduleTo;
            HRTrainingNeedsLine."Estimated Cost" := EstimatedCost;

            case InterventionRequired of
                'Training':
                    HRTrainingNeedsLine."Intervention Required" := HRTrainingNeedsLine."Intervention Required"::Training;
                'Coaching':
                    HRTrainingNeedsLine."Intervention Required" := HRTrainingNeedsLine."Intervention Required"::Coaching;
                'Mentoring':
                    HRTrainingNeedsLine."Intervention Required" := HRTrainingNeedsLine."Intervention Required"::Mentoring;
                'Other':
                    HRTrainingNeedsLine."Intervention Required" := HRTrainingNeedsLine."Intervention Required"::Other;
            end;

            if HRTrainingNeedsLine.Insert then begin
                HRTrainingNeedsApplicationLineCreated := true;
            end;
        end;
    end;

    procedure ModifyTrainingNeedApplication("TrainingNeedApplicationNo.": Code[20]; "Employee No.": Code[20]; CalendarYear: Code[50]; AppraisalPeriod: Code[50]) TrainingNeedApplicationModified: Boolean
    begin
        TrainingNeedApplicationModified := false;

        HRTrainingNeedsHeader.Reset;
        HRTrainingNeedsHeader.SetRange(HRTrainingNeedsHeader."Employee No.", "Employee No.");
        HRTrainingNeedsHeader.SetRange(HRTrainingNeedsHeader."No.", "TrainingNeedApplicationNo.");

        if HRTrainingNeedsHeader.FindFirst then begin

            HRTrainingNeedsHeader."Date of Request" := Today;
            HRTrainingNeedsHeader."Calendar Year" := CalendarYear;
            HRTrainingNeedsHeader."Appraisal Period" := UpperCase('Recommended Training for Appraisal Period ') + AppraisalPeriod;
            HRTrainingNeedsHeader.Modify;

            TrainingNeedApplicationModified := true;

        end;
    end;

    procedure ModifyTrainingNeedsApplicationLine(LineNo: Integer; "TrainingNeedApplicationNo.": Code[20]; EmployeeNo: Code[20]; DevelopmentNeeds: Text[100]; InterventionRequired: Text[100]; Objectives: Text[100]; ProposedTrainingProvider: Code[20]; "Location&Venue": Text[100]; ProposedPeriod: Option " ",Q1,Q2,Q3,Q4; Description: Text[250]; TrainingScheduleFrom: Date; TrainingScheduleTo: Date; EstimatedCost: Decimal) HRTrainingNeedsApplicationModified: Boolean
    begin
        HRTrainingNeedsApplicationModified := false;

        HRTrainingNeedsLine.Reset;

        HRTrainingNeedsLine.SetRange(HRTrainingNeedsLine."Line No.", LineNo);
        HRTrainingNeedsLine.SetRange("No.", "TrainingNeedApplicationNo.");

        if HRTrainingNeedsLine.FindFirst then begin
            HRTrainingNeedsLine."Development Needs" := DevelopmentNeeds;
            HRTrainingNeedsLine.Objectives := Objectives;
            HRTrainingNeedsLine."Proposed Training Provider" := ProposedTrainingProvider;
            HRTrainingNeedsLine."Training Location & Venue" := "Location&Venue";
            HRTrainingNeedsLine."Proposed Period" := ProposedPeriod;
            HRTrainingNeedsLine.Description := Description;
            HRTrainingNeedsLine."Training Scheduled Date" := TrainingScheduleFrom;
            HRTrainingNeedsLine."Training Scheduled Date To" := TrainingScheduleTo;
            HRTrainingNeedsLine."Estimated Cost" := EstimatedCost;

            case InterventionRequired of
                'Training':
                    HRTrainingNeedsLine."Intervention Required" := HRTrainingNeedsLine."Intervention Required"::Coaching;
                'Coaching':
                    HRTrainingNeedsLine."Intervention Required" := HRTrainingNeedsLine."Intervention Required"::Coaching;
                'Mentoring':
                    HRTrainingNeedsLine."Intervention Required" := HRTrainingNeedsLine."Intervention Required"::Mentoring;
                'Other':
                    HRTrainingNeedsLine."Intervention Required" := HRTrainingNeedsLine."Intervention Required"::Other;
            end;

            if HRTrainingNeedsLine.Modify then begin
                HRTrainingNeedsApplicationModified := true;
            end;
        end;
    end;

    procedure GetTrainingNeedApplicationStatus("TrainingNeedApplicationNo.": Code[20]) TrainingNeedApplicationStatus: Text
    begin
        TrainingNeedApplicationStatus := '';
        HRTrainingNeedsHeader.Reset;
        HRTrainingNeedsHeader.SetRange(HRTrainingNeedsHeader."No.", "TrainingNeedApplicationNo.");
        if HRTrainingNeedsHeader.FindFirst then begin
            TrainingNeedApplicationStatus := Format(HRTrainingNeedsHeader.Status);
        end;
    end;

    procedure CheckTrainingNeedsApplicationLinesExist("TrainingNeedApplicationNo.": Code[20]) TrainingNeedApplicationLinesExist: Boolean
    begin
        TrainingNeedApplicationLinesExist := false;
        HRTrainingNeedsLine.Reset;
        HRTrainingNeedsLine.SetRange(HRTrainingNeedsLine."No.", "TrainingNeedApplicationNo.");
        if HRTrainingNeedsLine.FindFirst then begin
            TrainingNeedApplicationLinesExist := true;
        end;
    end;

    procedure DeleteTrainingNeedsApplicationLine("LineNo.": Integer; "TrainingNeedApplicationNo.": Code[20]) HRTrainingNeedsApplicationLineDeleted: Boolean
    begin
        HRTrainingNeedsApplicationLineDeleted := false;

        HRTrainingNeedsLine.Reset;

        HRTrainingNeedsLine.SetRange(HRTrainingNeedsLine."Line No.", "LineNo.");
        HRTrainingNeedsLine.SetRange(HRTrainingNeedsLine."No.", "TrainingNeedApplicationNo.");

        if HRTrainingNeedsLine.FindFirst then begin
            if HRTrainingNeedsLine.Delete then begin
                HRTrainingNeedsApplicationLineDeleted := true;
            end;
        end;

        //************************************************** HR Training Need Application Workflows *********************************************************************************************************
    end;

    procedure CheckTrainingNeedApplicationApprovalWorkflowEnabled("TrainingNeedApplicationNo.": Code[20]) ApprovalWorkflowEnabled: Boolean
    begin
        ApprovalWorkflowEnabled := false;

        HRTrainingNeedsHeader.Reset;
        if HRTrainingNeedsHeader.Get("TrainingNeedApplicationNo.") then
            ApprovalWorkflowEnabled := ApprovalsMgmt.CheckHrTrainingNeedsHeaderApprovalsWorkflowEnabled(HRTrainingNeedsHeader);
    end;

    procedure SendTrainingNeedApplicationApprovalRequest("TrainingNeedApplicationNo.": Code[20]) TrainingNeedApplicationApprovalRequestSent: Boolean
    begin
        TrainingNeedApplicationApprovalRequestSent := false;

        HRTrainingNeedsHeader.Reset;
        if HRTrainingNeedsHeader.Get("TrainingNeedApplicationNo.") then begin
            ApprovalsMgmt.OnSendHRTrainingNeedsHeaderForApproval(HRTrainingNeedsHeader);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", HRTrainingNeedsHeader."No.");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst then
                TrainingNeedApplicationApprovalRequestSent := true;
        end;
    end;

    procedure CancelTrainingNeedApplicationnApprovalRequest("TrainingNeedApplicationNo.": Code[20]) TrainingNeedApplicationApprovalRequestCanceled: Boolean
    begin
        TrainingNeedApplicationApprovalRequestCanceled := false;

        HRTrainingNeedsHeader.Reset;
        if HRTrainingNeedsHeader.Get("TrainingNeedApplicationNo.") then begin
            //ApprovalsMgmt.OnCancelHRTrainingNeedsHeaderApprovalRequest(HRTrainingNeedsHeader);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", HRTrainingNeedsHeader."No.");
            if ApprovalEntry.FindLast then begin
                if ApprovalEntry.Status = ApprovalEntry.Status::Canceled then
                    TrainingNeedApplicationApprovalRequestCanceled := true;
            end;
        end;

        //******************************************* HR Training Application ********************************************************************************************************************************************
    end;

    procedure CheckOpenTrainingApplicationExists("EmployeeNo.": Code[20]) OpenTrainingApplicationExist: Boolean
    begin
        OpenTrainingApplicationExist := false;
        HRTrainingApplication.Reset;
        HRTrainingApplication.SetRange(HRTrainingApplication."Employee No.", "EmployeeNo.");
        if HRTrainingApplication.FindFirst then begin
            //if (HRTrainingApplication.Status=HRTrainingApplication.Status::Open) or (HRTrainingApplication.Status=HRTrainingApplication.Status::"Pending Approval") or (HRTrainingApplication.Status=HRTrainingApplication.Status::"3") then
            OpenTrainingApplicationExist := true;
        end;
    end;

    procedure CheckTrainingApplicationExists("TrainingApplicationNo.": Code[20]; "EmployeeNo.": Code[20]) TrainingApplicationExist: Boolean
    begin
        TrainingApplicationExist := false;
        HRTrainingApplication.Reset;
        HRTrainingApplication.SetRange(HRTrainingApplication."Employee No.", "EmployeeNo.");
        HRTrainingApplication.SetRange(HRTrainingApplication."Application No.", "TrainingApplicationNo.");
        if HRLeaveApplication.FindFirst then begin
            TrainingApplicationExist := true;
        end;
    end;

    procedure CreateTrainingApplication("EmployeeNo.": Code[20]; TrainingType: Text[100]; Description: Text[250]; TrainingCalendarYear: Code[30]; TrainingNeedNo: Text[250]; StartDate: Date; EndDate: Date; Provider: Text[100]; "Objective/Purpose": Text[250]) TrainingApplicationCreated: Boolean
    begin
        TrainingApplicationCreated := false;

        HumanResourcesSetup.Get;

        //check if submitted
        HRTrainingApplication.Reset;
        HRTrainingApplication.SetRange(HRTrainingApplication."Employee No.", "EmployeeNo.");
        HRTrainingApplication.SetRange(HRTrainingApplication."Evaluation Submitted", false);
        if HRTrainingApplication.FindFirst then
            Error(TrainingApplicationError);

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        HRTrainingApplication.Init;
        HRTrainingApplication."Application No." := NoSeriesMgt.GetNextNo(HumanResourcesSetup."Training Application Nos", 0D, true);
        HRTrainingApplication."Document Date" := Today;
        HRTrainingApplication."Employee No." := "EmployeeNo.";
        HRTrainingApplication.Validate(HRTrainingApplication."Employee No.");
        HRTrainingApplication."No." := HRTrainingApplication."Employee No.";
        HRTrainingApplication.Name := HRTrainingApplication."Employee Name";
        case TrainingType of
            'Group Training':
                HRTrainingApplication."Type of Training" := HRTrainingApplication."Type of Training"::"Group Training";
            'Individual Training':
                HRTrainingApplication."Type of Training" := HRTrainingApplication."Type of Training"::"Individual Training";
        end;
        HRTrainingApplication.Description := Description;
        HRTrainingApplication."Calendar Year" := TrainingCalendarYear;
        HRTrainingApplication."Training Need No." := TrainingNeedNo;
        HRTrainingApplication.Validate(HRTrainingApplication."Training Need No.");
        HRTrainingApplication."From Date" := StartDate;
        HRTrainingApplication."To Date" := EndDate;
        HRTrainingApplication.Validate("To Date");
        HRTrainingApplication."Provider Name" := Provider;
        HRTrainingApplication."Purpose of Training" := "Objective/Purpose";
        HRTrainingApplication."User ID" := Employee."User ID";
        if HRTrainingApplication.Insert then begin
            TrainingApplicationCreated := true;
            CheckTrainingApplicationApprovalWorkflowEnabled(HRTrainingApplication."Application No.");
            SendTrainingApplicationApprovalRequest(HRTrainingApplication."Application No.");
        end;
    end;

    procedure GetOpenTrainingApplication("EmployeeNo.": Code[20]) "OpenTrainingApplicationNo.": Code[20]
    begin
        "OpenTrainingApplicationNo." := '';
        HRTrainingApplication.Reset;
        HRTrainingApplication.SetRange(HRTrainingApplication."Employee No.", "EmployeeNo.");
        HRTrainingApplication.SetRange(HRTrainingApplication.Status, HRTrainingApplication.Status::Open);
        if HRTrainingApplication.FindLast then begin
            "OpenTrainingApplicationNo." := HRTrainingApplication."Application No.";
        end;
    end;

    procedure GetTrainingApplicationStatus("TrainingApplicationNo.": Code[20]) TrainingApplicationStatus: Text
    begin
        TrainingApplicationStatus := '';
        HRTrainingApplication.Reset;
        HRTrainingApplication.SetRange(HRTrainingApplication."Application No.", "TrainingApplicationNo.");
        if HRTrainingApplication.FindFirst then begin
            TrainingApplicationStatus := Format(HRTrainingApplication.Status);
        end;
    end;

    procedure ModifyTrainingApplication("EmployeeNo.": Code[30]; "TrainingNo.": Code[20]; TrainingType: Text; Description: Text[250]; TrainingCalendarYear: Code[30]; DevelopmentNeed: Text[250]; StartDate: Date; EndDate: Date; Provider: Text[100]; "Objective/Purpose": Text[250]) TrainingApplicationModified: Boolean
    begin
        TrainingApplicationModified := false;

        HumanResourcesSetup.Get;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        HRTrainingApplication.Reset;
        HRTrainingApplication."No." := NoSeriesMgt.GetNextNo(HumanResourcesSetup."Training Application Nos", 0D, true);
        HRTrainingApplication."Document Date" := Today;
        HRTrainingApplication."Employee No." := "EmployeeNo.";
        HRTrainingApplication.Validate(HRTrainingApplication."Employee No.");
        case TrainingType of
            'Individual Training':
                HRTrainingApplication."Type of Training" := HRTrainingApplication."Type of Training"::"Individual Training";
            'Group Training':
                HRTrainingApplication."Type of Training" := HRTrainingApplication."Type of Training"::"Group Training";
        end;
        HRTrainingApplication.Description := Description;
        HRTrainingApplication."Calendar Year" := TrainingCalendarYear;
        HRTrainingApplication."Development Need" := DevelopmentNeed;
        HRTrainingApplication."From Date" := StartDate;
        HRTrainingApplication."To Date" := EndDate;
        HRTrainingApplication.Validate("To Date");
        HRTrainingApplication."Provider Code" := Provider;
        HRTrainingApplication."Purpose of Training" := "Objective/Purpose";
        HRTrainingApplication."User ID" := Employee."User ID";
        if HRTrainingApplication.Modify then begin
            TrainingApplicationModified := true;
        end;
    end;

    procedure CheckTrainingApplicationApprovalWorkflowEnabled("TrainingApplicationNo.": Code[20]) ApprovalWorkflowEnabled: Boolean
    begin
        ApprovalWorkflowEnabled := false;
        HRTrainingApplication.Reset;
        // if HRTrainingApplication.Get("TrainingApplicationNo.") then
        //   ApprovalWorkflowEnabled:=ApprovalsMgmt.CheckHRTrainingApplicationsHeaderApprovalsWorkflowEnabled(HRTrainingApplication);
    end;

    procedure SendTrainingApplicationApprovalRequest(TrainingApplicationNo: Code[20]) ApprovalRequestSent: Boolean
    begin
        ApprovalRequestSent := false;
        HRTrainingApplication.Reset;
        if HRTrainingApplication.Get(TrainingApplicationNo) then begin
            HRTrainingApplication.Status := HRTrainingApplication.Status::"Pending Approval";
            HRTrainingApplication.Modify;
            ApprovalRequestSent := true;
        end;
    end;

    procedure CancelTrainingApplicationApprovalRequest(TrainingApplicationNo: Code[20]) ApprovalRequestCanceled: Boolean
    begin
        ApprovalRequestCanceled := false;
        HRTrainingApplication.Reset;
        if HRLeaveReimbursement.Get(TrainingApplicationNo) then begin
            ApprovalsMgmt.OnCancelHRTrainingApplicationsHeaderApprovalRequest(HRTrainingApplication);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", HRTrainingApplication."Application No.");
            if ApprovalEntry.FindLast then begin
                if ApprovalEntry.Status = ApprovalEntry.Status::Canceled then
                    ApprovalRequestCanceled := true;
            end;
        end;

        //************************************************ Employee Training Evaluation ************************************************************************************************************************
    end;

    procedure CheckOpenTrainingEvaluationExists("EmployeeNo.": Code[20]) OpenTrainingEvaluationExists: Boolean
    begin
        OpenTrainingEvaluationExists := false;
        HRTrainingEvaluation.Reset;
        HRTrainingEvaluation.SetRange(HRTrainingEvaluation."Employee No.", "EmployeeNo.");
        if (HRTrainingEvaluation.Status = HRTrainingEvaluation.Status::Open) or (HRTrainingEvaluation.Status = HRTrainingEvaluation.Status::"Pending Approval") then begin
            if HRTrainingEvaluation.FindFirst then begin
                OpenTrainingEvaluationExists := true;
            end;
        end;
    end;

    procedure CreateTrainingEvaluation("EmployeeNo.": Code[20]) TrainingEvaluationCreated: Boolean
    var
        HRTrainingEvaluation2: Record "Training Evaluation";
    begin
        TrainingEvaluationCreated := false;
        HumanResourcesSetup.Get;
        Employee.Reset;
        Employee.Get("EmployeeNo.");
        HRTrainingEvaluation.Init;
        HRTrainingEvaluation."Training Evaluation No." := NoSeriesMgt.GetNextNo(HumanResourcesSetup."Employee Evaluation Nos.", 0D, true);
        HRTrainingEvaluation.Date := Today;
        HRTrainingEvaluation."Employee No." := "EmployeeNo.";
        HRTrainingEvaluation.Validate(HRTrainingEvaluation."Employee No.");
        HRTrainingEvaluation."User ID" := Employee."User ID";
        if HRTrainingEvaluation.Insert then begin
            //Insert HR Required Documents
            HRTrainingEvaluation2.Reset;
            HRTrainingEvaluation2.SetRange(HRTrainingEvaluation2."Employee No.", "EmployeeNo.");
            HRTrainingEvaluation2.SetRange(HRTrainingEvaluation2.Status, HRTrainingEvaluation2.Status::Open);
            if HRTrainingEvaluation2.FindFirst then begin
                HRRequiredDocumentChecklist.Reset;
                HRJobLookupValue.Reset;
                HRJobLookupValue.SetRange(HRJobLookupValue.Option, HRJobLookupValue.Option::"Checklist Item");
                HRJobLookupValue.SetRange(HRJobLookupValue."Required Stage", HRJobLookupValue."Required Stage"::"Training Evaluation");
                if HRJobLookupValue.FindSet then begin
                    repeat
                        HRRequiredDocumentChecklist.Init;
                        HRRequiredDocumentChecklist."DocumentNo." := HRTrainingEvaluation2."Training Evaluation No.";
                        HRRequiredDocumentChecklist."Document Code" := HRJobLookupValue.Code;
                        HRRequiredDocumentChecklist."Document Description" := HRJobLookupValue.Description;
                        HRRequiredDocumentChecklist."Document Attached" := false;
                        HRRequiredDocumentChecklist.Insert;
                    until HRJobLookupValue.Next = 0;
                    TrainingEvaluationCreated := true;
                end;
                // MESSAGE(Success);
            end;
        end;
    end;

    procedure GetOpenTrainingEvaluationNo("EmployeeNo.": Code[20]) "EvaluationNo.": Code[20]
    begin
        "EvaluationNo." := '';
        HRTrainingEvaluation.Reset;
        HRTrainingEvaluation.SetRange(HRTrainingEvaluation."Employee No.", "EmployeeNo.");
        HRTrainingEvaluation.SetRange(HRTrainingEvaluation.Status, HRTrainingEvaluation.Status::Open);
        if HRTrainingEvaluation.FindFirst then begin
            "EvaluationNo." := HRTrainingEvaluation."Training Evaluation No.";
            CheckTrainingEvaluationnApprovalWorkflowEnabled("EvaluationNo.");
            SendTrainingEvaluationApprovalRequest("EvaluationNo.");
        end;
    end;

    procedure ModifyTrainingEvaluation("EmployeeNo.": Code[20]; "EvaluationNo.": Code[20]; "ApplicationNo.": Code[20]; Comments: Text[250]) TrainingEvaluationModified: Boolean
    begin
        TrainingEvaluationModified := false;
        Employee.Reset;
        Employee.Get("EmployeeNo.");
        HRTrainingEvaluation.Init;
        HRTrainingEvaluation."Training Evaluation No." := "EvaluationNo.";
        HRTrainingEvaluation.Date := Today;
        HRTrainingEvaluation."Employee No." := "EmployeeNo.";
        HRTrainingEvaluation.Validate(HRTrainingEvaluation."Employee No.");
        HRTrainingEvaluation."Training Application no." := "ApplicationNo.";
        HRTrainingEvaluation.Validate(HRTrainingEvaluation."Training Application no.");
        HRTrainingEvaluation."General Comments from Training" := Comments;
        HRTrainingEvaluation."User ID" := Employee."User ID";
        if HRTrainingEvaluation.Modify then begin
            TrainingEvaluationModified := true;
            CheckTrainingEvaluationnApprovalWorkflowEnabled("EvaluationNo.");
            SendTrainingEvaluationApprovalRequest("EvaluationNo.");
        end;
    end;

    procedure CheckTrainingEvaluationnApprovalWorkflowEnabled("TrainingEvaluationNo.": Code[20]) ApprovalWorkflowEnabled: Boolean
    begin
        ApprovalWorkflowEnabled := false;
        HRTrainingEvaluation.Reset;
        // if HRTrainingEvaluation.Get("TrainingEvaluationNo.") then
        //   ApprovalWorkflowEnabled:=ApprovalsMgmt.CheckTrainingEvaluationApprovalsWorkflowEnabled(HRTrainingEvaluation);
    end;

    procedure SendTrainingEvaluationApprovalRequest("TrainingEvaluationNo.": Code[20]) ApprovalRequestSent: Boolean
    begin
        ApprovalRequestSent := false;
        HRTrainingEvaluation.Reset;
        if HRTrainingEvaluation.Get("TrainingEvaluationNo.") then begin
            //HRTrainingEvaluation.Status:=HRTrainingEvaluation.Status::"3";
            HRTrainingEvaluation.Modify;
            ApprovalRequestSent := true;
        end;
    end;

    procedure ModifyHRRequiredDocumentLocalURL("DocumentNo.": Code[20]; DocumentCode: Code[50]; LocalURL: Text[250]) RequiredDocumentModified: Boolean
    var
        HRRequiredDocumentChecklist: Record "HR Required Document Checklist";
    begin
        RequiredDocumentModified := false;
        HRRequiredDocumentChecklist.Reset;
        HRRequiredDocumentChecklist.SetRange(HRRequiredDocumentChecklist."DocumentNo.", "DocumentNo.");
        HRRequiredDocumentChecklist.SetRange(HRRequiredDocumentChecklist."Document Code", DocumentCode);
        if HRRequiredDocumentChecklist.FindFirst then begin
            HRRequiredDocumentChecklist."Local File URL" := LocalURL;
            HRRequiredDocumentChecklist."Document Attached" := true;
            if HRRequiredDocumentChecklist.Modify then
                RequiredDocumentModified := true;
        end;
    end;

    procedure ModifyHRRequiredDocumentSharePointURL("DocumentNo.": Code[20]; DocumentCode: Code[50]; SharePointURL: Text[250]) HRRequiredDocumentModified: Boolean
    var
        HRRequiredDocumentChecklist: Record "HR Required Document Checklist";
    begin
        HRRequiredDocumentModified := false;
        HRRequiredDocumentChecklist.Reset;
        HRRequiredDocumentChecklist.SetRange(HRRequiredDocumentChecklist."DocumentNo.", "DocumentNo.");
        HRRequiredDocumentChecklist.SetRange(HRRequiredDocumentChecklist."Document Code", DocumentCode);
        if HRRequiredDocumentChecklist.FindFirst then begin
            HRRequiredDocumentChecklist."SharePoint URL" := SharePointURL;
            HRRequiredDocumentChecklist."Document Attached" := true;
            if HRRequiredDocumentChecklist.Modify then
                HRRequiredDocumentModified := true;
        end;
    end;

    procedure CheckHRRequiredDocumentsAttached("DocumentNo.": Code[20]) HRRequiredDocumentsAttached: Boolean
    var
        HRRequiredDocumentChecklist: Record "HR Required Document Checklist";
        Error0001: Label '%1 must be attached.';
    begin
        HRRequiredDocumentsAttached := false;
        HRRequiredDocumentChecklist.Reset;
        HRRequiredDocumentChecklist.SetRange(HRRequiredDocumentChecklist."DocumentNo.", "DocumentNo.");
        if HRRequiredDocumentChecklist.FindSet then begin
            repeat
                if HRRequiredDocumentChecklist."Local File URL" = '' then
                    Error(Error0001, HRRequiredDocumentChecklist."Document Description");
            until HRRequiredDocumentChecklist.Next = 0;
            HRRequiredDocumentsAttached := true;
        end;
    end;

    procedure DeleteHRRequiredDocuments("DocumentNo.": Code[20]) RequiredDocumentsDeleted: Boolean
    var
        HRRequiredDocumentChecklist: Record "HR Required Document Checklist";
    begin
        RequiredDocumentsDeleted := false;

        HRRequiredDocumentChecklist.Reset;
        HRRequiredDocumentChecklist.SetRange(HRRequiredDocumentChecklist."DocumentNo.", "DocumentNo.");
        if HRRequiredDocumentChecklist.FindSet then begin
            HRRequiredDocumentChecklist.DeleteAll;
            RequiredDocumentsDeleted := true;
        end;
    end;

    [Scope('Personalization')]
    procedure GetEmployeeLeaveApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; EmployeeNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::Leave);
        if EmployeeNo <> '' then begin
            Employee.Get(EmployeeNo);
            Employee.TestField("User ID");
            ApprovalEntry.SetRange("Approver ID", Employee."User ID");
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetLeaveApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; LeaveNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::Leave);
        if LeaveNo <> '' then begin
            ApprovalEntry.SetRange("Document No.", LeaveNo);
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetPeriods(var GetPayrollPeriods: XMLport GetPayrollPeriods; EmployeeNo: Code[20])
    var
        Employee: Record Employee;
        Periods: Record Periods;
    begin
        Employee.Get(EmployeeNo);
        Periods.Reset;
        Periods.SetFilter(Status, '=%1|%2', Periods.Status::Open, Periods.Status::Posted);
        Periods.SetRange("Approval Status", Periods."Approval Status"::Approved);
        Periods.SetRange("Enable Payslip", true);
        Periods.SetRange("Payroll Code", Employee."Payroll Code");
        if Periods.FindFirst then;

        GetPayrollPeriods.SetTableView(Periods);
    end;

    [Scope('Personalization')]
    procedure GeneratePayslip(EmployeeNo: Code[20]; PayrollPeriod: Code[20]) ServerPath: Text
    var
        Payslips: Report "Portal Payslips";
        Filename: Text;
        PortalSetup: Record "Portal Setup";
        Filepath: Text;
        Period: Record Periods;
    begin

        Employee.Reset;
        Employee.Get(EmployeeNo);
        Period.SetRange("Period ID", PayrollPeriod);
        Period.SetRange("Approval Status", Period."Approval Status"::Approved);
        if Period.FindFirst then begin
            //IF Period."Approval Status" = Period."Approval Status"::Approved THEN BEGIN
            //IF (Period."Enable Payslip" = TRUE) OR (Period."Approval Status" = Period."Approval Status"::Approved) THEN BEGIN
            PortalSetup.Reset;
            PortalSetup.Get;
            PortalSetup.TestField("Server File Path");
            PortalSetup.TestField("Local File Path");
            Filename := DelChr(EmployeeNo, '=', '/') + '_' + PayrollPeriod + '.pdf';
            Filepath := PortalSetup."Local File Path" + Filename;
            if FILE.Exists(Filepath) then
                FILE.Erase(Filepath);
            Payslips.sSetParameters(PayrollPeriod, EmployeeNo);
            Payslips.SaveAsPdf(Filepath);
            if FILE.Exists(Filepath) then
                ServerPath := PortalSetup."Server File Path" + Filename
            else
                Error('There was an Error. Please Try again');
            //END ELSE ERROR('Payslip for this '+PayrollPeriod+' Period is NOT Ready. Please try Again Later.');
        end else
            Error('Payslip for this ' + PayrollPeriod + ' Period is NOT Ready. Please try Again Later.');
    end;

    [Scope('Personalization')]
    procedure PrintLeave(LeaveNo: Code[20]) ServerPath: Text
    var
        HRLeaveApplicationReport: Report "HR Leave Application Report";
        Filename: Text;
        PortalSetup: Record "Portal Setup";
        Filepath: Text;
        HRLeaveApplication: Record "HR Leave Application";
    begin
        PortalSetup.Reset;
        PortalSetup.Get;
        PortalSetup.TestField("Server File Path");
        PortalSetup.TestField("Local File Path");
        Filename := LeaveNo + '_' + 'LeaveApplication.pdf';
        Filepath := PortalSetup."Local File Path" + Filename;
        // if FILE.Exists(Filepath) then
        //   FILE.Erase(Filepath);

        HRLeaveApplication.Reset;
        HRLeaveApplication.SetRange("No.", LeaveNo);
        HRLeaveApplicationReport.SetTableView(HRLeaveApplication);
        // HRLeaveApplicationReport.SaveAsPdf(Filepath);
        // if FILE.Exists(Filepath) then
        //   ServerPath:=PortalSetup."Server File Path"+Filename
        // else
        //   Error('There was an Error. Please Try again');
    end;

    [Scope('Personalization')]
    procedure CreateHREmployeeAppraisal("EmployeeNo.": Code[20]; DateofLastAppraisal: Date; AppraisalPeriod: Code[20]; CommentsByAppraisee: Text; CommentsByAppraiser: Text; CommentsByHOD: Text; CommentsByHODHR: Text) AppraisalCreated: Text
    begin
        AppraisalCreated := '';
        HumanResourcesSetup.Get;
        HREmployeeAppraisalHeaderRec.Init;
        HREmployeeAppraisalHeaderRec."No." := NoSeriesMgt.GetNextNo(HumanResourcesSetup."Employee Appraisal Nos.", 0D, true);
        HREmployeeAppraisalHeaderRec."Employee No." := "EmployeeNo.";
        HREmployeeAppraisalHeaderRec.Validate("Employee No.");
        HREmployeeAppraisalHeaderRec."Date of Last Appraisal" := DateofLastAppraisal;
        HREmployeeAppraisalHeaderRec."Appraisal Period" := AppraisalPeriod;
        HREmployeeAppraisalHeaderRec."Comments By HOD" := CommentsByHOD;
        HREmployeeAppraisalHeaderRec."Comments By HOD HR" := CommentsByHODHR;
        HREmployeeAppraisalHeaderRec."Final Comments by Appraiser" := CommentsByAppraiser;
        if HREmployeeAppraisalHeaderRec.Insert then begin
            AppraisalCreated := '200: Employee Appraisal Successfully Created ' + HREmployeeAppraisalHeaderRec."No.";
        end else
            AppraisalCreated := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyHREmployeeAppraisal(AppraisalNo: Code[20]; DateofLastAppraisal: Date; AppraisalPeriod: Code[20]; CommentsByAppraisee: Text; CommentsByAppraiser: Text; CommentsByHOD: Text; CommentsByHODHR: Text) AppraisalModifed: Boolean
    begin
        AppraisalModifed := false;
        HREmployeeAppraisalHeaderRec.Reset;
        HREmployeeAppraisalHeaderRec.SetRange("No.", AppraisalNo);
        if HREmployeeAppraisalHeaderRec.FindFirst then begin
            HREmployeeAppraisalHeaderRec."Date of Last Appraisal" := DateofLastAppraisal;
            HREmployeeAppraisalHeaderRec."Appraisal Period" := AppraisalPeriod;
            HREmployeeAppraisalHeaderRec."Comments By HOD" := CommentsByHOD;
            HREmployeeAppraisalHeaderRec."Final Comments by Appraiser" := CommentsByAppraiser;
            HREmployeeAppraisalHeaderRec."Comments By HOD HR" := CommentsByHODHR;
            if HREmployeeAppraisalHeaderRec.Modify then
                AppraisalModifed := true//'200: Employee Appraisal Successfully modified';
            else
                AppraisalModifed := false//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteAppraisal(AppraisalNo: Code[20]) AppraisalDeleted: Boolean
    begin
        AppraisalDeleted := false;
        HREmployeeAppraisalHeaderRec.Reset;
        HREmployeeAppraisalHeaderRec.SetRange("No.", AppraisalNo);
        if HREmployeeAppraisalHeaderRec.FindFirst then begin
            if HREmployeeAppraisalHeaderRec.Delete then
                AppraisalDeleted := true
            else
                AppraisalDeleted := false;
        end
    end;

    [Scope('Personalization')]
    procedure GetEmployeeAppraisalList(var ImportExportEmployAppraisal: XMLport "Import/Export Employ Appraisal"; EmployeeNo: Code[20])
    begin
        if EmployeeNo <> '' then begin

            HREmployeeAppraisalHeaderRec.Reset;
            HREmployeeAppraisalHeaderRec.SetFilter("Employee No.", EmployeeNo);
            if HREmployeeAppraisalHeaderRec.FindFirst then;
            ImportExportEmployAppraisal.SetTableView(HREmployeeAppraisalHeaderRec);
        end
    end;

    [Scope('Personalization')]
    procedure CreateAppraisalAcademicsProfLine(AppraisalNo: Code[20]; InsitutionName: Text; PeriodofStudy: Text; QualificationAwarded: Text) HrAppraisalAcademicLineCreated: Text
    var
        LineNo: Integer;
    begin
        HrAppraisalAcademicLineCreated := '';
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        if HrAppraisalAcademicProfQuaRec.FindLast then
            LineNo := HrAppraisalAcademicProfQuaRec."Line No." + 10000
        else
            LineNo := 10000;
        HrAppraisalAcademicProfQuaRec.Init;
        HrAppraisalAcademicProfQuaRec."Appraisal Code" := AppraisalNo;
        HrAppraisalAcademicProfQuaRec."Line No." := LineNo;
        HrAppraisalAcademicProfQuaRec."Name of Institution" := InsitutionName;
        HrAppraisalAcademicProfQuaRec."Period Of Study" := PeriodofStudy;
        HrAppraisalAcademicProfQuaRec."Qualification Awarded" := QualificationAwarded;

        if HrAppraisalAcademicProfQuaRec.Insert then
            HrAppraisalAcademicLineCreated := '200: Employee Appraisal Academics line Successfully Created'
        else
            HrAppraisalAcademicLineCreated := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifiedAppraisalAcademicsProfLine(AppraisalNo: Code[20]; LineNo: Integer; InsitutionName: Text; PeriodofStudy: Text; QualificationAwarded: Text) HrAppraisalAcademicLineModified: Boolean
    begin
        HrAppraisalAcademicLineModified := false;
        HREmployeeAppraisalHeaderRec.Reset;
        HrAppraisalAcademicProfQuaRec.SetRange("Appraisal Code", AppraisalNo);
        HrAppraisalAcademicProfQuaRec.SetRange("Line No.", LineNo);
        if HrAppraisalAcademicProfQuaRec.FindFirst then begin
            HrAppraisalAcademicProfQuaRec.Init;
            HrAppraisalAcademicProfQuaRec."Appraisal Code" := AppraisalNo;
            HrAppraisalAcademicProfQuaRec."Name of Institution" := InsitutionName;
            HrAppraisalAcademicProfQuaRec."Period Of Study" := PeriodofStudy;
            HrAppraisalAcademicProfQuaRec."Qualification Awarded" := QualificationAwarded;

            if HrAppraisalAcademicProfQuaRec.Modify then
                HrAppraisalAcademicLineModified := true//'200: Employee Appraisal Academics line Successfully Created'
            else
                HrAppraisalAcademicLineModified := false;//+'-'+GETLASTERRORTEXT;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteAppraisalAcademicsProfLine(LineNo: Integer; AppraisalNo: Code[20]) HRAppraisalAcademicLineDeleted: Boolean
    begin
        HRAppraisalAcademicLineDeleted := false;
        HREmployeeAppraisalHeaderRec.Reset;
        HrAppraisalAcademicProfQuaRec.SetRange("Appraisal Code", AppraisalNo);
        HrAppraisalAcademicProfQuaRec.SetRange("Line No.", LineNo);
        if HrAppraisalAcademicProfQuaRec.FindFirst then begin
            if HrAppraisalAcademicProfQuaRec.Delete then
                HRAppraisalAcademicLineDeleted := true
            else
                HRAppraisalAcademicLineDeleted := false;
        end;
    end;

    [Scope('Personalization')]
    procedure GetAppraisalAcademicsProfLines(var ImportExportAppraisalAcadem: XMLport "Import/Export Appraisal Academ"; AppraisalNo: Code[20])
    begin
        HrAppraisalAcademicProfQuaRec.Reset;
        HrAppraisalAcademicProfQuaRec.SetRange("Appraisal Code", AppraisalNo);
        ImportExportAppraisalAcadem.SetTableView(HrAppraisalAcademicProfQuaRec);
    end;

    [Scope('Personalization')]
    procedure CreatAppraisalCompetencyFactorLine(AppraisalNo: Code[20]; CompetencyFactortxt: Text; Score: Decimal) CompetencyFactorCreated: Text
    begin
        CompetencyFactorCreated := '';
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        HRAppraisalCompetencyFactor.Init;
        HRAppraisalCompetencyFactor."Appraisal No." := AppraisalNo;
        HRAppraisalCompetencyFactor."Competency Factor" := CompetencyFactortxt;
        HRAppraisalCompetencyFactor.Score := Score;
        if HRAppraisalCompetencyFactor.Insert then
            CompetencyFactorCreated := '200: Employee Appraisal Assessment factor line Successfully Created'
        else
            CompetencyFactorCreated := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyAppraisalCompetencyFactorLine(AppraisalNo: Code[20]; LineNo: Integer; CompetencyFactor: Text; Score: Decimal) CompetencyFactorModified: Boolean
    begin
        CompetencyFactorModified := false;
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        HRAppraisalCompetencyFactor.Reset;
        HRAppraisalCompetencyFactor.SetRange("Appraisal No.", AppraisalNo);
        HRAppraisalCompetencyFactor.SetRange("Line No.", LineNo);
        if HRAppraisalCompetencyFactor.FindLast then begin
            HRAppraisalCompetencyFactor."Competency Factor" := CompetencyFactor;
            HRAppraisalCompetencyFactor.Score := Score;
            if HRAppraisalCompetencyFactor.Modify then
                CompetencyFactorModified := true//'200: Employee Appraisal Assessment factor line Successfully Created'
            else
                CompetencyFactorModified := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteAppraisalCompetencyFactorLine(AppraisalNo: Code[20]; LineNo: Integer) CompetencyFactorDeleted: Boolean
    var
        "`": Integer;
    begin
        CompetencyFactorDeleted := false;
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        HRAppraisalCompetencyFactor.Reset;
        HRAppraisalCompetencyFactor.SetRange("Appraisal No.", AppraisalNo);
        HRAppraisalCompetencyFactor.SetRange("Line No.", LineNo);
        if HRAppraisalCompetencyFactor.Delete then
            CompetencyFactorDeleted := true//'200: Employee Appraisal Assessment factor line Successfully Created'
        else
            CompetencyFactorDeleted := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
    end;

    [Scope('Personalization')]
    procedure GetAppraisalCompetencyFactorLine(var ImportExportApprAssementFac: XMLport "Import/Export Appr AssementFac"; AppraisalNo: Code[20])
    begin
        HRAppraisalCompetencyFactor.Reset;
        HRAppraisalCompetencyFactor.SetRange("Appraisal No.", AppraisalNo);
        ImportExportApprAssementFac.SetTableView(HRAppraisalCompetencyFactor);
    end;

    [Scope('Personalization')]
    procedure CreateAppraisalChallengeLine(AppraisalNo: Code[20]; Challenge: Text) AppraisalChallengeLineCreated: Text
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalChallengeLineCreated := '';
        if HRAppraisalProblemsChalleng.FindLast then
            LineNoInt := HRAppraisalProblemsChalleng."Line No." + 10000
        else
            LineNoInt := 10000;
        HRAppraisalProblemsChalleng.Init;
        HRAppraisalProblemsChalleng."No." := AppraisalNo;
        HRAppraisalProblemsChalleng."Line No." := LineNoInt;
        HRAppraisalProblemsChalleng."Problem/Challenge" := Challenge;
        if HRAppraisalProblemsChalleng.Insert then
            AppraisalChallengeLineCreated := '200: Employee Appraisal Challenge line Successfully Created'
        else
            AppraisalChallengeLineCreated := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyAppraisalChallengeLine(AppraisalNo: Code[20]; LineNo: Integer; Challenge: Text) AppraisalChallengeLineModify: Boolean
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalChallengeLineModify := false;
        HRAppraisalProblemsChalleng.Reset;
        HRAppraisalProblemsChalleng.SetRange("No.", AppraisalNo);
        HRAppraisalProblemsChalleng.SetRange("Line No.", LineNo);
        if HRAppraisalProblemsChalleng.FindFirst then begin
            HRAppraisalProblemsChalleng."Problem/Challenge" := Challenge;

            if HRAppraisalProblemsChalleng.Modify then
                AppraisalChallengeLineModify := true//'200: Employee Appraisal Challenge line Successfully Created'
            else
                AppraisalChallengeLineModify := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteAppraisalChallengeLine(AppraisalNo: Code[20]; LineNo: Integer) AppraisalChallengeLineDeleted: Boolean
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalChallengeLineDeleted := false;
        HRAppraisalProblemsChalleng.Reset;
        HRAppraisalProblemsChalleng.SetRange("No.", AppraisalNo);
        HRAppraisalProblemsChalleng.SetRange("Line No.", LineNo);
        if HRAppraisalProblemsChalleng.FindFirst then begin
            if HRAppraisalProblemsChalleng.Delete then
                AppraisalChallengeLineDeleted := true//'200: Employee Appraisal Challenge line Successfully Created'
            else
                AppraisalChallengeLineDeleted := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        end;
    end;

    [Scope('Personalization')]
    procedure GetAppraisalChallengeLines(var ImportExportAppProblChalle: XMLport "Import/Export App Probl/Challe"; AppraisalNo: Code[20])
    begin
        HRAppraisalProblemsChalleng.Reset;
        HRAppraisalProblemsChalleng.SetRange("No.", AppraisalNo);
        ImportExportAppProblChalle.SetTableView(HRAppraisalProblemsChalleng);
    end;

    [Scope('Personalization')]
    procedure CreateAppraisalCourseTrainingAttended(AppraisalNo: Code[20]; TrainingCourse: Text) AppraisalTrainingLineCreated: Text
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalTrainingLineCreated := '';
        if HRAppraisalCourseTraining.FindLast then
            LineNoInt := HRAppraisalCourseTraining."Line No." + 10000
        else
            LineNoInt := 10000;

        HRAppraisalCourseTraining.Init;
        HRAppraisalCourseTraining."Appraisal No." := AppraisalNo;
        HRAppraisalCourseTraining."Line No." := LineNoInt;
        HRAppraisalCourseTraining."Course/Training" := TrainingCourse;
        if HRAppraisalCourseTraining.Insert then
            AppraisalTrainingLineCreated := '200: Employee Appraisal training/course line Successfully Created'
        else
            AppraisalTrainingLineCreated := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyAppraisalTrainingCourseLine(AppraisalNo: Code[20]; LineNo: Integer; TrainingCourse: Text) AppraisalTrainingLineModify: Boolean
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalTrainingLineModify := false;
        HRAppraisalCourseTraining.Reset;
        HRAppraisalCourseTraining.SetRange("Appraisal No.", AppraisalNo);
        HRAppraisalCourseTraining.SetRange("Line No.", LineNo);
        if HRAppraisalCourseTraining.FindFirst then begin
            HRAppraisalCourseTraining."Course/Training" := TrainingCourse;
            if HRAppraisalCourseTraining.Modify then
                AppraisalTrainingLineModify := true//'200: Employee Appraisal Challenge line Successfully Created'
            else
                AppraisalTrainingLineModify := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteAppraisalTrainingCourseLine(AppraisalNo: Code[20]; LineNo: Integer) AppraisalTrainingLineDeleted: Boolean
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalTrainingLineDeleted := false;
        HRAppraisalCourseTraining.Reset;
        HRAppraisalCourseTraining.SetRange("Appraisal No.", AppraisalNo);
        HRAppraisalCourseTraining.SetRange("Line No.", LineNo);
        if HRAppraisalCourseTraining.Delete then
            AppraisalTrainingLineDeleted := true//'200: Employee Appraisal Challenge line Successfully Created'
        else
            AppraisalTrainingLineDeleted := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;

    end;

    [Scope('Personalization')]
    procedure GetAppraisalTrainingLines(var ImportExportApprTraingCours: XMLport "Import/Export Appr TraingCours"; AppraisalNo: Code[20])
    begin
        HRAppraisalCourseTraining.Reset;
        HRAppraisalCourseTraining.SetRange("Appraisal No.", AppraisalNo);
        HRAppraisalCourseTraining.FindFirst;
        ImportExportApprTraingCours.SetTableView(HRAppraisalCourseTraining);
    end;

    [Scope('Personalization')]
    procedure CreateAppraisalPerformanceFactorLine(AppraisalNo: Code[20]; PerformanceFactor: Text) AppraisalPerformanceFactLineCreated: Text
    var
        LineNo: Integer;
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalPerformanceFactLineCreated := '';
        HRAppraisalPerformanceFacto.Init;
        if HRAppraisalPerformanceFacto.FindLast then
            LineNo := HRAppraisalPerformanceFacto."Line No." + 10000
        else
            LineNo := 10000;
        HRAppraisalPerformanceFacto."Line No." := LineNo;
        HRAppraisalPerformanceFacto."Performance Factor" := PerformanceFactor;
        HRAppraisalPerformanceFacto."Appraisal No." := AppraisalNo;
        if HRAppraisalPerformanceFacto.Insert then
            AppraisalPerformanceFactLineCreated := '200: Employee Appraisal Performance Factor line Successfully Created'
        else
            AppraisalPerformanceFactLineCreated := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyAppraisalPerformanceFactorLine(AppraisalNo: Code[20]; LineNo: Integer; PerformanceFactor: Text) AppraisalPerfFactorLineModify: Boolean
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalPerfFactorLineModify := false;
        HRAppraisalPerformanceFacto.Reset;
        HRAppraisalPerformanceFacto.SetRange("Appraisal No.", AppraisalNo);
        HRAppraisalPerformanceFacto.SetRange("Line No.", LineNo);
        if HRAppraisalPerformanceFacto.FindFirst then begin
            HRAppraisalPerformanceFacto."Performance Factor" := PerformanceFactor;
            if HRAppraisalPerformanceFacto.Modify then
                AppraisalPerfFactorLineModify := true//'200: Employee Appraisal Challenge line Successfully Created'
            else
                AppraisalPerfFactorLineModify := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteAppraisalPerformanceFactorLine(AppraisalNo: Code[20]; LineNo: Integer) AppraisalPerformanceFactLineDeleted: Boolean
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalPerformanceFactLineDeleted := false;
        HRAppraisalPerformanceFacto.Reset;
        HRAppraisalPerformanceFacto.SetRange("Appraisal No.", AppraisalNo);
        HRAppraisalPerformanceFacto.SetRange("Line No.", LineNo);
        if HRAppraisalPerformanceFacto.FindFirst then begin
            if HRAppraisalPerformanceFacto.Delete then
                AppraisalPerformanceFactLineDeleted := true//'200: Employee Appraisal Challenge line Successfully Created'
            else
                AppraisalPerformanceFactLineDeleted := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        end;
    end;

    [Scope('Personalization')]
    procedure GetAppraisalPerformanceFactorLines(var ImportExportApprPerfFactor: XMLport "Import/Export Appr Perf Factor"; AppraisalNo: Code[20])
    begin
        HRAppraisalPerformanceFacto.Reset;
        HRAppraisalPerformanceFacto.SetRange("Appraisal No.", AppraisalNo);
        ImportExportApprPerfFactor.SetTableView(HRAppraisalPerformanceFacto);
    end;

    [Scope('Personalization')]
    procedure CreateAppraisalPerformanceSuggestLine(AppraisalNo: Code[20]; PerformanceSuggestion: Text) AppraisalPerformanSuggestionLineCreated: Text
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        if HrAppraisalPerformaceSugge.FindLast then
            LineNoInt := HrAppraisalPerformaceSugge."Line No." + 10000
        else
            LineNoInt := 10000;
        AppraisalPerformanSuggestionLineCreated := '';
        HrAppraisalPerformaceSugge.Init;
        HrAppraisalPerformaceSugge."Appraisal No." := AppraisalNo;
        HrAppraisalPerformaceSugge."Line No." := LineNoInt;
        HrAppraisalPerformaceSugge.Suggestion := PerformanceSuggestion;
        if HrAppraisalPerformaceSugge.Insert then
            AppraisalPerformanSuggestionLineCreated := '200: Employee Appraisal Performance suggestion line Successfully Created'
        else
            AppraisalPerformanSuggestionLineCreated := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyAppraisalPerformanceSuggestLine(AppraisalNo: Code[20]; LineNo: Integer; PerformanceSuggestion: Text) AppraisalPerfSuggestionLineModify: Boolean
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalPerfSuggestionLineModify := false;
        HrAppraisalPerformaceSugge.Reset;
        HrAppraisalPerformaceSugge.SetRange("Appraisal No.", AppraisalNo);
        HrAppraisalPerformaceSugge.SetRange("Line No.", LineNo);
        if HrAppraisalPerformaceSugge.FindFirst then begin
            HrAppraisalPerformaceSugge.Suggestion := PerformanceSuggestion;
            if HrAppraisalPerformaceSugge.Modify then
                AppraisalPerfSuggestionLineModify := true//'200: Employee Appraisal Challenge line Successfully Created'
            else
                AppraisalPerfSuggestionLineModify := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteAppraisalPerformanceSuggestLine(AppraisalNo: Code[20]; LineNo: Integer) AppraisalPerformanceSuggestionDeleted: Boolean
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalPerformanceSuggestionDeleted := false;
        HrAppraisalPerformaceSugge.Reset;
        HrAppraisalPerformaceSugge.SetRange("Appraisal No.", AppraisalNo);
        HrAppraisalPerformaceSugge.SetRange("Line No.", LineNo);
        if HrAppraisalPerformaceSugge.FindFirst then begin
            if HrAppraisalPerformaceSugge.Delete then
                AppraisalPerformanceSuggestionDeleted := true//'200: Employee Appraisal Challenge line Successfully Created'
            else
                AppraisalPerformanceSuggestionDeleted := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        end;
    end;

    [Scope('Personalization')]
    procedure GetAppraisalPerformanceSuggestLines(var ImportExportApprPerfSugg: XMLport "Import/Export ApprPerfSugg"; AppraisalNo: Code[20])
    begin
        HrAppraisalPerformaceSugge.Reset;
        HrAppraisalPerformaceSugge.SetRange("Appraisal No.", AppraisalNo);
        ImportExportApprPerfSugg.SetTableView(HrAppraisalPerformaceSugge);
    end;

    [Scope('Personalization')]
    procedure CreateAppraisalTrainingNeedLine(AppraisalNo: Code[20]; TrainingNeed: Text) AppraisalTrainingNeedLineCreated: Text
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);

        if HRAppraisalTrainingNeedOb.FindLast then
            LineNoInt := HRAppraisalTrainingNeedOb."Line No." + 10000
        else
            LineNoInt := 10000;

        AppraisalTrainingNeedLineCreated := '';
        HRAppraisalTrainingNeedOb.Init;
        HRAppraisalTrainingNeedOb."Appraisal No." := AppraisalNo;
        HRAppraisalTrainingNeedOb."Line No." := LineNoInt;
        HRAppraisalTrainingNeedOb."Training Need & Objective" := TrainingNeed;
        if HRAppraisalTrainingNeedOb.Insert then
            AppraisalTrainingNeedLineCreated := '200: Employee Appraisal Training Need line Successfully Created'
        else
            AppraisalTrainingNeedLineCreated := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyAppraisalTrainingNeedLine(AppraisalNo: Code[20]; LineNo: Integer; TrainingNeed: Text) AppraisalTrainingNeedLineModify: Boolean
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalTrainingNeedLineModify := false;
        HRAppraisalTrainingNeedOb.Reset;
        HRAppraisalTrainingNeedOb.SetRange("Appraisal No.", AppraisalNo);
        HRAppraisalTrainingNeedOb.SetRange("Line No.", LineNo);
        if HRAppraisalTrainingNeedOb.FindFirst then begin
            HRAppraisalTrainingNeedOb."Training Need & Objective" := TrainingNeed;
            if HRAppraisalTrainingNeedOb.Modify then
                AppraisalTrainingNeedLineModify := true//'200: Employee Appraisal Challenge line Successfully Created'
            else
                AppraisalTrainingNeedLineModify := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteAppraisalTrainingNeedLine(AppraisalNo: Code[20]; LineNo: Integer) AppraisalTrainingNeedLineDeleted: Boolean
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalTrainingNeedLineDeleted := false;
        HRAppraisalTrainingNeedOb.Reset;
        HRAppraisalTrainingNeedOb.SetRange("Appraisal No.", AppraisalNo);
        HRAppraisalTrainingNeedOb.SetRange("Line No.", LineNo);
        if HRAppraisalTrainingNeedOb.FindFirst then begin
            if HRAppraisalTrainingNeedOb.Delete then
                AppraisalTrainingNeedLineDeleted := true//'200: Employee Appraisal Challenge line Successfully Created'
            else
                AppraisalTrainingNeedLineDeleted := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        end;
    end;

    [Scope('Personalization')]
    procedure GetAppraisalTrainingNeedLines(var ImportExpoTrainingNEedObje: XMLport "Import/Expo Training NEed/Obje"; AppraisalNo: Code[20])
    begin
        HRAppraisalTrainingNeedOb.Reset;
        HRAppraisalTrainingNeedOb.SetRange("Appraisal No.", AppraisalNo);
        ImportExpoTrainingNEedObje.SetTableView(HRAppraisalTrainingNeedOb);
    end;

    [Scope('Personalization')]
    procedure CreateAppraisalIdentPotentialLine(AppraisalNo: Code[20]; IdentifiedPotential: Text) AppraisalIdentifiedPotentialLineCreated: Text
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);

        if HRAppraisalIdentifiedPotent.FindLast then
            LineNoInt := HRAppraisalIdentifiedPotent."Line No."
        else
            LineNoInt := 10000;
        AppraisalIdentifiedPotentialLineCreated := '';
        HRAppraisalIdentifiedPotent.Init;
        HRAppraisalIdentifiedPotent."Appraisal No." := AppraisalNo;
        HRAppraisalIdentifiedPotent."Line No." := LineNoInt;
        HRAppraisalIdentifiedPotent."Identified Potential" := IdentifiedPotential;
        if HRAppraisalIdentifiedPotent.Insert then
            AppraisalIdentifiedPotentialLineCreated := '200: Employee Appraisal Identified potential line Successfully Created'
        else
            AppraisalIdentifiedPotentialLineCreated := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyAppraisalIdentPotentialLine(AppraisalNo: Code[20]; LineNo: Integer; IdentifiedPotential: Text) AppraisalIdentifiedPotentialLineModify: Boolean
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalIdentifiedPotentialLineModify := false;
        HRAppraisalIdentifiedPotent.Reset;
        HRAppraisalIdentifiedPotent.SetRange("Appraisal No.", AppraisalNo);
        HRAppraisalIdentifiedPotent.SetRange("Line No.", LineNo);
        if HRAppraisalIdentifiedPotent.FindFirst then begin
            HRAppraisalIdentifiedPotent."Identified Potential" := IdentifiedPotential;
            if HRAppraisalIdentifiedPotent.Modify then
                AppraisalIdentifiedPotentialLineModify := true//'200: Employee Appraisal Challenge line Successfully Created'
            else
                AppraisalIdentifiedPotentialLineModify := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteAppraisalIdentPotentialLine(AppraisalNo: Code[20]; LineNo: Integer) AppraisalIdentifiedPotentialLineDeleted: Boolean
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalIdentifiedPotentialLineDeleted := false;
        HRAppraisalIdentifiedPotent.Reset;
        HRAppraisalIdentifiedPotent.SetRange("Appraisal No.", AppraisalNo);
        HRAppraisalIdentifiedPotent.SetRange("Line No.", LineNo);
        if HRAppraisalIdentifiedPotent.Delete then
            AppraisalIdentifiedPotentialLineDeleted := true//'200: Employee Appraisal Challenge line Successfully Created'
        else
            AppraisalIdentifiedPotentialLineDeleted := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;

    end;

    [Scope('Personalization')]
    procedure GetAppraisalIdentiPotentialLines(var ImpExpAppraIdentPotentital: XMLport "Imp/Exp Appr Recommendation"; AppraisalNo: Code[20])
    begin
        HRAppraisalIdentifiedPotent.Reset;
        HRAppraisalIdentifiedPotent.SetRange("Appraisal No.", AppraisalNo);
        ImpExpAppraIdentPotentital.SetTableView(HRAppraisalIdentifiedPotent);
    end;

    [Scope('Personalization')]
    procedure CreateAppraisalSpecificRecomLine(AppraisalNo: Code[20]; Recommendation: Text; Reason: Text) AppraisalSpecificRecLineCreated: Text
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);

        if HRAppraisalRecommendation.FindLast then
            LineNoInt := HRAppraisalRecommendation."Line No." + 10000
        else
            LineNoInt := 10000;
        AppraisalSpecificRecLineCreated := '';
        HRAppraisalRecommendation.Init;
        HRAppraisalRecommendation."Appraisal No." := AppraisalNo;
        HRAppraisalRecommendation."Line No." := LineNoInt;
        HRAppraisalRecommendation.Recommendation := Recommendation;
        if HRAppraisalRecommendation.Insert then
            AppraisalSpecificRecLineCreated := '200: Employee Appraisal Recommendation line Successfully Created'
        else
            AppraisalSpecificRecLineCreated := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyAppraisalSpecificRecomLine(AppraisalNo: Code[20]; LineNo: Integer; Recommendation: Text; Reason: Integer) AppraisalSpecificRecommlLineModify: Boolean
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalSpecificRecommlLineModify := false;
        HRAppraisalIdentifiedPotent.Reset;
        HRAppraisalRecommendation.SetRange("Appraisal No.", AppraisalNo);
        HRAppraisalRecommendation.SetRange("Line No.", LineNo);
        if HRAppraisalRecommendation.FindFirst then begin
            HRAppraisalRecommendation.Recommendation := Recommendation;
            if HRAppraisalRecommendation.Modify then
                AppraisalSpecificRecommlLineModify := true//'200: Employee Appraisal Challenge line Successfully Created'
            else
                AppraisalSpecificRecommlLineModify := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteAppraisalSpecificRecomLine(AppraisalNo: Code[20]; LineNo: Integer) AppraisalSpecificRecomLineDeleted: Boolean
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalSpecificRecomLineDeleted := false;
        HRAppraisalRecommendation.Reset;
        HRAppraisalRecommendation.SetRange("Appraisal No.", AppraisalNo);
        HRAppraisalRecommendation.SetRange("Line No.", LineNo);
        if HRAppraisalRecommendation.FindFirst then begin
            if HRAppraisalRecommendation.Delete then
                AppraisalSpecificRecomLineDeleted := true//'200: Employee Appraisal Challenge line Successfully Created'
            else
                AppraisalSpecificRecomLineDeleted := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        end;
    end;

    [Scope('Personalization')]
    procedure GetAppraisalSpecificRecomLines(var ImpExpApprRecommendation: XMLport "Imp/Exp Appr Recommendation"; AppraisalNo: Code[20])
    begin
        HRAppraisalRecommendation.Reset;
        HRAppraisalRecommendation.SetRange("Appraisal No.", AppraisalNo);
        ImpExpApprRecommendation.SetTableView(HRAppraisalRecommendation);
    end;

    [Scope('Personalization')]
    procedure CreateAppraisalSpecialTaskLine(AppraisalNo: Code[20]; Task: Text) AppraisalSpecialTaskLineCreated: Text
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        if HRAppraisalSpecialTask.FindLast then
            LineNoInt := HRAppraisalSpecialTask."Line No." + 10000
        else
            LineNoInt := 10000;
        AppraisalSpecialTaskLineCreated := '';
        HRAppraisalSpecialTask.Init;
        HRAppraisalSpecialTask."No." := AppraisalNo;
        HRAppraisalSpecialTask.Task := Task;
        HRAppraisalSpecialTask."Line No." := LineNoInt;
        if HRAppraisalSpecialTask.Insert then
            AppraisalSpecialTaskLineCreated := '200: Employee Appraisal special Task line Successfully Created'
        else
            AppraisalSpecialTaskLineCreated := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyAppraisalSpecialTaskLine(AppraisalNo: Code[20]; LineNo: Integer; Task: Text) AppraisalSpecialTaskLineModify: Boolean
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);

        AppraisalSpecialTaskLineModify := false;
        HRAppraisalSpecialTask.Reset;
        HRAppraisalSpecialTask.SetRange("No.", AppraisalNo);
        HRAppraisalSpecialTask.SetRange("Line No.", LineNo);
        if HRAppraisalSpecialTask.FindFirst then begin
            HRAppraisalSpecialTask.Task := Task;
            if HRAppraisalSpecialTask.Modify then
                AppraisalSpecialTaskLineModify := true//'200: Employee Appraisal Challenge line Successfully Created'
            else
                AppraisalSpecialTaskLineModify := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteAppraisalSpecialTaskLine(AppraisalNo: Code[20]; LineNo: Integer) AppraisalSpecialTaskineDeleted: Boolean
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        AppraisalSpecialTaskineDeleted := false;

        HRAppraisalSpecialTask.Reset;
        HRAppraisalSpecialTask.SetRange("No.", AppraisalNo);
        HRAppraisalSpecialTask.SetRange("Line No.", LineNo);
        if HRAppraisalSpecialTask.FindFirst then begin
            if HRAppraisalSpecialTask.Delete then
                AppraisalSpecialTaskineDeleted := true//'200: Employee Appraisal Challenge line Successfully Created'
            else
                AppraisalSpecialTaskineDeleted := false;//GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        end

    end;

    [Scope('Personalization')]
    procedure GetAppraisalSpecialTaskLines(var ImpExpApprSpecialTask: XMLport "Imp/Exp Appr Special Task"; AppraisalNo: Code[20])
    begin
        HRAppraisalSpecialTask.Reset;
        HRAppraisalSpecialTask.SetRange("No.", AppraisalNo);
        ImpExpApprSpecialTask.SetTableView(HRAppraisalSpecialTask);
    end;

    [Scope('Personalization')]
    procedure CreateAppraisalResponsibiltyLine(AppraisalNo: Code[20]; Responsibility: Text) HrAppraisalResponsibilityLineCreated: Text
    begin
        HrAppraisalResponsibilityLineCreated := '';
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);

        if HrAppraisalResponsibility.FindLast then
            LineNoInt := HrAppraisalResponsibility."Line No." + 10000
        else
            LineNoInt := 10000;
        HrAppraisalResponsibility.Init;
        HrAppraisalResponsibility."Appraisal Code" := AppraisalNo;
        HrAppraisalResponsibility."Line No." := LineNoInt;
        HrAppraisalResponsibility."Appraisal Code" := AppraisalNo;
        HrAppraisalResponsibility."Responsibility/Duty" := Responsibility;

        if HrAppraisalResponsibility.Insert then
            HrAppraisalResponsibilityLineCreated := '200: Employee Appraisal Responsibility Successfully Created'
        else
            HrAppraisalResponsibilityLineCreated := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyAppraisalResponsibiltyLine(AppraisalNo: Code[20]; LineNo: Integer; Responsibility: Text) HrAppraisalResponsibilityLineModified: Text
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        HrAppraisalResponsibilityLineModified := '';
        HrAppraisalResponsibility.Reset;
        HrAppraisalResponsibility.SetRange("Appraisal Code", AppraisalNo);
        HrAppraisalResponsibility.SetRange("Line No.", LineNo);
        if HrAppraisalResponsibility.FindFirst then begin
            HrAppraisalResponsibility."Responsibility/Duty" := Responsibility;
            if HrAppraisalResponsibility.Modify then
                HrAppraisalResponsibilityLineModified := '200: Employee Appraisal Responsibility line Successfully MODIFIED'
            else
                HrAppraisalResponsibilityLineModified := GetLastErrorCode + '-' + GetLastErrorText;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteAppraisalResponsibiltyLine(AppraisalNo: Code[20]; LineNo: Integer) HrAppraisalResponsibilityLineDeleted: Text
    begin
        HREmployeeAppraisalHeaderRec.Get(AppraisalNo);
        HrAppraisalResponsibilityLineDeleted := '';
        HrAppraisalResponsibility.Reset;
        HrAppraisalResponsibility.SetRange("Appraisal Code", AppraisalNo);
        HrAppraisalResponsibility.SetRange("Line No.", LineNo);
        if HrAppraisalResponsibility.FindFirst then begin
            if HrAppraisalResponsibility.Delete then
                HrAppraisalResponsibilityLineDeleted := '200: Employee Appraisal Responsibility line Successfully Deleted'
            else
                HrAppraisalResponsibilityLineDeleted := GetLastErrorCode + '-' + GetLastErrorText;
        end;
    end;

    [Scope('Personalization')]
    procedure GetAppraisalResponsibiltyLine(var ImpExpAppraisalResponsibility: XMLport "Import/Export App Responsibili"; AppraisalNo: Code[20])
    begin
        HrAppraisalResponsibility.Reset;
        HrAppraisalResponsibility.SetRange("Appraisal Code", AppraisalNo);
        ImpExpAppraisalResponsibility.SetTableView(HrAppraisalResponsibility);
    end;

    [Scope('Personalization')]
    procedure CheckHRAppraisalApprovalWorkflowEnabled(HRappraisalNo: Code[20]) ApprovalWorkflowEnabled: Boolean
    begin
        ApprovalWorkflowEnabled := false;

        HREmployeeAppraisalHeader.Reset;
        // if HREmployeeAppraisalHeader.Get(HRappraisalNo) then
        //   ApprovalWorkflowEnabled:=ApprovalsMgmt.CheckHREmployeeAppraisalHeaderApprovalsWorkflowEnabled(HREmployeeAppraisalHeader);
    end;

    [Scope('Personalization')]
    procedure SendHRAppraisalApprovalRequest(HrAppraisalNo: Code[20]) HRAppraisalApprovalRequestSent: Text
    begin
        HRAppraisalApprovalRequestSent := '';
        HREmployeeAppraisalHeader.Reset;
        if HREmployeeAppraisalHeader.Get(HrAppraisalNo) then begin
            //ApprovalsMgmt.OnSendHREmployeeAppraisalHeaderForApproval(HREmployeeAppraisalHeader);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", HREmployeeAppraisalHeader."No.");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst then
                HRAppraisalApprovalRequestSent := '200: HR appraisal Request sent Successfully '
            else
                HRAppraisalApprovalRequestSent := '400:' + GetLastErrorCode + '-' + GetLastErrorText;

        end;
    end;

    [Scope('Personalization')]
    procedure CancelHRAppraisalApprovalRequest(HrAppraisalNo: Code[20]) HRAppraisalApprovalRequestCanceled: Text
    begin
        HRAppraisalApprovalRequestCanceled := '';

        HREmployeeAppraisalHeaderRec.Reset;
        if HREmployeeAppraisalHeaderRec.Get(HrAppraisalNo) then begin
            //ApprovalsMgmt.OnCancelHREmployeeAppraisalHeaderApprovalRequest(HREmployeeAppraisalHeaderRec);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", HREmployeeAppraisalHeaderRec."No.");
            if ApprovalEntry.FindLast then begin
                if ApprovalEntry.FindFirst then
                    HRAppraisalApprovalRequestCanceled := '200: HR Employee Appraisal Request Cancelled Successfully '
                else
                    HRAppraisalApprovalRequestCanceled := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
            end;
        end;
    end;

    [Scope('Personalization')]
    procedure ReopenHRAppraisal(HrAppraisalNo: Code[20]) HRAppraisalOpened: Boolean
    begin
        HRAppraisalOpened := false;

        HREmployeeAppraisalHeader.Reset;
        HREmployeeAppraisalHeader.SetRange(HREmployeeAppraisalHeader."No.", HrAppraisalNo);
        if HREmployeeAppraisalHeader.FindFirst then begin
            HRApprovalManager.ReOpenHREmployeeAppraisalHeader(HREmployeeAppraisalHeader);
            HRAppraisalOpened := true;
        end;
    end;

    [Scope('Personalization')]
    procedure ApproveHRAppraisal("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]) Approved: Text
    var
        "EntryNo.": Integer;
    begin

        Approved := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.ApproveApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);

        if ApprovalEntry.FindFirst then
            Approved := '200: Hr Appraisal Approved Successfully '
        else
            Approved := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure RejectHRAppraisal("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]; RejectionComments: Text) Rejected: Text
    var
        "EntryNo.": Integer;
    begin
        Rejected := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry."Rejection Comments" := RejectionComments;
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.RejectApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Rejected);
        if ApprovalEntry.FindFirst then
            Rejected := '200: HR Appraisal Rejected Successfully '
        else
            Rejected := '400:' + GetLastErrorCode + '-' + GetLastErrorText;


        //**************************************** HR Leave Reimbursement ********************************************************************************************************************************************************
    end;

    [Scope('Personalization')]
    procedure GetEmployeeAppraisalApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; EmployeeNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::Appraisal);
        if EmployeeNo <> '' then begin
            Employee.Get(EmployeeNo);
            Employee.TestField("User ID");
            ApprovalEntry.SetRange("Approver ID", Employee."User ID");
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetAppraisalApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; AppraisalNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::Appraisal);
        if AppraisalNo <> '' then begin
            ApprovalEntry.SetRange("Document No.", AppraisalNo);
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetAppraisalRecord(var ImportExportEmployAppraisal: XMLport "Import/Export Employ Appraisal"; AppraisalNo: Code[20])
    begin
        if AppraisalNo <> '' then begin

            HREmployeeAppraisalHeaderRec.Reset;
            HREmployeeAppraisalHeaderRec.SetRange("No.", AppraisalNo);
            if HREmployeeAppraisalHeaderRec.FindFirst then;
            ImportExportEmployAppraisal.SetTableView(HREmployeeAppraisalHeaderRec);
        end
    end;

    [Scope('Personalization')]
    procedure GetCasualRequisition(var CasualExport: XMLport "Casual Export"; EmployeeNo: Code[20])
    var
        CasualRequest: Record "HR Employee Requisitions";
    begin
        if EmployeeNo <> '' then begin
            CasualRequest.Reset;
            CasualRequest.SetFilter("Employee No", EmployeeNo);
            if CasualRequest.FindFirst then;
            CasualExport.SetTableView(CasualRequest);
        end
    end;

    [Scope('Personalization')]
    procedure CreateCasualRequisition("EmployeeNo.": Code[50]; JobTitle: Code[50]; budgetVote: Code[50]; StartDate: Date; EndDate: Date; MainDuties: Text; QualificationRequired: Text; YearsOfExperience: Integer; SpecificExperienceRequired: Text; SpecificSkillRequired: Text; AgeBracket: Text; FileName: Text; NoRequiredSkilled: Integer; NoRequiredUnSkilled: Integer; DateRequired: Date; DaysOfEngagementSkilled: Integer; DaysOfEngagementUnSkilled: Integer; ReasonOfEngagement: Text; DailyRateSkilled: Decimal; DailyRateUnskilled: Decimal; ProjectNo: Code[20]) CasualRequisitionsCreated: Text
    begin
        CasualRequisitionsCreated := '';

        HumanResourcesSetup.Get;
        HumanResourcesSetup.TestField("Casual Requisition Nos.");

        Employee.Reset;
        Employee.Get("EmployeeNo.");
        HRCasualRequisitions.Init;

        HRCasualRequisitions."No." := NoSeriesMgt.GetNextNo(HumanResourcesSetup."Casual Requisition Nos.", 0D, true);

        HRCasualRequisitions."Employee No" := "EmployeeNo.";
        HRCasualRequisitions.Validate(HRCasualRequisitions."Employee No");
        HRCasualRequisitions."Main Duties" := MainDuties;
        HRCasualRequisitions."Reason for Requisition" := MainDuties;
        HRCasualRequisitions."Date Required" := DateRequired;
        HRCasualRequisitions."Number Required - Unskilled" := NoRequiredUnSkilled;
        HRCasualRequisitions."Number Required - Skilled" := NoRequiredSkilled;
        HRCasualRequisitions."Casual Job Title" := JobTitle;
        //HRCasualRequisitions."Budget Vote" := budgetVote;
        //HRCasualRequisitions.VALIDATE(HRCasualRequisitions."Budget Vote");
        //HRCasualRequisitions."Forward To" := ForwardTo;
        HRCasualRequisitions."Start Date" := StartDate;
        HRCasualRequisitions."End Date" := EndDate;
        HRCasualRequisitions."Document Type" := HRCasualRequisitions."Document Type"::"Casual Request";
        HRCasualRequisitions."Qualifications Required" := QualificationRequired;
        HRCasualRequisitions."Age bracket" := AgeBracket;
        HRCasualRequisitions."No of Years of Experience" := YearsOfExperience;
        HRCasualRequisitions."Specific Experience Required" := SpecificExperienceRequired;
        HRCasualRequisitions."Specific Skills Required" := SpecificSkillRequired;
        HRCasualRequisitions."User ID" := Employee."User ID";
        HRCasualRequisitions.FileName := FileName;
        HRCasualRequisitions."Days for Engagement - Skilled" := DaysOfEngagementSkilled;
        HRCasualRequisitions."Days for Engagement - Unkilled" := DaysOfEngagementUnSkilled;
        HRCasualRequisitions.Validate("Project No", ProjectNo);
        HRCasualRequisitions.Validate("Daily Rate Skilled", DailyRateSkilled);
        HRCasualRequisitions.Validate("Daily Rate Unskilled", DailyRateUnskilled);
        HRCasualRequisitions.Validate("Reason for engagement", ReasonOfEngagement);
        if HRCasualRequisitions.Insert then
            CasualRequisitionsCreated := '200: Casual Requisitions No ' + HRCasualRequisitions."Job No." + ' Created Successfully'
        else
            CasualRequisitionsCreated := GetLastErrorCode + '-' + GetLastErrorText;

    end;

    [Scope('Personalization')]
    procedure ModifyCasualRequisition(Casualrequestno: Code[20]; "EmployeeNo.": Code[20]; CasualMobileNo: Code[20]; ForwardTo: Code[20]; JobTitle: Code[20]; DateRequired: Date; NumberRequired: Integer; StartDate: Date; EndDate: Date; MainDuties: Text; QualificationRequired: Text; YearsOfExperience: Integer; SpecificExperienceRequired: Text; SpecificSkillRequired: Text; AgeBracket: Text; FileName: Text; DaysOfEngagementSkilled: Integer; DaysOfEngagementUnSkilled: Integer; ReasonOfEngagement: Text; DailyRateSkilled: Decimal; DailyRateUnskilled: Decimal; ProjectNo: Code[20]; NoRequiredSkilled: Integer; NoRequiredUnSkilled: Integer) CasualRequisitionsCreated: Text
    begin
        CasualRequisitionsCreated := '';

        HumanResourcesSetup.Get;


        Employee.Reset;
        Employee.Get("EmployeeNo.");
        HRCasualRequisitions.Get(Casualrequestno);

        //HRCasualRequisitions.Code:=NoSeriesMgt.GetNextNo(HumanResourcesSetup."Casuals Request Nos",0D,TRUE);
        //HRCasualRequisitions."Phone No.":=CasualMobileNo;
        HRCasualRequisitions."Date Required" := DateRequired;
        HRCasualRequisitions."Employee No" := "EmployeeNo.";
        HRCasualRequisitions.Validate(HRCasualRequisitions."Employee No");
        HRCasualRequisitions."Main Duties" := MainDuties;
        HRCasualRequisitions."Number Required" := NumberRequired;
        HRCasualRequisitions."Casual Job Title" := JobTitle;
        HRCasualRequisitions."Number Required - Unskilled" := NoRequiredUnSkilled;
        HRCasualRequisitions."Number Required - Skilled" := NoRequiredSkilled;
        //HRCasualRequisitions."Forward To" := ForwardTo;
        HRCasualRequisitions."Date Required" := DateRequired;
        HRCasualRequisitions."Start Date" := StartDate;
        HRCasualRequisitions."End Date" := EndDate;
        HRCasualRequisitions."Qualifications Required" := QualificationRequired;
        HRCasualRequisitions."Age bracket" := AgeBracket;
        HRCasualRequisitions."No of Years of Experience" := YearsOfExperience;
        HRCasualRequisitions."Specific Experience Required" := SpecificExperienceRequired;
        HRCasualRequisitions."Specific Skills Required" := SpecificSkillRequired;
        HRCasualRequisitions.FileName := FileName;
        HRCasualRequisitions."Days for Engagement - Skilled" := DaysOfEngagementSkilled;
        HRCasualRequisitions."Days for Engagement - Unkilled" := DaysOfEngagementUnSkilled;
        HRCasualRequisitions.Validate("Project No", ProjectNo);
        HRCasualRequisitions.Validate("Daily Rate Skilled", DailyRateSkilled);
        HRCasualRequisitions.Validate("Daily Rate Unskilled", DailyRateUnskilled);
        HRCasualRequisitions.Validate("Reason for engagement", ReasonOfEngagement);
        //HRCasualRequisitions."Created by":= Employee."User ID";
        if HRCasualRequisitions.Modify then
            CasualRequisitionsCreated := '200: Casual Requisitions No ' + HRCasualRequisitions."Job No." + ' Created Successfully'
        else
            CasualRequisitionsCreated := GetLastErrorCode + '-' + GetLastErrorText;

    end;

    [Scope('Personalization')]
    procedure SendCasualRequestApprovalRequest(HRCasualRequisitionNo: Code[20]) CasualRequestApprovalRequestSent: Text
    begin
        CasualRequestApprovalRequestSent := '';

        HRCasualRequisitions.Reset;
        if HRCasualRequisitions.Get(HRCasualRequisitionNo) then begin

            //IF BudgetAmountCasual('','CASUAL',HRCasualRequisitions."Start Date",HRCasualRequisitions."Budget GL") > 0 THEN BEGIN

            //ApprovalsMgmt.OnSendCReqForApproval(HRCasualRequisitions);
            //ApprovalsMgmt.OnSendCasualRequestForApproval(HRCasualRequisitions);

            if ApprovalsMgmt.CheckHREmployeeRequisitionApprovalsWorkflowEnabled(HRCasualRequisitions) then
                ApprovalsMgmt.OnSendHREmployeeRequisitionForApproval(HRCasualRequisitions);

            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", HRCasualRequisitions."No.");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst then
                CasualRequestApprovalRequestSent := '200: Approval Request sent Successfully.'
            else
                CasualRequestApprovalRequestSent := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
            //END ELSE  CasualRequestApprovalRequestSent:='400: Budget is Insufficient, Please try Escalating Instead.';
        end;
    end;

    [Scope('Personalization')]
    procedure ApproveCasualRequest("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]) Approved: Text
    var
        "EntryNo.": Integer;
    begin

        Approved := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.ApproveApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);

        if ApprovalEntry.FindFirst then
            Approved := '200: Record Approved Successfully '
        else
            Approved := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure RejectCasualRequest("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]; RejectionComments: Text) Rejected: Text
    var
        "EntryNo.": Integer;
    begin
        Rejected := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry."Rejection Comments" := RejectionComments;
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.RejectApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Rejected);
        if ApprovalEntry.FindFirst then
            Rejected := '200: Record Rejected Successfully '
        else
            Rejected := '400:' + GetLastErrorCode + '-' + GetLastErrorText;


        //**************************************** HR casual request ********************************************************************************************************************************************************
    end;

    [Scope('Personalization')]
    procedure GetEmployeeCasualRequestApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; EmployeeNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::Requisition);
        if EmployeeNo <> '' then begin
            Employee.Get(EmployeeNo);
            Employee.TestField("User ID");
            ApprovalEntry.SetRange("Approver ID", Employee."User ID");
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetCasualRequestApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; DocumentNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::Requisition);
        if DocumentNo <> '' then begin
            ApprovalEntry.SetRange("Document No.", DocumentNo);
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetCasualRequisitionDocument(var CasualExport: XMLport "Casual Export"; DocumentNo: Code[20])
    var
        CasualRequest: Record "HR Employee Requisitions";
    begin
        if DocumentNo <> '' then begin
            CasualRequest.Reset;
            CasualRequest.SetFilter("No.", DocumentNo);
            if CasualRequest.FindFirst then;
            CasualExport.SetTableView(CasualRequest);
        end
    end;

    [Scope('Personalization')]
    procedure DeleteCasualRequestLine(DocNo: Code[20]; LineNo: Integer) ReturnValueDeleted: Boolean
    begin
        ReturnValueDeleted := false;
        /*
        HRCasualRequisitionsLine.RESET;
        
        HRCasualRequisitionsLine.SETRANGE(HRCasualRequisitionsLine."Line No",LineNo);
        HRCasualRequisitionsLine.SETRANGE(HRCasualRequisitionsLine."No.",DocNo);
        
        IF HRCasualRequisitionsLine.FINDFIRST THEN BEGIN
          IF HRCasualRequisitionsLine.DELETE THEN BEGIN
            ReturnValueDeleted:=TRUE;
          END;
        END;
        */
        //************************************************** HR Training Need Application Workflows *********************************************************************************************************

    end;

    [Scope('Personalization')]
    procedure CreateCasualRequisitionLine(HeaderNo: Code[20]; Qualification: Code[20]; NumberRequired: Integer; RateUnitOfMeasure: Code[50]; Quantity: Decimal; PayRate: Decimal) CasualRequisitionsCreated: Text
    var
        LineNo: Integer;
    begin
        CasualRequisitionsCreated := '';
        /*
        HRCasualRequisitionsLine.INIT;
        
        IF HRCasualRequisitionsLine.FINDLAST THEN
          LineNo:=HRCasualRequisitionsLine."Line No"+10000
        ELSE
          LineNo:=10000;
        
        HRCasualRequisitionsLine."Line No" := LineNo;
        HRCasualRequisitionsLine."No." := HeaderNo;
        //HRCasualRequisitionsLine.Station := Station;
        HRCasualRequisitionsLine."Number Required" := NumberRequired;
        //HRCasualRequisitionsLine.VALIDATE("Requested Employees");
        HRCasualRequisitionsLine."Rate Unit of Measure" := RateUnitOfMeasure;
        HRCasualRequisitionsLine.VALIDATE("Rate Unit of Measure");
        HRCasualRequisitionsLine."Pay Rate" := PayRate;
        HRCasualRequisitionsLine.VALIDATE("Pay Rate");
        HRCasualRequisitionsLine."No of days" := Quantity;
        HRCasualRequisitionsLine.VALIDATE("No of days");
        
        
        IF HRCasualRequisitionsLine.INSERT THEN
            CasualRequisitionsCreated:='200: Casual Requisitions Line Created Successfully'
         ELSE
          CasualRequisitionsCreated:= '400: Error Occured '+GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
         */

    end;

    [Scope('Personalization')]
    procedure ModifyCasualRequisitionLine(LineNo: Integer; HeaderNo: Code[20]; Station: Code[20]; NumberRequired: Integer; JobTitle: Code[50]) CasualRequisitionsCreated: Text
    begin
        CasualRequisitionsCreated := '';
        /*
        HRCasualRequisitionsLine.RESET;
        
        //HRCasualRequisitionsLine.GET(LineNo);
        HRCasualRequisitionsLine.SETRANGE("Line No",LineNo);
        HRCasualRequisitionsLine.SETRANGE("No.",HeaderNo);
        
        IF HRCasualRequisitionsLine.FINDFIRST THEN BEGIN
          HRCasualRequisitionsLine."Line No" := LineNo;
        //HRCasualRequisitionsLine."Casual Request" := HeaderNo;
        //HRCasualRequisitionsLine.Station := Station;
        HRCasualRequisitionsLine."Requested Employees" := NumberRequired;
        HRCasualRequisitionsLine."Casual Job Title" := JobTitle;
        HRCasualRequisitionsLine.VALIDATE("Requested Employees");
        HRCasualRequisitionsLine.VALIDATE("Casual Job Title");
        
        IF HRCasualRequisitionsLine.MODIFY THEN
            CasualRequisitionsCreated:='200: Casual Requisitions Line Modified Successfully'
         ELSE
          CasualRequisitionsCreated:= '400: Error Occured '+GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        
        END ELSE
          CasualRequisitionsCreated:= '400: Line NOT Found!';
        
        */

    end;

    [Scope('Personalization')]
    procedure GetCasualRequisitionLine(var CasualRequestLineExport: XMLport casualLineExport; HeaderNo: Code[20])
    var
        CasualRequest: Record "HR Employee Requisitions";
    begin
        if HeaderNo <> '' then begin
            HRCasualRequisitionsLine.Reset;
            HRCasualRequisitionsLine.SetRange("No.", HeaderNo);
            if HRCasualRequisitionsLine.FindFirst then;
            CasualRequestLineExport.SetTableView(HRCasualRequisitionsLine);

        end
    end;

    [Scope('Personalization')]
    procedure GenerateP9(EmployeeNo: Code[20]; Year: Integer) ServerPath: Text
    var
        PortalP9AReport: Report "Portal P9A Report";
        Filename: Text;
        PortalSetup: Record "Portal Setup";
        Filepath: Text;
    begin
        PortalSetup.Reset;
        PortalSetup.Get;
        PortalSetup.TestField("Server File Path");
        PortalSetup.TestField("Local File Path");
        Filename := DelChr(EmployeeNo, '=', '/') + '_' + Format(Year) + '_p9.pdf';
        Filepath := PortalSetup."Local File Path" + Filename;
        if FILE.Exists(Filepath) then
            FILE.Erase(Filepath);
        PortalP9AReport.sSetParameters(Year, EmployeeNo);
        PortalP9AReport.SaveAsPdf(Filepath);
        if FILE.Exists(Filepath) then
            ServerPath := PortalSetup."Server File Path" + Filename
        else
            Error('There was an Error. Please Try again');
    end;

    [Scope('Personalization')]
    procedure CreateLeavePlan(EmployeeNo: Code[20]; LeaveType: Code[50]; CreatedBy: Code[20]; Description: Text) LeaveApplicationCreated: Text
    var
        HRLeaveType: Record "HR Leave Types";
        Text101: Label 'Applied number of days must be equal to %1';
    begin
        LeaveApplicationCreated := '';

        HumanResourcesSetup.Get;

        Employee.Reset;
        Employee.Get(EmployeeNo);


        HRLeavePlannerHeader.Init;
        HRLeavePlannerHeader."No." := NoSeriesMgt.GetNextNo(HumanResourcesSetup."Leave Planner Nos.", 0D, true);

        HRLeavePlannerHeader."Employee No." := EmployeeNo;
        HRLeavePlannerHeader.Validate("Employee No.");
        HRLeavePlannerHeader."Document Date" := Today;

        HRLeavePlannerHeader."Leave Type" := LeaveType;
        HRLeavePlannerHeader.Description := Description;
        HRLeavePlannerHeader."User ID" := Employee."User ID";
        HRLeavePlannerHeader."Created By Employee" := CreatedBy;
        if HRLeavePlannerHeader.Insert then begin
            LeaveApplicationCreated := '200:' + HRLeavePlannerHeader."No." + ': Leave Plan Created Successfully';
        end else
            LeaveApplicationCreated := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyLeavePlan(LeavePlanNo: Code[30]; EmployeeNo: Code[20]; LeaveType: Code[50]; CreatedBy: Code[20]; Description: Text) LeaveApplicationModified: Text
    var
        Text101: Label 'Applied number of days must be equal to %1';
        HRLeaveType: Record "HR Leave Types";
    begin
        //ERROR(Text_0001);
        LeaveApplicationModified := '';
        HumanResourcesSetup.Get;

        Employee.Reset;
        Employee.Get(EmployeeNo);

        HRLeavePlannerHeader.Reset;
        HRLeavePlannerHeader.SetRange(HRLeavePlannerHeader."No.", LeavePlanNo);
        if HRLeavePlannerHeader.FindFirst then begin
            HRLeavePlannerHeader."Employee No." := EmployeeNo;
            HRLeavePlannerHeader.Validate("Employee No.");
            HRLeavePlannerHeader.Description := Description;
            //HRLeavePlannerHeader.VALIDATE("Leave Type",LeaveType);
            HRLeavePlannerHeader."Leave Type" := LeaveType;
            HRLeavePlannerHeader."User ID" := Employee."User ID";
            HRLeavePlannerHeader.Modify;
            LeaveApplicationModified := '200: Leave plan Application No ' + HRLeavePlannerHeader."No." + ' Modified Successfully';
        end else
            LeaveApplicationModified := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure SendLeavePlanApprovalRequest("HRLeaveApplicationNo.": Code[20]) LeaveApplicationApprovalRequestSent: Text
    begin
        LeaveApplicationApprovalRequestSent := '';

        HRLeavePlannerHeader.Reset;
        if HRLeavePlannerHeader.Get("HRLeaveApplicationNo.") then begin
            ApprovalsMgmt.OnSendHRLeavePlannerHeaderForApproval(HRLeavePlannerHeader);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", HRLeavePlannerHeader."No.");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst then
                LeaveApplicationApprovalRequestSent := '200: Leave Plan Approval Request sent Successfully '
            else
                LeaveApplicationApprovalRequestSent := '400:' + GetLastErrorCode + '-' + GetLastErrorText;

        end;
    end;

    [Scope('Personalization')]
    procedure CancelLeavePlanApprovalRequest("LeaveApplicationNo.": Code[20]) LeaveApplicationApprovalRequestCanceled: Text
    begin
        LeaveApplicationApprovalRequestCanceled := '';

        HRLeaveApplication.Reset;
        if HRLeaveApplication.Get("LeaveApplicationNo.") then begin
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", HRLeaveApplication."No.");
            if ApprovalEntry.FindLast then begin
                ApprovalEntry."Web Portal Approval" := true;
                ApprovalEntry.Modify;
                //ApprovalsMgmt.OnCancelHRLeaveApplicationApprovalRequest(HRLeaveApplication);
                Commit;
                if ApprovalEntry.FindFirst then
                    LeaveApplicationApprovalRequestCanceled := '200: Leave Plan Approval Request Cancelled Successfully '
                else
                    LeaveApplicationApprovalRequestCanceled := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
            end;
        end;
    end;

    [Scope('Personalization')]
    procedure ReopenLeavePlan("LeaveApplicationNo.": Code[20]) LeaveApplicationOpened: Boolean
    begin
        LeaveApplicationOpened := false;

        HRLeaveApplication.Reset;
        HRLeaveApplication.SetRange(HRLeaveApplication."No.", "LeaveApplicationNo.");
        if HRLeaveApplication.FindFirst then begin
            HRApprovalManager.ReOpenHRLeaveApplication(HRLeaveApplication);
            LeaveApplicationOpened := true;
        end;
    end;

    [Scope('Personalization')]
    procedure ApproveLeavePlan("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]) Approved: Text
    var
        "EntryNo.": Integer;
    begin

        Approved := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.ApproveApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);

        if ApprovalEntry.FindFirst then
            Approved := '200: Record Approved Successfully '
        else
            Approved := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure RejectLeavePlan("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]; RejectionComments: Text) Rejected: Text
    var
        "EntryNo.": Integer;
    begin
        Rejected := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry."Rejection Comments" := RejectionComments;
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.RejectApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Rejected);
        if ApprovalEntry.FindFirst then
            Rejected := '200: Record Rejected Successfully '
        else
            Rejected := '400:' + GetLastErrorCode + '-' + GetLastErrorText;


        //**************************************** HR Leave Reimbursement ********************************************************************************************************************************************************
    end;

    [Scope('Personalization')]
    procedure GetEmployeeLeavePlanApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; EmployeeNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::"Leave Plan");
        if EmployeeNo <> '' then begin
            Employee.Get(EmployeeNo);
            Employee.TestField("User ID");
            ApprovalEntry.SetRange("Approver ID", Employee."User ID");
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetLeavePlanApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; LeavePlanNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::"Leave Plan");
        if LeavePlanNo <> '' then begin
            ApprovalEntry.SetRange("Document No.", LeavePlanNo);
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetLeavePlanList(var LeavePlanImportExport: XMLport "Leave Plan Import/Export"; EmployeeNo: Code[20])
    begin
        if EmployeeNo <> '' then begin
            HRLeavePlannerHeader2.Reset;
            HRLeavePlannerHeader2.SetFilter("Employee No.", EmployeeNo);
            if HRLeavePlannerHeader2.FindFirst then;
            LeavePlanImportExport.SetTableView(HRLeavePlannerHeader2);
        end
    end;

    [Scope('Personalization')]
    procedure GetLeavePlanListStatus(var LeavePlanImportExport: XMLport "Leave Plan Import/Export"; EmployeeNo: Code[20]; StatusFilter: Option Open,"Pending Approval",Approved,Rejected,Posted)
    begin
        HRLeavePlannerHeader2.Reset;
        HRLeavePlannerHeader2.SetRange(Status, StatusFilter);
        if EmployeeNo <> '' then begin

            HRLeavePlannerHeader2.SetFilter("Employee No.", EmployeeNo);
            if HRLeavePlannerHeader2.FindFirst then;
            LeavePlanImportExport.SetTableView(HRLeavePlannerHeader2);
        end
    end;

    [Scope('Personalization')]
    procedure GetLeavePlanHeaderLines(var LeavePlanImportExport: XMLport "Leave Plan Import/Export"; HeaderNo: Code[20])
    begin

        if HeaderNo <> '' then begin
            HRLeavePlannerHeader2.Reset;
            HRLeavePlannerHeader2.SetFilter("No.", HeaderNo);
            if HRLeavePlannerHeader2.FindFirst then;
            LeavePlanImportExport.SetTableView(HRLeavePlannerHeader2);
        end
    end;

    [Scope('Personalization')]
    procedure CreateLeavePlanLine(LeavePLanNo: Code[20]; LeaveMonth: Code[50]; NoofDays: Integer; RelieverNo: Code[20]; StartDate: Date) LeavePlanLineCreated: Text
    var
        HREmployee: Record Employee;
    begin
        LeavePlanLineCreated := '';
        HRLeavePlannerHeader.Reset;
        HRLeavePlannerHeader.Get(LeavePLanNo);

        HRLeavePlannerLine.Init;
        HRLeavePlannerLine."Leave Planner No." := LeavePLanNo;
        HRLeavePlannerLine.Month := LeaveMonth;
        HRLeavePlannerLine."Start Date" := StartDate;
        //HRLeavePlannerLine."No. of Days" :=NoofDays;
        HRLeavePlannerLine.Validate("No. of Days", NoofDays);
        HRLeavePlannerLine.Validate("Reliever No.", RelieverNo);

        if HRLeavePlannerLine.Insert then begin
            LeavePlanLineCreated := '200: Leave Plan Line Successfully Created';
        end else
            LeavePlanLineCreated := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure DeleteLeavePlanLine(LeaveMonth: Text; LeavePLanNo: Code[20]) LeavePlanLineDeleted: Boolean
    begin
        LeavePlanLineDeleted := false;

        HRLeavePlannerLine.Reset;
        HRLeavePlannerLine.SetRange(Month, LeaveMonth);
        HRLeavePlannerLine.SetRange("Leave Planner No.", LeavePLanNo);
        if HRLeavePlannerLine.FindFirst then begin
            if HRLeavePlannerLine.Delete then begin

                LeavePlanLineDeleted := true;
            end;
        end;
    end;

    [Scope('Personalization')]
    procedure ModifyLeavePlanLine(LeavePLanNo: Code[20]; LeaveMonth: Code[50]; NoofDays: Integer; RelieverNo: Code[20]; StartDate: Date) LeavePlanLineCreated: Text
    var
        HREmployee: Record Employee;
    begin
        LeavePlanLineCreated := '';
        HRLeavePlannerHeader.Reset;
        HRLeavePlannerHeader.Get(LeavePLanNo);

        HRLeavePlannerLine.Get(LeavePLanNo, LeaveMonth);
        HRLeavePlannerLine."Leave Planner No." := LeavePLanNo;
        HRLeavePlannerLine.Month := LeaveMonth;
        HRLeavePlannerLine."Start Date" := StartDate;
        HRLeavePlannerLine.Validate("No. of Days", NoofDays);
        HRLeavePlannerLine.Validate("Reliever No.", RelieverNo);

        if HRLeavePlannerLine.Modify then begin
            LeavePlanLineCreated := '200: Leave Plan Line Successfully modified';
        end else
            LeavePlanLineCreated := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure GetLeavePlanCreatedByList(var LeavePlanImportExport: XMLport "Leave Plan Import/Export"; EmployeeNo: Code[20]; Createdby: Code[20])
    begin
        if EmployeeNo <> '' then begin
            HRLeavePlannerHeader2.Reset;
            HRLeavePlannerHeader2.SetFilter("Employee No.", '<>%1', EmployeeNo);
            HRLeavePlannerHeader2.SetFilter("Created By Employee", Createdby);
            if HRLeavePlannerHeader2.FindFirst then;
            LeavePlanImportExport.SetTableView(HRLeavePlannerHeader2);
        end
    end;

    [Scope('Personalization')]
    procedure CreateAttendanceTerminal("Terminal No": Code[20]; "Givenl Name": Code[30]; "Terminal Actual Name": Code[20]; Location: Code[30]; "Tcp Ip": Code[30]; "Domain name": Code[150]; "Serial No": Code[30]; Type: Code[30]) ReturnValue: Text
    var
        HRTrainingEvaluation2: Record "Training Evaluation";
    begin
        ReturnValue := '500: did not insert';

        HumanResourcesSetup.Get;



        AttendanceTerminal.Init;
        AttendanceTerminal.No := NoSeriesMgt.GetNextNo(HumanResourcesSetup."Leave Application Nos.", 0D, true);

        AttendanceTerminal.Name := "Givenl Name";
        AttendanceTerminal.Location := Location;
        AttendanceTerminal."Domain Name" := "Domain name";
        AttendanceTerminal.Type := Type;
        AttendanceTerminal."Terminal Tcp Ip" := "Tcp Ip";
        AttendanceTerminal."Terminal Serial Number" := "Serial No";
        AttendanceTerminal."Terminal Device Name" := "Terminal Actual Name";
        AttendanceTerminal."Terminal No" := "Terminal No";
        if AttendanceTerminal.Insert then begin
            ReturnValue := '200: Record inserted successfully';
        end;
    end;

    [Scope('Personalization')]
    procedure CreateAttendanceRecord("Employee No": Code[20]; "Employee Name": Code[150]; Time: DateTime; "Work Status": Option; Type: Option; "Terminal No": Code[150]; "Terminal Name": Code[30]; "Terminal Location": Code[30]; "Attendance Status": Code[20]) ReturnValue: Text
    var
        HRTrainingEvaluation2: Record "Training Evaluation";
    begin
        ReturnValue := '500: did not insert';

        HumanResourcesSetup.Get;

        AttendanceRecord.Init;
        AttendanceRecord.No := NoSeriesMgt.GetNextNo(HumanResourcesSetup."Attendance Nos", 0D, true);

        AttendanceRecord."Employee No" := "Employee No";
        AttendanceRecord."Employee Name" := "Employee Name";
        AttendanceRecord.Time := Time;
        AttendanceRecord.Validate(Time);
        AttendanceRecord."Work Status" := "Work Status";
        AttendanceRecord.Type := Type;
        AttendanceRecord."Terminal No" := "Terminal No";
        AttendanceRecord."Terminal Name" := "Terminal Name";
        AttendanceRecord."Terminal Location" := "Terminal Location";
        AttendanceRecord."Attendance Status" := "Attendance Status";
        if AttendanceRecord.Insert then begin
            ReturnValue := '200: Record inserted successfully';
        end;
    end;

    [Scope('Personalization')]
    procedure CreateAttendanceTimetable(Name: Code[30]; "Start time": DateTime; "End Time": DateTime; "Checkin begin": DateTime; "Checkin end": DateTime; "Checkout Begin": DateTime; "Checkout End": DateTime; Late: Boolean; "Late Come": Integer; Early: Boolean; "Early Out": Integer) ReturnValue: Text
    var
        HRTrainingEvaluation2: Record "Training Evaluation";
    begin
        ReturnValue := '500: did not insert';

        HumanResourcesSetup.Get;

        AttendanceTimetable.Init;
        AttendanceTimetable.No := NoSeriesMgt.GetNextNo(HumanResourcesSetup."Approved Training Nos", 0D, true);

        AttendanceTimetable.Name := Name;
        AttendanceTimetable."Start Time" := "Start time";
        AttendanceTimetable."End Time" := "End Time";
        AttendanceTimetable."Check In Begin" := "Checkin begin";
        AttendanceTimetable."Check In End" := "Checkin end";
        AttendanceTimetable."Check out Start" := "Checkout Begin";
        AttendanceTimetable."Check Out End" := "Checkout End";
        AttendanceTimetable.Late := Late;
        AttendanceTimetable."Late Come" := "Late Come";
        AttendanceTimetable.Early := Early;
        AttendanceTimetable."Early Out" := "Early Out";
        if AttendanceTimetable.Insert then begin
            ReturnValue := '200: Record inserted successfully';
        end;
    end;

    [Scope('Personalization')]
    procedure CreateAttendanceSummary(No: Code[20]; EmployeeNo: Code[30]; "Time In": Text; "Time Out": Text; "Agreed Status": Code[150]; Clocked: Boolean; "Clocked In Late": Boolean; "Clocked Out Ealy": Boolean; "Date Clocked": Date; "Break Out": Text; "Break In": Text) ReturnValue: Text
    var
        HRTrainingEvaluation2: Record "Training Evaluation";
        TimeIn: DateTime;
        Timeout: DateTime;
    begin
        ReturnValue := '400: Did not insert';

        HumanResourcesSetup.Get;

        AttendanceSummary.Init;
        AttendanceSummary."No." := NoSeriesMgt.GetNextNo(HumanResourcesSetup."Attendance Summary Nos", 0D, true);// No;
        AttendanceSummary."Employee No." := EmployeeNo;
        AttendanceSummary.Validate("Employee No.");

        if Evaluate(TimeIn, "Time In") then
            AttendanceSummary."Time In" := TimeIn;
        if Evaluate(Timeout, "Time Out") then
            AttendanceSummary."Time Out" := Timeout;

        AttendanceSummary."Time In String" := "Time In";
        AttendanceSummary."Time out String" := "Time Out";
        AttendanceSummary.Date := "Date Clocked";

        AttendanceSummary.Id := No;
        AttendanceSummary."Agreed Status" := "Agreed Status";
        AttendanceSummary.Clocked := Clocked;
        AttendanceSummary."Clocked In Late" := "Clocked In Late";
        AttendanceSummary."Clocket Out Early" := "Clocked Out Ealy";
        AttendanceSummary."Break Out" := "Break Out";
        AttendanceSummary."Break In" := "Break In";
        if AttendanceSummary.Insert then begin
            ReturnValue := AttendanceSummary."No."; //'200: Record inserted successfully';
        end;
    end;

    [Scope('Personalization')]
    procedure GetEmployeeDetails(var EmployeeExport: XMLport "Employee2 Export"; EmployeeNo: Code[20])
    var
        Customer: Record Customer;
    begin
        if EmployeeNo <> '' then begin

            Employee.Reset;
            Employee.SetRange("No.", EmployeeNo);
            if Employee.FindFirst then;
            EmployeeExport.SetTableView(Employee);
        end;

        //Update 9/29/2020 jim
    end;

    [Scope('Personalization')]
    procedure GetEmployeeLeaveStatus(EmployeeNo: Code[20]; Date: Date) ReturnValue: Text
    begin
        if EmployeeNo <> '' then begin
            HRLeaveApplication.Reset;
            HRLeaveApplication.SetRange("Employee No.", EmployeeNo);
            HRLeaveApplication.SetFilter(Status, '%1|%2', HRLeaveApplication.Status::Posted, HRLeaveApplication.Status::Released);
            HRLeaveApplication.SetFilter(HRLeaveApplication."Leave Start Date", '<%1', Date);
            HRLeaveApplication.SetFilter(HRLeaveApplication."Leave End Date", '>%1', Date);
            if HRLeaveApplication.FindFirst then
                ReturnValue := 'On Leave'
            else
                ReturnValue := 'False'
        end;

        //Update 9/29/2020 jim
    end;

    [Scope('Personalization')]
    procedure ModifyAttendanceSummary(DocumentNo: Code[20]; "Time In": Text; "Time Out": Text; "Agreed Status": Code[150]; Clocked: Boolean; "Clocked In Late": Boolean; "Clocked Out Ealy": Boolean; "Date Clocked": Date; "Break Out": Text; "Break In": Text) ReturnValue: Text
    var
        HRTrainingEvaluation2: Record "Training Evaluation";
        TimeIn: DateTime;
        Timeout: DateTime;
    begin
        ReturnValue := '400: Did not insert';

        HumanResourcesSetup.Get;

        AttendanceSummary.Reset;
        AttendanceSummary.SetRange("No.", DocumentNo);
        if AttendanceSummary.FindFirst then begin
            if Evaluate(TimeIn, "Time In") then
                AttendanceSummary."Time In" := TimeIn;
            if Evaluate(Timeout, "Time Out") then
                AttendanceSummary."Time Out" := Timeout;

            AttendanceSummary."Time In String" := "Time In";
            AttendanceSummary."Time out String" := "Time Out";
            AttendanceSummary.Date := "Date Clocked";
            AttendanceSummary."Agreed Status" := "Agreed Status";
            AttendanceSummary.Clocked := Clocked;
            AttendanceSummary."Clocked In Late" := "Clocked In Late";
            AttendanceSummary."Clocket Out Early" := "Clocked Out Ealy";
            AttendanceSummary."Break Out" := "Break Out";
            AttendanceSummary."Break In" := "Break In";
            if AttendanceSummary.Modify then begin
                ReturnValue := '200: Record ' + AttendanceSummary."No." + ' Modified successfully';
            end;

        end;
    end;

    [Scope('Personalization')]
    procedure GetAllApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; EmployeeNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetFilter(Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Approved, ApprovalEntry.Status::Rejected);
        if EmployeeNo <> '' then begin
            Employee.Get(EmployeeNo);
            Employee.TestField("User ID");
            ApprovalEntry.SetRange("Approver ID", Employee."User ID");
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure ApproveRecord("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]) Approved: Text
    var
        "EntryNo.": Integer;
    begin

        Approved := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.ApproveApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);

        if ApprovalEntry.FindFirst then
            Approved := '200: Record Approved Successfully '
        else
            Approved := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure RejectRecord("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]; RejectionComments: Text) Rejected: Text
    var
        "EntryNo.": Integer;
    begin
        Rejected := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry."Rejection Comments" := RejectionComments;
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.RejectApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Rejected);
        if ApprovalEntry.FindFirst then
            Rejected := '200: Record Rejected Successfully '
        else
            Rejected := '400:' + GetLastErrorCode + '-' + GetLastErrorText;


        //**************************************** HR Leave Reimbursement ********************************************************************************************************************************************************
    end;

    [Scope('Personalization')]
    procedure GenerateApprovalPrintOut(DocumentType: Integer; DocumentNo: Code[20]) ServerPath: Text
    var
        PortalP9AReport: Report "Portal P9A Report";
        Filename: Text;
        PortalSetup: Record "Portal Setup";
        Filepath: Text;
    begin
        PortalSetup.Reset;
        PortalSetup.Get;
        PortalSetup.TestField("Server File Path");
        PortalSetup.TestField("Local File Path");
        Filename := DelChr(DocumentNo, '=', '/') + '_' + Format(DocumentType) + '_printout.pdf';
        Filepath := PortalSetup."Local File Path" + Filename;

        if ((DocumentType = 1) or (DocumentType = 6)) then begin
            // if FILE.Exists(Filepath) then
            // FILE.Erase(Filepath);

            TransferOrderPortal.sSetParameters(DocumentNo);
            // TransferOrderPortal.SaveAsPdf(Filepath);
            // if FILE.Exists(Filepath) then
            //   ServerPath:=PortalSetup."Server File Path"+Filename
            // else
            //   ServerPath := '';
            //ERROR('There was an Error. Please Try again');
        end;
    end;
}

