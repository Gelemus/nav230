pageextension 60754 pageextension60754 extends "Purchase Quotes"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on ""Buy-from Vendor Name"(Control 6)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Buy-from Contact"(Control 35)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Pay-to Name"(Control 161)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Pay-to Contact"(Control 151)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Name"(Control 145)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Contact"(Control 135)".

        addfirst(Control1)
        {
            field("Request for Quotation Code"; Rec."Request for Quotation Code")
            {
            }
        }
    }
}
