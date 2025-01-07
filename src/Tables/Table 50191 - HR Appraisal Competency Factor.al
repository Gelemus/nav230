table 50191 "HR Appraisal Competency Factor"
{

    fields
    {
        field(1;"Appraisal No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Line No.";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Competency Factor";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Score;Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*IF "Score (1-4)" > 4 THEN
                  ERROR('Upper Limit Exceeded');
                IF "Score (1-4)" < 0 THEN
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
        field(7;"Self Rating";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8;Consensus;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Status Previous Year";Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (Actual >= "Status Previous Year") then
                begin
                  "Maintaining Last Year Score" := 0.5*Score;
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*Score;
                  Consensus := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end else
                begin
                  "Maintaining Last Year Score" := (1-(("Status Previous Year"-Actual)/("Status Previous Year")))*0.5*Score;
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*Score;
                  Consensus := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end;
            end;
        }
        field(10;Target;Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (Actual >= "Status Previous Year") then
                begin
                  "Maintaining Last Year Score" := 0.5*Score;
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*Score;
                  Consensus := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end else
                begin
                  "Maintaining Last Year Score" := (1-(("Status Previous Year"-Actual)/("Status Previous Year")))*0.5*Score;
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*Score;
                  Consensus := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end;
            end;
        }
        field(11;"Unit of Measure";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12;Actual;Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (Actual >= "Status Previous Year") then
                begin
                  "Maintaining Last Year Score" := 0.5*Score;
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*Score;
                  Consensus := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end else
                begin
                  "Maintaining Last Year Score" := (1-(("Status Previous Year"-Actual)/("Status Previous Year")))*0.5*Score;
                  "Curreny Year Increase/Decline" := ((Actual- "Status Previous Year")/(Target-"Status Previous Year"))*0.5*Score;
                  Consensus := "Maintaining Last Year Score" +"Curreny Year Increase/Decline";
                end;
            end;
        }
        field(13;"Maintaining Last Year Score";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Curreny Year Increase/Decline";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Appraisal No.","Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

