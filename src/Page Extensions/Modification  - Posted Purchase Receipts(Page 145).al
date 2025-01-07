pageextension 60101 pageextension60101 extends "Posted Purchase Receipts"
{

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Posted Purchase Receipts"(Page 145)".

    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("Order No."; Rec."Order No.")
            {
            }
        }
    }
    actions
    {


        //Unsupported feature: Code Modification on ""&Print"(Action 9).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SetSelectionFilter(PurchRcptHeader);
        PurchRcptHeader.PrintRecords(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        {CurrPage.SETSELECTIONFILTER(PurchRcptHeader);
        PurchRcptHeader.PrintRecords(TRUE);}
        PurchRcptHeader.Reset;
        PurchRcptHeader.SetRange(PurchRcptHeader."No.","No.");
        if PurchRcptHeader.FindFirst then begin
          REPORT.RunModal(50110,true,false,PurchRcptHeader);
        end;
        */
        //end;
    }
}

