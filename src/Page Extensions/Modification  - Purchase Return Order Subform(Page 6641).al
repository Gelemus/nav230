pageextension 60556 pageextension60556 extends "Purchase Return Order Subform" 
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Description(Control 6)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Unit of Measure"(Control 10)".


        //Unsupported feature: Code Modification on ""Deferral Code"(Control 23).OnAssistEdit".

        //trigger OnAssistEdit()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ShowDeferralSchedule;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IsNonInventoriableItem;
            */
        //end;
    }

    //Unsupported feature: Property Modification (Attributes) on "ApproveCalcInvDisc(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "InsertExtendedText(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateForm(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDocumentLineTracking(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertExtendedText(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "OnCrossReferenceNoOnLookup(PROCEDURE 2)".

}

