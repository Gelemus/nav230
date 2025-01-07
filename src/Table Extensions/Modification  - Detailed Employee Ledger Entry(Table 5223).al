tableextension 60393 tableextension60393 extends "Detailed Employee Ledger Entry" 
{
    fields
    {
        field(52136923;Description2;Text[250])
        {
            Caption = 'Description2';
            DataClassification = ToBeClassified;
        }
        field(52137023;"Employee Transaction Type";Option)
        {
            Caption = 'Employee Transaction Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,NetPay,Imprest';
            OptionMembers = " ",NetPay,Imprest;
        }
        field(52137123;"Payroll Period";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(52137124;"Payroll Group Code";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52137641;"Loan Transaction Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Loan Disbursed,Principal Receivable,Principal Paid,Interest Receivable,Interest Paid,Penalty Receivable,Penalty Paid,Loan Charge Receivable,Loan Charge Paid';
            OptionMembers = " ","Loan Disbursed","Principal Receivable","Principal Paid","Interest Receivable","Interest Paid","Penalty Receivable","Penalty Paid","Loan Charge Receivable","Loan Charge Paid";
        }
        field(52137642;"Loan No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "UpdateDebitCredit(PROCEDURE 47)".


    //Unsupported feature: Property Modification (Attributes) on "SetZeroTransNo(PROCEDURE 3)".

}

