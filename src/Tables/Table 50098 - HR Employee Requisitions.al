table 50098 "HR Employee Requisitions"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Jobs"."No." WHERE(Status = CONST(Open),
                                                   "Vacant Positions" = FILTER(> 0),
                                                   Active = CONST(true));

            trigger OnValidate()
            begin
                "Job Title" := '';
                "Job Grade" := '';
                "Global Dimension 1 Code" := '';
                "Global Dimension 2 Code" := '';
                "Maximum Positions" := 0;
                "Vacant Positions" := 0;
                if HRJob.Get("Job No.") then begin
                    HRJob.CalcFields("Occupied Positions");
                    if HRJob."Maximum Positions" = HRJob."Occupied Positions" then begin
                        Error(NoVacantPositions, HRJob."Job Title");
                    end else begin
                        "Job Title" := HRJob."Job Title";
                        "Job Grade" := HRJob."Job Grade";
                        "Global Dimension 1 Code" := HRJob."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := HRJob."Global Dimension 2 Code";

                        "Maximum Positions" := HRJob."Maximum Positions";
                        "Vacant Positions" := HRJob."Maximum Positions" - HRJob."Occupied Positions";
                        "Requested Employees" := HRJob."Vacant Positions";
                    end;
                end;
            end;
        }
        field(3; "Job Title"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Emp. Requisition Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Job Grade"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "HR Job Lookup Value".Code WHERE(Option = CONST("Job Grade"));
        }
        field(6; "Maximum Positions"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Occupied Positions"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Vacant Positions"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Requested Employees"; Integer)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                TestField("Job No.");
                if "Requested Employees" > "Vacant Positions" then
                    Error(RequestedEmployeesError, "Job Title", "Vacant Positions");
            end;
        }
        field(10; "Closing Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Job No.");
                if "Closing Date" < CalcDate('+1D', Today) then
                    Error(ClosingDateError, CalcDate('+1D', Today));
            end;
        }
        field(11; "Requisition Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Internal,Internal/External';
            OptionMembers = " ",Internal,"Internal/External";
        }
        field(12; "Emplymt. Contract Code"; Code[10])
        {
            Caption = 'Emplymt. Contract Code';
            DataClassification = ToBeClassified;
            TableRelation = "Employment Contract";
        }
        field(13; "Reason for Requisition"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Interview Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Interview Time"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Interview Location"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Purchase Requisition Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Purchase Requisition No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(49; Description; Text[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Description := UpperCase(Description);
            end;
        }
        field(50; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));

            trigger OnValidate()
            begin
                DimensionValue.Reset;
                DimensionValue.SetRange(Code, "Global Dimension 1 Code");
                if DimensionValue.FindFirst then
                    Department := DimensionValue.Name;
            end;
        }
        field(51; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));

            trigger OnValidate()
            begin
                DimensionValue.Reset;
                DimensionValue.SetRange(Code, "Global Dimension 2 Code");
                if DimensionValue.FindFirst then
                    Section := DimensionValue.Name;
            end;
        }
        field(52; "Shortcut Dimension 3 Code"; Code[50])
        {
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard));

            trigger OnValidate()
            begin
                DimensionValue.Reset;
                DimensionValue.SetRange(Code, "Shortcut Dimension 3 Code");
                if DimensionValue.FindFirst then
                    Section := DimensionValue.Name;
            end;
        }

        field(53; "Shortcut Dimension 4 Code"; Code[50])
        {
            CaptionClass = '1,2,4';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(54; "Shortcut Dimension 5 Code"; Code[50])
        {
            CaptionClass = '1,2,5';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(55; "Shortcut Dimension 6 Code"; Code[50])
        {
            CaptionClass = '1,2,6';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(56; "Shortcut Dimension 7 Code"; Code[50])
        {
            CaptionClass = '1,2,7';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(57; "Shortcut Dimension 8 Code"; Code[50])
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
        field(59; "Job Advert Published"; Boolean)
        {
            Caption = 'Job Advertisment Published';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(69; "Job Advert Dropped"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Closed';
            OptionMembers = Open,"Pending Approval",Released,Rejected,Closed;

            trigger OnValidate()
            begin
                if Status = Status::Released then
                    "Requisition Approved" := true;
                Modify;
            end;
        }
        field(71; "Requisition Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Mandatory Docs. Required"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(99; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                UserSetup.Reset;
                UserSetup.SetRange(UserSetup."User ID", "User ID");
                if UserSetup.FindFirst then begin
                    //UserSetup.TESTFIELD(UserSetup."Global Dimension 1 Code");
                    //UserSetup.TESTFIELD(UserSetup."Global Dimension 2 Code");
                    "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                    /* "Shortcut Dimension 3 Code":=UserSetup."Shortcut Dimension 3 Code";
                     "Shortcut Dimension 4 Code":=UserSetup."Shortcut Dimension 4 Code";
                     "Shortcut Dimension 5 Code":=UserSetup."Shortcut Dimension 5 Code";
                     "Shortcut Dimension 6 Code":=UserSetup."Shortcut Dimension 6 Code";
                     "Shortcut Dimension 7 Code":=UserSetup."Shortcut Dimension 7 Code";
                     "Shortcut Dimension 8 Code":=UserSetup."Shortcut Dimension 8 Code";*/
                    "Employee No" := UserSetup."No.";
                    "Employee Name" := UserSetup."Full Name";
                    Validate("Employee No");
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
        field(103; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(104; "Regret Email Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(105; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                EmployeeRec.Reset;
                EmployeeRec.SetRange("No.", "Employee No");
                if EmployeeRec.FindSet then begin
                    "Employee Name" := EmployeeRec."Full Name";
                    Position := EmployeeRec.Position;
                    "Position Title" := EmployeeRec."Position Title";
                    Validate("Global Dimension 1 Code", EmployeeRec."Global Dimension 1 Code");
                    Validate("Global Dimension 2 Code", EmployeeRec."Global Dimension 2 Code");
                    // VALIDATE("Shortcut Dimension 3 Code",Employee."Shortcut Dimension 3 Code");
                end;
            end;
        }
        field(106; "Employee Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(107; "No of days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(108; Position; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee.Position;
        }
        field(109; "Position Title"; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."Position Title";
        }
        field(111; "Casual Job Title"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(112; "Date Required"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(113; "Number Required"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(114; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(115; "End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Start Date" = 0D then
                    Error('Please input Start Date');

                /*
                IF ("End Date"-"Start Date")>14 THEN
                  ERROR('The Engagement must not exceed 2 weeks');
                */

            end;
        }
        field(116; "Main Duties"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(117; "Qualifications Required"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(118; "No of Years of Experience"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(119; "Specific Experience Required"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(120; "Specific Skills Required"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(121; "Reports to"; Code[20])
        {
            Caption = 'Reports to';
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                //

                "Reports to Name" := '';

                if Employee.Get("Reports to") then begin
                    "Reports to Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";

                end;
            end;
        }
        field(122; "Reports to Name"; Text[100])
        {
            Caption = 'Reports to Name';
            DataClassification = ToBeClassified;
        }
        field(123; Supervisor; Code[20])
        {
            Caption = 'Supervisor';
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                //

                "Supervisor Name" := '';

                if Employee.Get(Supervisor) then begin
                    "Supervisor Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";

                end;
            end;
        }
        field(124; "Supervisor Name"; Text[100])
        {
            Caption = 'Supervisor Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(125; "Employee Replaced"; Code[20])
        {
            Caption = 'Employee Replaced';
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                //

                "Employee Replaced Name" := '';

                if Employee.Get("Employee Replaced") then begin
                    "Employee Replaced Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";

                    "Employee Replaced Designation" := Employee."Job Title";
                end;
            end;
        }
        field(126; "Employee Replaced Name"; Text[100])
        {
            Caption = 'Employee Replaced Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(127; "Employee Replaced Designation"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(128; "Age bracket"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(129; "Budget Vote"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Requisition Codes"."Requisition Code" WHERE("Requisition Type" = CONST(Service));

            trigger OnValidate()
            begin
                PurchaseRequisitionCodes.Get(0, "Budget Vote");
                "Budget GL" := PurchaseRequisitionCodes."No.";
                "Budget GL Name" := PurchaseRequisitionCodes.Name;
            end;
        }
        field(130; "Budget GL"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                if "GL ACCOUNT".Get("Budget GL") then
                    "Budget GL Name" := "GL ACCOUNT".Name;
            end;
        }
        field(131; "Budget GL Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(132; Escalated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(133; "Escalation Reason"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(134; Department; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(135; Section; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(136; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Employee Request","Casual Request";
        }
        field(137; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(138; "Number Required - Skilled"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Skilled" := "Number Required - Skilled" * "Days for Engagement - Skilled" * "Daily Rate Skilled";
                "Estimated Total Cost of Work" := "Total Skilled" + "Total Unskilled" + "Total Piece Work";
            end;
        }
        field(139; "Number Required - Unskilled"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Unskilled" := "Number Required - Unskilled" * "Days for Engagement - Unkilled" * "Daily Rate Unskilled";
                "Estimated Total Cost of Work" := "Total Skilled" + "Total Unskilled" + "Total Piece Work";
            end;
        }
        field(140; "Reason for engagement"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(141; "Daily Rate Skilled"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                "Total Skilled" := "Number Required - Skilled" * "Days for Engagement - Skilled" * "Daily Rate Skilled";
                "Estimated Total Cost of Work" := "Total Skilled" + "Total Unskilled" + "Total Piece Work";
            end;
        }
        field(142; "Daily Rate Unskilled"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                "Total Unskilled" := "Number Required - Unskilled" * "Days for Engagement - Unkilled" * "Daily Rate Unskilled";
                "Estimated Total Cost of Work" := "Total Skilled" + "Total Unskilled" + "Total Piece Work";
            end;
        }
        field(50227; "Project No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;

            trigger OnValidate()
            begin
                if JobRec.Get("Project No") then begin
                    "Project Name" := JobRec.Description;
                end;
            end;
        }
        field(50228; "Project Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50229; "Days for Engagement - Skilled"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Skilled" := "Number Required - Skilled" * "Days for Engagement - Skilled" * "Daily Rate Skilled";
                "Estimated Total Cost of Work" := "Total Skilled" + "Total Unskilled" + "Total Piece Work";
            end;
        }
        field(50230; "Days for Engagement - Unkilled"; Integer)
        {
            Caption = 'Days for Engagement - Unskilled';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Unskilled" := "Number Required - Unskilled" * "Days for Engagement - Unkilled" * "Daily Rate Unskilled";
                "Estimated Total Cost of Work" := "Total Skilled" + "Total Unskilled" + "Total Piece Work";
            end;
        }
        field(50231; FileName; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50232; "Piece Work"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50233; "No of Meters/others"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Piece Work" := "No of Meters/others" * Amount;
                "Estimated Total Cost of Work" := "Total Skilled" + "Total Unskilled" + "Total Piece Work";
            end;
        }
        field(50234; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                "Total Piece Work" := "No of Meters/others" * Amount;
                "Estimated Total Cost of Work" := "Total Skilled" + "Total Unskilled" + "Total Piece Work";
            end;
        }
        field(50235; "Estimated Total Cost of Work"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50236; "Total Skilled"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50237; "Total Unskilled"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50238; "Total Piece Work"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50239; "Skilled Casual Rate"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Skilled,Unskilled,Others,Masonry';
            OptionMembers = ,Skilled,Unskilled,Others,Masonry;

            trigger OnValidate()
            begin
                "Daily Rate Skilled" := 0;

                if "Skilled Casual Rate" = "Skilled Casual Rate"::Skilled then begin
                    CasuallRates.Reset;
                    CasuallRates.SetRange("Casual Rates", CasuallRates."Casual Rates"::Skilled);
                    if CasuallRates.FindSet then begin
                        "Daily Rate Skilled" := CasuallRates.Amount;
                    end;
                end else begin
                    if "Skilled Casual Rate" = "Skilled Casual Rate"::Masonry then begin
                        CasuallRates.Reset;
                        CasuallRates.SetRange("Casual Rates", CasuallRates."Casual Rates"::Masonry);
                        if CasuallRates.FindSet then begin
                            "Daily Rate Skilled" := CasuallRates.Amount;
                        end;
                    end;
                end;
            end;
        }
        field(50240; "Unskilled Casual Rate"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Skilled,Unskilled,Others,Masonry';
            OptionMembers = ,Skilled,Unskilled,Others,Masonry;

            trigger OnValidate()
            begin
                "Daily Rate Unskilled" := 0;

                if "Unskilled Casual Rate" = "Unskilled Casual Rate"::Unskilled then begin
                    CasuallRates.Reset;
                    CasuallRates.SetRange("Casual Rates", CasuallRates."Casual Rates"::Unskilled);
                    if CasuallRates.FindSet then begin
                        "Daily Rate Unskilled" := CasuallRates.Amount;
                    end;
                end;
            end;
        }
        field(50241; "Other Casual Rate"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Skilled,Unskilled,Others,Masonry';
            OptionMembers = ,Skilled,Unskilled,Others,Masonry;

            trigger OnValidate()
            begin
                Amount := 0;

                if "Other Casual Rate" = "Other Casual Rate"::Others then begin
                    CasuallRates.Reset;
                    CasuallRates.SetRange("Casual Rates", CasuallRates."Casual Rates"::Others);
                    if CasuallRates.FindSet then begin
                        Amount := CasuallRates.Amount;
                    end;
                end;
            end;
        }
        field(50242; Voted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50243; "Committed Budget"; Boolean)
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
        fieldgroup(DropDown; "No.", "Reason for engagement", "Start Date", "End Date")
        {
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get;
            if "Document Type" = "Document Type"::"Casual Request" then begin
                HRSetup.TestField(HRSetup."Casual Requisition Nos.");
                NoSeriesMgt.InitSeries(HRSetup."Casual Requisition Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            end else begin
                HRSetup.TestField(HRSetup."Employee Requisition Nos.");
                NoSeriesMgt.InitSeries(HRSetup."Employee Requisition Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            end;
        end;
        "User ID" := UserId;
        "Document Date" := Today;
        Validate("User ID");
    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRJob: Record "HR Jobs";
        HREmployeeRequisition: Record "HR Employee Requisitions";
        RequestedEmployeesError: Label 'The Requested Employee(s) cannot be more than the vacant position(s) in the %1 Job, the number of vacant positions is %2';
        NoVacantPositions: Label 'No Vacant Position(s) Exist for Job Title %1';
        ClosingDateError: Label 'The Closing Date cannot be Less than %1';
        EmployeeRec: Record Employee;
        Employee: Record Employee;
        DimensionValue: Record "Dimension Value";
        PurchaseRequisitionCodes: Record "Purchase Requisition Codes";
        "GL ACCOUNT": Record "G/L Account";
        JobRec: Record Job;
        UserSetup: Record Employee;
        CasuallRates: Record "Casual l Rates";
}

