tableextension 60485 tableextension60485 extends "Transfer Line" 
{
    fields
    {

        //Unsupported feature: Code Modification on ""Item No."(Field 3).OnValidate".

        //trigger "(Field 3)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestField("Quantity Shipped",0);
            if CurrFieldNo <> 0 then
              TestStatusOpen;
            #4..34

            CreateDim(DATABASE::Item,"Item No.");
            DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..37

            //added on 29/07/2020
            ItemLedgerEntry.Reset;
            ItemLedgerEntry.SetRange(ItemLedgerEntry."Item No.","Item No.");
            ItemLedgerEntry.SetRange(ItemLedgerEntry."Location Code","Transfer-from Code");
            if ItemLedgerEntry.FindSet then begin
              repeat
                AvailableInventory:=AvailableInventory+ItemLedgerEntry.Quantity;
              until ItemLedgerEntry.Next=0;
            end;
            Inventory:=AvailableInventory;
            */
        //end;
        field(50000;Inventory;Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "ResetPostedQty(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "BlockDynamicTracking(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "LookupShortcutDimCode(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "OpenItemTrackingLines(PROCEDURE 6500)".


    //Unsupported feature: Property Modification (Attributes) on "ShowReservation(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateWithWarehouseShipReceive(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "RenameNo(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "IsInbound(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "FilterLinesWithItemToPlan(PROCEDURE 70)".


    //Unsupported feature: Property Modification (Attributes) on "FindLinesWithItemToPlan(PROCEDURE 68)".


    //Unsupported feature: Property Modification (Attributes) on "LinesWithItemToPlanExist(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "IsShippedDimChanged(PROCEDURE 105)".


    //Unsupported feature: Property Modification (Attributes) on "ConfirmShippedDimChange(PROCEDURE 106)".


    //Unsupported feature: Property Modification (Attributes) on "DateConflictCheck(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "RowID1(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetTransHeader(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterResetPostedQty(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateQuantityOnBeforeTransLineVerifyChange(PROCEDURE 18)".


    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        AvailableInventory: Decimal;
}

