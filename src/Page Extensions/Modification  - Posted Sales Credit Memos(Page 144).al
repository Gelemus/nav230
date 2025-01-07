pageextension 60090 pageextension60090 extends "Posted Sales Credit Memos"
{

    //Unsupported feature: Property Insertion (InsertAllowed) on ""Posted Sales Credit Memos"(Page 144)".


    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Posted Sales Credit Memos"(Page 144)".

    layout
    {
        // modify("Posting Date")
        // {
        //     Visible = false;
        // }
        addafter("Due Date")
        {
            // field("Posting Date"; Rec."Posting Date")
            // {
            // }
            field("External Document No."; Rec."External Document No.")
            {
            }
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "OnBeforePrintRecords(PROCEDURE 1)".

}

