pageextension 60788 pageextension60788 extends "Purch. Cr. Memo Subform" 
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Description(Control 6)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Unit of Measure"(Control 10)".


        //Unsupported feature: Code Modification on ""Deferral Code"(Control 25).OnAssistEdit".

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
    actions
    {


        //Unsupported feature: Code Modification on "DeferralSchedule(Action 27).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
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


    //Unsupported feature: Property Modification (Attributes) on "CalcInvDisc(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "ExplodeBOM(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetReturnShipment(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "InsertExtendedText(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "ItemChargeAssgnt(PROCEDURE 5800)".


    //Unsupported feature: Property Modification (Attributes) on "OpenItemTrackingLines(PROCEDURE 6500)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateForm(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "SetUpdateAllowed(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAllowed(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "ShowLineComments(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertExtendedText(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "OnCrossReferenceNoOnLookup(PROCEDURE 14)".

}

