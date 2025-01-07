table 50127 "HR Leave Application"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //updated on 09/04/2024
                if "Posting Date" > Today then
                    Error(Text_005);
            end;
        }
        field(4; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange(Employee."No.", "Employee No.");
                if Employee.FindFirst then begin
                    "Employee Name" := Employee."Last Name" + ' ' + Employee."First Name" + ' ' + Employee."Middle Name";
                    "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := Employee."Shortcut Dimension 3 Code";
                    "Position Title" := Employee."Position Title";
                    Employee.TestField(Employee."Emplymt. Contract Code");
                    "Emplymt. Contract Code" := Employee."Emplymt. Contract Code";
                    "Leave Group" := Employee."Leave Group";
                    "Shortcut Dimension 3 Code" := Employee."Shortcut Dimension 3 Code";
                    "Supervisor Name" := Employee."Supervisor Job No.";
                    //updated on 19/07/2021
                    HOD := Employee.HOD;
                    "Area Manager" := Employee.Supervisor;
                    MD := Employee.MD;
                    CIS := Employee.CIS;
                    Driver := Employee.Driver;
                    //Update Gender
                    Gender := Employee.Gender;
                    HRLeavePeriod.Reset;
                    HRLeavePeriod.SetRange(HRLeavePeriod.Closed, false);
                    if HRLeavePeriod.FindFirst then begin
                        "Leave Period" := HRLeavePeriod.Code;
                    end;

                end else begin
                    "Leave Group" := '';
                    "Employee Name" := '';
                    "Emplymt. Contract Code" := '';
                    "Leave Type" := '';
                    "Leave Period" := '';
                end;

                //check for two leave type the same period
                // HRLeaveApplication.Reset;
                // HRLeaveApplication.SetRange("Employee No.", "Employee No.");
                // //HRLeaveApplication.SETRANGE(Status,TRUE);
                // if HRLeaveApplication.FindLast then begin
                //     if HRLeaveApplication."Leave Return Date" > Today then
                //         Error(Text_003);
                //  end;
            end;
        }
        field(5; "Employee Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Leave Type"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Leave Types".Code;

            trigger OnValidate()
            begin
                TestField("Employee No.");
                Employee.Reset;
                Employee.Get("Employee No.");
                Employee.TestField("Leave Calendar");
                HRLeaveType.Reset;
                if HRLeaveType.Get("Leave Type") then begin
                    //Check Leave Planner
                    TestField("Leave Period");
                    if HRLeaveType."Leave Plan Mandatory" then begin
                        HRLeavePlanner.Reset;
                        HRLeavePlanner.SetRange(HRLeavePlanner."Employee No.", "Employee No.");
                        HRLeavePlanner.SetRange(HRLeavePlanner."Leave Period", "Leave Period");
                        HRLeavePlanner.SetRange(HRLeavePlanner."Leave Type", "Leave Type");
                        HRLeavePlanner.SetRange(HRLeavePlanner.Status, HRLeavePlanner.Status::Released);
                        if not HRLeavePlanner.FindFirst then begin
                            Error(LeavePlannerMandatory, "Leave Type", "Employee No.", "Leave Period", "Leave Type");
                        end;
                    end;
                    //Update Leave Gender BV 31.01.2023
                    if (Gender = Gender::Female) and (HRLeaveType.Gender = HRLeaveType.Gender::Male) then begin
                        Error('This Leave Type is for Male Gender');
                    end else
                        if (Gender = Gender::Male) and (HRLeaveType.Gender = HRLeaveType.Gender::Female) then begin
                            Error('This Leave Type is for Female Gender');
                        end;
                    // Close Update Leave Gender BV 31.01.2023
                end;
                //End Check Leave Planner

                //Calculate Leave Balance
                LeavePeriods.Reset;
                LeavePeriods.SetRange(Closed, false);
                if LeavePeriods.FindFirst then
                    LeavePeriod := LeavePeriods.Code;
                LeaveLedgerEntries.Reset;
                LeaveLedgerEntries.SetRange(LeaveLedgerEntries."Employee No.", "Employee No.");
                LeaveLedgerEntries.SetRange(LeaveLedgerEntries."Leave Type", "Leave Type");
                LeaveLedgerEntries.SetRange("Leave Period", LeavePeriod);
                LeaveLedgerEntries.CalcSums(LeaveLedgerEntries.Days);
                "Leave Balance" := LeaveLedgerEntries.Days;

            end;
        }
        field(7; "Leave Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Leave Periods".Code WHERE(Closed = CONST(false));
        }
        field(8; "Leave Balance"; Decimal)
        {
            Caption = 'Leave Balance from Days Allocated';
            Editable = false;
        }
        field(9; "Leave Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Employee No.");
                TestField("Leave Type");
                HRSetup.Get();
                if "Leave Start Date" = 0D then begin
                    "Leave Return Date" := 0D;
                    "Leave End Date" := 0D;
                end else begin
                    if CalendarMgmt.CheckDateStatus(HRLeaveType."Base Calendar", "Leave Start Date", Description) then begin
                        Error('Start Date Must be a Working Day');
                    end;
                end;
                //commented on 29/05/2020
                if "Leave Start Date" < Today then begin
                    Error(LeaveStartDateEarlierthanCurrentDate, Today);
                end;



                "Days Applied" := 0;
                Validate("Days Applied");

                //Exempt Employees from applying leave on month of december
                /*Month:=DATE2DMY("Leave Start Date",2);
                IF Month =12 THEN BEGIN
                  ERROR('RESTRICTED YOU CANNOT PROCEED FOR LEAVE IN DECEMBER');
                  END;
                */

            end;
        }
        field(10; "Days Applied"; Integer)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                "Days Approved" := "Days Applied";
                TestField("Substitute No.");
                if LeaveTypes.Get("Leave Type") then
                    //IF LeaveTypes."Annual Leave" THEN
                    if "Days Applied" > "Leave Balance" then
                        Error(Text_001);

                "Days Approved" := "Days Applied";
                Validate("Days Approved");
            end;
        }
        field(11; "Days Approved"; Integer)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                "Leave End Date" := 0D;
                "Leave Return Date" := 0D;

                Employee.Get("Employee No.");
                BaseCalendarCode := Employee."Leave Calendar";
                if "Days Approved" <> 0 then begin
                    "Leave End Date" := HRLeaveManagement.CalculateLeaveEndDate("Leave Type", "Leave Period", "Leave Start Date", "Days Approved", BaseCalendarCode);
                    "Leave Return Date" := HRLeaveManagement.CalculateLeaveReturnDate("Leave Type", "Leave Period", "Leave End Date", BaseCalendarCode);
                end;


                //ERROR(text1234,FORMAT("Days Applied"));

                HRLeaveType.Reset;
                HRLeaveType.SetRange(Code, "Leave Type");
                HRLeaveType.SetRange("Take as Block", true);
                if HRLeaveType.FindFirst then begin
                    if HRLeaveType.Days <> "Days Applied" then
                        Error(text1234, Format("Days Applied"));
                    Error(Text_004);
                end;
            end;
        }
        field(12; "Leave End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Leave Return Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Substitute No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                "Substitute Name" := '';

                Employee.Reset;
                if Employee.Get("Substitute No.") then begin
                    "Substitute Name" := Employee."Last Name" + ' ' + Employee."First Name" + ' ' + Employee."Middle Name";
                end;

                /*HRLeaveApplication.RESET;
                HRLeaveApplication.SETRANGE("Employee No.","Substitute No.");
                HRLeaveApplication.SETRANGE(Posted,TRUE);
                IF HRLeaveApplication.FINDLAST THEN BEGIN
                  IF HRLeaveApplication."Leave Return Date" > TODAY THEN
                  ERROR(Text_002);;
                END;*/

            end;
        }
        field(15; "Substitute Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Leave Group"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Leave Groups".Code;
        }
        field(49; "Reason for Leave"; Text[250])
        {
            Caption = 'Employee Comments';
            DataClassification = ToBeClassified;
        }
        field(50; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(51; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(52; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(53; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(54; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(55; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(56; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(57; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(58; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center".Code;
        }
        field(70; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted,Cancelled';
            OptionMembers = Open,"Pending Approval",Released,Rejected,Posted,Cancelled;
        }
        field(71; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(73; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(74; "Time Posted"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(99; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange(Employee."User ID", "User ID");
                if Employee.FindFirst then begin
                    "Employee No." := Employee."No.";
                    "Employee Name" := Employee."Last Name" + ' ' + Employee."Middle Name" + ' ' + Employee."First Name";
                    "Emplymt. Contract Code" := Employee."Emplymt. Contract Code";
                end;
            end;
        }
        field(100; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(102; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            DataClassification = ToBeClassified;
        }
        field(103; "Emplymt. Contract Code"; Code[10])
        {
            Caption = 'Emplymt. Contract Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Employment Contract".Code;
        }
        field(104; "Approved By Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Approval Entry"."Approver ID" WHERE("Document No." = FIELD("No."));
        }
        field(105; "Request Leave Allowance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(106; "Leave Allowance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(107; "Details of Examination"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(108; "Date of Exam"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(109; "Supervisor Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(110; "E-mail Address"; Text[30])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(111; "Cell Phone Number"; Text[30])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(112; "Cumm. Allocated Leave Days"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries".Days WHERE("Employee No." = FIELD("Employee No."),
                                                                    "Leave Allocation" = CONST(true),
                                                                    "Leave Period" = FIELD("Leave Period")));
            FieldClass = FlowField;
        }
        field(113; "Allocated Days"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries".Days WHERE("Leave Type" = FIELD("Leave Type"),
                                                                    "Employee No." = FIELD("Employee No."),
                                                                    "Leave Allocation" = CONST(true),
                                                                    "Leave Period" = FIELD("Leave Period")));
            FieldClass = FlowField;
        }
        field(114; "Leave Days Taken"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries".Days WHERE("Leave Type" = FIELD("Leave Type"),
                                                                    "Employee No." = FIELD("Employee No."),
                                                                    "Leave Allocation" = CONST(false),
                                                                    "Leave Period" = FIELD("Leave Period"),
                                                                    "Entry Type" = FILTER("Negative Adjustment")));
            FieldClass = FlowField;
        }
        field(115; "Leave Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(116; "Leave Carry Over"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries".Days WHERE("Leave Type" = FIELD("Leave Type"),
                                                                    "Employee No." = FIELD("Employee No."),
                                                                    "Leave Allocation" = CONST(false),
                                                                    "Leave Period" = FIELD("Leave Period"),
                                                                    "Entry Type" = FILTER("Carry forward")));
            FieldClass = FlowField;
        }
        field(117; "Document Name"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(118; "Pending Approver"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Approval Entry"."Approver ID" WHERE("Document No." = FIELD("No."),
                                                                  Status = FILTER(Open));
        }
        field(119; "Leave Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "On Leave",Reinstated;
        }
        field(120; "Position Title"; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."Position Title";
        }
        field(121; "Substitute No2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                "Substitute Name2" := '';

                Employee.Reset;
                if Employee.Get("Substitute No2") then begin
                    "Substitute Name2" := Employee."Last Name" + ' ' + Employee."First Name" + ' ' + Employee."Middle Name";
                end;

                HRLeaveApplication.Reset;
                HRLeaveApplication.SetRange("Employee No.", "Substitute No2");
                HRLeaveApplication.SetRange(Posted, true);
                if HRLeaveApplication.FindLast then begin
                    if HRLeaveApplication."Leave Return Date" > Today then
                        Error(Text_002);
                    ;
                end;
            end;
        }
        field(122; "Substitute Name2"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(123; "Substitute No3"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                "Substitute Name3" := '';

                Employee.Reset;
                if Employee.Get("Substitute No3") then begin
                    "Substitute Name3" := Employee."Last Name" + ' ' + Employee."First Name" + ' ' + Employee."Middle Name";
                end;

                HRLeaveApplication.Reset;
                HRLeaveApplication.SetRange("Employee No.", "Substitute No3");
                HRLeaveApplication.SetRange(Posted, true);
                if HRLeaveApplication.FindLast then begin
                    if HRLeaveApplication."Leave Return Date" > Today then
                        Error(Text_002);
                    ;
                end;
            end;
        }
        field(124; "Substitute Name3"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(125; "Cancelled By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(126; "Time Cancelled"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(127; "Date Cancelled"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(128; "Reason for Cancellation"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(129; Driver; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50000; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(50225; HOD; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50226; "Area Manager"; Boolean)
        {
            Caption = 'Supervisor';
            DataClassification = ToBeClassified;
        }
        field(50227; MD; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50228; Printed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50234; CIS; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Leave Application Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Leave Application Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Document Date" := Today;
        "User ID" := UserId;
        Validate("User ID");
        Validate("Employee No.");
    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employee: Record Employee;
        HRLeaveManagement: Codeunit "HR Leave Management";
        HRLeavePeriod: Record "HR Leave Periods";
        LeaveStartDateEarlierthanCurrentDate: Label 'The Leave Start Date cannot be earlier than %1';
        ConfirmDaysAppliedMoreThanLeaveBalance: Label 'The Days Applied:%1 are more than the Leave Balance:%2. The Extra %3  Leave Days will be treated as UnPaid Days. Continue?';
        HRLeaveType: Record "HR Leave Types";
        HRLeavePlanner: Record "HR Leave Planner Header";
        LeavePlannerMandatory: Label 'Leave Plan is mandatory for Leave Type:%1. Leave Plan is missing for Employee No.:%2  Leave Period:%3 Leave Type:%4';
        BaseCalendarCode: Code[10];
        Text_001: Label 'Leave days applied exceed your current Leave Balance. Please adjust the Leave days you are Applying to proceed';
        AnnualLeaveBalance: Decimal;
        LeaveLedgerEntries: Record "HR Leave Ledger Entries";
        LeaveTypes: Record "HR Leave Types";
        LeavePeriods: Record "HR Leave Periods";
        LeaveYear: Integer;
        AnnualLeaveCode: Code[20];
        CurrentYear: Integer;
        LeaveBalance: Decimal;
        LeavePeriod: Code[20];
        HRLeaveApplication: Record "HR Leave Application";
        Text_002: Label 'You cannot select substitute approver who is on leave';
        Text_003: Label 'You cannot apply for another leave before another one ends';
        Text_004: Label 'Days applied must be same as the allocated days';
        EmployeeLeaveType: Record "Employee Leave Type";
        text1234: Label 'hapa are %1';
        CalendarMgmt: Codeunit "HR Calendar Management";
        Description: Text;
        Month: Integer;
        Text_005: Label 'You cannot select a future date ';
}

