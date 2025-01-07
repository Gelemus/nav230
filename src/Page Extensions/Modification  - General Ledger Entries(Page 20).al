pageextension 60164 pageextension60164 extends "General Ledger Entries"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on ""Global Dimension 1 Code"(Control 28)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Global Dimension 2 Code"(Control 30)".


        //Unsupported feature: Property Modification (ImplicitType) on ""External Document No."(Control 29)".


        //Unsupported feature: Property Deletion (Visible) on ""Global Dimension 1 Code"(Control 28)".


        //Unsupported feature: Property Deletion (Editable) on ""Global Dimension 1 Code"(Control 28)".


        //Unsupported feature: Property Deletion (Visible) on ""Global Dimension 2 Code"(Control 30)".


        //Unsupported feature: Property Deletion (Editable) on ""Global Dimension 2 Code"(Control 30)".

        addafter(Description)
        {
            field(Payee; Rec.Payee)
            {
            }
            field(Description2; Rec.Description2)
            {
            }
        }
        moveafter(Quantity; "Debit Amount")
    }
}

