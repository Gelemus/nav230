table 50116 "HR Employee Detail Update"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                "Employee Name" := '';
                if Employee.Get("Employee No.") then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Current Job Grade" := Employee."Job Grade-d";
                    "Current Employee Status" := Employee.Status;
                    "Current HR Department" := Employee.Department;
                    "Current HR Location" := Employee.Location;
                    "Current Bank Code" := Employee."Bank Code-d";
                    "Current Bank Name" := Employee."Bank Name";
                    "Current Bank Branch Code" := Employee."Bank Branch Code-d";
                    "Current Bank Branch Name" := Employee."Bank Branch Name";
                end;
            end;
        }
        field(3; "Employee Name"; Text[150])
        {
            Editable = false;
        }
        field(4; "Document Date"; Date)
        {
        }
        field(9; "Update Option"; Option)
        {
            OptionCaption = ' ,Status Change,Location Transfer,Department Transfer,Bank Change';
            OptionMembers = " ","Status Change","Location Transfer","Department Transfer","Bank Change";

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.") then begin
                    if "Update Option" = "Update Option"::"Status Change" then begin
                        "Current Employee Status" := Employee.Status;
                    end;
                end;
            end;
        }
        field(10; "Current Employee Status"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Active,Inactive,Terminated';
            OptionMembers = " ",Active,Inactive,Terminated;
        }
        field(11; "New Employee Status"; Option)
        {
            OptionCaption = ' ,Active,Inactive,Terminated';
            OptionMembers = " ",Active,Inactive,Terminated;
        }
        field(12; "Current HR Location"; Code[50])
        {
            Editable = false;
        }
        field(13; "New HR Location"; Code[50])
        {
        }
        field(14; "Current HR Department"; Code[50])
        {
            Editable = false;
        }
        field(15; "New HR Department"; Code[50])
        {
        }
        field(16; "Current Bank Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Bank Code"."Bank Code";
        }
        field(17; "Current Bank Name"; Text[100])
        {
            Editable = false;
        }
        field(18; "Current Bank Branch Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Bank Branch"."Bank Branch Code";
        }
        field(19; "Current Bank Branch Name"; Text[150])
        {
            Editable = false;
        }
        field(20; "Current Bank Account No."; Code[20])
        {
            Editable = false;
        }
        field(21; "New Bank Code"; Code[20])
        {
            TableRelation = "Bank Code"."Bank Code";

            trigger OnValidate()
            begin
                "New Bank Name" := '';
                if BankCode.Get("New Bank Code") then begin
                    "New Bank Name" := BankCode."Bank Name";
                end;
            end;
        }
        field(22; "New Bank Name"; Text[100])
        {
            Editable = false;
        }
        field(23; "New Bank Branch Code"; Code[20])
        {
            TableRelation = "Bank Branch"."Bank Branch Code" WHERE("Branch Email Address" = FIELD("New Bank Code"));

            trigger OnValidate()
            begin
                TestField("New Bank Code");
                "New Bank Branch Name" := '';
                if BankBranch.Get("New Bank Code", "New Bank Branch Code") then begin
                    "New Bank Branch Name" := BankBranch."Bank Branch Name";
                    Modify;
                end;
            end;
        }
        field(24; "New Bank Branch Name"; Text[150])
        {
            Editable = false;
        }
        field(25; "New Bank Account No."; Code[20])
        {
        }
        field(26; "Current Job Grade"; Code[50])
        {
            Editable = false;
            TableRelation = "HR Job Lookup Value".Code WHERE(Option = CONST("Job Grade"));
        }
        field(27; "New Job Grade"; Code[50])
        {
            TableRelation = "HR Job Lookup Value".Code WHERE(Option = CONST("Job Grade"));
        }
        field(50; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(51; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(52; "Shortcut Dimension 3 Code"; Code[50])
        {
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard));
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
        field(97; Description; Text[250])
        {
        }
        field(98; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted;
        }
        field(99; "User ID"; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(100; "No. Series"; Code[20])
        {
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
            HRSetup.TestField(HRSetup."Employee Detail Update Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Employee Detail Update Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "User ID" := UserId;
    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employee: Record Employee;
        BankCode: Record "Bank Code";
        BankBranch: Record "Bank Branch";
}

