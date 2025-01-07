pageextension 60369 pageextension60369 extends "Purchase Order Subform"
{
    layout
    {
        modify(Description)
        {
            Editable = false;
        }
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Unit of Measure Code")
        {
            Visible = false;
        }



        modify("Quantity Received")
        {
            Editable = false;
        }
        modify("Quantity Invoiced")
        {
            Visible = true;
            Editable = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Description 2")
        {
            Visible = true;
            Enabled = true;
        }


        //Unsupported feature: Property Deletion (Visible) on ""VAT Prod. Posting Group"(Control 14)".


        //Unsupported feature: Property Deletion (Editable) on ""Location Code"(Control 74)".


        //Unsupported feature: Property Deletion (Enabled) on ""Line Amount"(Control 44)".


        //Unsupported feature: Code Modification on ""Deferral Code"(Control 21).OnAssistEdit".

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
        // addafter("VAT Prod. Posting Group")
        // {
        //     field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
        //     {
        //     }
        //     field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
        //     {
        //     }
        // }
        // addafter(Description)
        // {
        //     field("Description 2"; Rec."Description 2")
        //     {
        //     }
        //     field("Depreciation Book Code"; Rec."Depreciation Book Code")
        //     {
        //     }
        // }
        addafter("Job Unit Price")
        {
            field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
            {
                Editable = false;
            }
            field("Amt. Rcd. Not Invoiced"; Rec."Amt. Rcd. Not Invoiced")
            {
                Editable = false;
            }

        }
    }
    actions
    {


        //Unsupported feature: Code Modification on "SelectMultiItems(Action 11).OnAction".

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
        modify(DeferralSchedule)
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "ApproveCalcInvDisc(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "InsertExtendedText(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "ShowTracking(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateForm(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDocumentLineTracking(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertExtendedText(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "OnCrossReferenceNoOnLookup(PROCEDURE 4)".

}

