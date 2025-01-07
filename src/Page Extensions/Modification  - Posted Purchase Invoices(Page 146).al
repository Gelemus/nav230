pageextension 60105 pageextension60105 extends "Posted Purchase Invoices"
{

    //Unsupported feature: Property Insertion (InsertAllowed) on ""Posted Purchase Invoices"(Page 146)".


    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Posted Purchase Invoices"(Page 146)".

    layout
    {

        //Unsupported feature: Property Deletion (Visible) on ""Order No."(Control 32)".

        addafter(Closed)
        {
            field("Posted By"; Rec."Posted By")
            {
            }
        }
    }
}

