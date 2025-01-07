table 50232 "HR Appraisal Target Parameter"
{

    fields
    {
        field(1;"Appraisal Period";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Performance Target";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Assesssment;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Performance Score Min Limit";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Performance Score Max Limit";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Appraisal Period")
        {
        }
    }

    fieldgroups
    {
    }
}

