table 50161 "Training Evaluation"
{

    fields
    {
        field(1;"Training Evaluation No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2;"Employee No.";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange(Employee."No.","Employee No.");
                if Employee.FindFirst then begin
                  "Employee Name":=Employee."Last Name"+' '+Employee."Middle Name"+' '+Employee."First Name";
                  "Official Mail":=Employee."Company E-Mail";
                  "Global Dimension 1 Code":=Employee."Global Dimension 1 Code";
                  "Global Dimension 2 Code":=Employee."Global Dimension 2 Code";
                  "Shortcut Dimension 3 Code":=Employee."Shortcut Dimension 3 Code";
                end;
            end;
        }
        field(3;"Employee Name";Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4;"Official Mail";Text[100])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(6;"Training Application no.";Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Training Applications"."Application No." WHERE ("No."=FIELD("Employee No."));

            trigger OnValidate()
            begin
                HRTrainingApplications.Reset;
                HRTrainingApplications.SetRange("Application No.","Training Application no.");
                if HRTrainingApplications.FindFirst then begin
                  "Calendar Year":=HRTrainingApplications."Calendar Year";
                  "Venue/Location":=HRTrainingApplications.Location;
                  "Training Provider":=HRTrainingApplications."Provider Name";
                  "Developement Need":=HRTrainingApplications."Development Need";
                  Objectives:=HRTrainingApplications."Purpose of Training";
                  "Training Start Date":=HRTrainingApplications."From Date";
                  "Training End Date":=HRTrainingApplications."To Date";
                end;
            end;
        }
        field(7;"Calendar Year";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "HR Calendar Period".Code;
        }
        field(8;"Training Provider";Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9;"Venue/Location";Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10;"General Comments from Training";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Objective Achieved";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13;Submitted;Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14;Date;Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Developement Need";Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16;Objectives;Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17;"Training Start Date";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18;"Training End Date";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20;"User ID";Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange(Employee."User ID","User ID");
                if Employee.FindFirst then begin
                  "Employee No.":=Employee."No.";
                  "Employee Name":=Employee."Last Name"+' '+Employee."Middle Name"+' '+Employee."First Name";
                  "Global Dimension 1 Code":=Employee."Global Dimension 1 Code";
                  "Global Dimension 2 Code":=Employee."Global Dimension 2 Code";
                  "Shortcut Dimension 3 Code":=Employee."Shortcut Dimension 3 Code";
                  "Shortcut Dimension 4 Code":=Employee."Shortcut Dimension 4 Code";
                  "Shortcut Dimension 5 Code":=Employee."Shortcut Dimension 5 Code";
                  "Shortcut Dimension 6 Code":=Employee."Shortcut Dimension 6 Code";
                  "Shortcut Dimension 7 Code":=Employee."Shortcut Dimension 7 Code";
                  "Shortcut Dimension 8 Code":=Employee."Shortcut Dimension 8 Code"
                end;
            end;
        }
        field(21;"No. Series";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25;Status;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(50;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(51;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(52;"Shortcut Dimension 3 Code";Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(53;"Shortcut Dimension 4 Code";Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
        }
        field(54;"Shortcut Dimension 5 Code";Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
        }
        field(55;"Shortcut Dimension 6 Code";Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
        }
        field(56;"Shortcut Dimension 7 Code";Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
        }
        field(57;"Shortcut Dimension 8 Code";Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
        }
    }

    keys
    {
        key(Key1;"Training Evaluation No.","Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Training Evaluation No."= '' then begin
          HRSetup.Get;
          HRSetup.TestField(HRSetup."Employee Evaluation Nos.");
          NoSeriesMgt.InitSeries(HRSetup."Training Group Nos",xRec."No. Series",0D,"Training Evaluation No.","No. Series");
        end;

        "User ID":=UserId;
        Date:=Today;
    end;

    var
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRTrainingApplications: Record "HR Training Applications";
}

