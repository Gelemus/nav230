table 50079 "Emp. Loan Int. Accrual Buffer"
{

    fields
    {
        field(1;"Loan Account No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Posting Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Loan Transaction Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Loan Disbursed,Principal Receivable,Principal Paid,Interest Receivable,Interest Paid,Penalty Receivable,Penalty Paid,Loan Charge Receivable,Loan Charge Paid';
            OptionMembers = " ","Loan Disbursed","Principal Receivable","Principal Paid","Interest Receivable","Interest Paid","Penalty Receivable","Penalty Paid","Loan Charge Receivable","Loan Charge Paid";
        }
        field(4;"Document No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5;Description;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6;Amount;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Amount LCY";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Employee No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Loan Account No.","Posting Date")
        {
        }
    }

    fieldgroups
    {
    }
}

