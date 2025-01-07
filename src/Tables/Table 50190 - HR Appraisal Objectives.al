table 50190 "HR Appraisal Objectives"
{

    fields
    {
        field(1;"Appraisal No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Line No.";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3;"Appraisal Objective";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Score;Decimal)
        {
            Caption = 'Score (WT)';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*IF Score>4 THEN
                  ERROR('Upper Limit Exceeded');
                IF Score<0 THEN
                  ERROR('Lower Limit Exceeded');
                */

            end;
        }
        field(5;Comments;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Perfomance Target";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Perfomance Indictor/Activities";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Self Rating";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9;Consensus;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Status Previous Year";Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //IF(H8>F8,0.5*E8,(1-(F8-H8)/F8)*E8*0.5)
                //=((H7-F7)/(G7-F7))*0.5*E7
                if (Actual > "Status Previous Year") then
                begin
                  "Maintaining Last Year Score" :=(0.5*Score);
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*Score;
                  Consensus := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end else
                begin
                  "Maintaining Last Year Score" := (1-("Status Previous Year"-Actual)/"Status Previous Year")*0.5*Score;
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*Score;
                  Consensus := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end;
            end;
        }
        field(11;Target;Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (Actual > "Status Previous Year") then
                begin
                  "Maintaining Last Year Score" :=(0.5*Score);
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*Score;
                  Consensus := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end else
                begin
                  "Maintaining Last Year Score" := (1-("Status Previous Year"-Actual)/"Status Previous Year")*0.5*Score;
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*Score;
                  Consensus := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end;
            end;
        }
        field(12;"Unit of Measure";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(13;Actual;Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (Actual > "Status Previous Year") then
                begin
                  "Maintaining Last Year Score" :=(0.5*Score);
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*Score;
                  Consensus := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end else
                begin
                  "Maintaining Last Year Score" := (1-("Status Previous Year"-Actual)/"Status Previous Year")*0.5*Score;
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*Score;
                  Consensus := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end;
            end;
        }
        field(14;"Maintaining Last Year Score";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Curreny Year Increase/Decline";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16;"Period Under Study";Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Appraisal No.","Line No.")
        {
        }
        key(Key2;"Period Under Study")
        {
        }
    }

    fieldgroups
    {
    }
}

