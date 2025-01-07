pageextension 60388 pageextension60388 extends "Purch. Invoice Subform"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Description(Control 6)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Unit of Measure"(Control 10)".


        //Unsupported feature: Property Deletion (Visible) on ""VAT Prod. Posting Group"(Control 14)".


        //Unsupported feature: Property Deletion (Visible) on ""Depreciation Book Code"(Control 26)".


        //Unsupported feature: Code Modification on ""Deferral Code"(Control 17).OnAssistEdit".

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
        //ShowDeferralSchedule;
        */
        //end;
        // addafter(Description)
        // {
        //     field("Description 2"; Rec."Description 2")
        //     {
        //     }
        // }
        // addafter("Allow Item Charge Assignment")
        // {
        //     field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
        //     {
        //     }
        //     field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
        //     {
        //     }
        // }
    }
    actions
    {


        //Unsupported feature: Code Modification on "SelectMultiItems(Action 27).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SelectMultipleItems;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //SelectMultipleItems;
        */
        //end;


        //Unsupported feature: Code Modification on "DeferralSchedule(Action 19).OnAction".

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
        //ShowDeferralSchedule;
        */
        //end;
    }

    //Unsupported feature: Property Modification (Attributes) on "ApproveCalcInvDisc(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "InsertExtendedText(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateForm(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertExtendedText(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "OnCrossReferenceNoOnLookup(PROCEDURE 5)".

}

