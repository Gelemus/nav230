pageextension 60217 pageextension60217 extends "Payment Journal"
{
    layout
    {

        //Unsupported feature: Property Modification (Name) on ""Incoming Document Entry No."(Control 9)".


        //Unsupported feature: Property Modification (SourceExpr) on ""Incoming Document Entry No."(Control 9)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Incoming Document Entry No."(Control 9)".


        //Unsupported feature: Property Modification (ImplicitType) on ""External Document No."(Control 83)".

        modify("Document Date")
        {
            Visible = false;
        }
        modify("Incoming Document Entry No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Incoming Document Entry No."(Control 9)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Incoming Document Entry No."(Control 9)".


        //Unsupported feature: Property Deletion (Visible) on ""Incoming Document Entry No."(Control 9)".

        modify("Applies-to Ext. Doc. No.")
        {
            Visible = false;
        }
        modify("Recipient Bank Account")
        {
            Visible = false;
        }
        modify("Message to Recipient")
        {
            Visible = false;
        }
        modify("Salespers./Purch. Code")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }
        modify("Payment Reference")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (Visible) on ""Debit Amount"(Control 1000)".


        //Unsupported feature: Property Deletion (Visible) on ""Credit Amount"(Control 1001)".

        moveafter("Posting Date"; "Document No.")
        moveafter("Document No."; "Account Type")
        moveafter(Description; "Incoming Document Entry No.")
        // moveafter(Payee;"Debit Amount")
        moveafter("Credit Amount"; Amount)
        moveafter(Amount; "Bal. Account Type")
        moveafter("Document Type"; "Currency Code")
    }
}

