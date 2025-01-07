table 50078 "Employee App. Repay. Schedule"
{

    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Table90010.Field1;
        }
        field(2; "Loan Disbursement No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(4; "Repayment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Instalment No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Principal Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Principal Moratorium Period"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Interest Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Interest Moratorium Period"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Total Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Application No.", "Loan Disbursement No.", "Employee No.", "Repayment Date")
        {
        }
    }

    fieldgroups
    {
    }
}

