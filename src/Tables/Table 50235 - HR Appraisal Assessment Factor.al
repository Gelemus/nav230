table 50235 "HR Appraisal Assessment Factor"
{

    fields
    {
        field(1;"Appraisall Period";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Assessment Factor";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Score;Decimal)
        {
            Caption = 'Score (1-5)';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Appraisall Period")
        {
        }
    }

    fieldgroups
    {
    }
}

