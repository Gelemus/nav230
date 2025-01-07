codeunit 50036 "HR Leave Management"
{

    trigger OnRun()
    begin
    end;

    var
        HRGeneralSetup: Record "Human Resources Setup";
        Employee: Record Employee;
        LeaveLedgerEntry: Record "HR Leave Ledger Entries";
        LeavePeriods: Record "HR Leave Periods";
        LeaveTypes: Record "HR Leave Types";
        HRCalender: Record "HR Base Calendar";
        CalendarMgmt: Codeunit "HR Calendar Management";
        Description: Text[30];
        HRLeavePlannerHeader: Record "HR Leave Planner Header";
        HRLeaveApplication: Record "HR Leave Application";
        HRLeaveAllocationHeader: Record "HR Leave Allocation Header";
        HRLeaveAllocationLine: Record "HR Leave Allocation Line";
        HRReimbursment: Record "HR Leave Reimbursement";
        HRCarryOver: Record "HR Leave Carryover";
        Text0001: Label ' Leave Reimbursment is already Posted!';
        LeaveYear: Integer;
        LeaveEndDate: Date;
        // SMTPMail: Codeunit "SMTP Mail";
        // SMTP: Record "SMTP Mail Setup";
        VarInteger: Integer;

    procedure CheckOpenLeavePlannerExists(EmployeeUserID: Code[50]) OpenLeavePlannerExist: Boolean
    begin
        OpenLeavePlannerExist := false;
        HRLeavePlannerHeader.Reset;
        HRLeavePlannerHeader.SetRange(HRLeavePlannerHeader."User ID", EmployeeUserID);
        HRLeavePlannerHeader.SetRange(HRLeavePlannerHeader.Status, HRLeavePlannerHeader.Status::Open);
        if HRLeavePlannerHeader.FindFirst then begin
            OpenLeavePlannerExist := true;
        end;
    end;

    procedure CheckOpenLeaveApplicationExists(EmployeeUserID: Code[50]) OpenLeaveApplicationExist: Boolean
    begin
        OpenLeaveApplicationExist := false;
        HRLeaveApplication.Reset;
        HRLeaveApplication.SetRange(HRLeaveApplication."User ID", EmployeeUserID);
        HRLeaveApplication.SetRange(HRLeaveApplication.Status, HRLeaveApplication.Status::Open);
        if HRLeaveApplication.FindFirst then begin
            OpenLeaveApplicationExist := true;
        end;
    end;

    procedure CheckOpenLeaveReimbursementExists(EmployeeUserID: Code[50]) OpenLeaveReimbursementExist: Boolean
    begin
        OpenLeaveReimbursementExist := false;
        HRReimbursment.Reset;
        HRReimbursment.SetRange(HRReimbursment."User ID", EmployeeUserID);
        HRReimbursment.SetRange(HRReimbursment.Status, HRReimbursment.Status::Open);
        if HRReimbursment.FindFirst then begin
            OpenLeaveReimbursementExist := true;
        end;
    end;

    procedure CalculateLeaveEndDate(LeaveType: Code[50]; LeavePeriod: Code[20]; LeaveStartDate: Date; DaysApplied: Integer; BaseCalendarCode: Code[10]) LeaveEndDate: Date
    var
        NonWorkingDay: Boolean;
        LeaveDays: Integer;
        LeaveEndDateFormula: DateFormula;
    begin
        LeaveTypes.Reset;
        LeaveTypes.Get(LeaveType);
        if LeaveTypes."Inclusive of Non Working Days" then begin
            LeaveDays := DaysApplied - 1;
            Evaluate(LeaveEndDateFormula, Format(LeaveDays) + 'D');
            LeaveEndDate := CalcDate(LeaveEndDateFormula, LeaveStartDate);
        end else begin
            LeaveDays := DaysApplied;
            LeaveEndDate := CalcDate('-1D', LeaveStartDate);
            while LeaveDays > 0 do begin
                LeaveEndDate := CalcDate('1D', LeaveEndDate);
                if BaseCalendarCode = '' then
                    NonWorkingDay := CalendarMgmt.CheckDateStatus(LeaveTypes."Base Calendar", LeaveEndDate, Description)
                else
                    NonWorkingDay := CalendarMgmt.CheckDateStatus(BaseCalendarCode, LeaveEndDate, Description);
                if not NonWorkingDay then begin
                    LeaveDays := LeaveDays - 1;
                end;
            end;
        end;
    end;

    procedure CalculateLeaveReturnDate(LeaveType: Code[50]; LeavePeriod: Code[20]; LeaveEndDate: Date; BaseCalendarCode: Code[10]) LeaveReturnDate: Date
    var
        NonWorkingDay: Boolean;
    begin
        LeaveTypes.Reset;
        LeaveTypes.Get(LeaveType);
        LeaveReturnDate := LeaveEndDate;
        repeat
            LeaveReturnDate := CalcDate('1D', LeaveReturnDate);
            if BaseCalendarCode = '' then
                NonWorkingDay := CalendarMgmt.CheckDateStatus(LeaveTypes."Base Calendar", LeaveReturnDate, Description)
            else
                NonWorkingDay := CalendarMgmt.CheckDateStatus(BaseCalendarCode, LeaveReturnDate, Description);
        until NonWorkingDay = false;
    end;

    procedure CheckLeaveApplicationMandatoryFields("HR Leave Application": Record "HR Leave Application"; Posting: Boolean)
    var
        HRLeaveApplication: Record "HR Leave Application";
        HRLeaveApplication2: Record "HR Leave Application";
    begin
        HRLeaveApplication.TransferFields("HR Leave Application", true);
        HRLeaveApplication.TestField(HRLeaveApplication."Posting Date");
        HRLeaveApplication.TestField(HRLeaveApplication."Employee No.");
        HRLeaveApplication.TestField(HRLeaveApplication."Leave Type");
        HRLeaveApplication.TestField(HRLeaveApplication."Leave Period");
        HRLeaveApplication.TestField(HRLeaveApplication."Days Approved");
        /*IF Posting THEN
          HRLeaveApplication.TESTFIELD(HRLeaveApplication.Status,HRLeaveApplication.Status::Released);*/

    end;

    procedure PostLeaveApplication(LeaveApplication: Code[20]) LeavePosted: Boolean
    var
        HRLeaveApplication: Record "HR Leave Application";
        HRLeaveApplication2: Record "HR Leave Application";
        LeaveDescription: Label 'Leave Application for Leave Type: %1, Leave Period:%2';
    begin
        LeavePosted := false;
        HRLeaveApplication.Reset;
        HRLeaveApplication.Get(LeaveApplication);
        if Employee.Get(HRLeaveApplication."Employee No.") then begin
            LeaveLedgerEntry.Init;
            LeaveLedgerEntry."Line No." := 0;
            LeaveLedgerEntry."Document No." := HRLeaveApplication."No.";
            LeaveLedgerEntry."Posting Date" := Today;
            LeaveLedgerEntry."Leave Year" := Date2DMY(HRLeaveApplication."Posting Date", 3);
            LeaveLedgerEntry."Entry Type" := LeaveLedgerEntry."Entry Type"::"Negative Adjustment";
            LeaveLedgerEntry."Employee No." := HRLeaveApplication."Employee No.";
            LeaveLedgerEntry."Leave Type" := HRLeaveApplication."Leave Type";
            LeaveLedgerEntry."Leave Period" := HRLeaveApplication."Leave Period";
            LeaveLedgerEntry.Days := -(HRLeaveApplication."Days Approved");
            LeaveLedgerEntry."HR Location" := Employee.Location;
            LeaveLedgerEntry."HR Department" := Employee.Department;
            LeaveLedgerEntry.Description := StrSubstNo(LeaveDescription, HRLeaveApplication."Leave Type", HRLeaveApplication."Leave Period");
            LeaveLedgerEntry."Global Dimension 1 Code" := HRLeaveApplication."Global Dimension 1 Code";
            LeaveLedgerEntry."Global Dimension 2 Code" := HRLeaveApplication."Global Dimension 2 Code";
            LeaveLedgerEntry."Shortcut Dimension 3 Code" := HRLeaveApplication."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Shortcut Dimension 4 Code" := HRLeaveApplication."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Shortcut Dimension 5 Code" := HRLeaveApplication."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Shortcut Dimension 6 Code" := HRLeaveApplication."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Shortcut Dimension 7 Code" := HRLeaveApplication."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Shortcut Dimension 8 Code" := HRLeaveApplication."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Responsibility Center" := HRLeaveApplication."Responsibility Center";
            LeaveLedgerEntry."User ID" := UserId;
            if LeaveLedgerEntry.Insert then begin
                HRLeaveApplication2.Reset;
                HRLeaveApplication2.SetRange(HRLeaveApplication2."No.", HRLeaveApplication."No.");
                if HRLeaveApplication2.FindFirst then begin
                    if HRLeaveApplication2."Leave Start Date" = Today then begin
                        Employee.Get(HRLeaveApplication2."Employee No.");
                        Employee."Leave Status" := Employee."Leave Status"::"On Leave";
                        Employee.Modify;
                    end;
                    HRLeaveApplication2.Status := HRLeaveApplication2.Status::Posted;
                    HRLeaveApplication2.Posted := true;
                    HRLeaveApplication2."Posted By" := UserId;
                    HRLeaveApplication2."Date Posted" := Today;
                    HRLeaveApplication2."Time Posted" := Time;
                    HRLeaveApplication2."Posting Date" := Today;
                    if HRLeaveApplication2.Modify then
                        LeavePosted := true;
                    SendEmailNotificationOnPostLeave(LeaveApplication);
                end;
            end;
        end;
        Commit;

        //............Send Email notification to Employee, Substitute, Supervisor and Human Resource on Posting Leave Application.........
        //SendEmailNotificationOnPostLeave(LeaveApplication);
    end;

    procedure CheckOpenLeaveAllocationExists(EmployeeUserID: Code[50]) OpenLeaveAllocationExist: Boolean
    begin
        OpenLeaveAllocationExist := false;
        HRLeaveAllocationHeader.Reset;
        HRLeaveAllocationHeader.SetRange(HRLeaveAllocationHeader."User ID", EmployeeUserID);
        HRLeaveAllocationHeader.SetRange(HRLeaveAllocationHeader.Status, HRLeaveAllocationHeader.Status::Open);
        if HRLeaveAllocationHeader.FindFirst then begin
            OpenLeaveAllocationExist := true;
        end;
    end;

    procedure AutoFillLeaveAllocationLines(LeaveAllocation: Code[20]) AutoFilledLines: Boolean
    var
        EmployeeLeaveType: Record "Employee Leave Type";
        HRLeaveTypes: Record "HR Leave Types";
    begin
        AutoFilledLines := true;
        HRLeaveAllocationHeader.Get(LeaveAllocation);

        HRLeaveAllocationLine.Reset;
        HRLeaveAllocationLine.SetRange(HRLeaveAllocationLine."Leave Allocation No.", HRLeaveAllocationHeader."No.");
        if HRLeaveAllocationLine.FindSet then begin
            HRLeaveAllocationLine.DeleteAll;
        end;

        Employee.Reset;
        Employee.SetRange(Employee.Status, Employee.Status::Active);
        //Employee.SETRANGE(Employee."Emplymt. Contract Code","Emplymt. Contract Code");
        if Employee.FindSet then begin
            repeat
                LeaveLedgerEntry.Reset;
                LeaveLedgerEntry.SetRange(LeaveLedgerEntry."Employee No.", Employee."No.");
                LeaveLedgerEntry.SetRange(LeaveLedgerEntry."Leave Type", HRLeaveAllocationHeader."Leave Type");
                LeaveLedgerEntry.SetRange(LeaveLedgerEntry."Leave Period", HRLeaveAllocationHeader."Leave Period");
                if not LeaveLedgerEntry.FindFirst then begin
                    EmployeeLeaveType.Reset;
                    EmployeeLeaveType.SetRange(EmployeeLeaveType."Employee No.", Employee."No.");
                    EmployeeLeaveType.SetRange(EmployeeLeaveType."Leave Type", HRLeaveAllocationHeader."Leave Type");
                    if EmployeeLeaveType.FindSet then begin
                        repeat
                            // EmployeeLeaveType.GET(Employee."No.",HRLeaveAllocationHeader."Leave Type");
                            HRLeaveAllocationLine.Reset;
                            HRLeaveAllocationLine."Leave Allocation No." := HRLeaveAllocationHeader."No.";
                            HRLeaveAllocationLine."Employee No." := Employee."No.";
                            HRLeaveAllocationLine.Validate(HRLeaveAllocationLine."Employee No.");
                            HRLeaveAllocationLine."Entry Type" := HRLeaveAllocationLine."Entry Type"::"Positive Adjustment";
                            HRLeaveTypes.Reset;
                            HRLeaveTypes.SetRange(HRLeaveTypes.Code, HRLeaveAllocationHeader."Leave Type");
                            if HRLeaveTypes.FindFirst then begin
                                HRLeaveAllocationLine."Days Allocated" := HRLeaveTypes.Days;
                                HRLeaveAllocationLine.Validate(HRLeaveAllocationLine."Days Allocated");
                            end;
                            HRLeaveAllocationLine.Description := HRLeaveAllocationHeader.Description;
                            HRLeaveAllocationLine."Global Dimension 1 Code" := HRLeaveAllocationHeader."Global Dimension 1 Code";
                            HRLeaveAllocationLine."Global Dimension 2 Code" := HRLeaveAllocationHeader."Global Dimension 2 Code";
                            HRLeaveAllocationLine."Shortcut Dimension 3 Code" := HRLeaveAllocationHeader."Shortcut Dimension 3 Code";
                            HRLeaveAllocationLine."Shortcut Dimension 4 Code" := HRLeaveAllocationHeader."Shortcut Dimension 4 Code";
                            HRLeaveAllocationLine."Shortcut Dimension 5 Code" := HRLeaveAllocationHeader."Shortcut Dimension 5 Code";
                            HRLeaveAllocationLine."Shortcut Dimension 6 Code" := HRLeaveAllocationHeader."Shortcut Dimension 6 Code";
                            HRLeaveAllocationLine."Shortcut Dimension 7 Code" := HRLeaveAllocationHeader."Shortcut Dimension 7 Code";
                            HRLeaveAllocationLine."Shortcut Dimension 8 Code" := HRLeaveAllocationHeader."Shortcut Dimension 8 Code";
                            HRLeaveAllocationLine.Insert;
                        until EmployeeLeaveType.Next = 0;
                    end;
                end;
            until Employee.Next = 0;
        end;
        AutoFilledLines := true;
    end;

    procedure PostLeaveAllocation(LeaveAllocation: Code[20]) LeaveAllocationPosted: Boolean
    var
        HRLeaveApplication: Record "HR Leave Application";
        HRLeaveApplication2: Record "HR Leave Application";
        LeaveDescription: Label 'Leave Allocation for Leave Type: %1, Leave Period:%2';
    begin
        LeaveAllocationPosted := false;
        HRLeaveAllocationHeader.Get(LeaveAllocation);
        HRLeaveAllocationLine.Reset;
        HRLeaveAllocationLine.SetRange(HRLeaveAllocationLine."Leave Allocation No.", HRLeaveAllocationHeader."No.");
        HRLeaveAllocationLine.SetFilter("New Days Approved", '>%1', 0);
        if HRLeaveAllocationLine.FindSet then begin
            repeat
                Employee.Get(HRLeaveAllocationLine."Employee No.");
                LeaveLedgerEntry.Init;
                LeaveLedgerEntry."Line No." := 0;
                LeaveLedgerEntry."Document No." := HRLeaveAllocationLine."Leave Allocation No.";
                LeaveLedgerEntry."Posting Date" := HRLeaveAllocationHeader."Posting Date";
                LeaveLedgerEntry."Leave Year" := Date2DMY(HRLeaveAllocationHeader."Posting Date", 3);
                LeaveLedgerEntry."Entry Type" := HRLeaveAllocationLine."Entry Type";
                LeaveLedgerEntry."Employee No." := HRLeaveAllocationLine."Employee No.";
                LeaveLedgerEntry."Leave Type" := HRLeaveAllocationHeader."Leave Type";
                LeaveLedgerEntry."Leave Period" := HRLeaveAllocationHeader."Leave Period";
                Evaluate(VarInteger, HRLeaveAllocationHeader."Leave Period");
                LeaveLedgerEntry."Leave Year 2" := VarInteger;
                if HRLeaveAllocationLine."Entry Type" = HRLeaveAllocationLine."Entry Type"::"Positive Adjustment" then
                    LeaveLedgerEntry.Days := HRLeaveAllocationLine."New Days Approved"
                else
                    LeaveLedgerEntry.Days := -(HRLeaveAllocationLine."New Days Approved");
                LeaveLedgerEntry."HR Location" := Employee.Location;
                LeaveLedgerEntry."HR Department" := Employee.Department;
                LeaveLedgerEntry.Description := StrSubstNo(LeaveDescription, HRLeaveAllocationHeader."Leave Type", HRLeaveAllocationHeader."Leave Period");
                LeaveLedgerEntry."Global Dimension 1 Code" := HRLeaveAllocationLine."Global Dimension 1 Code";
                LeaveLedgerEntry."Global Dimension 2 Code" := HRLeaveAllocationLine."Global Dimension 2 Code";
                LeaveLedgerEntry."Shortcut Dimension 3 Code" := HRLeaveAllocationLine."Shortcut Dimension 3 Code";
                LeaveLedgerEntry."Shortcut Dimension 4 Code" := HRLeaveAllocationLine."Shortcut Dimension 3 Code";
                LeaveLedgerEntry."Shortcut Dimension 5 Code" := HRLeaveAllocationLine."Shortcut Dimension 3 Code";
                LeaveLedgerEntry."Shortcut Dimension 6 Code" := HRLeaveAllocationLine."Shortcut Dimension 3 Code";
                LeaveLedgerEntry."Shortcut Dimension 7 Code" := HRLeaveAllocationLine."Shortcut Dimension 3 Code";
                LeaveLedgerEntry."Shortcut Dimension 8 Code" := HRLeaveAllocationLine."Shortcut Dimension 3 Code";
                LeaveLedgerEntry."Responsibility Center" := HRLeaveAllocationLine."Responsibility Center";
                LeaveLedgerEntry."User ID" := UserId;
                LeaveLedgerEntry."Leave Allocation" := true;
                LeaveLedgerEntry.Insert;
            until HRLeaveAllocationLine.Next = 0;
        end;
        Commit;
        HRLeaveAllocationHeader.Get(LeaveAllocation);
        LeaveLedgerEntry.Reset;
        LeaveLedgerEntry.SetRange(LeaveLedgerEntry."Document No.", HRLeaveAllocationHeader."No.");
        if LeaveLedgerEntry.FindFirst then begin
            HRLeaveAllocationHeader.Status := HRLeaveAllocationHeader.Status::Posted;
            HRLeaveAllocationHeader.Posted := true;
            HRLeaveAllocationHeader."Posted By" := UserId;
            HRLeaveAllocationHeader."Date Posted" := Today;
            HRLeaveAllocationHeader."Time Posted" := Time;
            HRLeaveAllocationHeader.Validate(HRLeaveAllocationHeader.Status);
            if HRLeaveAllocationHeader.Modify then begin
                LeaveAllocationPosted := true;
            end;
        end;
    end;

    procedure CheckReimbursmentMandatoryFields("HR Leave Reimbursment": Record "HR Leave Reimbursement"; Posting: Boolean)
    var
        HRLeaveReimbursment: Record "HR Leave Application";
        HRLeaveReimbursment2: Record "HR Leave Application";
    begin
        HRReimbursment.TransferFields("HR Leave Reimbursment", true);
        HRReimbursment.TestField(HRReimbursment."Posting Date");
        HRReimbursment.TestField(HRReimbursment."Employee No.");
        HRReimbursment.TestField(HRReimbursment."Leave Type");
        HRReimbursment.TestField(HRReimbursment."Leave Period");
        HRReimbursment.TestField(HRReimbursment."Days to Reimburse");
    end;

    procedure PostLeaveReimbursment(LeaveReimbursment: Code[20]) ReimbursmentPosted: Boolean
    var
        HRLeaveReimbursment: Record "HR Leave Reimbursement";
        HRLeaveReimbursment2: Record "HR Leave Reimbursement";
        LeaveDescription: Label 'Leave Application for Leave Type: %1, Leave Period:%2';
        HRLeaveApplication2: Record "HR Leave Application";
    begin
        ReimbursmentPosted := false;
        HRReimbursment.Reset;
        HRReimbursment.Get(LeaveReimbursment);

        //Check whether document is posted
        LeaveLedgerEntry.Reset;
        LeaveLedgerEntry.SetRange(LeaveLedgerEntry."Document No.", HRReimbursment."No.");
        if LeaveLedgerEntry.FindFirst then begin
            Error(Text0001);
        end;

        if Employee.Get(HRReimbursment."Employee No.") then begin
            LeaveLedgerEntry.Reset;
            LeaveLedgerEntry."Line No." := 0;
            LeaveLedgerEntry."Document No." := HRReimbursment."No.";
            LeaveLedgerEntry."Posting Date" := HRReimbursment."Posting Date";
            LeaveLedgerEntry."Leave Year" := Date2DMY(HRReimbursment."Posting Date", 3);
            LeaveLedgerEntry."Entry Type" := LeaveLedgerEntry."Entry Type"::Reimbursement;
            LeaveLedgerEntry."Employee No." := HRReimbursment."Employee No.";
            LeaveLedgerEntry."Leave Type" := HRReimbursment."Leave Type";
            LeaveLedgerEntry."Leave Period" := HRReimbursment."Leave Period";
            LeaveLedgerEntry.Days := (HRReimbursment."Days to Reimburse");
            LeaveLedgerEntry."HR Location" := Employee.Location;
            LeaveLedgerEntry."HR Department" := Employee.Department;
            LeaveLedgerEntry."Leave Year" := LeaveYear;
            LeaveLedgerEntry.Description := StrSubstNo(LeaveDescription, HRReimbursment."Leave Type", HRReimbursment."Leave Period");
            LeaveLedgerEntry."Global Dimension 1 Code" := HRReimbursment."Global Dimension 1 Code";
            LeaveLedgerEntry."Global Dimension 2 Code" := HRReimbursment."Global Dimension 2 Code";
            LeaveLedgerEntry."Shortcut Dimension 3 Code" := HRReimbursment."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Shortcut Dimension 4 Code" := HRReimbursment."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Shortcut Dimension 5 Code" := HRReimbursment."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Shortcut Dimension 6 Code" := HRReimbursment."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Shortcut Dimension 7 Code" := HRReimbursment."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Shortcut Dimension 8 Code" := HRReimbursment."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Responsibility Center" := HRReimbursment."Responsibility Center";
            LeaveLedgerEntry."User ID" := UserId;
            if LeaveLedgerEntry.Insert then begin
                HRLeaveReimbursment2.Reset;
                HRLeaveReimbursment2.SetRange(HRLeaveReimbursment2."No.", LeaveReimbursment);
                if HRLeaveReimbursment2.FindFirst then begin
                    //modify leave status on employee card
                    Employee.Get(HRLeaveReimbursment2."Employee No.");
                    Employee."Leave Status" := Employee."Leave Status"::" ";
                    Employee.Modify;

                    //Modify Leave Application Return Date on Leave Application Recall Employee
                    HRLeaveApplication2.Get(HRLeaveReimbursment2."Leave Application No.");
                    HRLeaveApplication2."Leave Return Date" := HRLeaveReimbursment2."Actual Return Date";
                    HRLeaveApplication2.Modify;

                    //modify reimbursement card
                    HRLeaveReimbursment2.Status := HRLeaveReimbursment2.Status::Posted;
                    HRLeaveReimbursment2.Posted := true;
                    HRLeaveReimbursment2."Posted By" := UserId;
                    HRLeaveReimbursment2."Date Posted" := Today;
                    HRLeaveReimbursment2."Time Posted" := Time;
                    if HRLeaveReimbursment2.Modify then
                        ReimbursmentPosted := true;
                end;
            end;
        end;
        Commit;
    end;

    procedure CheckCarryOverMandatoryFields("HR Leave Carryover": Record "HR Leave Carryover"; Posting: Boolean)
    var
        HRLeaveCarryOver: Record "HR Leave Carryover";
        HRLeaveCarryOver2: Record "HR Leave Carryover";
    begin
        HRCarryOver.TransferFields("HR Leave Carryover", true);
        HRCarryOver.TestField(HRCarryOver."Posting Date");
        HRCarryOver.TestField(HRCarryOver."Employee No.");
        HRCarryOver.TestField(HRCarryOver."Leave Type");
        HRCarryOver.TestField(HRCarryOver."Leave Period");
        HRCarryOver.TestField(HRCarryOver."Days to CarryOver");
        HRCarryOver.TestField(Posted, false);
    end;

    procedure PostLeaveCarryover(LeaveCarryOver: Code[20]) Carryover: Boolean
    var
        HRLeaveCarryOver: Record "HR Leave Carryover";
        HRLeaveCarryOver2: Record "HR Leave Carryover";
        LeaveDescription: Label 'Leave Application for Leave Type: %1, Leave Period:%2';
    begin
        Carryover := false;
        HRCarryOver.Reset;
        HRCarryOver.Get(LeaveCarryOver);
        HRCarryOver.TestField(Posted, false);
        if Employee.Get(HRCarryOver."Employee No.") then begin
            LeaveLedgerEntry.Reset;
            LeaveLedgerEntry."Line No." := 0;
            LeaveLedgerEntry."Document No." := HRCarryOver."No.";
            LeaveLedgerEntry."Posting Date" := HRCarryOver."Posting Date";
            LeaveLedgerEntry."Entry Type" := LeaveLedgerEntry."Entry Type"::"Carry forward";
            LeaveLedgerEntry."Employee No." := HRCarryOver."Employee No.";
            LeaveLedgerEntry."Leave Type" := HRCarryOver."Leave Type";
            LeaveLedgerEntry."Leave Period" := HRCarryOver."Leave Period";
            LeaveLedgerEntry.Days := (HRCarryOver."Days to CarryOver");
            LeaveLedgerEntry."HR Location" := Employee.Location;
            LeaveLedgerEntry."HR Department" := Employee.Department;
            LeaveLedgerEntry.Description := StrSubstNo(LeaveDescription, HRCarryOver."Leave Type", HRCarryOver."Leave Period");
            LeaveLedgerEntry."Global Dimension 1 Code" := HRCarryOver."Global Dimension 1 Code";
            LeaveLedgerEntry."Global Dimension 2 Code" := HRCarryOver."Global Dimension 2 Code";
            LeaveLedgerEntry."Shortcut Dimension 3 Code" := HRCarryOver."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Shortcut Dimension 4 Code" := HRCarryOver."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Shortcut Dimension 5 Code" := HRCarryOver."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Shortcut Dimension 6 Code" := HRCarryOver."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Shortcut Dimension 7 Code" := HRCarryOver."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Shortcut Dimension 8 Code" := HRCarryOver."Shortcut Dimension 3 Code";
            LeaveLedgerEntry."Responsibility Center" := HRCarryOver."Responsibility Center";
            LeaveLedgerEntry."User ID" := UserId;

            if LeaveLedgerEntry.Insert then begin
                HRLeaveCarryOver2.Reset;
                HRLeaveCarryOver2.SetRange(HRLeaveCarryOver2."No.", HRCarryOver."No.");
                if HRLeaveCarryOver2.FindFirst then begin

                    Employee.Get(HRLeaveCarryOver2."Employee No.");
                    Employee."Leave Status" := Employee."Leave Status"::" ";
                    Employee.Modify;


                    HRLeaveCarryOver2.Status := HRLeaveCarryOver2.Status::Posted;
                    HRLeaveCarryOver2.Posted := true;
                    HRLeaveCarryOver2."Posted By" := UserId;
                    HRLeaveCarryOver2."Date Posted" := Today;
                    HRLeaveCarryOver2."Time Posted" := Time;
                    if HRLeaveCarryOver2.Modify then
                        Carryover := true;
                end;
            end;
        end;
        Commit;
    end;

    procedure CloseLeavePeriod(LeavePeriodCode: Code[50]) LeavePeriodClosed: Boolean
    begin
        LeavePeriodClosed := false;

        LeavePeriods.Reset;
        if LeavePeriods.Get(LeavePeriodCode) then begin

        end;
    end;

    procedure CalculateLeaveReimbursment(LeaveType: Code[50]; LeavePeriod: Code[20]; LeaveStartDate: Date; DaysApplied: Integer; BaseCalendarCode: Code[10]; ActualReturnDate: Date; LeaveEndDate: Date) TotalLeaveDays: Integer
    var
        NonWorkingDay: Boolean;
        LeaveDays: Integer;
        LeaveEndDateFormula: DateFormula;
    begin
        TotalLeaveDays := 0;
        LeaveTypes.Reset;
        LeaveTypes.Get(LeaveType);
        if LeaveTypes."Inclusive of Non Working Days" then begin
            LeaveDays := DaysApplied - 1;
            Evaluate(LeaveEndDateFormula, Format(LeaveDays) + 'D');
            LeaveEndDate := CalcDate(LeaveEndDateFormula, LeaveStartDate);
        end else begin
            LeaveDays := DaysApplied;
            LeaveEndDate := CalcDate('-1D', LeaveStartDate);
            while LeaveDays > 0 do begin
                TotalLeaveDays := TotalLeaveDays + 1;
                LeaveEndDate := CalcDate('1D', LeaveEndDate);
                if BaseCalendarCode = '' then
                    NonWorkingDay := CalendarMgmt.CheckDateStatus(LeaveTypes."Base Calendar", LeaveEndDate, Description)
                else
                    NonWorkingDay := CalendarMgmt.CheckDateStatus(BaseCalendarCode, LeaveEndDate, Description);
                if not NonWorkingDay then begin
                    LeaveDays := LeaveDays - 1;
                end;
            end;
        end;
    end;

    procedure SendEmailNotificationOnPostLeave(ApplicationNo: Code[50])
    var
        HRLeaveApplication: Record "HR Leave Application";
        HREmployee: Record Employee;
    begin
        // SMTP.Get;
        HRLeaveApplication.Reset;
        HRLeaveApplication.SetRange(HRLeaveApplication."No.", ApplicationNo);
        if HRLeaveApplication.FindFirst then begin
            Employee.Reset;
            Employee.SetRange(Employee."No.", HRLeaveApplication."Employee No.");
            Employee.SetFilter(Employee."Company E-Mail", '<>%1', '');
            if Employee.FindFirst then begin
                // SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",Employee."Company E-Mail",'Leave Application ' +HRLeaveApplication."No.",'',true);
                // SMTPMail.AppendBody('Dear'+' '+HRLeaveApplication."Employee Name"+',');
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody('Your Leave Application has been approved and Posted. The leave application no. is  ' + HRLeaveApplication."No.");
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody('Leave starts on  '+Format(HRLeaveApplication."Leave Start Date",0,4) +' and ends on  '+Format(HRLeaveApplication."Leave End Date",0,4));
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody('You are Required to Resume Work on  '+Format(HRLeaveApplication."Leave Return Date",0,4));
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody('Thank you.');
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody(SMTP."Sender Name");
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody('This is a system generated mail. Please do not reply to this Email');
                // SMTPMail.Send;
            end;
            if Employee.HR = true then begin
                Employee.Reset;
                Employee.SetRange(Employee."No.", HREmployee."No.");
                Employee.SetFilter(Employee."Company E-Mail", '<>%1', '');
                if Employee.FindFirst then begin
                    // SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",Employee."Company E-Mail",'Leave Application ' +HRLeaveApplication."No.",'',true);
                    // SMTPMail.AppendBody('Dear'+' '+Employee."First Name"+',');
                    // SMTPMail.AppendBody('<br><br>');
                    // SMTPMail.AppendBody('Kindly note:  '+HRLeaveApplication."Employee Name"+  ' will be away on leave');
                    // SMTPMail.AppendBody('<br><br>');
                    // SMTPMail.AppendBody('From,'+Format(HRLeaveApplication."Leave Start Date",0,4) +' to '+Format(HRLeaveApplication."Leave End Date",0,4));
                    // SMTPMail.AppendBody('<br><br>');
                    // SMTPMail.AppendBody('Thank you.');
                    // SMTPMail.AppendBody('<br><br>');
                    // SMTPMail.AppendBody(SMTP."Sender Name");
                    // SMTPMail.AppendBody('<br><br>');
                    // SMTPMail.AppendBody('<br><br>');
                    // SMTPMail.AppendBody('This is a system generated mail. Please do not reply to this Email');
                    // SMTPMail.Send;
                end;
            end;
            // END;

            Employee.Reset;
            Employee.SetRange(Employee."No.", HRLeaveApplication."Substitute No.");
            Employee.SetFilter(Employee."Company E-Mail", '<>%1', '');
            if Employee.FindFirst then begin
                // SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",Employee."Company E-Mail",'Leave Application ' +HRLeaveApplication."No.",'',true);
                // SMTPMail.AppendBody('Dear'+' '+HRLeaveApplication."Substitute Name"+',');
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody('Kindly note:  '+HRLeaveApplication."Employee Name"+  ' will be away on leave');
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody('From,'+Format(HRLeaveApplication."Leave Start Date",0,4) +' to '+Format(HRLeaveApplication."Leave End Date",0,4));
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody('During this Period you have been appointed as his/her reliever');
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody('Thank you.');
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody(SMTP."Sender Name");
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody('This is a system generated mail. Please do not reply to this Email');
                // SMTPMail.Send;
            end;
        end;
    end;

    procedure CarryOverLeaveDays(LeavePeriod: Code[20])
    var
        LeaveTypes: Record "HR Leave Types";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        Employee: Record Employee;
        TotalLeaveDays: Integer;
        HRLeavePeriods: Record "HR Leave Periods";
        PostingDate: Date;
        lineNo: Integer;
        NewLeavePeriod: Code[30];
        Text0001: Label 'Leave carry over from the period';
        HRLeaveLedgerEntries2: Record "HR Leave Ledger Entries";
    begin
        HRLeavePeriods.Reset;
        HRLeavePeriods.SetRange(HRLeavePeriods.Closed, false);
        if HRLeavePeriods.FindFirst then begin
            PostingDate := HRLeavePeriods."Start Date";
            NewLeavePeriod := HRLeavePeriods.Code;
        end;



        LeaveTypes.Reset;
        LeaveTypes.SetRange(LeaveTypes.Balance, LeaveTypes.Balance::"Carry Forward");
        if LeaveTypes.FindSet then begin
            repeat
                Employee.Reset;
                Employee.SetRange(Employee.Status, Employee.Status::Active);
                if Employee.FindSet then begin
                    repeat
                        TotalLeaveDays := 0;
                        LeaveLedgerEntry.Reset;
                        LeaveLedgerEntry.SetRange(LeaveLedgerEntry."Leave Period", LeavePeriod);
                        LeaveLedgerEntry.SetRange(LeaveLedgerEntry."Employee No.", Employee."No.");
                        LeaveLedgerEntry.SetRange(LeaveLedgerEntry."Leave Type", LeaveTypes.Code);
                        if LeaveLedgerEntry.FindSet then begin
                            lineNo := 0;
                            repeat
                                TotalLeaveDays := TotalLeaveDays + LeaveLedgerEntry.Days;
                            until LeaveLedgerEntry.Next = 0;
                        end;

                        HRLeaveLedgerEntries.Reset;
                        if HRLeaveLedgerEntries.FindLast then
                            HRLeaveLedgerEntries."Line No." := HRLeaveLedgerEntries."Line No." + 1;
                        HRLeaveLedgerEntries."Document No." := LeavePeriod;
                        HRLeaveLedgerEntries."Posting Date" := PostingDate;
                        HRLeaveLedgerEntries."Entry Type" := HRLeaveLedgerEntries."Entry Type"::"Carry forward";
                        HRLeaveLedgerEntries."Leave Type" := LeaveTypes.Code;
                        HRLeaveLedgerEntries."Leave Period" := NewLeavePeriod;
                        HRLeaveLedgerEntries."Employee No." := Employee."No.";
                        if LeaveTypes."Max Carry Forward Days" <= TotalLeaveDays then begin
                            HRLeaveLedgerEntries.Days := LeaveTypes."Max Carry Forward Days"
                        end else begin
                            HRLeaveLedgerEntries.Days := TotalLeaveDays;
                        end;
                        HRLeaveLedgerEntries.Description := Text0001 + ' ' + Format(LeavePeriod);
                        HRLeaveLedgerEntries."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                        HRLeaveLedgerEntries."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                        HRLeaveLedgerEntries."Shortcut Dimension 3 Code" := Employee."Shortcut Dimension 3 Code";
                        HRLeaveLedgerEntries."Shortcut Dimension 4 Code" := Employee."Shortcut Dimension 4 Code";
                        HRLeaveLedgerEntries."Shortcut Dimension 5 Code" := Employee."Shortcut Dimension 5 Code";
                        HRLeaveLedgerEntries."Shortcut Dimension 6 Code" := Employee."Shortcut Dimension 6 Code";
                        HRLeaveLedgerEntries."Shortcut Dimension 7 Code" := Employee."Shortcut Dimension 7 Code";
                        HRLeaveLedgerEntries."Shortcut Dimension 8 Code" := Employee."Shortcut Dimension 8 Code";
                        HRLeaveLedgerEntries.Insert;
                    until Employee.Next = 0;
                end;
            until LeaveTypes.Next = 0;
        end;
    end;
}

