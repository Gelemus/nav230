table 50164 "HR Training Applications"
{

    fields
    {
        field(1; "Application No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Training Need No."; Code[20])
        {
            Caption = 'Approved Training Need No.';
            NotBlank = true;
            TableRelation = IF ("Type of Training" = CONST("Individual Training")) "Approved Training Needs Line"."No." WHERE("Employee No." = FIELD("No."),
                                                                                                                             "No." = FIELD("Training Need No."),
                                                                                                                             "Training Attended" = CONST(false))
            ELSE IF ("Type of Training" = CONST("Group Training")) "HR Training Needs Line";

            trigger OnValidate()
            begin
                /*"Development Need":='';
                "Purpose of Training":='';
                Location:='';*/


                ApprovedTrainingNeedsLine.Reset;
                ApprovedTrainingNeedsLine.SetRange("No.", "Training Need No.");
                ApprovedTrainingNeedsLine.SetRange("Employee No.", "Employee No.");
                ApprovedTrainingNeedsLine.SetRange("Approved By Management", true);
                ApprovedTrainingNeedsLine.SetRange("Training Attended", false);
                if ApprovedTrainingNeedsLine.FindSet then begin
                    "Development Need" := ApprovedTrainingNeedsLine."Development Needs";
                    "Purpose of Training" := ApprovedTrainingNeedsLine.Objectives;
                    Location := ApprovedTrainingNeedsLine."Training Location & Venue";
                    "From Date" := ApprovedTrainingNeedsLine."Training Scheduled Date";
                    "To Date" := ApprovedTrainingNeedsLine."Training Scheduled Date To";

                    TrainingAttendees.Reset;
                    TrainingAttendees.SetRange(TrainingAttendees."Application No.", "Application No.");
                    if TrainingAttendees.FindFirst then begin
                        CalcFields("Estimated Cost Of Training");
                        TrainingAttendees."Estimated Cost" := ApprovedTrainingNeedsLine."Estimated Cost";
                        TrainingAttendees.Modify;
                    end;
                end;

            end;
        }
        field(5; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Type of Training" = CONST("Group Training")) "HR Training Group"."Training Group App. No."
            ELSE IF ("Type of Training" = CONST("Individual Training")) Employee."No.";

            trigger OnValidate()
            begin
                TestField("Type of Training");
                Name := '';
                Description := '';
                "Development Need" := '';
                "Purpose of Training" := '';
                "Calendar Year" := '';
                "Number of Days" := '';
                "From Date" := 0D;
                "To Date" := 0D;

                TrainingEvaluation.Reset;
                TrainingEvaluation.SetRange(TrainingEvaluation."Employee No.", "No.");
                TrainingEvaluation.SetRange(Submitted, false);
                if TrainingEvaluation.FindFirst then begin
                    Error(ErrorTrainingApplication);
                end;


                if HREmployee.Get("No.") then begin
                    Name := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                    "Global Dimension 1 Code" := HREmployee."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := HREmployee."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := HREmployee."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := HREmployee."Shortcut Dimension 4 Code";
                end;
                TrainingManagement.ValidateTrainingDetails(Rec);
            end;
        }
        field(6; Name; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Document Date"; Date)
        {
            Editable = false;
        }
        field(8; Description; Text[250])
        {
        }
        field(9; "From Date"; Date)
        {
            Caption = 'Training Start Date';
        }
        field(10; "To Date"; Date)
        {
            Caption = 'Training End Date';

            trigger OnValidate()
            begin
                "Number of Days" := Format("To Date" - "From Date");
            end;
        }
        field(11; "Number of Days"; Text[70])
        {
            Editable = false;
        }
        field(12; "Estimated Cost Of Training"; Decimal)
        {
            CalcFormula = Sum("HR Training Attendees"."Estimated Cost" WHERE("Application No." = FIELD("Application No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; Location; Text[30])
        {
            Caption = 'Training Location and Venue';
            Editable = false;
        }
        field(14; "Provider Code"; Code[10])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."No.", "Provider Code");
                if Vendor.FindFirst then begin
                    "Provider Name" := Vendor.Name;
                end;
            end;
        }
        field(15; "Provider Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Purpose of Training"; Text[100])
        {
            Caption = 'Objective/Purpose of Training';
        }
        field(17; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(18; Posted; Boolean)
        {
            Editable = false;
        }
        field(19; Recommendations; Code[20])
        {
        }
        field(20; "Actual Training Cost"; Decimal)
        {
            Caption = 'Actual Cost of Training';
        }
        field(21; "Total Training Cost"; Decimal)
        {
            CalcFormula = Sum("HR Training Attendees"."Actual Training Cost" WHERE("Application No." = FIELD("Application No.")));
            Caption = 'Total Actual Training Cost ';
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Calendar Year"; Code[20])
        {
            Caption = 'Training Calendar Year';
            DataClassification = ToBeClassified;
            TableRelation = "HR Calendar Period".Code;
        }
        field(23; "Development Need"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "User ID"; Code[50])
        {
            Editable = true;
        }
        field(26; "Evaluation Submitted"; Boolean)
        {
            Caption = 'Training Evaluation Submitted';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50; "No. Series"; Code[20])
        {
        }
        field(51; "Type of Training"; Option)
        {
            Caption = 'Training Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Individual Training","Group Training","Individual Induction","Group Induction";

            trigger OnValidate()
            begin
                "No." := '';
                Name := '';
                Description := '';
                "Development Need" := '';
                "Purpose of Training" := '';
                "Calendar Year" := '';
                "Number of Days" := '';
                "From Date" := 0D;
                "To Date" := 0D;

                //delete all lines
                TrainingAttendees.Reset;
                TrainingAttendees.SetRange("Application No.", "Application No.");
                if TrainingAttendees.FindSet then
                    TrainingAttendees.DeleteAll;
            end;
        }
        field(52; "Employee No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                TrainingAttendees.Reset;
                TrainingAttendees.SetRange("Application No.", "Application No.");
                if TrainingAttendees.FindSet then
                    TrainingAttendees.DeleteAll;

                "Employee Name" := '';

                if HREmployee.Get("Employee No.") then begin
                    "Employee Name" := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";

                    TrainingAttendees.Init;
                    TrainingAttendees."Application No." := "Application No.";
                    TrainingAttendees."Employee No" := "Employee No.";
                    TrainingAttendees."Employee Name" := "Employee Name";
                    TrainingAttendees."E-mail Address" := HREmployee."Company E-Mail";
                    TrainingAttendees."Global Dimension 1 Code" := HREmployee."Global Dimension 1 Code";
                    TrainingAttendees."Global Dimension 2 Code" := HREmployee."Global Dimension 2 Code";
                    TrainingAttendees."Shortcut Dimension 3 Code" := HREmployee."Shortcut Dimension 3 Code";
                    TrainingAttendees."Shortcut Dimension 4 Code" := HREmployee."Shortcut Dimension 4 Code";
                    TrainingAttendees."Shortcut Dimension 5 Code" := HREmployee."Shortcut Dimension 5 Code";
                    TrainingAttendees."Shortcut Dimension 6 Code" := HREmployee."Shortcut Dimension 6 Code";
                    TrainingAttendees."Shortcut Dimension 7 Code" := HREmployee."Shortcut Dimension 7 Code";
                    TrainingAttendees."Shortcut Dimension 8 Code" := HREmployee."Shortcut Dimension 8 Code";
                    TrainingAttendees.Insert;
                end;
            end;
        }
        field(53; "Employee Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(54; "Evaluation Card Created"; Boolean)
        {
            Caption = 'Evaluation Card Created';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(61; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(62; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(63; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false),
                                                          test = FIELD("Global Dimension 1 Code"));
        }
        field(64; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false),
                                                          test = FIELD("Global Dimension 1 Code"));
        }
        field(65; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false),
                                                          test = FIELD("Global Dimension 1 Code"));
        }
        field(66; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false),
                                                          test = FIELD("Global Dimension 1 Code"));
        }
        field(67; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false),
                                                          test = FIELD("Global Dimension 1 Code"));
        }
    }

    keys
    {
        key(Key1; "Application No.")
        {
        }
        // key(Key2;'')
        // {
        //     Enabled = false;
        // }
        // key(Key3;'')
        // {
        //     Enabled = false;
        // }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Application No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Training Application Nos");
            NoSeriesMgt.InitSeries(HRSetup."Training Application Nos", xRec."No. Series", 0D, "Application No.", "No. Series");
        end;

        "User ID" := UserId;
        "Document Date" := Today;
    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TrainingNeeds: Record "HR Training Needs Line";
        TrainingGroupParticipants: Record "Approved Training Needs Line";
        TrainingManagement: Codeunit "HR Training Management";
        TrainingGroups: Record "HR Training Group";
        Vendor: Record Vendor;
        HREmployee: Record Employee;
        TrainingAttendees: Record "HR Training Attendees";
        Dates: Codeunit Dates;
        ApprovedTrainingNeedsLine: Record "Approved Training Needs Line";
        TrainingEvaluation: Record "Training Evaluation";
        ErrorTrainingApplication: Label 'You cannot make another Training application if you have not submiited an Evaluation from your previous training attended! Please submit evaluation for your previous Training to proceed';
}

