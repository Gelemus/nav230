table 50233 "HR Employee Appraisal Target"
{

    fields
    {
        field(1;"Appraisal No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Appraisal Period";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;KPI;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Results Achieved";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Performance Score %";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Appraisal No.")
        {
        }
    }

    fieldgroups
    {
    }
}

