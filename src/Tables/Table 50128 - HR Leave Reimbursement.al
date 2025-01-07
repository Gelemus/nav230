table 50128 "HR Leave Reimbursement"
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
        }
        field(4; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.") then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := Employee."Shortcut Dimension 3 Code";

                end else begin
                    "Employee Name" := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Shortcut Dimension 3 Code" := '';
                end;
            end;
        }
        field(5; "Employee Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Leave Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Leave Application"."No." WHERE("Employee No." = FIELD("Employee No."),
                                                                Status = CONST(Posted));

            trigger OnValidate()
            begin
                if HRLeaveApplication.Get("Leave Application No.") then begin
                    "Leave Type" := HRLeaveApplication."Leave Type";
                    "Leave Period" := HRLeaveApplication."Leave Period";
                    "Leave Start Date" := HRLeaveApplication."Leave Start Date";
                    "Leave Days Applied" := HRLeaveApplication."Days Applied";
                    "Leave Days Approved" := HRLeaveApplication."Days Approved";
                    "Leave End Date" := HRLeaveApplication."Leave End Date";
                    "Leave Return Date" := HRLeaveApplication."Leave Return Date";
                    "Substitute No." := HRLeaveApplication."Substitute No.";
                    "Substitute Name" := HRLeaveApplication."Substitute Name";
                    "Reason for Leave" := HRLeaveApplication."Reason for Leave";
                end else begin
                    "Leave Type" := '';
                    "Leave Period" := '';
                    "Leave Start Date" := 0D;
                    "Leave Days Applied" := 0;
                    "Leave Days Approved" := 0;
                    "Leave End Date" := 0D;
                    "Leave Return Date" := 0D;
                    "Substitute No." := '';
                    "Substitute Name" := '';
                    "Reason for Leave" := '';
                end;
            end;
        }
        field(8; "Leave Type"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "HR Leave Types".Code;
        }
        field(9; "Leave Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "HR Leave Periods".Code;
        }
        field(10; "Leave Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Leave Days Applied"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            MinValue = 0;
        }
        field(12; "Leave Days Approved"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            MinValue = 0;
        }
        field(13; "Leave End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Leave Return Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Substitute No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Employee;
        }
        field(17; "Substitute Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Reason for Leave"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Leave Balance"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Actual Return Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Leave Application No.");
                if "Actual Return Date" >= "Leave Return Date" then begin
                    Error(ActualReturnDateError, "Leave Return Date");
                end;
                if "Actual Return Date" < "Leave Start Date" then begin
                    Error(ActualReturnDateError_2, "Leave Start Date");
                end;

                if "Actual Return Date" <> 0D then begin
                    ActualReturnDate := "Actual Return Date";
                    if Employees.Get("Employee No.") then
                        BaseCalendarCode := Employees."Leave Calendar";

                    while ActualReturnDate <= "Leave End Date" do begin
                        // musya//NonWorkingDay:=CalendarMgmt.CheckDateStatus(BaseCalendarCode,ActualReturnDate,Description);
                        if NonWorkingDay then begin
                        end else begin
                            TotalLeaveDays := TotalLeaveDays + 1;
                        end;
                        ActualReturnDate := ActualReturnDate + 1;
                    end;
                    "Days to Reimburse" := TotalLeaveDays;
                end;
            end;
        }
        field(25; "Days to Reimburse"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Reason for Reimbursement"; Text[250])
        {
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
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted';
            OptionMembers = Open,"Pending Approval",Released,Rejected,Posted;
        }
        field(71; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(73; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(74; "Time Posted"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(99; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup"."User ID";
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
        field(103; "Leave Year"; Integer)
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
            HRSetup.TestField(HRSetup."Leave Reimbursement Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Leave Reimbursement Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Document Date" := Today;
        "User ID" := UserId;
    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employee: Record Employee;
        HRLeaveApplication: Record "HR Leave Application";
        ActualReturnDateError: Label 'The Actual Return Date cannot be on or later than the Leave Return Date:%1';
        BaseCalendarCode: Code[20];
        ActualReturnDateError_2: Label 'The Actual Return Date cannot be on or Earlier than the Leave Start Date:%1';
        HRLeaveManagement: Codeunit "HR Leave Management";
        CalendarMgmt: Codeunit "Calendar Management";
        Employees: Record Employee;
        NonWorkingDay: Boolean;
        Description: Text;
        TotalLeaveDays: Integer;
        ActualReturnDate: Date;
        HRBaseCalendarChange: Record "HR Base Calendar Change";
}

