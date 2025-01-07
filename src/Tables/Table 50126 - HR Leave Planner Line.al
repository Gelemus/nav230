table 50126 "HR Leave Planner Line"
{

    fields
    {
        field(1; "Leave Planner No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Start Date"; Date)
        {

            trigger OnValidate()
            begin
                //Check if Its Non Working day
            end;
        }
        field(3; "End Date"; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin
                "No. of Days" := Date2DMY("End Date", 1) - Date2DMY("Start Date", 1) + 1;
            end;
        }
        field(4; "Reliever No."; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Reliever No.") then begin
                    "Reliever Name" := Employee."Last Name" + ' ' + Employee."First Name" + ' ' + Employee."Middle Name";
                end else begin
                    "Reliever Name" := '';
                end;
            end;
        }
        field(5; "Reliever Name"; Text[150])
        {
            Editable = false;
        }
        field(6; "No. of Days"; Integer)
        {

            trigger OnValidate()
            begin
                TestField("Start Date");
                if HRLeavePlannerHeader.Get("Leave Planner No.") then begin
                    HRLeavePlannerHeader.TestField(HRLeavePlannerHeader."Employee No.");
                    HRLeavePlannerHeader.TestField(HRLeavePlannerHeader."Leave Type");
                    HRLeavePlannerHeader.TestField(HRLeavePlannerHeader."Leave Period");
                    HRLeavePlannerHeader.TestField(HRLeavePlannerHeader.Description);
                    HRLeavePlannerHeader.TestField(HRLeavePlannerHeader."Global Dimension 1 Code");
                    HRLeavePlannerHeader."No of Days" := "No. of Days";
                    Employee.Reset;
                    Employee.SetRange("No.", HRLeavePlannerHeader."Employee No.");
                    if Employee.FindFirst then
                        BaseCalender.Reset;
                    BaseCalender.SetRange(Code, Employee."Leave Calendar");
                    if BaseCalender.FindFirst then
                        "End Date" := HRLeaveManagement.CalculateLeaveEndDate(HRLeavePlannerHeader."Leave Type", HRLeavePlannerHeader."Leave Period", "Start Date", "No. of Days", BaseCalender.Code);
                end;

            end;
        }
        field(7; "Reliever Grade"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Designation; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Month; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Level; Option)
        {
            Caption = 'Level';
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = ' ,CMT,Management,Unionisable';
            OptionMembers = " ",CMT,Management,Unionisable;
        }
        field(20; "Leave Type"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Leave Types".Code WHERE("Leave Plan Mandatory" = CONST(true));
        }
        field(21; "Leave Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "HR Leave Periods".Code WHERE(Closed = CONST(false));
        }
        field(50; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimensionValue.Reset;
                DimensionValue.SetRange(Code, "Global Dimension 1 Code");
                if DimensionValue.FindFirst then
                    Department := DimensionValue.Name;
            end;
        }
        field(51; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimensionValue.Reset;
                DimensionValue.SetRange(Code, "Global Dimension 2 Code");
                if DimensionValue.FindFirst then
                    Station := DimensionValue.Name;
            end;
        }
        field(52; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimensionValue.Reset;
                DimensionValue.SetRange(Code, "Shortcut Dimension 3 Code");
                if DimensionValue.FindFirst then
                    Section := DimensionValue.Name;
            end;
        }
        field(117; Department; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(118; Station; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(119; Section; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(120; "Leave Balance"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries".Days WHERE("Employee No." = FIELD("Employee No."),
                                                                    "Leave Type" = FIELD("Leave Type"),
                                                                    "Leave Period" = FIELD("Leave Period")));
            FieldClass = FlowField;
        }
        field(121; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(122; "Employee Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Leave Planner No.", "Start Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;
        HRLeaveManagement: Codeunit "HR Leave Management";
        HRLeavePlannerHeader: Record "HR Leave Planner Header";
        BaseCalender: Record "HR Base Calendar";
        DimensionValue: Record "Dimension Value";
}

