table 50125 "HR Leave Planner Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.") then begin
                    "Employee Name" := Employee."Last Name" + ' ' + Employee."First Name" + ' ' + Employee."Middle Name";
                    "Job No." := Employee.Position;
                    "Job Title" := Employee."Job Title";
                    "Job Grade" := Employee."Salary Scale";
                    "Job Description" := Employee."Job Title";
                    "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := Employee."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := Employee."Shortcut Dimension 4 Code";
                    "Shortcut Dimension 5 Code" := Employee."Shortcut Dimension 5 Code";
                    "Shortcut Dimension 6 Code" := Employee."Shortcut Dimension 6 Code";
                    "Shortcut Dimension 7 Code" := Employee."Shortcut Dimension 7 Code";
                    "Shortcut Dimension 8 Code" := Employee."Shortcut Dimension 8 Code";
                    HOD := Employee.HOD;
                    "Area Manager" := Employee.Supervisor;
                    MD := Employee.MD;
                    CIS := Employee.CIS;
                    HRLeavePeriod.Reset;
                    HRLeavePeriod.SetRange(HRLeavePeriod.Closed, false);
                    if HRLeavePeriod.FindFirst then begin
                        "Leave Period" := HRLeavePeriod.Code;
                    end;
                end else begin
                    "Employee Name" := '';
                    "Job No." := '';
                    "Job Title" := '';
                    "Job Grade" := '';
                    "Job Description" := '';
                    "Leave Period" := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Shortcut Dimension 3 Code" := '';
                    "Shortcut Dimension 4 Code" := '';
                    "Shortcut Dimension 5 Code" := '';
                    "Shortcut Dimension 6 Code" := '';
                    "Shortcut Dimension 7 Code" := '';
                    "Shortcut Dimension 8 Code" := '';
                end;
            end;
        }
        field(3; "Employee Name"; Text[150])
        {
            Editable = false;
        }
        field(4; "Job No."; Code[20])
        {
            Editable = false;
            TableRelation = "HR Jobs"."No.";
        }
        field(5; "Job Title"; Code[50])
        {
            Editable = false;
        }
        field(6; "Job Description"; Text[100])
        {
            Editable = false;
        }
        field(7; "Job Grade"; Code[20])
        {
            Editable = false;
            TableRelation = "HR Job Lookup Value".Code WHERE(Option = CONST("Job Grade"));
        }
        field(8; Level; Option)
        {
            Caption = 'Level';
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = ' ,CMT,Management,Unionisable';
            OptionMembers = " ",CMT,Management,Unionisable;
        }
        field(20; "Leave Type"; Code[50])
        {
            TableRelation = "HR Leave Types".Code WHERE("Leave Plan Mandatory" = CONST(false));

            trigger OnValidate()
            begin
                "Leave Period" := '2022';
            end;
        }
        field(21; "Leave Period"; Code[20])
        {
            Editable = false;
            TableRelation = "HR Leave Periods".Code WHERE(Closed = CONST(false));
        }
        field(49; Description; Text[250])
        {

            trigger OnValidate()
            begin
                Description := UpperCase(Description);
            end;
        }
        field(50; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(51; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(52; "Shortcut Dimension 3 Code"; Code[50])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(53; "Shortcut Dimension 4 Code"; Code[50])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(54; "Shortcut Dimension 5 Code"; Code[50])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(55; "Shortcut Dimension 6 Code"; Code[50])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(56; "Shortcut Dimension 7 Code"; Code[50])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(57; "Shortcut Dimension 8 Code"; Code[50])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(58; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(70; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            OptionMembers = Open,"Pending Approval",Released,Rejected;
        }
        field(99; "User ID"; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange(Employee."User ID", "User ID");
                if Employee.FindFirst then begin
                    Employee.TestField("Global Dimension 1 Code");
                    Employee.TestField("Global Dimension 2 Code");
                    "Employee No." := Employee."No.";
                    "Employee Name" := Employee."Last Name" + ' ' + Employee."Middle Name" + ' ' + Employee."First Name";
                    "Job No." := Employee.Position;
                    "Job Title" := Employee."Job Title";
                    "Job Grade" := Employee."Salary Scale";
                    "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := Employee."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := Employee."Shortcut Dimension 4 Code";
                    "Shortcut Dimension 5 Code" := Employee."Shortcut Dimension 5 Code";
                    "Shortcut Dimension 6 Code" := Employee."Shortcut Dimension 6 Code";
                    "Shortcut Dimension 7 Code" := Employee."Shortcut Dimension 7 Code";
                    "Shortcut Dimension 8 Code" := Employee."Shortcut Dimension 8 Code";
                end;
            end;
        }
        field(100; "No. Series"; Code[20])
        {
        }
        field(102; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
        }
        field(107; "Pending Approver"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Approval Entry"."Approver ID" WHERE("Document No." = FIELD("No."),
                                                                  Status = FILTER(Open));
        }
        field(117; Department; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(118; Station; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(119; Section; Text[50])
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
        field(121; "Created By Employee"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*  IF Employee.GET("Created By Employee") THEN BEGIN
                    IF Employee.Responsibilty = Employee.Responsibilty::" " THEN BEGIN
                      ERROR('You are not Allowed to Make this Request. Contact Section Head for Assistance.');
                      EXIT;
                    END;
                  END;*/

            end;
        }
        field(122; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(123; "No of Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
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
            HRSetup.TestField(HRSetup."Leave Planner Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Leave Planner Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "User ID" := UserId;
        Validate("User ID");
    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employee: Record Employee;
        HRLeavePeriod: Record "HR Leave Periods";
}

