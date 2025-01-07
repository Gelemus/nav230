table 50087 "Employee Loans User Setup"
{

    fields
    {
        field(1;"User ID";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(2;"HR Manager";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Executive Director";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Legal Manager";Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"User ID")
        {
        }
    }

    fieldgroups
    {
    }
}

