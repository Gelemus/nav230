table 50142 "Individual Appraisal Lines"
{

    fields
    {
        field(1;"Appraisal No";Code[30])
        {
            TableRelation = "HR Employee Appraisal Header";
        }
        field(2;"Appraisal Period";Code[20])
        {
            TableRelation = "HR Calendar Period".Code;
        }
        field(3;"Appraisal Objective";Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Appraisal Objective".Code WHERE (Code=FIELD("Appraisal Objective"),
                                                                 "Deparment Code"=CONST(''));

            trigger OnValidate()
            begin
                "Objective Weight":=0;
                "Objective Weight":=0;
                HRAppraisalObjective.Reset;
                HRAppraisalObjective.SetRange(Code,"Appraisal Objective");
                if HRAppraisalObjective.FindFirst then
                 "Objective Weight":=HRAppraisalObjective."Objective Weight";
            end;
        }
        field(4;"Organization Activity Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Organization Appraisal Lines"."Activity Code" WHERE ("Appraisal Period"=FIELD("Appraisal Period"),
                                                                                  "Appraisal Objective"=FIELD("Appraisal Objective"),
                                                                                  "Activity Option"=CONST("Cascade-Down"));

            trigger OnValidate()
            begin
                "Organization Activity Descrp":='';

                OrganizationAppraisalLines.Reset;
                OrganizationAppraisalLines.SetRange(OrganizationAppraisalLines."Activity Code","Organization Activity Code");
                OrganizationAppraisalLines.SetRange(OrganizationAppraisalLines."Appraisal Objective","Appraisal Objective");
                if OrganizationAppraisalLines.FindFirst then begin
                    "Organization Activity Descrp":=OrganizationAppraisalLines."Activity Description";
                    "Parameter Type":=OrganizationAppraisalLines."Parameter Type";
                end;
            end;
        }
        field(5;"Departmental Activity Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Departmental Appraisal Lines"."Activity Code" WHERE ("Appraisal Period"=FIELD("Appraisal Period"),
                                                                                  "Organization Activity Code"=FIELD("Organization Activity Code"),
                                                                                  "Activity Code"=FIELD("Departmental Activity Code"),
                                                                                  "Activity option"=CONST("Cascade-Down"),
                                                                                  "Appraisal Objective"=FIELD("Appraisal Objective"));

            trigger OnValidate()
            begin
                "Departmental Activity Descrp":='';
                DepartmentalAppraisalLines.Reset;
                DepartmentalAppraisalLines.SetRange(DepartmentalAppraisalLines."Activity Code","Departmental Activity Code");
                DepartmentalAppraisalLines.SetRange(DepartmentalAppraisalLines."Appraisal Objective","Appraisal Objective");
                if DepartmentalAppraisalLines.FindFirst then begin
                    "Departmental Activity Descrp":=DepartmentalAppraisalLines."Activity Description";
                end;
            end;
        }
        field(6;"Divisional Activity Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Divisional Appraisal Lines"."Activity Code" WHERE ("Appraisal Period"=FIELD("Appraisal Period"),
                                                                                "Organization Activity Code"=FIELD("Organization Activity Code"),
                                                                                "Departmental Activity Code"=FIELD("Departmental Activity Code"),
                                                                                "Activity Code"=FIELD("Divisional Activity Code"),
                                                                                "Activity Option"=CONST("Cascade-Down"));

            trigger OnValidate()
            begin
                "Divisional Activity Descrp":='';
                DivisionalAppraisalLines.Reset;
                DivisionalAppraisalLines.SetRange(DivisionalAppraisalLines."Activity Code","Divisional Activity Code");
                DivisionalAppraisalLines.SetRange(DivisionalAppraisalLines."Appraisal Objective","Appraisal Objective");
                if DivisionalAppraisalLines.FindFirst then begin
                    "Divisional Activity Descrp":=DivisionalAppraisalLines."Activity Description";
                end;
            end;
        }
        field(7;"Activity Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Appraisal KPI"."Activity Code" WHERE ("Appraissal Objective"=FIELD("Appraisal Objective"));

            trigger OnValidate()
            var
                HRAppraisalKPIRec: Record "HR Appraisal KPI";
            begin
                //HumanResourcesSetup.GET;
                //"Activity Code":=NoSeriesManagement.GetNextNo(HumanResourcesSetup."Appraisal Activity Code Nos",0D,TRUE);
                HRAppraisalKPIRec.Reset;
                HRAppraisalKPIRec.SetRange("Activity Code","Activity Code");
                if HRAppraisalKPIRec.FindFirst then
                  "Activity Description":=HRAppraisalKPIRec.Description;
            end;
        }
        field(8;"Activity Description";Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(16;"Activity Weight";Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TotalActivityWeight:=0;
                EmployeeAppraisalLines.Reset;
                EmployeeAppraisalLines.SetRange(EmployeeAppraisalLines."Appraisal No","Appraisal No");
                EmployeeAppraisalLines.SetRange(EmployeeAppraisalLines."Appraisal Objective","Appraisal Objective");
                if EmployeeAppraisalLines.FindSet then begin
                  repeat
                    TotalActivityWeight:=TotalActivityWeight+EmployeeAppraisalLines."Activity Weight";
                  until EmployeeAppraisalLines.Next=0;
                end;
                TotalActivityWeight:=TotalActivityWeight+"Activity Weight"-xRec."Activity Weight";
                if TotalActivityWeight > 100 then
                  Error(Txt_001);
            end;
        }
        field(19;"Target Value";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20;"Parameter Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Time-Based,Value Based';
            OptionMembers = " ","Time-Based","Value Based";
        }
        field(21;"Target Output (KPIS)";Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22;"Objective Weight";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23;"Actual Output Description";Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(24;"Actual Value";Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Results:=0;
                if "Parameter Type"="Parameter Type"::"Time-Based" then begin
                  if "Actual Value" >0 then
                 Results:="Target Value"/"Actual Value"*3;

                  if Results>1 then
                   "Self Assessment Rating":=GetMinimumActualValueandTargetValue(Results,"Global Dimension 1 Code","Appraisal Objective","Appraisal Score Type")
                  else
                   "Self Assessment Rating":=1;
                end else begin
                  Results:="Actual Value"/"Target Value"*3;

                  if Results>1 then
                   "Self Assessment Rating":=GetMinimumActualValueandTargetValue(Results,"Global Dimension 1 Code","Appraisal Objective","Appraisal Score Type")
                  else
                   "Self Assessment Rating":=1;
                end;

                "Self Assessment Weighted Rat.":="Activity Weight"/100*"Objective Weight"/100*"Self Assessment Rating";
            end;
        }
        field(25;"Appraisal Score Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Core,"Non-Core";
        }
        field(30;"Self Assessment Rating";Decimal)
        {
            Editable = false;
        }
        field(31;"Self Assessment Weighted Rat.";Decimal)
        {
            Caption = 'Self Assessment Weighted Rat.';
            Editable = false;
        }
        field(32;"Actual agreed Value";Decimal)
        {
            DecimalPlaces = 0:0;

            trigger OnValidate()
            begin
                Results:=0;
                if "Parameter Type"="Parameter Type"::"Time-Based" then begin
                 if "Actual agreed Value">0 then
                 Results:="Target Value"/"Actual agreed Value"*3;

                  if Results>1 then
                   "Agreed Rating with Supervisor":=GetMinimumActualValueandTargetValue(Results,"Global Dimension 1 Code","Appraisal Objective","Appraisal Score Type")
                  else
                   "Agreed Rating with Supervisor":=1;
                end else begin
                  Results:="Actual agreed Value"/"Target Value"*3;

                  if Results>1 then begin
                   "Agreed Rating with Supervisor":=GetMinimumActualValueandTargetValue(Results,"Global Dimension 1 Code","Appraisal Objective","Appraisal Score Type");
                   Modify;
                  end else begin
                   "Agreed Rating with Supervisor":=1;
                    Modify;
                  end;
                end;
                "Weighted Rat. With Supervisor":="Activity Weight"/100*"Objective Weight"/100*"Agreed Rating with Supervisor";
            end;
        }
        field(33;"Agreed Rating with Supervisor";Decimal)
        {
            Caption = 'Agreed Rating with Supervisor';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34;"Weighted Rat. With Supervisor";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35;"Moderated Value";Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Results:=0;
                if "Parameter Type"="Parameter Type"::"Time-Based" then begin
                  if "Moderated Value" >0 then
                 Results:="Target Value"/"Moderated Value"*3;

                  if Results>1 then
                   "Moderated Assessment Rating":=GetMinimumActualValueandTargetValue(Results,"Global Dimension 1 Code","Appraisal Objective","Appraisal Score Type")
                  else
                   "Moderated Assessment Rating":=1;
                end else begin
                  Results:="Moderated Value"/"Target Value"*3;

                  if Results >1 then
                   "Moderated Assessment Rating":=GetMinimumActualValueandTargetValue(Results,"Global Dimension 1 Code","Appraisal Objective","Appraisal Score Type")
                  else
                   "Moderated Assessment Rating":=1;
                  end;
                 "Weighted Rat. Moderated Value":="Activity Weight"/100*"Objective Weight"/100*"Moderated Assessment Rating";
            end;
        }
        field(36;"Moderated Assessment Rating";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(37;"Weighted Rat. Moderated Value";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(38;"Base Unit of Measure";Code[20])
        {
            Caption = 'Base Unit of Measure';
            DataClassification = ToBeClassified;
            TableRelation = "HR Lookup Values".Code WHERE (Option=CONST("Unit of Measure"));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                UnitOfMeasure: Record "Unit of Measure";
            begin
            end;
        }
        field(40;"Organization Activity Descrp";Text[150])
        {
            Caption = 'Organization Activity Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(41;"Departmental Activity Descrp";Text[150])
        {
            Caption = 'Departmental Activity Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(42;"Divisional Activity Descrp";Text[150])
        {
            Caption = 'Divisional Activity Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(48;"No. Series";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(51;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(52;"Shortcut Dimension 3 Code";Code[20])
        {
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(53;"Shortcut Dimension 4 Code";Code[20])
        {
            CaptionClass = '1,2,4';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(54;"Shortcut Dimension 5 Code";Code[20])
        {
            CaptionClass = '1,2,5';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(55;"Shortcut Dimension 6 Code";Code[20])
        {
            CaptionClass = '1,2,6';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(56;"Shortcut Dimension 7 Code";Code[20])
        {
            CaptionClass = '1,2,7';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(57;"Shortcut Dimension 8 Code";Code[20])
        {
            CaptionClass = '1,2,8';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard));
        }
    }

    keys
    {
        key(Key1;"Appraisal No","Appraisal Objective","Organization Activity Code","Departmental Activity Code","Divisional Activity Code","Activity Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DrillDown;"Appraisal Objective","Organization Activity Code","Departmental Activity Code","Divisional Activity Code","Activity Code","Activity Description")
        {
        }
    }

    trigger OnInsert()
    begin
        AppraisalHeader.Reset;
        AppraisalHeader.SetRange("No.","Appraisal No");
        if AppraisalHeader.FindFirst then begin
          "Global Dimension 1 Code":=AppraisalHeader."Global Dimension 1 Code";
          "Global Dimension 2 Code":=AppraisalHeader."Global Dimension 2 Code";
          "Shortcut Dimension 3 Code":=AppraisalHeader."Shortcut Dimension 3 Code";
          "Shortcut Dimension 4 Code":=AppraisalHeader."Shortcut Dimension 4 Code";
          "Shortcut Dimension 5 Code":=AppraisalHeader."Shortcut Dimension 5 Code";
          "Shortcut Dimension 6 Code":=AppraisalHeader."Shortcut Dimension 6 Code";
         // "Divisional Activity Code":=AppraisalHeader."Employee No.";
        end;
    end;

    var
        AppraisalCodes: Record "HR Appraisal KPI";
        AppraisalHeader: Record "HR Employee Appraisal Header";
        HRAppraisalObjective: Record "HR Appraisal Objective";
        EmployeeAppraisalLines: Record "Individual Appraisal Lines";
        Results: Decimal;
        TotalActivityWeight: Decimal;
        Txt_001: Label 'The Activity weight should not exceed 100%! Please check';
        OrganizationAppraisalLines: Record "Organization Appraisal Lines";
        DepartmentalAppraisalLines: Record "Departmental Appraisal Lines";
        DivisionalAppraisalLines: Record "Divisional Appraisal Lines";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        HumanResourcesSetup: Record "Human Resources Setup";

    procedure maxRating() maxRating: Decimal
    begin
    end;

    procedure GetMinimumActualValueandTargetValue(Results: Decimal;DepartmentCode: Code[20];ObjectiveCode: Code[20];Type: Option " ",Core,"Non-Core") MinimumValue: Decimal
    var
        HumanResourcesSetup: Record "Human Resources Setup";
        HRAppraisalObjective: Record "HR Appraisal Objective";
    begin
        HumanResourcesSetup.Get;
        if Type = Type::Core then begin
          if Results < HumanResourcesSetup."Appraisal Max score (Core)" then
            MinimumValue:=Results
          else
            MinimumValue:=HumanResourcesSetup."Appraisal Max score (Core)";
        end else begin
          if Type = Type::"Non-Core" then begin
            if Results < HumanResourcesSetup."Appraisal Max Score(None Core)" then
              MinimumValue:=Results
            else
              MinimumValue:=HumanResourcesSetup."Appraisal Max Score(None Core)";
            end;
        end;
    end;

    [Scope('Personalization')]
    procedure AssistEdit(): Boolean
    begin
        HumanResourcesSetup.Get;
        HumanResourcesSetup.TestField("Appraisal Activity Code Nos");
        if NoSeriesManagement.SelectSeries(HumanResourcesSetup."Appraisal Activity Code Nos",xRec."No. Series","No. Series") then begin
          NoSeriesManagement.SetSeries("Activity Code");
          exit(true);
        end;
    end;
}

