pageextension 60667 pageextension60667 extends "Acc. Payables Activities"
{
    layout
    {
        addfirst(Content)
        {
            cuegroup(Approvals)
            {
                Caption = 'Approvals';
                // field("Requests to Approve"; "Requests to Approve")
                // {
                //     DrillDownPageID = "Requests to Approve";
                // }
            }
        }
        //  moveafter(Control1900000001; "Document Approvals")
    }
}

