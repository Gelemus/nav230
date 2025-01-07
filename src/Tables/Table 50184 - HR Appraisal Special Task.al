table 50184 "HR Appraisal Special Task"
{

    fields
    {
        field(1;"No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Line No.";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3;Task;Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"No.","Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

