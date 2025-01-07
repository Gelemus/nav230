tableextension 60484 tableextension60484 extends "Transfer Header" 
{
    fields
    {
        modify(Status)
        {
            OptionCaption = 'Open,Released,Pending Approval';

            //Unsupported feature: Property Modification (OptionString) on "Status(Field 23)".

        }

        //Unsupported feature: Code Insertion on ""Assigned User ID"(Field 9000)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            //check if there is another pending request
            TransHeader.Reset;
            */
        //end;
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetInventorySetup;
        if "No." = '' then begin
          TestNoSeries;
          NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
        end;
        InitRecord;
        Validate("Shipment Date",WorkDate);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
        "Assigned User ID" := UserId;
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitRecord(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "InitRecord(PROCEDURE 10)".

    //procedure InitRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        if "Posting Date" = 0D then
          Validate("Posting Date",WorkDate);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        {IF "Posting Date" = 0D THEN
          VALIDATE("Posting Date",WORKDATE);
        }
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideValidationDialog(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateTransLines(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "ShouldDeleteOneTransferOrder(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "DeleteOneTransferOrder(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "CalledFromWarehouse(PROCEDURE 7300)".


    //Unsupported feature: Property Modification (Attributes) on "CreateInvtPutAwayPick(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDocDim(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAllLineDim(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBeforePost(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "CheckInvtPostingSetup(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "HasShippedItems(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "HasTransferLines(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateTransLines(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "VerifyNoOutboundWhseHandlingOnLocation(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "VerifyNoInboundWhseHandlingOnLocation(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckBeforePost(PROCEDURE 16)".


    var
        Employee: Record Employee;
}

