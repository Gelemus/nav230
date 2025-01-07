table 50099 "HR Job Applications"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Employee Requisition No."; Code[20])
        {
            TableRelation = "HR Employee Requisitions"."No." WHERE(Status = FILTER(Released));

            trigger OnValidate()
            begin
                if HREmployeeRequisition.Get("Employee Requisition No.") then begin
                    "Job No." := HREmployeeRequisition."Job No.";
                    "Job Title" := HREmployeeRequisition."Job Title";
                    "Job Grade" := HREmployeeRequisition."Job Grade";
                    "Emplymt. Contract Code" := HREmployeeRequisition."Emplymt. Contract Code";
                    "Emp. Requisition Description" := HREmployeeRequisition."Emp. Requisition Description";
                    "Global Dimension 1 Code" := HREmployeeRequisition."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := HREmployeeRequisition."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := HREmployeeRequisition."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := HREmployeeRequisition."Shortcut Dimension 4 Code";
                end else begin
                    "Job No." := '';
                    "Job Title" := '';
                    "Emp. Requisition Description" := '';
                    "Job Grade" := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Shortcut Dimension 3 Code" := '';
                    "Shortcut Dimension 4 Code" := '';
                end;
            end;
        }
        field(3; Surname; Text[50])
        {
        }
        field(4; Firstname; Text[50])
        {
        }
        field(5; Middlename; Text[50])
        {
        }
        field(6; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(7; "Date of Birth"; Date)
        {

            trigger OnValidate()
            begin
                HRSetup.Get;
                HRSetup.TestField(HRSetup."Permanent Employment Code");
                TestField("Date of Birth");
                TestField("Emplymt. Contract Code");
                Age := Dates.DetermineAge("Date of Birth", Today);
                if Age < (Format(18)) then
                    Error(Txt_001);
                if (Age > (Format(50))) and ("Emplymt. Contract Code" = HRSetup."Permanent Employment Code") then
                    Error(Txt_002);
            end;
        }
        field(8; Age; Text[250])
        {
            Editable = false;
        }
        field(9; "Postal Address"; Code[20])
        {
        }
        field(10; "Residential Address"; Code[50])
        {
        }
        field(11; "Post Code"; Code[20])
        {
            TableRelation = "Post Code".Code;
        }
        field(12; "City/Town"; Text[30])
        {
            Editable = false;
        }
        field(13; County; Code[50])
        {
            Caption = 'County of Origin Code';
            TableRelation = County;

            trigger OnValidate()
            begin
                if Counties.Get(County) then
                    "County Name" := Counties.Name;
            end;
        }
        field(14; "County Name"; Text[100])
        {
            Caption = 'County of Origin Name';
            Editable = false;
        }
        field(15; SubCounty; Code[50])
        {
            Caption = 'SubCounty of origin Code';
            TableRelation = "Sub-County"."Sub-County Code" WHERE("County Code" = FIELD(County));

            trigger OnValidate()
            begin
                SubCounties.Reset;
                SubCounties.SetRange("County Code", County);
                SubCounties.SetRange("Sub-County Code", SubCounty);
                if SubCounties.FindFirst then
                    "SubCounty Name" := SubCounties."Sub-County Name";
            end;
        }
        field(16; "SubCounty Name"; Text[100])
        {
            Caption = 'SubCounty of Origin Name';
            Editable = false;
        }
        field(17; Country; Code[50])
        {
            TableRelation = "Country/Region".Code;

            trigger OnValidate()
            begin
                Country := UpperCase(Country);
            end;
        }
        field(18; "Alternative Phone No."; Code[20])
        {
        }
        field(19; "Mobile Phone No."; Code[20])
        {
        }
        field(20; "Personal Email Address"; Text[100])
        {
        }
        field(21; "Birth Certificate No."; Code[20])
        {
        }
        field(22; "National ID No."; Code[20])
        {
        }
        field(23; "Passport No."; Code[20])
        {
        }
        field(24; "Driving Licence No."; Code[20])
        {
        }
        field(25; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married';
            OptionMembers = " ",Single,Married;
        }
        field(26; Citizenship; Code[50])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Option = CONST(Nationality));
        }
        field(27; Religion; Code[50])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Option = CONST(Religion));
        }
        field(28; "Person Living With Disability"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;
        }
        field(29; "Ethnic Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Lookup Values".Code WHERE(Option = CONST(Ethnicity));
        }
        field(30; "Emplymt. Contract Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employment Contract".Code;
        }
        field(31; "Email Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Huduma No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "PIN  No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "NHIF No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "NSSF No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Job No."; Code[20])
        {
            Editable = false;
            TableRelation = "HR Jobs"."No.";

            trigger OnValidate()
            begin
                if HRJob.Get("Job No.") then
                    "Job Title" := HRJob."Job Title";
            end;
        }
        field(41; "Job Title"; Code[50])
        {
            Editable = false;
        }
        field(42; "Emp. Requisition Description"; Code[250])
        {
            Editable = false;
        }
        field(43; "Job Grade"; Code[50])
        {
            Editable = false;
            TableRelation = "HR Job Lookup Value".Code WHERE(Option = CONST("Job Grade"));
        }
        field(44; Qualified; Boolean)
        {
            Editable = false;
        }
        field(45; ShortListed; Boolean)
        {
            Caption = 'System ShortListed';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(46; "Salary Notch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Job Grade Levels"."Job Grade Level" WHERE("Job Grade" = FIELD("Job Grade"));
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
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(51; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,2,2';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(52; "Shortcut Dimension 3 Code"; Code[50])
        {
            CaptionClass = '1,2,3';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(53; "Shortcut Dimension 4 Code"; Code[50])
        {
            CaptionClass = '1,2,4';
            Editable = false;
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
        field(59; "Committee Shortlisted"; Boolean)
        {
            Caption = 'Committee Approved  Shortlisting';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60; "Interview Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Interview Time"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Interview Location"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Submitted,Shortlisted,Unsuccessful,Closed';
            OptionMembers = Open,"Pending Approval",Approved,Submitted,Shortlisted,Unsuccessful,Closed;
        }
        field(80; "Post Applied Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employee Requisitions"."Job No.";
        }
        field(81; "Post Applied Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employee Requisitions"."Job No.";
        }
        field(99; "User ID"; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(100; "No. Series"; Code[20])
        {
        }

        field(102; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
        }
        field(103; "Expected Salary"; Decimal)
        {

        }
        field(104; "Years of Experience"; Integer)
        {
        }
        field(105; "O Level Grade"; code[50])
        {

        }
        field(106; "Declaration"; Boolean)
        {

        }
        field(52136923; "National Identity Card"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136924; "Pin Certificate"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136925; NSSF; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136926; NHIF; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136927; "Copy of ATM"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136928; "Academic Certs Original"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136929; "2 Passport Colored Photos"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136930; "HELB Loan Status statement"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136931; "EACC Clearance Cert"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136932; "Good Conduct Cert"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136933; "Tax Compliance Cert"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136934; "CRB Clearance Cert"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136935; "Cert of Service"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136936; "Birth Certificate"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136937; "Employee Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136938; "To be Interviewed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136939; "HR Salary Notch"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Human Capital Management)';
            TableRelation = "HR Job Grade Levels"."Job Grade Level" WHERE("Job Grade" = FIELD("Job Grade"));
        }
        field(52137048; PasswordResetToken; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Human Capital Management)';
        }
        field(52137049; PasswordResetTokenExpiry; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Human Capital Management)';
        }
        field(52137050; "Portal Password"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Human Capital Management)';
        }
        field(52137051; "Default Portal Password"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Human Capital Management)';
            Editable = false;
        }
        field(52137080; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Human Capital Management)';
            TableRelation = "Bank Code"."Bank Code";

            trigger OnValidate()
            begin
                "Bank Name" := '';
                BankCodes.Reset;
                BankCodes.SetRange(BankCodes."Bank Code", "Bank Code");
                if BankCodes.FindFirst then begin
                    BankCodes.TestField(BankCodes."Bank Name");
                    "Bank Name" := BankCodes."Bank Name";
                end;
            end;
        }
        field(52137081; "Bank Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Human Capital Management)';
        }
        field(52137082; "Bank Branch Code"; Code[20])
        {
            Caption = 'Bank Branch Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Human Capital Management)';
            TableRelation = "Bank Branch"."Bank Branch Code" WHERE("Bank Code" = FIELD("Bank Code"));

            trigger OnValidate()
            begin
                "Bank Branch Name" := '';
                BankBranches.Reset;
                BankBranches.SetRange(BankBranches."Bank Code", "Bank Code");
                BankBranches.SetRange(BankBranches."Bank Branch Code", "Bank Branch Code");
                if BankBranches.FindFirst then begin
                    BankBranches.TestField(BankBranches."Bank Branch Name");
                    "Bank Branch Name" := BankBranches."Bank Branch Name";
                end;
            end;
        }
        field(52137083; "Bank Branch Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Human Capital Management)';
        }
        field(52137084; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Human Capital Management)';
        }
        field(52137085; "Probation Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Human Capital Management)';
        }
        field(52137086; "Probation Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Human Capital Management)';

            trigger OnValidate()
            begin
                if Format("Probation Period") = '' then begin
                    "Probation End date" := 0D
                end else begin
                    TestField("Probation Start Date");
                    "Probation End date" := (CalcDate("Probation Period", "Probation Start Date") - 1);
                end;
            end;
        }
        field(52137087; "Probation End date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Human Capital Management)';
            Editable = false;
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
            HRSetup.TestField(HRSetup."Job Application Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Job Application Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "User ID" := UserId;
    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRJob: Record "HR Jobs";
        HREmployeeRequisition: Record "HR Employee Requisitions";
        Counties: Record County;
        SubCounties: Record "Sub-County";
        Dates: Codeunit Dates;
        PostCode: Record "Post Code";
        Txt_001: Label 'Sorry you are below the Age Limit! You do not qualify to apply for this Job.';
        Txt_002: Label 'Sorry you are above the Age Limit! You do not qualify to apply for this Job.';
        BankCodes: Record "Bank Code";
        BankBranches: Record "Bank Branch";
}

