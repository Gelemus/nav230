tableextension 60282 tableextension60282 extends "Sales Line" 
{
    fields
    {

        //Unsupported feature: Code Modification on ""Unit Price"(Field 22).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            Validate("Line Discount %");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            "Unit Price":="Unit Price";
            Validate("Line Discount %");
            */
        //end;
    }

    //Unsupported feature: Property Modification (Attributes) on "InitOutstanding(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "InitOutstandingAmount(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToShip(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToReceive(PROCEDURE 5803)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToInvoice(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "MaxQtyToInvoice(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "MaxQtyToInvoiceBase(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "CalcLineAmount(PROCEDURE 163)".


    //Unsupported feature: Property Modification (Attributes) on "SetSalesHeader(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "GetSalesHeader(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateUnitPrice(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "FindResUnitCost(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePrepmtSetupFields(PROCEDURE 102)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAmounts(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateVATAmounts(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "CheckItemAvailable(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "ShowReservation(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "ShowReservationEntries(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "AutoReserve(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "AutoAsmToOrder(PROCEDURE 82)".


    //Unsupported feature: Property Modification (Attributes) on "CalcPlannedDeliveryDate(PROCEDURE 92)".


    //Unsupported feature: Property Modification (Attributes) on "CalcPlannedShptDate(PROCEDURE 93)".


    //Unsupported feature: Property Modification (Attributes) on "CalcShipmentDate(PROCEDURE 111)".


    //Unsupported feature: Property Modification (Attributes) on "SignedXX(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "OpenItemTrackingLines(PROCEDURE 6500)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "LookupShortcutDimCode(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "SelectMultipleItems(PROCEDURE 180)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemSub(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "ShowNonstock(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "GetCaptionClass(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "GetUnitCost(PROCEDURE 5808)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemChargeAssgnt(PROCEDURE 5801)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateItemChargeAssgnt(PROCEDURE 5807)".


    //Unsupported feature: Property Modification (Attributes) on "TestStatusOpen(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "SuspendStatusCheck(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateVATOnLines(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "CalcVATAmountLines(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "GetCPGInvRoundAcc(PROCEDURE 71)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateWithWarehouseShip(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "GetItemTranslation(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "PriceExists(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "LineDiscExists(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "RowID1(PROCEDURE 47)".


    //Unsupported feature: Property Modification (Attributes) on "GetATOBin(PROCEDURE 89)".


    //Unsupported feature: Property Modification (Attributes) on "IsInbound(PROCEDURE 97)".


    //Unsupported feature: Property Modification (Attributes) on "CheckAssocPurchOrder(PROCEDURE 51)".


    //Unsupported feature: Property Modification (Attributes) on "CrossReferenceNoLookUp(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "ItemExists(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "IsShipment(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideValidationDialog(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "CalcPrepaymentToDeduct(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "IsFinalInvoice(PROCEDURE 116)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountToHandle(PROCEDURE 117)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountExclVAT(PROCEDURE 349)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountInclVAT(PROCEDURE 351)".


    //Unsupported feature: Property Modification (Attributes) on "SetHasBeenShown(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "BlockDynamicTracking(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToShip2(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "ShowLineComments(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "SetDefaultQuantity(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePrePaymentAmounts(PROCEDURE 64)".


    //Unsupported feature: Property Modification (Attributes) on "ZeroAmountLine(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "FilterLinesWithItemToPlan(PROCEDURE 69)".


    //Unsupported feature: Property Modification (Attributes) on "FindLinesWithItemToPlan(PROCEDURE 66)".


    //Unsupported feature: Property Modification (Attributes) on "LinesWithItemToPlanExist(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "AsmToOrderExists(PROCEDURE 72)".


    //Unsupported feature: Property Modification (Attributes) on "FullQtyIsForAsmToOrder(PROCEDURE 74)".


    //Unsupported feature: Property Modification (Attributes) on "QtyBaseOnATO(PROCEDURE 86)".


    //Unsupported feature: Property Modification (Attributes) on "QtyAsmRemainingBaseOnATO(PROCEDURE 90)".


    //Unsupported feature: Property Modification (Attributes) on "QtyToAsmBaseOnATO(PROCEDURE 88)".


    //Unsupported feature: Property Modification (Attributes) on "IsAsmToOrderAllowed(PROCEDURE 77)".


    //Unsupported feature: Property Modification (Attributes) on "IsAsmToOrderRequired(PROCEDURE 81)".


    //Unsupported feature: Property Modification (Attributes) on "CheckAsmToOrder(PROCEDURE 85)".


    //Unsupported feature: Property Modification (Attributes) on "ShowAsmToOrderLines(PROCEDURE 80)".


    //Unsupported feature: Property Modification (Attributes) on "FindOpenATOEntry(PROCEDURE 96)".


    //Unsupported feature: Property Modification (Attributes) on "RollUpAsmCost(PROCEDURE 83)".


    //Unsupported feature: Property Modification (Attributes) on "RollupAsmPrice(PROCEDURE 84)".


    //Unsupported feature: Property Modification (Attributes) on "OutstandingInvoiceAmountFromShipment(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "IsShippedReceivedItemDimChanged(PROCEDURE 113)".


    //Unsupported feature: Property Modification (Attributes) on "ConfirmShippedReceivedItemDimChange(PROCEDURE 114)".


    //Unsupported feature: Property Modification (Attributes) on "InitType(PROCEDURE 91)".


    //Unsupported feature: Property Modification (Attributes) on "CheckLocationOnWMS(PROCEDURE 101)".


    //Unsupported feature: Property Modification (Attributes) on "IsNonInventoriableItem(PROCEDURE 195)".


    //Unsupported feature: Property Modification (Attributes) on "IsInventoriableItem(PROCEDURE 196)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateLineDiscountPercent(PROCEDURE 226)".


    //Unsupported feature: Property Modification (Attributes) on "HasTypeToFillMandatoryFields(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "GetDeferralAmount(PROCEDURE 104)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePriceDescription(PROCEDURE 147)".


    //Unsupported feature: Property Modification (Attributes) on "DefaultDeferralCode(PROCEDURE 109)".


    //Unsupported feature: Property Modification (Attributes) on "IsCreditDocType(PROCEDURE 110)".


    //Unsupported feature: Property Modification (Attributes) on "CanEditUnitOfMeasureCode(PROCEDURE 115)".


    //Unsupported feature: Property Modification (Attributes) on "InsertFreightLine(PROCEDURE 121)".


    //Unsupported feature: Property Modification (Attributes) on "IsLookupRequested(PROCEDURE 119)".


    //Unsupported feature: Property Modification (Attributes) on "TestItemFields(PROCEDURE 120)".


    //Unsupported feature: Property Modification (Attributes) on "CalculateNotShippedInvExlcVatLCY(PROCEDURE 118)".


    //Unsupported feature: Property Modification (Attributes) on "ClearSalesHeader(PROCEDURE 124)".


    //Unsupported feature: Property Modification (Attributes) on "GetDocumentTypeDescription(PROCEDURE 156)".


    //Unsupported feature: Property Modification (Attributes) on "FormatType(PROCEDURE 149)".


    //Unsupported feature: Property Modification (Attributes) on "RenameNo(PROCEDURE 133)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePlanned(PROCEDURE 151)".


    //Unsupported feature: Property Modification (Attributes) on "AssignedItemCharge(PROCEDURE 153)".


    //Unsupported feature: Property Modification (Attributes) on "CalcPlannedDate(PROCEDURE 218)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignFieldsForNo(PROCEDURE 158)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignHeaderValues(PROCEDURE 134)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignStdTxtValues(PROCEDURE 135)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignGLAccountValues(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemValues(PROCEDURE 136)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemChargeValues(PROCEDURE 137)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignResourceValues(PROCEDURE 139)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignFixedAssetValues(PROCEDURE 140)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemUOM(PROCEDURE 141)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignResourceUOM(PROCEDURE 143)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAutoReserve(PROCEDURE 208)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromItem(PROCEDURE 230)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterFilterLinesWithItemToPlan(PROCEDURE 217)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterFindResUnitCost(PROCEDURE 214)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetUnitCost(PROCEDURE 172)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToAsm(PROCEDURE 223)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateUnitPrice(PROCEDURE 126)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalcInvDiscToInvoice(PROCEDURE 220)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalcVATAmountLines(PROCEDURE 190)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckAssocPurchOrder(PROCEDURE 175)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckItemAvailable(PROCEDURE 225)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCopyFromItem(PROCEDURE 222)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCrossReferenceNoAssign(PROCEDURE 193)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetDefaultBin(PROCEDURE 216)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInitQtyToAsm(PROCEDURE 221)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestStatusOpen(PROCEDURE 205)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateUnitPrice(PROCEDURE 127)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateVATAmounts(PROCEDURE 206)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateReturnReasonCode(PROCEDURE 227)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeVerifyReservedQty(PROCEDURE 145)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitHeaderDefaults(PROCEDURE 161)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitOutstanding(PROCEDURE 215)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitOutstandingQty(PROCEDURE 202)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitOutstandingAmount(PROCEDURE 132)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToInvoice(PROCEDURE 128)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToShip(PROCEDURE 129)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToReceive(PROCEDURE 130)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCalcVATAmountLines(PROCEDURE 170)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetLineAmountToHandle(PROCEDURE 171)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateAmounts(PROCEDURE 152)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateAmountsDone(PROCEDURE 165)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateDates(PROCEDURE 200)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateVATAmounts(PROCEDURE 199)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateVATOnLines(PROCEDURE 162)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 164)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterShowItemSub(PROCEDURE 166)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateReturnReasonCode(PROCEDURE 174)".


    //Unsupported feature: Property Modification (Attributes) on "OnShowItemChargeAssgntOnBeforeCalcItemCharge(PROCEDURE 194)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateUnitPriceOnBeforeFindPrice(PROCEDURE 191)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateLocationCodeOnBeforeSetShipmentDate(PROCEDURE 201)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateTypeOnAfterCheckItem(PROCEDURE 188)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateTypeOnCopyFromTempSalesLine(PROCEDURE 167)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnAfterVerifyChange(PROCEDURE 187)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnCopyFromTempSalesLine(PROCEDURE 168)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnBeforeInitRec(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnBeforeUpdateDates(PROCEDURE 210)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateVariantCodeOnAfterChecks(PROCEDURE 213)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestStatusOpen(PROCEDURE 169)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetDefaultQuantity(PROCEDURE 176)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateTotalAmounts(PROCEDURE 68)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetDeferralPostDate(PROCEDURE 159)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAutoAsmToOrder(PROCEDURE 179)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeAutoAsmToOrder(PROCEDURE 178)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterBlanketOrderLookup(PROCEDURE 182)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeBlanketOrderLookup(PROCEDURE 184)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalcPlannedDeliveryDate(PROCEDURE 203)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeOpenItemTrackingLines(PROCEDURE 212)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckCreditLimitCondition(PROCEDURE 185)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateAmountOnBeforeCheckCreditLimit(PROCEDURE 207)".


    //Unsupported feature: Property Modification (Attributes) on "OnCrossReferenceNoLookupOnBeforeValidateUnitPrice(PROCEDURE 228)".

}

