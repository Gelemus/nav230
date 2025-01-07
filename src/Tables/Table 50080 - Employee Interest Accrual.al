table 50080 "Employee Interest Accrual"
{

    fields
    {
        field(1; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
           // TableRelation = Table50307.Field1;
        }
        field(2; "Accrual Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Interest Accrual,Penalty Accrual';
            OptionMembers = " ","Interest Accrual","Penalty Accrual";
        }
        field(3; "Accrual Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Posted to Customer Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Received; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Posted to Accrual Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Account No.", "Accrual Type", "Accrual Date")
        {
        }
    }

    fieldgroups
    {
    }
}

