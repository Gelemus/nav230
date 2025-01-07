pageextension 60079 pageextension60079 extends "Posted Purchase Invoice"
{

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Posted Purchase Invoice"(Page 138)".

    layout
    {
        addafter("Document Date")
        {
            field("Reference No"; Rec."Reference No")
            {
                Editable = false;
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Deletion (Visible) on "CorrectInvoice(Action 23)".

    }
}

