table 50144 "HR Appraisal KPI"
{
    Caption = 'HR Appraisal KPI';

    fields
    {
        field(1;"Appraissal Objective";Code[50])
        {
        }
        field(2;"Activity Code";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Description;Text[250])
        {
        }
        field(4;"Appraisal Target Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Personal,Job-Specific,Subordinates,Peers,External Sources';
            OptionMembers = " ",Personal,"Job-Specific",Subordinates,Peers,"External Sources";
        }
        field(5;"Actual Output Description";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Appraisal Period";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Calendar Period".Code;
        }
        field(12;"KPI Weight";Decimal)
        {
            FieldClass = Normal;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                /*TotalKPIWeight:=0;
                HRAppraisalKPI.RESET;
                HRAppraisalKPI.SETRANGE(HRAppraisalKPI."Appraissal Objective","Appraissal Objective");
                IF HRAppraisalKPI.FINDSET THEN BEGIN
                  REPEAT
                    TotalKPIWeight:=TotalKPIWeight+HRAppraisalKPI."KPI Weight";
                  UNTIL HRAppraisalKPI.NEXT=0;
                END;
                MESSAGE(FORMAT(TotalKPIWeight));
                IF TotalKPIWeight > 100 THEN
                  ERROR(Txt_001);*/

            end;
        }
        field(50;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(51;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
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
        field(58;"Apprasee Marks";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(59;"Appraiser Marks";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60;"Agreed Marks";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(61;"Status Previous Year";Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (Actual >= "Status Previous Year") then
                begin
                  "Maintaining Last Year Score" := 0.5*"KPI Weight";
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*"KPI Weight";
                  "Agreed Marks" := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end else
                begin
                  "Maintaining Last Year Score" := (1-(("Status Previous Year"-Actual)/("Status Previous Year")))*0.5*"KPI Weight";
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*"KPI Weight";
                  "Agreed Marks" := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end;
            end;
        }
        field(62;Target;Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (Actual >= "Status Previous Year") then
                begin
                  "Maintaining Last Year Score" := 0.5*"KPI Weight";
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*"KPI Weight";
                  "Agreed Marks" := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end else
                begin
                  "Maintaining Last Year Score" := (1-(("Status Previous Year"-Actual)/("Status Previous Year")))*0.5*"KPI Weight";
                  //"Maintaining Last Year Score" := ROUND("Maintaining Last Year Score",1,'>');
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*"KPI Weight";
                  "Agreed Marks" := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end;
            end;
        }
        field(63;"Unit of Measure";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(64;Actual;Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (Actual >= "Status Previous Year") then
                begin
                  "Maintaining Last Year Score" := 0.5*"KPI Weight";
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*"KPI Weight";
                  "Agreed Marks" := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end else
                begin
                  "Maintaining Last Year Score" := (1-(("Status Previous Year"-Actual)/("Status Previous Year")))*0.5*"KPI Weight";
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*"KPI Weight";
                  "Agreed Marks" := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end;
            end;
        }
        field(65;"Maintaining Last Year Score";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(66;"Curreny Year Increase/Decline";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(67;"Line No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(68;"Set Target";Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(69;"Key Indicators/Perfomance Obje";Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Appraissal Objective","Line No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        TotalKPIWeight: Decimal;
        HRAppraisalKPI: Record "HR Appraisal KPI";
        Txt_001: Label 'The Activity weight should not exceed 100%! Please check';
}

