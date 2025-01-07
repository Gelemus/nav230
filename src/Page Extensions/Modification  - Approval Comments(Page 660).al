pageextension 60545 pageextension60545 extends "Approval Comments"
{
    layout
    {
        addafter("Date and Time")
        {
            field("Document No."; Rec."Document No.")
            {
                Editable = false;
            }
        }
        moveafter("User ID"; "Entry No.")
    }

    //Unsupported feature: Property Modification (Attributes) on "SetWorkflowStepInstanceID(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (ModifyAllowed).

}

