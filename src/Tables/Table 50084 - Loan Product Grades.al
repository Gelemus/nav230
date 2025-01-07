table 50084 "Loan Product Grades"
{

    fields
    {
        field(1; "Loan Product"; Code[50])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Table50363;
        }
        field(2; "Job Grade"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Job Lookup Value".Code WHERE(Option = CONST("Job Grade"));
        }
        field(3; "Max. Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan Product", "Job Grade")
        {
        }
    }

    fieldgroups
    {
    }
}

