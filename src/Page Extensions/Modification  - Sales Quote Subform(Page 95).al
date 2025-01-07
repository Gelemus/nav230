pageextension 60762 pageextension60762 extends "Sales Quote Subform" 
{
    layout
    {
        modify("Qty. to Assemble to Order")
        {
            Visible = false;
        }
        moveafter("Unit Price";"Line Amount")
        moveafter("Line Amount";"Shortcut Dimension 1 Code")
    }

    //Unsupported feature: Property Modification (Attributes) on "ApproveCalcInvDisc(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CalcInvDisc(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "InsertExtendedText(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateForm(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertExtendedText(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "OnCrossReferenceNoOnLookup(PROCEDURE 5)".

}

