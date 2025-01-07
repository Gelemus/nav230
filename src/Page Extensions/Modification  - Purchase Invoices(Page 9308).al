pageextension 60756 pageextension60756 extends "Purchase Invoices"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on ""Buy-from Vendor Name"(Control 6)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Buy-from Contact"(Control 35)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Pay-to Name"(Control 161)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Pay-to Contact"(Control 151)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Name"(Control 145)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Contact"(Control 135)".

        addafter(Amount)
        {
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
            }
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "Post(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "VerifyTotal(PROCEDURE 1)".

}

