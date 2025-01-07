pageextension 60310 pageextension60310 extends "Purchase Invoice"
{

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Purchase Invoice"(Page 51)".

    layout
    {
        modify("No.")
        {
            Editable = false;
        }

        //Unsupported feature: Property Modification (ImplicitType) on ""Buy-from Vendor Name"(Control 6)".

        // modify("Posting Description")
        // {

        //     //Unsupported feature: Property Modification (ImplicitType) on ""Posting Description"(Control 90)".

        //     ShowMandatory = VendorInvoiceNoMandatory;
        // }

        //Unsupported feature: Property Modification (ImplicitType) on ""Buy-from Address"(Control 72)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Buy-from Contact"(Control 8)".

        // modify("Posting Date")
        // {
        //     ShowMandatory = VendorInvoiceNoMandatory;
        // }

        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Name"(Control 36)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Address"(Control 38)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Contact"(Control 44)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Pay-to Name"(Control 18)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Pay-to Address"(Control 20)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Pay-to Contact"(Control 26)".


        //Unsupported feature: Property Deletion (Visible) on ""Posting Description"(Control 90)".

        addafter("Vendor Invoice No.")
        {
            field("Vendor Account No"; Rec."Vendor Account No")
            {
            }
            field("Delivery Note No."; Rec."Delivery Note No.")
            {
            }
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "LineModified(PROCEDURE 7)".

}

