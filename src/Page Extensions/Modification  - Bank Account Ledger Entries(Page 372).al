pageextension 60250 pageextension60250 extends "Bank Account Ledger Entries"
{
    layout
    {

        //Unsupported feature: Property Deletion (Visible) on ""Debit Amount"(Control 3)".


        //Unsupported feature: Property Deletion (Visible) on ""Credit Amount"(Control 5)".

        addafter("Document No.")
        {
            field("External Document No."; Rec."External Document No.")
            {
            }
        }
        addafter(Description)
        {
            field(Payee; Rec.Payee)
            {
            }
        }
        addafter("Dimension Set ID")
        {
            field("Statement Date"; Rec."Statement Date")
            {
            }
            field("Statement Status"; Rec."Statement Status")
            {
            }
            field("Statement No."; Rec."Statement No.")
            {
            }
            field("Statement Line No."; Rec."Statement Line No.")
            {
            }
        }
        moveafter("Currency Code"; "Debit Amount")
    }
}

