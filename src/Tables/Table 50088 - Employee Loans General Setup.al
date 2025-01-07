table 50088 "Employee Loans General Setup"
{

    fields
    {
        field(1;"Primary Key";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Loan Application No's";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1;"Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

