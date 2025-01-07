table 50193 "HR Appraisal Global Competency"
{

    fields
    {
        field(1;"Competency Factor";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Appraisal Period";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Calendar Period";
        }
        field(3;Score;Decimal)
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
    }

    keys
    {
        key(Key1;"Competency Factor",Score)
        {
        }
    }

    fieldgroups
    {
    }
}

