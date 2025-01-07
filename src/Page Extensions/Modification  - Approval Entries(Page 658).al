pageextension 60544 pageextension60544 extends "Approval Entries"
{
    
    
    


    layout
    {
        

     

        addafter("Currency Code")
        {
            field(Amount; Rec.Amount)
            {
            }
        }
        moveafter(Control1; "Date-Time Sent for Approval")
        moveafter("Date-Time Sent for Approval"; Details)
        moveafter(Overdue; "Document No.")
        moveafter("Limit Type"; Status)
        moveafter("Sender ID"; "Approver ID")
        moveafter("Approver ID"; "Sequence No.")
        moveafter("Document Type"; "Currency Code")



    }
    

}

