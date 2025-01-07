pageextension 60550 pageextension60550 extends "Approval User Setup" 
{
    layout
    {
        moveafter("User ID";"E-Mail")
        moveafter("E-Mail";"Approver ID")
        moveafter("Approver ID";Substitute)
        moveafter(Substitute;"Approval Administrator")
        moveafter("Approval Administrator";"Sales Amount Approval Limit")
    }
}

