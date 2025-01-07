table 50889 "Litigation Answer Setup"
{

    fields
    {
        field(1;"Line No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;LitigationQuestionLineNo;Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Liigation Question Setup."."Line No";
        }
        field(3;Answer;Text[350])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"File Name";Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

