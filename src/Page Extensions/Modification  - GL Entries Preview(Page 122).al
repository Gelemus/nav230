pageextension 60046 pageextension60046 extends "G/L Entries Preview"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on ""Global Dimension 1 Code"(Control 28)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Global Dimension 2 Code"(Control 30)".


        //Unsupported feature: Property Deletion (Visible) on ""Global Dimension 1 Code"(Control 28)".


        //Unsupported feature: Property Deletion (Visible) on ""Global Dimension 2 Code"(Control 30)".

        addafter("Document No.")
        {
            field("Reference No"; Rec."Reference No")
            {
            }
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
    }
}

