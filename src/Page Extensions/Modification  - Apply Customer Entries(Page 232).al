pageextension 60199 pageextension60199 extends "Apply Customer Entries"
{

    //Unsupported feature: Property Modification (OptionString) on "CalcType(Variable 1029)".

    //var
    //>>>> ORIGINAL VALUE:
    //CalcType : Direct,GenJnlLine,SalesHeader,ServHeader;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CalcType : Direct,GenJnlLine,SalesHeader,ServHeader,ReceiptLine;
    //Variable type has not been exported.

    var
        "//Custom": Integer;
        ReceiptLine: Record "Receipt Line";
        ReceiptLineApply: Boolean;

    //Unsupported feature: Property Modification (Attributes) on "SetGenJnlLine(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetSales(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "SetService(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "SetCustLedgEntry(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "SetApplyingCustLedgEntry(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "SetCustApplId(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "CalcApplnAmount(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "CheckRounding(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustLedgEntry(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "ExchangeAmountsOnLedgerEntry(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "CalcOppositeEntriesAmount(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCalcApplnAmount(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCalcApplnAmountToApply(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCalcApplnRemainingAmount(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterExchangeAmountsOnLedgerEntry(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeHandledChosenEntries(PROCEDURE 23)".


    local procedure "//Cust"()
    begin
    end;

    procedure SetReceiptLine(NewReceiptLine: Record "Receipt Line"; ApplnTypeSelect: Integer)
    begin
        ReceiptLine := NewReceiptLine;
        ReceiptLineApply := true;

        if ReceiptLine."Account Type" = ReceiptLine."Account Type"::Customer then
            ApplyingAmount := ReceiptLine.Amount;
        ApplnDate := ReceiptLine."Posting Date";
        ApplnCurrencyCode := ReceiptLine."Currency Code";
        // CalcType := CalcType::ReceiptLine;

        case ApplnTypeSelect of
            ReceiptLine.FieldNo("Net Amount"):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            ReceiptLine.FieldNo("Net Amount(LCY)"):
                ApplnType := ApplnType::"Applies-to ID";
        end;

        SetApplyingCustLedgEntry;
    end;
}

