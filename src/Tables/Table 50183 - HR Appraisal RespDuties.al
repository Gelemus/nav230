table 50183 "HR Appraisal Resp/Duties"
{

    fields
    {
        field(1;"Appraisal Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Line No.";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Responsibility/Duty";Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Appraisal Code","Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

