table 50093 "HR Jobs"
{

    fields
    {
        field(1;"No.";Code[20])
        {
            Editable = true;
        }
        field(2;"Job Title";Code[200])
        {
        }
        field(4;"Job Grade";Code[50])
        {
            TableRelation = "HR Job Lookup Value".Code WHERE (Option=CONST("Job Grade"));
        }
        field(6;"Purpose Code";Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Job Lookup Value".Option WHERE (Option=CONST("Job Purpose"));
        }
        field(10;"Maximum Positions";Integer)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                CalcFields("Occupied Positions");
                if "Maximum Positions"<"Occupied Positions" then begin
                  Error(ErrorMaximumPositions,"Occupied Positions");
                end else begin
                  "Vacant Positions":="Maximum Positions"-"Occupied Positions";
                end;
            end;
        }
        field(11;"Occupied Positions";Integer)
        {
            CalcFormula = Count(Employee WHERE (Position=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                CalcFields("Occupied Positions");
                if "Occupied Positions">"Maximum Positions" then begin
                  Error(ErrorVaccantPositions);
                end else begin
                  "Vacant Positions":="Maximum Positions"-"Occupied Positions";
                end;
            end;
        }
        field(12;"Vacant Positions";Integer)
        {
            Editable = false;
            MinValue = 0;
        }
        field(13;"Supervisor Job No.";Code[20])
        {
            TableRelation = "HR Jobs"."No." WHERE (Status=CONST(Open));

            trigger OnValidate()
            begin
                "Supervisor Job Title":='';
                if HRJob.Get("Supervisor Job No.") then begin
                  "Supervisor Job Title":=HRJob."Job Title";
                end;
            end;
        }
        field(14;"Supervisor Job Title";Code[100])
        {
            Editable = false;
        }
        field(15;"Appraisal Level";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Organizational,Departmental,Divisional,Individual';
            OptionMembers = " ",Organizational,Departmental,Divisional,Individual;
        }
        field(16;"Job Purpose";Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(17;"Job Purpose Description 2";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(49;Description;Text[250])
        {

            trigger OnValidate()
            begin
                Description:=UpperCase(Description);
            end;
        }
        field(50;"Global Dimension 1 Code";Code[50])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(51;"Global Dimension 2 Code";Code[50])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(52;"Shortcut Dimension 3 Code";Code[50])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(53;"Shortcut Dimension 4 Code";Code[50])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(54;"Shortcut Dimension 5 Code";Code[50])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(55;"Shortcut Dimension 6 Code";Code[50])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(56;"Shortcut Dimension 7 Code";Code[50])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(57;"Shortcut Dimension 8 Code";Code[50])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(58;"Responsibility Center";Code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(59;Active;Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(70;Status;Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Released,Rejected;
        }
        field(99;"User ID";Code[50])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(100;"No. Series";Code[20])
        {
        }
        field(102;"Incoming Document Entry No.";Integer)
        {
            Caption = 'Incoming Document Entry No.';
        }
        field(103;Levels;Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Job Lookup Value".Code WHERE (Option=CONST("Job Grade Level"));
        }
        field(104;"Employee grades";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(105;"Employee Name";Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(106;"Working Relationships";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,Internal,External';
            OptionMembers = "  ",Internal,External;
        }
        field(107;Mandatory;Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
        key(Key2;"Job Grade")
        {
        }
        key(Key3;"Employee grades")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"No.","Job Title")
        {
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
          HRSetup.Get;
          HRSetup.TestField(HRSetup."Job Nos.");
          NoSeriesMgt.InitSeries(HRSetup."Job Nos.",xRec."No. Series",0D,"No.","No. Series");
        end;
        "User ID":=UserId;
    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRJob: Record "HR Jobs";
        ErrorMaximumPositions: Label 'The Maximum Position(s) cannot be Less than the Occupied Position(s):%1';
        ErrorVaccantPositions: Label 'The Vaccant Position(s) cannot exceed the Maximum Position(s) to be occupied for this Job.';
}

