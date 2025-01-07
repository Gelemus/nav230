pageextension 60203 pageextension60203 extends "Apply Vendor Entries"
{
    layout
    {

        //Unsupported feature: Property Deletion (Editable) on ""ApplyingVendLedgEntry.Amount"(Control 81)".


        //Unsupported feature: Property Deletion (Visible) on "Amount(Control 12)".

    }

    //Unsupported feature: Property Modification (OptionString) on "CalcType(Variable 1027)".

    //var
    //>>>> ORIGINAL VALUE:
    //CalcType : Direct,GenJnlLine,PurchHeader;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CalcType : Direct,GenJnlLine,PurchHeader,PaymentLine;
    //Variable type has not been exported.

    var
        "//CustomCode": Integer;
        PaymentLine: Record "Payment Line";
        PaymentLine2: Record "Payment Line";
        PaymentLineApply: Boolean;


    //Unsupported feature: Code Modification on "OnQueryClosePage".

    //trigger OnQueryClosePage(CloseAction: Action): Boolean
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if CloseAction = ACTION::LookupOK then
      LookupOKOnPush;
    if ApplnType = ApplnType::"Applies-to Doc. No." then begin
      if OK and (ApplyingVendLedgEntry."Posting Date" < "Posting Date") then begin
        OK := false;
        Error(
          EarlierPostingDateErr,ApplyingVendLedgEntry."Document Type",ApplyingVendLedgEntry."Document No.",
          "Document Type","Document No.");
      end;
      if OK then begin
        if "Amount to Apply" = 0 then
    #12..22
      end;
      CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit",Rec);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
       // ERROR(
       //   EarlierPostingDateErr,ApplyingVendLedgEntry."Document Type",ApplyingVendLedgEntry."Document No.",
       //   "Document Type","Document No.");
    #9..25
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SetGenJnlLine(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetPurch(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "SetVendLedgEntry(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "SetApplyingVendLedgEntry(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "SetVendApplId(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "CheckRounding(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetVendLedgEntry(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "SetAppliesToID(PROCEDURE 1031)".


    //Unsupported feature: Property Modification (Attributes) on "ExchangeAmountsOnLedgerEntry(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "CalcOppositeEntriesAmount(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCalcApplnAmount(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCalcApplnAmountToApply(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCalcApplnRemainingAmount(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterExchangeAmountsOnLedgerEntry(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeHandledChosenEntries(PROCEDURE 23)".


    local procedure "//Custom"()
    begin
    end;

    procedure SetPaymentLine(NewPaymentLine: Record "Payment Line"; ApplnTypeSelect: Integer)
    begin
        PaymentLine := NewPaymentLine;
        PaymentLineApply := true;

        if PaymentLine."Account Type" = PaymentLine."Account Type"::Vendor then
            ApplyingAmount := PaymentLine."Total Amount";
        ApplnDate := PaymentLine."Posting Date";
        ApplnCurrencyCode := PaymentLine."Currency Code";
        // CalcType := CalcType::PaymentLine;

        case ApplnTypeSelect of
            PaymentLine.FieldNo("Applies-to Doc. No."):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            PaymentLine.FieldNo("Applies-to ID"):
                ApplnType := ApplnType::"Applies-to ID";
        end;

        SetApplyingVendLedgEntry;
    end;
}

