tableextension 60289 tableextension60289 extends "Purchase Header"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Pay-to Name"(Field 5)".


        //Unsupported feature: Property Modification (Data type) on ""Pay-to Address"(Field 7)".


        //Unsupported feature: Property Modification (Data type) on ""Pay-to Contact"(Field 10)".


        //Unsupported feature: Property Modification (Data type) on ""Ship-to Name"(Field 13)".


        //Unsupported feature: Property Modification (Data type) on ""Ship-to Address"(Field 15)".


        //Unsupported feature: Property Modification (Data type) on ""Ship-to Contact"(Field 18)".


        //Unsupported feature: Property Modification (Data type) on ""Posting Description"(Field 22)".


        //Unsupported feature: Property Modification (Data type) on ""Buy-from Vendor Name"(Field 79)".


        //Unsupported feature: Property Modification (Data type) on ""Buy-from Address"(Field 81)".


        //Unsupported feature: Property Modification (Data type) on ""Buy-from Contact"(Field 84)".


        //Unsupported feature: Property Modification (Editable) on ""No. Series"(Field 107)".

        modify(Status)
        {
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Cancelled';

            //Unsupported feature: Property Modification (OptionString) on "Status(Field 120)".


            //Unsupported feature: Property Modification (Editable) on "Status(Field 120)".

        }

        //Unsupported feature: Property Modification (Data type) on ""Prepmt. Posting Description"(Field 139)".


        //Unsupported feature: Code Modification on ""Buy-from Vendor No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "No." = '' then
          InitRecord;
        TestStatusOpen;
        if ("Buy-from Vendor No." <> xRec."Buy-from Vendor No.") and
           (xRec."Buy-from Vendor No." <> '')
        then begin
          CheckDropShipmentLineExists;
          if GetHideValidationDialog or not GuiAllowed then
            Confirmed := true
          else
            Confirmed := Confirm(ConfirmChangeQst,false,BuyFromVendorTxt);
        #12..23
          end;
        end;

        GetVend("Buy-from Vendor No.");
        Vend.CheckBlockedVendOnDocs(Vend,false);
        Vend.TestField("Gen. Bus. Posting Group");
        OnAfterCheckBuyFromVendor(Rec,xRec,Vend);

        "Buy-from Vendor Name" := Vend.Name;
        "Buy-from Vendor Name 2" := Vend."Name 2";
        CopyBuyFromVendorAddressFieldsFromVendor(Vend,false);
        #35..42
        Validate("Lead Time Calculation",Vend."Lead Time Calculation");
        "Responsibility Center" := UserSetupMgt.GetRespCenter(1,Vend."Responsibility Center");
        ValidateEmptySellToCustomerAndLocation;
        OnAfterCopyBuyFromVendorFieldsFromVendor(Rec,Vend,xRec);

        if "Buy-from Vendor No." = xRec."Pay-to Vendor No." then
          if ReceivedPurchLinesExist or ReturnShipmentExist then begin
        #50..74
            Validate("Location Code",Vend."Location Code");
        end;

        OnValidateBuyFromVendorNoBeforeRecreateLines(Rec,CurrFieldNo);

        if (xRec."Buy-from Vendor No." <> "Buy-from Vendor No.") or
           (xRec."Currency Code" <> "Currency Code") or
           (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group") or
        #83..86
        if not SkipBuyFromContact then
          UpdateBuyFromCont("Buy-from Vendor No.");

        if "No." <> '' then
          StandardCodesMgt.CheckShowPurchRecurringLinesNotification(Rec);

        if (xRec."Buy-from Vendor No." <> '') and (xRec."Buy-from Vendor No." <> "Buy-from Vendor No.") then
          RecallModifyAddressNotification(GetModifyVendorAddressNotificationId);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "No." = '' then
          InitRecord;
        TestField(Status,Status::Open);
        #4..7
          if HideValidationDialog then
        #9..26

        #27..29
        #32..45
        #47..77
        #80..89
        if (xRec."Buy-from Vendor No." <> '') and (xRec."Buy-from Vendor No." <> "Buy-from Vendor No.") then
          RecallModifyAddressNotification(GetModifyVendorAddressNotificationId);
        */
        //end;


        //Unsupported feature: Code Modification on ""Pay-to Vendor No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        if (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") and
           (xRec."Pay-to Vendor No." <> '')
        then begin
          if GetHideValidationDialog or not GuiAllowed then
            Confirmed := true
          else
            Confirmed := Confirm(ConfirmChangeQst,false,PayToVendorTxt);
        #9..31
        "Payment Terms Code" := Vend."Payment Terms Code";
        "Prepmt. Payment Terms Code" := Vend."Payment Terms Code";

        if IsCreditDocType then begin
          "Payment Method Code" := '';
          if PaymentTerms.Get("Payment Terms Code") then
            if PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then
        #39..76
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center");

        OnValidatePaytoVendorNoBeforeRecreateLines(Rec,CurrFieldNo);

        if (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and
           (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.")
        then
        #85..90

        if (xRec."Pay-to Vendor No." <> '') and (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") then
          RecallModifyAddressNotification(GetModifyPayToVendorAddressNotificationId);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestField(Status,Status::Open);
        #2..4
          if HideValidationDialog then
        #6..34
        if "Document Type" in ["Document Type"::"Credit Memo","Document Type"::"Return Order"] then begin
        #36..79
        #82..93
        */
        //end;


        //Unsupported feature: Code Modification on ""Order Date"(Field 19).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        if ("Document Type" in ["Document Type"::Quote,"Document Type"::Order]) and
           not ("Order Date" = xRec."Order Date")
        then
          PriceMessageIfPurchLinesExist(FieldCaption("Order Date"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestField(Status,Status::Open);
        #2..5
        */
        //end;


        //Unsupported feature: Code Modification on ""Posting Date"(Field 20).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestField("Posting Date");
        TestNoSeriesDate(
          "Posting No.","Posting No. Series",
          FieldCaption("Posting No."),FieldCaption("Posting No. Series"));
        #5..9
          FieldCaption("Prepmt. Cr. Memo No."),FieldCaption("Prepmt. Cr. Memo No. Series"));

        if "Incoming Document Entry No." = 0 then
          Validate("Document Date","Posting Date");

        if ("Document Type" in ["Document Type"::Invoice,"Document Type"::"Credit Memo"]) and
           not ("Posting Date" = xRec."Posting Date")
        #17..28

        if PurchLinesExist then
          JobUpdatePurchLines(SkipJobCurrFactorUpdate);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #2..12
          //VALIDATE("Document Date","Posting Date");
        #14..31
        */
        //end;


        //Unsupported feature: Code Modification on ""Expected Receipt Date"(Field 21).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Expected Receipt Date" <> 0D then
          UpdatePurchLinesByFieldNo(FieldNo("Expected Receipt Date"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Expected Receipt Date" <> 0D then
          UpdatePurchLines(FieldCaption("Expected Receipt Date"),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: Code Modification on ""Payment Discount %"(Field 25).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if not (CurrFieldNo in [0,FieldNo("Posting Date"),FieldNo("Document Date")]) then
          TestStatusOpen;
        GLSetup.Get;
        if "Payment Discount %" < GLSetup."VAT Tolerance %" then
          "VAT Base Discount %" := "Payment Discount %"
        else
          "VAT Base Discount %" := GLSetup."VAT Tolerance %";
        Validate("VAT Base Discount %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not (CurrFieldNo in [0,FieldNo("Posting Date"),FieldNo("Document Date")]) then
          TestField(Status,Status::Open);
        #3..8
        */
        //end;


        //Unsupported feature: Code Modification on ""Shipment Method Code"(Field 27).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestField(Status,Status::Open);
        */
        //end;


        //Unsupported feature: Code Modification on ""Location Code"(Field 28).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        if ("Location Code" <> xRec."Location Code") and
           (xRec."Buy-from Vendor No." = "Buy-from Vendor No.")
        then
        #5..12
          if Location.Get("Location Code") then;
          "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestField(Status,Status::Open);
        #2..15
        */
        //end;


        //Unsupported feature: Code Modification on ""Currency Code"(Field 32).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if not (CurrFieldNo in [0,FieldNo("Posting Date")]) or ("Currency Code" <> xRec."Currency Code") then
          TestStatusOpen;
        if (CurrFieldNo <> FieldNo("Currency Code")) and ("Currency Code" = xRec."Currency Code") then
          UpdateCurrencyFactor
        else
          if "Currency Code" <> xRec."Currency Code" then
            UpdateCurrencyFactor
          else
            if "Currency Code" <> '' then begin
              UpdateCurrencyFactor;
              if "Currency Factor" <> xRec."Currency Factor" then
                ConfirmUpdateCurrencyFactor;
            end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not (CurrFieldNo in [0,FieldNo("Posting Date")]) or ("Currency Code" <> xRec."Currency Code") then
          TestField(Status,Status::Open);
        #3..5
          if "Currency Code" <> xRec."Currency Code" then begin
            UpdateCurrencyFactor;
            if PurchLinesExist then
              if Confirm(ChangeCurrencyQst,false,FieldCaption("Currency Code")) then begin
                SetHideValidationDialog(true);
                RecreatePurchLines(FieldCaption("Currency Code"));
                SetHideValidationDialog(false);
              end else
                Error(Text018,FieldCaption("Currency Code"));
          end else
        #9..13
        */
        //end;


        //Unsupported feature: Code Modification on ""Currency Factor"(Field 33).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Currency Factor" <> xRec."Currency Factor" then
          UpdatePurchLinesByFieldNo(FieldNo("Currency Factor"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Currency Factor" <> xRec."Currency Factor" then
          UpdatePurchLines(FieldCaption("Currency Factor"),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: Code Modification on ""Prices Including VAT"(Field 35).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;

        if "Prices Including VAT" <> xRec."Prices Including VAT" then begin
          PurchLine.SetRange("Document Type","Document Type");
          PurchLine.SetRange("Document No.","No.");
          PurchLine.SetFilter("Direct Unit Cost",'<>%1',0);
          PurchLine.SetFilter("VAT %",'<>%1',0);
          if PurchLine.Find('-') then begin
            RecalculatePrice :=
              ConfirmManagement.ConfirmProcess(
                StrSubstNo(
                  Text025 +
                  Text027,
                  FieldCaption("Prices Including VAT"),PurchLine.FieldCaption("Direct Unit Cost")),
                true);
            OnAfterConfirmPurchPrice(Rec,PurchLine,RecalculatePrice);
            PurchLine.SetPurchHeader(Rec);

            if "Currency Code" = '' then
        #20..52
          end;
          OnAfterChangePricesIncludingVAT(Rec);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestField(Status,Status::Open);
        #2..9
              Confirm(
        #11..15
        #17..55
        */
        //end;


        //Unsupported feature: Code Modification on ""Invoice Disc. Code"(Field 37).OnValidate".

        //trigger  Code"(Field 37)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        MessageIfPurchLinesExist(FieldCaption("Invoice Disc. Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestField(Status,Status::Open);
        MessageIfPurchLinesExist(FieldCaption("Invoice Disc. Code"));
        */
        //end;


        //Unsupported feature: Code Modification on ""Applies-to Doc. No."(Field 53).OnLookup".

        //trigger  No()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestField("Bal. Account No.",'');
        VendLedgEntry.SetCurrentKey("Vendor No.",Open,Positive,"Due Date");
        VendLedgEntry.SetRange("Vendor No.","Pay-to Vendor No.");
        #4..28
            "Currency Code",VendLedgEntry."Currency Code",GenJnlLine."Account Type"::Vendor,true);
          "Applies-to Doc. Type" := VendLedgEntry."Document Type";
          "Applies-to Doc. No." := VendLedgEntry."Document No.";
          OnAfterAppliesToDocNoOnLookup(Rec,VendLedgEntry);
        end;
        Clear(ApplyVendEntries);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..31
        end;
        Clear(ApplyVendEntries);
        */
        //end;


        //Unsupported feature: Code Modification on ""Vendor Invoice No."(Field 68).OnValidate".

        //trigger "(Field 68)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Vendor Invoice No." <> '' then
          if FindPostedDocumentWithSameExternalDocNo(VendorLedgerEntry,"Vendor Invoice No.") then
            ShowExternalDocAlreadyExistNotification(VendorLedgerEntry)
          else
            RecallExternalDocAlreadyExistsNotification;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5


          "Vendor Invoice No.2" := "Vendor Invoice No.";
        */
        //end;


        //Unsupported feature: Code Modification on ""Gen. Bus. Posting Group"(Field 74).OnValidate".

        //trigger  Bus()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        if (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and
           (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group")
        then begin
          if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") then
            "VAT Bus. Posting Group" := GenBusPostingGrp."Def. VAT Bus. Posting Group";
          RecreatePurchLines(FieldCaption("Gen. Bus. Posting Group"));
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestField(Status,Status::Open);
        #2..8
        */
        //end;


        //Unsupported feature: Code Modification on ""Transaction Type"(Field 76).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdatePurchLinesByFieldNo(FieldNo("Transaction Type"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdatePurchLines(FieldCaption("Transaction Type"),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: Code Modification on ""Transport Method"(Field 77).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdatePurchLinesByFieldNo(FieldNo("Transport Method"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdatePurchLines(FieldCaption("Transport Method"),CurrFieldNo <> 0);
        */
        //end;

        //Unsupported feature: Property Deletion (CaptionClass) on ""Pay-to County"(Field 86)".


        //Unsupported feature: Property Deletion (CaptionClass) on ""Buy-from County"(Field 89)".


        //Unsupported feature: Property Deletion (CaptionClass) on ""Ship-to County"(Field 92)".



        //Unsupported feature: Code Modification on ""Entry Point"(Field 97).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdatePurchLinesByFieldNo(FieldNo("Entry Point"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdatePurchLines(FieldCaption("Entry Point"),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: Code Modification on ""Document Date"(Field 99).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if xRec."Document Date" <> "Document Date" then
          UpdateDocumentDate := true;
        Validate("Payment Terms Code");
        Validate("Prepmt. Payment Terms Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."Document Date" <> "Document Date" then
          UpdateDocumentDate := false;
        Validate("Payment Terms Code");
        Validate("Prepmt. Payment Terms Code");
        */
        //end;


        //Unsupported feature: Code Modification on "Area(Field 101).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdatePurchLinesByFieldNo(FieldNo(Area),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdatePurchLines(FieldCaption(Area),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: Code Modification on ""Transaction Specification"(Field 102).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdatePurchLinesByFieldNo(FieldNo("Transaction Specification"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdatePurchLines(FieldCaption("Transaction Specification"),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: Code Modification on ""Tax Area Code"(Field 114).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        MessageIfPurchLinesExist(FieldCaption("Tax Area Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestField(Status,Status::Open);
        MessageIfPurchLinesExist(FieldCaption("Tax Area Code"));
        */
        //end;


        //Unsupported feature: Code Modification on ""Tax Liable"(Field 115).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        MessageIfPurchLinesExist(FieldCaption("Tax Liable"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestField(Status,Status::Open);
        MessageIfPurchLinesExist(FieldCaption("Tax Liable"));
        */
        //end;


        //Unsupported feature: Code Modification on ""VAT Bus. Posting Group"(Field 116).OnValidate".

        //trigger  Posting Group"(Field 116)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        if (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and
           (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group")
        then
          RecreatePurchLines(FieldCaption("VAT Bus. Posting Group"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestField(Status,Status::Open);
        #2..5
        */
        //end;


        //Unsupported feature: Code Modification on ""VAT Base Discount %"(Field 119).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GLSetup.Get;
        if "VAT Base Discount %" > GLSetup."VAT Tolerance %" then begin
          if GetHideValidationDialog or not GuiAllowed then
            Confirmed := true
          else
            Confirmed :=
        #7..31
          until PurchLine.Next = 0;
        end;
        PurchLine.Reset;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GLSetup.Get;
        if "VAT Base Discount %" > GLSetup."VAT Tolerance %" then begin
          if HideValidationDialog then
        #4..34
        */
        //end;


        //Unsupported feature: Code Modification on ""Prepayment %"(Field 134).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if xRec."Prepayment %" <> "Prepayment %" then
          UpdatePurchLinesByFieldNo(FieldNo("Prepayment %"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."Prepayment %" <> "Prepayment %" then
          UpdatePurchLines(FieldCaption("Prepayment %"),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: Code Modification on ""Prepmt. Payment Discount %"(Field 144).OnValidate".

        //trigger  Payment Discount %"(Field 144)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if not (CurrFieldNo in [0,FieldNo("Posting Date"),FieldNo("Document Date")]) then
          TestStatusOpen;
        GLSetup.Get;
        if "Payment Discount %" < GLSetup."VAT Tolerance %" then
          "VAT Base Discount %" := "Payment Discount %"
        else
          "VAT Base Discount %" := GLSetup."VAT Tolerance %";
        Validate("VAT Base Discount %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not (CurrFieldNo in [0,FieldNo("Posting Date"),FieldNo("Document Date")]) then
          TestField(Status,Status::Open);
        #3..8
        */
        //end;


        //Unsupported feature: Code Modification on ""Buy-from Contact No."(Field 5052).OnValidate".

        //trigger "(Field 5052)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;

        if "Buy-from Contact No." <> '' then
          if Cont.Get("Buy-from Contact No.") then
            Cont.CheckIfPrivacyBlockedGeneric;

        if ("Buy-from Contact No." <> xRec."Buy-from Contact No.") and
           (xRec."Buy-from Contact No." <> '')
        then begin
          if GetHideValidationDialog or not GuiAllowed then
            Confirmed := true
          else
            Confirmed := Confirm(ConfirmChangeQst,false,FieldCaption("Buy-from Contact No."));
        #14..27
        end;

        UpdateBuyFromVend("Buy-from Contact No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestField(Status,Status::Open);
        #2..9
          if HideValidationDialog then
        #11..30
        */
        //end;


        //Unsupported feature: Code Modification on ""Pay-to Contact No."(Field 5053).OnValidate".

        //trigger "(Field 5053)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;

        if "Pay-to Contact No." <> '' then
          if Cont.Get("Pay-to Contact No.") then
            Cont.CheckIfPrivacyBlockedGeneric;

        if ("Pay-to Contact No." <> xRec."Pay-to Contact No.") and
           (xRec."Pay-to Contact No." <> '')
        then begin
          if GetHideValidationDialog or not GuiAllowed then
            Confirmed := true
          else
            Confirmed := Confirm(ConfirmChangeQst,false,FieldCaption("Pay-to Contact No."));
        #14..27
        end;

        UpdatePayToVend("Pay-to Contact No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestField(Status,Status::Open);
        #2..9
          if HideValidationDialog then
        #11..30
        */
        //end;


        //Unsupported feature: Code Modification on ""Responsibility Center"(Field 5700).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        if not UserSetupMgt.CheckRespCenter(1,"Responsibility Center") then
          Error(
            Text028,
        #5..24
          RecreatePurchLines(FieldCaption("Responsibility Center"));
          "Assigned User ID" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestField(Status,Status::Open);
        #2..27
        */
        //end;


        //Unsupported feature: Code Modification on ""Requested Receipt Date"(Field 5790).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        if "Promised Receipt Date" <> 0D then
          Error(
            Text034,
            FieldCaption("Requested Receipt Date"),
            FieldCaption("Promised Receipt Date"));

        if "Requested Receipt Date" <> xRec."Requested Receipt Date" then
          UpdatePurchLinesByFieldNo(FieldNo("Requested Receipt Date"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestField(Status,Status::Open);
        #2..8
          UpdatePurchLines(FieldCaption("Requested Receipt Date"),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: Code Modification on ""Promised Receipt Date"(Field 5791).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        if "Promised Receipt Date" <> xRec."Promised Receipt Date" then
          UpdatePurchLinesByFieldNo(FieldNo("Promised Receipt Date"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestField(Status,Status::Open);
        if "Promised Receipt Date" <> xRec."Promised Receipt Date" then
          UpdatePurchLines(FieldCaption("Promised Receipt Date"),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: Code Modification on ""Lead Time Calculation"(Field 5792).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        LeadTimeMgt.CheckLeadTimeIsNotNegative("Lead Time Calculation");

        if "Lead Time Calculation" <> xRec."Lead Time Calculation" then
          UpdatePurchLinesByFieldNo(FieldNo("Lead Time Calculation"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestField(Status,Status::Open);
        #2..4
          UpdatePurchLines(FieldCaption("Lead Time Calculation"),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: Code Modification on ""Inbound Whse. Handling Time"(Field 5793).OnValidate".

        //trigger  Handling Time"(Field 5793)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        if "Inbound Whse. Handling Time" <> xRec."Inbound Whse. Handling Time" then
          UpdatePurchLinesByFieldNo(FieldNo("Inbound Whse. Handling Time"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestField(Status,Status::Open);
        if "Inbound Whse. Handling Time" <> xRec."Inbound Whse. Handling Time" then
          UpdatePurchLines(FieldCaption("Inbound Whse. Handling Time"),CurrFieldNo <> 0);
        */
        //end;
        field(50000; "Reference No"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Vendor Invoice No.2"; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "position Title"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Vendor Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Vendor Phone Number"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Required on"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Cancelled By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Date Cancelled"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Reason for Cancellation"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Inspection No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Vendor Account No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; HOD; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; HOS; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136923; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(52136924; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(52136925; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(52136926; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(52136927; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(52136928; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(52136932; "Amount(LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52136933; "Amount Including VAT(LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52136980; "Purchase Order Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136983; "Request for Quotation Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Request for Quotation Header"."No." WHERE(Status = CONST(Released));

            trigger OnValidate()
            begin
                //Sysre NextGen Addon
                TestField("Buy-from Vendor No.");
                //Check if the selected vendor was part of the RFQ
                /*RequestforQuotationVendors.RESET;
                RequestforQuotationVendors.SETRANGE(RequestforQuotationVendors."RFQ Document No.","Request for Quotation Code");
                RequestforQuotationVendors.SETRANGE(RequestforQuotationVendors."Vendor No.","Buy-from Vendor No.");
                IF NOT RequestforQuotationVendors.FINDFIRST THEN BEGIN
                  ERROR(Text057,RequestforQuotationVendors."RFQ Document No.");
                END;
                //End Check
                */
                if Confirm(Text055) then begin
                    ProcurementManagement.CreatePurchaseQuoteLinesfromRFQ(Rec, "Request for Quotation Code");
                end else begin
                    Error(Text056);
                end;
                //End Sysre NextGen Addon

            end;
        }
        field(52137000; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';

            trigger OnValidate()
            begin
                UserSetup.Reset;
                UserSetup.SetRange(UserSetup."User ID", "User ID");
                if UserSetup.FindFirst then begin
                    //UserSetup.TESTFIELD(UserSetup."Global Dimension 1 Code");
                    //UserSetup.TESTFIELD(UserSetup."Global Dimension 2 Code");
                    "Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := UserSetup."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := UserSetup."Shortcut Dimension 4 Code";
                    "Shortcut Dimension 5 Code" := UserSetup."Shortcut Dimension 5 Code";
                    "Shortcut Dimension 6 Code" := UserSetup."Shortcut Dimension 6 Code";
                    "Shortcut Dimension 7 Code" := UserSetup."Shortcut Dimension 7 Code";
                    "Shortcut Dimension 8 Code" := UserSetup."Shortcut Dimension 8 Code";
                    HOD := UserSetup.HOD;
                end;
            end;
        }
        field(52137001; "PO sent to Vendor"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52137002; "Purchase Order Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,LPO,LSO';
            OptionMembers = " ",LPO,LSO;
        }
        field(52137003; "Delivery Note No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(52137004; "Purchase Requisition"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Requisitions";
        }
        field(52137005; "Quote Description"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Status,""Expected Receipt Date"",""Location Code"",""Responsibility Center"""(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Assigned User ID"(Key)".

    }


    //Unsupported feature: Code Modification on "OnInsert".

    trigger OnInsert()

    begin
        "User ID" := UserId;
    end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
    "User ID":=UserId;
    Validate("User ID");
    PurchSetup.Get;
           "Posting No. Series":=PurchSetup."Posted Invoice Nos.";

    //Insert Mandatory Documents LPO
    VendorDocs.Reset;
    VendorDocs.SetRange(VendorDocs.Code,"No.");
    if VendorDocs.FindSet then begin
      VendorDocs.DeleteAll
    end;
    Commit;

      ProcurementUploadDocuments2.Reset;
      ProcurementUploadDocuments2.SetRange(ProcurementUploadDocuments2.Type,ProcurementUploadDocuments2.Type::LPO);
      if ProcurementUploadDocuments2.FindSet then begin
        repeat
          VendorDocs.Init;
          VendorDocs.Code:="No.";
          VendorDocs."Document Code":=ProcurementUploadDocuments2."Document Code";
          VendorDocs."Document Description":=ProcurementUploadDocuments2."Document Description";
          //VendorDocs.Code:="No.";
          VendorDocs."Document Attached":=false;
          VendorDocs.Insert;
        until ProcurementUploadDocuments2.Next=0;
      end;
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitInsert(PROCEDURE 41)".


    //Unsupported feature: Property Insertion (Local) on "InitInsert(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "InitRecord(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "InitRecord(PROCEDURE 10)".

    //procedure InitRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchSetup.Get;
    IsHandled := false;
    OnBeforeInitRecord(Rec,IsHandled);
    if not IsHandled then
      case "Document Type" of
        "Document Type"::Quote,"Document Type"::Order:
          begin
            NoSeriesMgt.SetDefaultSeries("Posting No. Series",PurchSetup."Posted Invoice Nos.");
            NoSeriesMgt.SetDefaultSeries("Receiving No. Series",PurchSetup."Posted Receipt Nos.");
            if "Document Type" = "Document Type"::Order then begin
              NoSeriesMgt.SetDefaultSeries("Prepayment No. Series",PurchSetup."Posted Prepmt. Inv. Nos.");
              NoSeriesMgt.SetDefaultSeries("Prepmt. Cr. Memo No. Series",PurchSetup."Posted Prepmt. Cr. Memo Nos.");
            end;
          end;
        "Document Type"::Invoice:
          begin
            if ("No. Series" <> '') and
               (PurchSetup."Invoice Nos." = PurchSetup."Posted Invoice Nos.")
            then
              "Posting No. Series" := "No. Series"
            else
              NoSeriesMgt.SetDefaultSeries("Posting No. Series",PurchSetup."Posted Invoice Nos.");
            if PurchSetup."Receipt on Invoice" then
              NoSeriesMgt.SetDefaultSeries("Receiving No. Series",PurchSetup."Posted Receipt Nos.");
          end;
        "Document Type"::"Return Order":
          begin
            NoSeriesMgt.SetDefaultSeries("Posting No. Series",PurchSetup."Posted Credit Memo Nos.");
            NoSeriesMgt.SetDefaultSeries("Return Shipment No. Series",PurchSetup."Posted Return Shpt. Nos.");
          end;
        "Document Type"::"Credit Memo":
          begin
            if ("No. Series" <> '') and
               (PurchSetup."Credit Memo Nos." = PurchSetup."Posted Credit Memo Nos.")
            then
              "Posting No. Series" := "No. Series"
            else
              NoSeriesMgt.SetDefaultSeries("Posting No. Series",PurchSetup."Posted Credit Memo Nos.");
            if PurchSetup."Return Shipment on Credit Memo" then
              NoSeriesMgt.SetDefaultSeries("Return Shipment No. Series",PurchSetup."Posted Return Shpt. Nos.");
          end;
      end;

    if "Document Type" in
       ["Document Type"::Order,"Document Type"::Invoice,"Document Type"::"Return Order","Document Type"::Quote]
    then
      "Order Date" := WorkDate;

    if "Document Type" = "Document Type"::Invoice then
      "Expected Receipt Date" := WorkDate;

    if not ("Document Type" in ["Document Type"::"Blanket Order","Document Type"::Quote]) and
       ("Posting Date" = 0D)
    then
      "Posting Date" := WorkDate;

    if PurchSetup."Default Posting Date" = PurchSetup."Default Posting Date"::"No Date" then
      "Posting Date" := 0D;

    "Document Date" := WorkDate;

    ValidateEmptySellToCustomerAndLocation;

    if IsCreditDocType then begin
      GLSetup.Get;
      Correction := GLSetup."Mark Cr. Memos as Corrections";
    end;

    "Posting Description" := Format("Document Type") + ' ' + "No.";

    if InvtSetup.Get then
      "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";

    "Responsibility Center" := UserSetupMgt.GetRespCenter(1,"Responsibility Center");
    "Doc. No. Occurrence" := ArchiveManagement.GetNextOccurrenceNo(DATABASE::"Purchase Header","Document Type","No.");

    OnAfterInitRecord(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    PurchSetup.Get;

    case "Document Type" of
      "Document Type"::Quote,"Document Type"::Order:
        begin
          NoSeriesMgt.SetDefaultSeries("Posting No. Series",PurchSetup."Posted Invoice Nos.");
          NoSeriesMgt.SetDefaultSeries("Receiving No. Series",PurchSetup."Posted Receipt Nos.");
          if "Document Type" = "Document Type"::Order then begin
            NoSeriesMgt.SetDefaultSeries("Prepayment No. Series",PurchSetup."Posted Prepmt. Inv. Nos.");
            NoSeriesMgt.SetDefaultSeries("Prepmt. Cr. Memo No. Series",PurchSetup."Posted Prepmt. Cr. Memo Nos.");
          end;
        end;
      "Document Type"::Invoice:
        begin
          if ("No. Series" <> '') and
             (PurchSetup."Invoice Nos." = PurchSetup."Posted Invoice Nos.")
          then
            "Posting No. Series" := "No. Series"
          else
            NoSeriesMgt.SetDefaultSeries("Posting No. Series",PurchSetup."Posted Invoice Nos.");
          if PurchSetup."Receipt on Invoice" then
            NoSeriesMgt.SetDefaultSeries("Receiving No. Series",PurchSetup."Posted Receipt Nos.");
        end;
      "Document Type"::"Return Order":
        begin
          NoSeriesMgt.SetDefaultSeries("Posting No. Series",PurchSetup."Posted Credit Memo Nos.");
          NoSeriesMgt.SetDefaultSeries("Return Shipment No. Series",PurchSetup."Posted Return Shpt. Nos.");
        end;
      "Document Type"::"Credit Memo":
        begin
          if ("No. Series" <> '') and
             (PurchSetup."Credit Memo Nos." = PurchSetup."Posted Credit Memo Nos.")
          then
            "Posting No. Series" := "No. Series"
          else
            NoSeriesMgt.SetDefaultSeries("Posting No. Series",PurchSetup."Posted Credit Memo Nos.");
          if PurchSetup."Return Shipment on Credit Memo" then
            NoSeriesMgt.SetDefaultSeries("Return Shipment No. Series",PurchSetup."Posted Return Shpt. Nos.");
        end;
    end;
    #43..54
      "Posting Date" := 0D;//WORKDATE;
    #56..68
    //"Posting Description" := FORMAT("Document Type") + ' ' + "No.";
    #70..77
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "TestNoSeries(PROCEDURE 6)".


    //Unsupported feature: Property Insertion (Local) on "TestNoSeries(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "TestNoSeries(PROCEDURE 6)".

    //procedure TestNoSeries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchSetup.Get;
    IsHandled := false;
    OnBeforeTestNoSeries(Rec,IsHandled);
    if not IsHandled then
      case "Document Type" of
        "Document Type"::Quote:
          PurchSetup.TestField("Quote Nos.");
        "Document Type"::Order:
          PurchSetup.TestField("Order Nos.");
        "Document Type"::Invoice:
          begin
            PurchSetup.TestField("Invoice Nos.");
            PurchSetup.TestField("Posted Invoice Nos.");
          end;
        "Document Type"::"Return Order":
          PurchSetup.TestField("Return Order Nos.");
        "Document Type"::"Credit Memo":
          begin
            PurchSetup.TestField("Credit Memo Nos.");
            PurchSetup.TestField("Posted Credit Memo Nos.");
          end;
        "Document Type"::"Blanket Order":
          PurchSetup.TestField("Blanket Order Nos.");
      end;

    OnAfterTestNoSeries(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    PurchSetup.Get;
    case "Document Type" of
      "Document Type"::Quote:
        PurchSetup.TestField("Quote Nos.");
      "Document Type"::Order:
        PurchSetup.TestField("Order Nos.");
      "Document Type"::Invoice:
        begin
          PurchSetup.TestField("Invoice Nos.");
          PurchSetup.TestField("Posted Invoice Nos.");
        end;
      "Document Type"::"Return Order":
        PurchSetup.TestField("Return Order Nos.");
      "Document Type"::"Credit Memo":
        begin
          PurchSetup.TestField("Credit Memo Nos.");
          PurchSetup.TestField("Posted Credit Memo Nos.");
        end;
      "Document Type"::"Blanket Order":
        PurchSetup.TestField("Blanket Order Nos.");
    end;

    OnAfterTestNoSeries(Rec);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetNoSeriesCode(PROCEDURE 9)".


    //Unsupported feature: Property Insertion (Local) on "GetNoSeriesCode(PROCEDURE 9)".



    //Unsupported feature: Code Modification on "GetNoSeriesCode(PROCEDURE 9)".

    //procedure GetNoSeriesCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    case "Document Type" of
      "Document Type"::Quote:
        NoSeriesCode := PurchSetup."Quote Nos.";
    #4..11
      "Document Type"::"Blanket Order":
        NoSeriesCode := PurchSetup."Blanket Order Nos.";
    end;
    OnAfterGetNoSeriesCode(Rec,PurchSetup,NoSeriesCode);
    exit(NoSeriesMgt.GetNoSeriesWithCheck(NoSeriesCode,SelectNoSeriesAllowed,"No. Series"));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..14
    exit(NoSeriesMgt.GetNoSeriesWithCheck(NoSeriesCode,SelectNoSeriesAllowed,"No. Series"));
    */
    //end;


    //Unsupported feature: Code Modification on "GetPostingNoSeriesCode(PROCEDURE 8)".

    //procedure GetPostingNoSeriesCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if IsCreditDocType then
      PostingNos := PurchSetup."Posted Credit Memo Nos."
    else
      PostingNos := PurchSetup."Posted Invoice Nos.";

    OnAfterGetPostingNoSeriesCode(Rec,PostingNos);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if IsCreditDocType then
      exit(PurchSetup."Posted Credit Memo Nos.");
    exit(PurchSetup."Posted Invoice Nos.");
    */
    //end;


    //Unsupported feature: Code Modification on "GetPostingPrepaymentNoSeriesCode(PROCEDURE 37)".

    //procedure GetPostingPrepaymentNoSeriesCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if IsCreditDocType then
      PostingNos := PurchSetup."Posted Prepmt. Cr. Memo Nos."
    else
      PostingNos := PurchSetup."Posted Prepmt. Inv. Nos.";

    OnAfterGetPrepaymentPostingNoSeriesCode(Rec,PostingNos);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if IsCreditDocType then
      exit(PurchSetup."Posted Prepmt. Cr. Memo Nos.");
    exit(PurchSetup."Posted Prepmt. Inv. Nos.");
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ConfirmDeletion(PROCEDURE 11)".



    //Unsupported feature: Code Modification on "ConfirmDeletion(PROCEDURE 11)".

    //procedure ConfirmDeletion();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SourceCodeSetup.Get;
    SourceCodeSetup.TestField("Deleted Document");
    SourceCode.Get(SourceCodeSetup."Deleted Document");

    PostPurchDelete.InitDeleteHeader(
      Rec,PurchRcptHeader,PurchInvHeader,PurchCrMemoHeader,
      ReturnShptHeader,PurchInvHeaderPrepmt,PurchCrMemoHeaderPrepmt,SourceCode.Code);

    if PurchRcptHeader."No." <> '' then
      if not ConfirmManagement.ConfirmProcess(StrSubstNo(Text009,PurchRcptHeader."No."),true) then
        exit;
    if PurchInvHeader."No." <> '' then
      if not ConfirmManagement.ConfirmProcess(StrSubstNo(Text012,PurchInvHeader."No."),true) then
        exit;
    if PurchCrMemoHeader."No." <> '' then
      if not ConfirmManagement.ConfirmProcess(StrSubstNo(Text014,PurchCrMemoHeader."No."),true) then
        exit;
    if ReturnShptHeader."No." <> '' then
      if not ConfirmManagement.ConfirmProcess(StrSubstNo(Text029,ReturnShptHeader."No."),true) then
        exit;
    if "Prepayment No." <> '' then
      if not ConfirmManagement.ConfirmProcess(StrSubstNo(Text045,PurchInvHeaderPrepmt."No."),true) then
        exit;
    if "Prepmt. Cr. Memo No." <> '' then
      if not ConfirmManagement.ConfirmProcess(StrSubstNo(Text046,PurchCrMemoHeaderPrepmt."No."),true) then
        exit;
    exit(true);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
      if not Confirm(Text009,true,PurchRcptHeader."No.")
      then
        exit;
    if PurchInvHeader."No." <> '' then
      if not Confirm(Text012,true,PurchInvHeader."No.")
      then
        exit;
    if PurchCrMemoHeader."No." <> '' then
      if not Confirm(Text014,true,PurchCrMemoHeader."No.")
      then
        exit;
    if ReturnShptHeader."No." <> '' then
      if not Confirm(Text029,true,ReturnShptHeader."No.")
      then
        exit;
    if "Prepayment No." <> '' then
      if not Confirm(Text045,true,PurchInvHeaderPrepmt."No.")
      then
        exit;
    if "Prepmt. Cr. Memo No." <> '' then
      if not Confirm(Text046,true,PurchCrMemoHeaderPrepmt."No.")
      then
        exit;
    exit(true);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "PurchLinesExist(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "PurchLinesExist(PROCEDURE 3)".

    //procedure PurchLinesExist();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchLine.Reset;
    PurchLine.SetRange("Document Type","Document Type");
    PurchLine.SetRange("Document No.","No.");
    exit(not PurchLine.IsEmpty);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    exit(PurchLine.FindFirst);
    */
    //end;


    //Unsupported feature: Code Modification on "RecreatePurchLines(PROCEDURE 4)".

    //procedure RecreatePurchLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if not PurchLinesExist then
      exit;

    IsHandled := false;
    OnRecreatePurchLinesOnBeforeConfirm(Rec,xRec,ChangedFieldName,HideValidationDialog,Confirmed,IsHandled);
    if not IsHandled then
      if GetHideValidationDialog then
        Confirmed := true
      else begin
        if HasItemChargeAssignment then
          ConfirmText := ResetItemChargeAssignMsg
        else
          ConfirmText := RecreatePurchLinesMsg;
        Confirmed := ConfirmManagement.ConfirmProcess(StrSubstNo(ConfirmText,ChangedFieldName),true);
      end;

    if Confirmed then begin
      PurchLine.LockTable;
      ItemChargeAssgntPurch.LockTable;
      Modify;
      OnBeforeRecreatePurchLines(Rec);

      PurchLine.Reset;
      PurchLine.SetRange("Document Type","Document Type");
      PurchLine.SetRange("Document No.","No.");
      if PurchLine.FindSet then begin
        repeat
          PurchLine.TestField("Quantity Received",0);
          PurchLine.TestField("Quantity Invoiced",0);
          PurchLine.TestField("Return Qty. Shipped",0);
          PurchLine.CalcFields("Reserved Qty. (Base)");
          PurchLine.TestField("Reserved Qty. (Base)",0);
          PurchLine.TestField("Receipt No.",'');
          PurchLine.TestField("Return Shipment No.",'');
          PurchLine.TestField("Blanket Order No.",'');
          if PurchLine."Drop Shipment" or PurchLine."Special Order" then begin
            case true of
              PurchLine."Drop Shipment":
                SalesHeader.Get(SalesHeader."Document Type"::Order,PurchLine."Sales Order No.");
              PurchLine."Special Order":
                SalesHeader.Get(SalesHeader."Document Type"::Order,PurchLine."Special Order Sales No.");
            end;
            TestField("Sell-to Customer No.",SalesHeader."Sell-to Customer No.");
            TestField("Ship-to Code",SalesHeader."Ship-to Code");
          end;

          PurchLine.TestField("Prepmt. Amt. Inv.",0);
          TempPurchLine := PurchLine;
          if PurchLine.Nonstock then begin
            PurchLine.Nonstock := false;
            PurchLine.Modify;
          end;
          OnRecreatePurchLinesOnBeforeTempPurchLineInsert(TempPurchLine,PurchLine);
          TempPurchLine.Insert;
        until PurchLine.Next = 0;

        TransferItemChargeAssgntPurchToTemp(ItemChargeAssgntPurch,TempItemChargeAssgntPurch);

        PurchLine.DeleteAll(true);

        PurchLine.Init;
        PurchLine."Line No." := 0;
        TempPurchLine.FindSet;
        ExtendedTextAdded := false;
        repeat
          if TempPurchLine."Attached to Line No." = 0 then begin
            PurchLine.Init;
            PurchLine."Line No." := PurchLine."Line No." + 10000;
            PurchLine.Validate(Type,TempPurchLine.Type);
            OnRecreatePurchLinesOnAfterValidateType(PurchLine,TempPurchLine);
            if TempPurchLine."No." = '' then begin
              PurchLine.Validate(Description,TempPurchLine.Description);
              PurchLine.Validate("Description 2",TempPurchLine."Description 2");
            end else begin
              PurchLine.Validate("No.",TempPurchLine."No.");
              if PurchLine.Type <> PurchLine.Type::" " then
                case true of
                  TempPurchLine."Drop Shipment":
                    TransferSavedFieldsDropShipment(PurchLine,TempPurchLine);
                  TempPurchLine."Special Order":
                    TransferSavedFieldsSpecialOrder(PurchLine,TempPurchLine);
                  else
                    TransferSavedFields(PurchLine,TempPurchLine);
                end;
            end;

            OnRecreatePurchLinesOnBeforeInsertPurchLine(PurchLine,TempPurchLine);
            PurchLine.Insert;
            ExtendedTextAdded := false;

            OnAfterRecreatePurchLine(PurchLine,TempPurchLine);

            if PurchLine.Type = PurchLine.Type::Item then
              RecreatePurchLinesFillItemChargeAssignment(PurchLine,TempPurchLine,TempItemChargeAssgntPurch);

            if PurchLine.Type = PurchLine.Type::"Charge (Item)" then begin
              TempInteger.Init;
              TempInteger.Number := PurchLine."Line No.";
              TempInteger.Insert;
            end;
          end else
            if not ExtendedTextAdded then begin
              TransferExtendedText.PurchCheckIfAnyExtText(PurchLine,true);
              TransferExtendedText.InsertPurchExtText(PurchLine);
              OnAfterTransferExtendedTextForPurchaseLineRecreation(PurchLine);
              PurchLine.FindLast;
              ExtendedTextAdded := true;
            end;
        until TempPurchLine.Next = 0;

        RecreateItemChargeAssgntPurch(TempItemChargeAssgntPurch,TempPurchLine,TempInteger);

        TempPurchLine.SetRange(Type);
        TempPurchLine.DeleteAll;
        OnAfterDeleteAllTempPurchLines;
      end;
    end else
      Error(Text018,ChangedFieldName);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    if HideValidationDialog or not GuiAllowed then
      Confirmed := true
    else begin
      if HasItemChargeAssignment then
        ConfirmText := ResetItemChargeAssignMsg
      else
        ConfirmText := RecreatePurchLinesMsg;
      Confirmed := Confirm(ConfirmText,false,ChangedFieldName);
    end;
    #16..20
    #22..52
    #54..69
    #71..86
    #88..90
            if PurchLine.Type = PurchLine.Type::Item then begin
              ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
              TempItemChargeAssgntPurch.SetRange("Applies-to Doc. Type",TempPurchLine."Document Type");
              TempItemChargeAssgntPurch.SetRange("Applies-to Doc. No.",TempPurchLine."Document No.");
              TempItemChargeAssgntPurch.SetRange("Applies-to Doc. Line No.",TempPurchLine."Line No.");
              if TempItemChargeAssgntPurch.FindSet then
                repeat
                  if not TempItemChargeAssgntPurch.Mark then begin
                    TempItemChargeAssgntPurch."Applies-to Doc. Line No." := PurchLine."Line No.";
                    TempItemChargeAssgntPurch.Description := PurchLine.Description;
                    TempItemChargeAssgntPurch.Modify;
                    TempItemChargeAssgntPurch.Mark(true);
                  end;
                until TempItemChargeAssgntPurch.Next = 0;
            end;
    #96..110
        ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
        TempPurchLine.SetRange(Type,PurchLine.Type::"Charge (Item)");
        if TempPurchLine.FindSet then
          repeat
            TempItemChargeAssgntPurch.SetRange("Document Line No.",TempPurchLine."Line No.");
            if TempItemChargeAssgntPurch.FindSet then begin
              repeat
                TempInteger.FindFirst;
                ItemChargeAssgntPurch.Init;
                ItemChargeAssgntPurch := TempItemChargeAssgntPurch;
                ItemChargeAssgntPurch."Document Line No." := TempInteger.Number;
                ItemChargeAssgntPurch.Validate("Unit Cost",0);
                ItemChargeAssgntPurch.Insert;
              until TempItemChargeAssgntPurch.Next = 0;
              TempInteger.Delete;
            end;
          until TempPurchLine.Next = 0;
    #112..114
        ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
        TempItemChargeAssgntPurch.DeleteAll;
      end;
    end else
      Error(
        Text018,ChangedFieldName);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "MessageIfPurchLinesExist(PROCEDURE 5)".


    //Unsupported feature: Property Insertion (Local) on "MessageIfPurchLinesExist(PROCEDURE 5)".



    //Unsupported feature: Code Modification on "MessageIfPurchLinesExist(PROCEDURE 5)".

    //procedure MessageIfPurchLinesExist();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if PurchLinesExist and not GetHideValidationDialog then begin
      MessageText := StrSubstNo(LinesNotUpdatedMsg,ChangedFieldName);
      MessageText := StrSubstNo(SplitMessageTxt,MessageText,Text020);
      Message(MessageText);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if PurchLinesExist and not HideValidationDialog then begin
    #2..5
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "PriceMessageIfPurchLinesExist(PROCEDURE 7)".


    //Unsupported feature: Property Insertion (Local) on "PriceMessageIfPurchLinesExist(PROCEDURE 7)".



    //Unsupported feature: Code Modification on "PriceMessageIfPurchLinesExist(PROCEDURE 7)".

    //procedure PriceMessageIfPurchLinesExist();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if PurchLinesExist and not GetHideValidationDialog then begin
      MessageText := StrSubstNo(LinesNotUpdatedMsg,ChangedFieldName);
      if "Currency Code" <> '' then
        MessageText := StrSubstNo(SplitMessageTxt,MessageText,AffectExchangeRateMsg);
      Message(MessageText);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if PurchLinesExist and not HideValidationDialog then begin
    #2..6
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateCurrencyFactor(PROCEDURE 12)".


    //Unsupported feature: Property Insertion (Local) on "UpdateCurrencyFactor(PROCEDURE 12)".



    //Unsupported feature: Code Modification on "UpdateCurrencyFactor(PROCEDURE 12)".

    //procedure UpdateCurrencyFactor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeUpdateCurrencyFactor(Rec,Updated);
    if Updated then
      exit;

    if "Currency Code" <> '' then begin
      if "Posting Date" <> 0D then
        CurrencyDate := "Posting Date"
      else
        CurrencyDate := WorkDate;

      if UpdateCurrencyExchangeRates.ExchangeRatesForCurrencyExist(CurrencyDate,"Currency Code") then begin
        "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate,"Currency Code");
        if "Currency Code" <> xRec."Currency Code" then
          RecreatePurchLines(FieldCaption("Currency Code"));
      end else begin
        if ConfirmManagement.ConfirmProcess(
             StrSubstNo(MissingExchangeRatesQst,"Currency Code",CurrencyDate),true)
        then begin
          UpdateCurrencyExchangeRates.OpenExchangeRatesPage("Currency Code");
          UpdateCurrencyFactor;
        end else
          RevertCurrencyCodeAndPostingDate;
      end;
    end else
      "Currency Factor" := 0;

    OnAfterUpdateCurrencyFactor(Rec,GetHideValidationDialog);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #5..10
      "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate,"Currency Code");
    end else
      "Currency Factor" := 0;
    */
    //end;


    //Unsupported feature: Code Modification on "ConfirmUpdateCurrencyFactor(PROCEDURE 13)".

    //procedure ConfirmUpdateCurrencyFactor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if GetHideValidationDialog or not GuiAllowed then
      Confirmed := true
    else
      Confirmed := Confirm(Text022,false);
    if Confirmed then
      Validate("Currency Factor")
    else
      "Currency Factor" := xRec."Currency Factor";
    exit(Confirmed);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if HideValidationDialog then
    #2..9
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SetHideValidationDialog(PROCEDURE 14)".


    //Unsupported feature: Variable Insertion (Variable: PurchLineReserve) (VariableCollection) on "UpdatePurchLines(PROCEDURE 15)".


    //Unsupported feature: Variable Insertion (Variable: Question) (VariableCollection) on "UpdatePurchLines(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePurchLines(PROCEDURE 15)".



    //Unsupported feature: Code Modification on "UpdatePurchLines(PROCEDURE 15)".

    //procedure UpdatePurchLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Field.SetRange(TableNo,DATABASE::"Purchase Header");
    Field.SetRange("Field Caption",ChangedFieldName);
    Field.SetFilter(ObsoleteState,'<>%1',Field.ObsoleteState::Removed);
    Field.Find('-');
    if Field.Next <> 0 then
      Error(DuplicatedCaptionsNotAllowedErr);
    UpdatePurchLinesByFieldNo(Field."No.",AskQuestion);

    OnAfterUpdatePurchLines(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if not PurchLinesExist then
      exit;

    if AskQuestion then begin
      Question := StrSubstNo(
          Text032 +
          Text033,ChangedFieldName);
      if GuiAllowed then
        if DIALOG.Confirm(Question,true) then
          case ChangedFieldName of
            FieldCaption("Expected Receipt Date"),
            FieldCaption("Requested Receipt Date"),
            FieldCaption("Promised Receipt Date"),
            FieldCaption("Lead Time Calculation"),
            FieldCaption("Inbound Whse. Handling Time"):
              ConfirmResvDateConflict;
          end
        else
          exit;
    end;

    PurchLine.LockTable;
    Modify;

    PurchLine.Reset;
    PurchLine.SetRange("Document Type","Document Type");
    PurchLine.SetRange("Document No.","No.");
    if PurchLine.FindSet then
      repeat
        xPurchLine := PurchLine;
        case ChangedFieldName of
          FieldCaption("Expected Receipt Date"):
            if PurchLine."No." <> '' then
              PurchLine.Validate("Expected Receipt Date","Expected Receipt Date");
          FieldCaption("Currency Factor"):
            if PurchLine.Type <> PurchLine.Type::" " then
              PurchLine.Validate("Direct Unit Cost");
          FieldCaption("Transaction Type"):
            PurchLine.Validate("Transaction Type","Transaction Type");
          FieldCaption("Transport Method"):
            PurchLine.Validate("Transport Method","Transport Method");
          FieldCaption("Entry Point"):
            PurchLine.Validate("Entry Point","Entry Point");
          FieldCaption(Area):
            PurchLine.Validate(Area,Area);
          FieldCaption("Transaction Specification"):
            PurchLine.Validate("Transaction Specification","Transaction Specification");
          FieldCaption("Requested Receipt Date"):
            if PurchLine."No." <> '' then
              PurchLine.Validate("Requested Receipt Date","Requested Receipt Date");
          FieldCaption("Prepayment %"):
            if PurchLine."No." <> '' then
              PurchLine.Validate("Prepayment %","Prepayment %");
          FieldCaption("Promised Receipt Date"):
            if PurchLine."No." <> '' then
              PurchLine.Validate("Promised Receipt Date","Promised Receipt Date");
          FieldCaption("Lead Time Calculation"):
            if PurchLine."No." <> '' then
              PurchLine.Validate("Lead Time Calculation","Lead Time Calculation");
          FieldCaption("Inbound Whse. Handling Time"):
            if PurchLine."No." <> '' then
              PurchLine.Validate("Inbound Whse. Handling Time","Inbound Whse. Handling Time");
          PurchLine.FieldCaption("Deferral Code"):
            if PurchLine."No." <> '' then
              PurchLine.Validate("Deferral Code");
          else
            OnUpdatePurchLinesByChangedFieldName(Rec,PurchLine,ChangedFieldName);
        end;
        PurchLine.Modify(true);
        PurchLineReserve.VerifyChange(PurchLine,xPurchLine);
      until PurchLine.Next = 0;
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: InspectionHeaderRec) (VariableCollection) on "TestInspectionStatus(PROCEDURE 99)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePurchLinesByFieldNo(PROCEDURE 99)".


    //Unsupported feature: Property Modification (Name) on "UpdatePurchLinesByFieldNo(PROCEDURE 99)".



    //Unsupported feature: Code Modification on "UpdatePurchLinesByFieldNo(PROCEDURE 99)".

    //procedure UpdatePurchLinesByFieldNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if not PurchLinesExist then
      exit;

    if not Field.Get(DATABASE::"Purchase Header",ChangedFieldNo) then
      Field.Get(DATABASE::"Purchase Line",ChangedFieldNo);

    if AskQuestion then begin
      Question := StrSubstNo(Text032,Field."Field Caption");
      if GuiAllowed then
        if DIALOG.Confirm(Question,true) then
          case ChangedFieldNo of
            FieldNo("Expected Receipt Date"),
            FieldNo("Requested Receipt Date"),
            FieldNo("Promised Receipt Date"),
            FieldNo("Lead Time Calculation"),
            FieldNo("Inbound Whse. Handling Time"):
              ConfirmResvDateConflict;
          end
        else
          exit;
    end;

    PurchLine.LockTable;
    Modify;

    PurchLine.Reset;
    PurchLine.SetRange("Document Type","Document Type");
    PurchLine.SetRange("Document No.","No.");
    if PurchLine.FindSet then
      repeat
        xPurchLine := PurchLine;
        case ChangedFieldNo of
          FieldNo("Expected Receipt Date"):
            if PurchLine."No." <> '' then
              PurchLine.Validate("Expected Receipt Date","Expected Receipt Date");
          FieldNo("Currency Factor"):
            if PurchLine.Type <> PurchLine.Type::" " then
              PurchLine.Validate("Direct Unit Cost");
          FieldNo("Transaction Type"):
            PurchLine.Validate("Transaction Type","Transaction Type");
          FieldNo("Transport Method"):
            PurchLine.Validate("Transport Method","Transport Method");
          FieldNo("Entry Point"):
            PurchLine.Validate("Entry Point","Entry Point");
          FieldNo(Area):
            PurchLine.Validate(Area,Area);
          FieldNo("Transaction Specification"):
            PurchLine.Validate("Transaction Specification","Transaction Specification");
          FieldNo("Requested Receipt Date"):
            if PurchLine."No." <> '' then
              PurchLine.Validate("Requested Receipt Date","Requested Receipt Date");
          FieldNo("Prepayment %"):
            if PurchLine."No." <> '' then
              PurchLine.Validate("Prepayment %","Prepayment %");
          FieldNo("Promised Receipt Date"):
            if PurchLine."No." <> '' then
              PurchLine.Validate("Promised Receipt Date","Promised Receipt Date");
          FieldNo("Lead Time Calculation"):
            if PurchLine."No." <> '' then
              PurchLine.Validate("Lead Time Calculation","Lead Time Calculation");
          FieldNo("Inbound Whse. Handling Time"):
            if PurchLine."No." <> '' then
              PurchLine.Validate("Inbound Whse. Handling Time","Inbound Whse. Handling Time");
          PurchLine.FieldNo("Deferral Code"):
            if PurchLine."No." <> '' then
              PurchLine.Validate("Deferral Code");
          else
            OnUpdatePurchLinesByChangedFieldName(Rec,PurchLine,Field."Field Caption");
        end;
        PurchLine.Modify(true);
        PurchLineReserve.VerifyChange(PurchLine,xPurchLine);
      until PurchLine.Next = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    InspectionHeaderRec.Reset;
    InspectionHeaderRec.SetRange("Order No",OrderNo);
    if not InspectionHeaderRec.FindFirst then
      Error('Inspection yet be done and released')
    else
      begin
        InspectionHeaderRec.TestField(InspectionHeaderRec.Status,InspectionHeaderRec.Status::Released);

        end;
    */
    //end;


    //Unsupported feature: Code Modification on "ConfirmResvDateConflict(PROCEDURE 31)".

    //procedure ConfirmResvDateConflict();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if ResvEngMgt.ResvExistsForPurchHeader(Rec) then
      if not ConfirmManagement.ConfirmProcess(Text050,true) then
        Error('');
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if ResvEngMgt.ResvExistsForPurchHeader(Rec) then
      if not Confirm(Text050,false) then
        Error('');
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 19)".



    //Unsupported feature: Code Modification on "ValidateShortcutDimCode(PROCEDURE 19)".

    //procedure ValidateShortcutDimCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OldDimSetID := "Dimension Set ID";
    DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
    if "No." <> '' then
    #4..7
      if PurchLinesExist then
        UpdateAllLineDim("Dimension Set ID",OldDimSetID);
    end;

    OnAfterValidateShortcutDimCode(Rec,xRec,FieldNumber,ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateShipToAddress(PROCEDURE 21)".



    //Unsupported feature: Code Modification on "UpdateShipToAddress(PROCEDURE 21)".

    //procedure UpdateShipToAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if IsCreditDocType then begin
      OnAfterUpdateShipToAddress(Rec);
      exit;
    end;

    if ("Location Code" <> '') and Location.Get("Location Code") and ("Sell-to Customer No." = '') then begin
      SetShipToAddress(
    #8..20
    end;

    OnAfterUpdateShipToAddress(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if IsCreditDocType then
      exit;
    #5..23
    */
    //end;


    //Unsupported feature: Code Modification on "DeletePurchaseLines(PROCEDURE 17)".

    //procedure DeletePurchaseLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if PurchLine.FindSet then begin
      ReservMgt.DeleteDocumentReservation(DATABASE::"Purchase Line","Document Type","No.",GetHideValidationDialog);
      repeat
        PurchLine.SuspendStatusCheck(true);
        PurchLine.Delete(true);
      until PurchLine.Next = 0;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if PurchLine.FindSet then begin
      ReservMgt.DeleteDocumentReservation(DATABASE::"Purchase Line","Document Type","No.",HideValidationDialog);
    #3..7
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateBuyFromCont(PROCEDURE 24)".

    //procedure UpdateBuyFromCont();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if OfficeMgt.GetContact(OfficeContact,VendorNo) then begin
      SetHideValidationDialog(true);
      UpdateBuyFromVend(OfficeContact."No.");
    #4..13
    if "Buy-from Contact No." <> '' then
      if OfficeContact.Get("Buy-from Contact No.") then
        OfficeContact.CheckIfPrivacyBlockedGeneric;

    OnAfterUpdateBuyFromCont(Rec,Vend,OfficeContact);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..16
    */
    //end;


    //Unsupported feature: Code Modification on "UpdatePayToCont(PROCEDURE 27)".

    //procedure UpdatePayToCont();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Vend.Get(VendorNo) then begin
      if Vend."Primary Contact No." <> '' then
        "Pay-to Contact No." := Vend."Primary Contact No."
    #4..8
    if "Pay-to Contact No." <> '' then
      if Contact.Get("Pay-to Contact No.") then
        Contact.CheckIfPrivacyBlockedGeneric;

    OnAfterUpdatePayToCont(Rec,Vend,Contact);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..11
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateBuyFromVend(PROCEDURE 25)".

    //procedure UpdateBuyFromVend();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Cont.Get(ContactNo) then begin
      "Buy-from Contact No." := Cont."No.";
      if Cont.Type = Cont.Type::Person then
    #4..28
       ("Pay-to Vendor No." = '')
    then
      Validate("Pay-to Contact No.","Buy-from Contact No.");

    OnAfterUpdateBuyFromVend(Rec,Cont);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..31
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CreateInvtPutAwayPick(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDocDim(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAllLineDim(PROCEDURE 34)".


    //Unsupported feature: Property Insertion (Local) on "UpdateAllLineDim(PROCEDURE 34)".



    //Unsupported feature: Code Modification on "UpdateAllLineDim(PROCEDURE 34)".

    //procedure UpdateAllLineDim();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    // Update all lines with changed dimensions.

    if NewParentDimSetID = OldParentDimSetID then
      exit;
    if not ConfirmManagement.ConfirmProcess(Text051,true) then
      exit;

    PurchLine.Reset;
    #9..14
        if PurchLine."Dimension Set ID" <> NewDimSetID then begin
          PurchLine."Dimension Set ID" := NewDimSetID;

          if not GetHideValidationDialog and GuiAllowed then
            VerifyReceivedShippedItemLineDimChange(ReceivedShippedItemLineDimChangeConfirmed);

          DimMgt.UpdateGlobalDimFromDimSetID(
            PurchLine."Dimension Set ID",PurchLine."Shortcut Dimension 1 Code",PurchLine."Shortcut Dimension 2 Code");
          PurchLine.Modify;
        end;
      until PurchLine.Next = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    if not Confirm(Text051) then
    #6..17
          if not HideValidationDialog and GuiAllowed then
    #19..25
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SetAmountToApply(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "SetShipToForSpecOrder(PROCEDURE 23)".



    //Unsupported feature: Code Modification on "SetShipToForSpecOrder(PROCEDURE 23)".

    //procedure SetShipToForSpecOrder();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Location.Get("Location Code") then begin
      "Ship-to Code" := '';
      SetShipToAddress(
    #4..14
      "Ship-to Contact" := CompanyInfo."Ship-to Contact";
      "Location Code" := '';
    end;

    OnAfterSetShipToForSpecOrder(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..17
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SetSecurityFilterOnRespCenter(PROCEDURE 43)".



    //Unsupported feature: Code Modification on "SetSecurityFilterOnRespCenter(PROCEDURE 43)".

    //procedure SetSecurityFilterOnRespCenter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := false;
    OnBeforeSetSecurityFilterOnRespCenter(Rec,IsHandled);
    if (not IsHandled) and (UserSetupMgt.GetPurchasesFilter <> '') then begin
      FilterGroup(2);
      SetRange("Responsibility Center",UserSetupMgt.GetPurchasesFilter);
      FilterGroup(0);
    end;

    SetRange("Date Filter",0D,WorkDate - 1);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if UserSetupMgt.GetPurchasesFilter <> '' then begin
    #4..9
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CalcInvDiscForHeader(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "AddShipToAddress(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "DropShptOrderExists(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "SpecialOrderExists(PROCEDURE 81)".


    //Unsupported feature: Property Modification (Attributes) on "QtyToReceiveIsZero(PROCEDURE 30)".



    //Unsupported feature: Code Modification on "IsApprovedForPosting(PROCEDURE 50)".

    //procedure IsApprovedForPosting();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then begin
      if PrepaymentMgt.TestPurchasePrepayment(Rec) then
        Error(PrepaymentInvoicesNotPaidErr,"Document Type","No.");
      if PrepaymentMgt.TestPurchasePayment(Rec) then
        if not ConfirmManagement.ConfirmProcess(StrSubstNo(Text054,"Document Type","No."),true) then
          exit(false);
      exit(true);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then begin
      if PrepaymentMgt.TestPurchasePrepayment(Rec) then
        Error(StrSubstNo(PrepaymentInvoicesNotPaidErr,"Document Type","No."));
      if PrepaymentMgt.TestPurchasePayment(Rec) then
        if not Confirm(StrSubstNo(Text054,"Document Type","No."),true) then
    #6..8
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "IsApprovedForPostingBatch(PROCEDURE 51)".


    //Unsupported feature: Property Modification (Attributes) on "IsTotalValid(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "SendToPosting(PROCEDURE 57)".



    //Unsupported feature: Code Modification on "SendToPosting(PROCEDURE 57)".

    //procedure SendToPosting();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if not IsApprovedForPosting then
      exit;

    Commit;
    ErrorMessageMgt.Activate(ErrorMessageHandler);
    IsSuccess := CODEUNIT.Run(PostingCodeunitID,Rec);
    if not IsSuccess then
      ErrorMessageHandler.ShowErrors;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if not IsApprovedForPosting then
      exit;
    CODEUNIT.Run(PostingCodeunitID,Rec);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CancelBackgroundPosting(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "AddSpecialOrderToAddress(PROCEDURE 80)".


    //Unsupported feature: Property Modification (Attributes) on "InvoicedLineExists(PROCEDURE 56)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDimSetForPrepmtAccDefaultDim(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "OpenPurchaseOrderStatistics(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "GetCardpageID(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckPurchasePostRestrictions(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckPurchaseReleaseRestrictions(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "CheckPurchaseReleaseRestrictions(PROCEDURE 105)".


    //Unsupported feature: Property Modification (Attributes) on "SetStatus(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "TriggerOnAfterPostPurchaseDoc(PROCEDURE 116)".


    //Unsupported feature: Property Modification (Attributes) on "DeferralHeadersExist(PROCEDURE 38)".



    //Unsupported feature: Code Modification on "ConfirmUpdateDeferralDate(PROCEDURE 85)".

    //procedure ConfirmUpdateDeferralDate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if GetHideValidationDialog or not GuiAllowed then
      Confirmed := true
    else
      Confirmed := Confirm(DeferralLineQst,false,FieldCaption("Posting Date"));
    if Confirmed then
      UpdatePurchLinesByFieldNo(PurchLine.FieldNo("Deferral Code"),false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if HideValidationDialog then
    #2..5
      UpdatePurchLines(PurchLine.FieldCaption("Deferral Code"),false);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "IsCreditDocType(PROCEDURE 110)".



    //Unsupported feature: Code Modification on "IsCreditDocType(PROCEDURE 110)".

    //procedure IsCreditDocType();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CreditDocType := "Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"];
    OnBeforeIsCreditDocType(Rec,CreditDocType);
    exit(CreditDocType);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    exit("Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"]);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SetBuyFromVendorFromFilter(PROCEDURE 186)".


    //Unsupported feature: Property Modification (Attributes) on "CopyBuyFromVendorFilter(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "HasBuyFromAddress(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "HasShipToAddress(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "HasPayToAddress(PROCEDURE 66)".



    //Unsupported feature: Code Modification on "CopyBuyFromVendorAddressFieldsFromVendor(PROCEDURE 62)".

    //procedure CopyBuyFromVendorAddressFieldsFromVendor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if BuyFromVendorIsReplaced or ShouldCopyAddressFromBuyFromVendor(BuyFromVendor) or ForceCopy then begin
      "Buy-from Address" := BuyFromVendor.Address;
      "Buy-from Address 2" := BuyFromVendor."Address 2";
      "Buy-from City" := BuyFromVendor.City;
      "Buy-from Post Code" := BuyFromVendor."Post Code";
      "Buy-from County" := BuyFromVendor.County;
      "Buy-from Country/Region Code" := BuyFromVendor."Country/Region Code";
      OnAfterCopyBuyFromVendorAddressFieldsFromVendor(Rec,BuyFromVendor);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    end;
    */
    //end;


    //Unsupported feature: Code Modification on "CopyShipToVendorAddressFieldsFromVendor(PROCEDURE 98)".

    //procedure CopyShipToVendorAddressFieldsFromVendor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if BuyFromVendorIsReplaced or (not HasShipToAddress) or ForceCopy then begin
      "Ship-to Address" := BuyFromVendor.Address;
      "Ship-to Address 2" := BuyFromVendor."Address 2";
      "Ship-to City" := BuyFromVendor.City;
      "Ship-to Post Code" := BuyFromVendor."Post Code";
      "Ship-to County" := BuyFromVendor.County;
      Validate("Ship-to Country/Region Code",BuyFromVendor."Country/Region Code");
      OnAfterCopyShipToVendorAddressFieldsFromVendor(Rec,BuyFromVendor);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    end;
    */
    //end;


    //Unsupported feature: Code Modification on "CopyPayToVendorAddressFieldsFromVendor(PROCEDURE 63)".

    //procedure CopyPayToVendorAddressFieldsFromVendor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if PayToVendorIsReplaced or ShouldCopyAddressFromPayToVendor(PayToVendor) or ForceCopy then begin
      "Pay-to Address" := PayToVendor.Address;
      "Pay-to Address 2" := PayToVendor."Address 2";
      "Pay-to City" := PayToVendor.City;
      "Pay-to Post Code" := PayToVendor."Post Code";
      "Pay-to County" := PayToVendor.County;
      "Pay-to Country/Region Code" := PayToVendor."Country/Region Code";
      OnAfterCopyPayToVendorAddressFieldsFromVendor(Rec,PayToVendor);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    end;
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SetShipToAddress(PROCEDURE 117)".


    //Unsupported feature: Property Modification (Attributes) on "ConfirmCloseUnposted(PROCEDURE 104)".



    //Unsupported feature: Code Modification on "ConfirmCloseUnposted(PROCEDURE 104)".

    //procedure ConfirmCloseUnposted();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if PurchLinesExist then
      if InstructionMgt.IsUnpostedEnabledForRecord(Rec) then
        exit(InstructionMgt.ShowConfirm(DocumentNotPostedClosePageQst,InstructionMgt.QueryPostOnCloseCode));
    exit(true)
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if PurchLinesExist then
      exit(InstructionMgt.ShowConfirm(DocumentNotPostedClosePageQst,InstructionMgt.QueryPostOnCloseCode));
    exit(true)
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitFromPurchHeader(PROCEDURE 109)".


    //Unsupported feature: Property Modification (Attributes) on "SendRecords(PROCEDURE 75)".


    //Unsupported feature: Property Modification (Attributes) on "PrintRecords(PROCEDURE 74)".


    //Unsupported feature: Property Modification (Attributes) on "SendProfile(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateBuyFromVendorNo(PROCEDURE 77)".


    //Unsupported feature: Property Modification (Attributes) on "BatchConfirmUpdateDeferralDate(PROCEDURE 78)".



    //Unsupported feature: Code Modification on "BatchConfirmUpdateDeferralDate(PROCEDURE 78)".

    //procedure BatchConfirmUpdateDeferralDate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if (not ReplacePostingDate) or (PostingDateReq = "Posting Date") or (BatchConfirm = BatchConfirm::Skip) then
      exit;

    #4..14
            BatchConfirm := BatchConfirm::Skip;
        end;
      BatchConfirm::Update:
        UpdatePurchLinesByFieldNo(PurchLine.FieldNo("Deferral Code"),false);
    end;
    Commit;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..17
        UpdatePurchLines(PurchLine.FieldCaption("Deferral Code"),false);
    end;
    Commit;
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SetAllowSelectNoSeries(PROCEDURE 86)".


    //Unsupported feature: Property Modification (Attributes) on "RecallModifyAddressNotification(PROCEDURE 148)".


    //Unsupported feature: Property Modification (Attributes) on "GetModifyVendorAddressNotificationId(PROCEDURE 193)".


    //Unsupported feature: Property Modification (Attributes) on "GetModifyPayToVendorAddressNotificationId(PROCEDURE 191)".


    //Unsupported feature: Property Modification (Attributes) on "GetShowExternalDocAlreadyExistNotificationId(PROCEDURE 92)".


    //Unsupported feature: Property Modification (Attributes) on "SetModifyVendorAddressNotificationDefaultState(PROCEDURE 196)".


    //Unsupported feature: Property Modification (Attributes) on "SetModifyPayToVendorAddressNotificationDefaultState(PROCEDURE 197)".


    //Unsupported feature: Property Modification (Attributes) on "SetShowExternalDocAlreadyExistNotificationDefaultState(PROCEDURE 87)".


    //Unsupported feature: Property Modification (Attributes) on "DontNotifyCurrentUserAgain(PROCEDURE 141)".


    //Unsupported feature: Property Modification (Attributes) on "FilterPartialReceived(PROCEDURE 108)".


    //Unsupported feature: Property Modification (Attributes) on "FilterPartialInvoiced(PROCEDURE 307)".


    //Unsupported feature: Variable Insertion (Variable: MyNotifications) (VariableCollection) on "IsDocAlreadyExistNotificationEnabled(PROCEDURE 91)".



    //Unsupported feature: Code Modification on "IsDocAlreadyExistNotificationEnabled(PROCEDURE 91)".

    //procedure IsDocAlreadyExistNotificationEnabled();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    exit(InstructionMgt.IsMyNotificationEnabled(GetShowExternalDocAlreadyExistNotificationId));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if not MyNotifications.Get(UserId,GetShowExternalDocAlreadyExistNotificationId) then
      exit(false);

    exit(MyNotifications.Enabled);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ShipToAddressEqualsCompanyShipToAddress(PROCEDURE 111)".


    //Unsupported feature: Property Modification (Attributes) on "BuyFromAddressEqualsShipToAddress(PROCEDURE 94)".


    //Unsupported feature: Property Modification (Attributes) on "ValidatePurchaserOnPurchHeader(PROCEDURE 912)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitRecord(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitNoSeries(PROCEDURE 140)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterChangePricesIncludingVAT(PROCEDURE 187)".


    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "HasItemChargeAssignment(PROCEDURE 93)".


    //Unsupported feature: Variable Insertion (Variable: ItemChargeAssgntPurch) (VariableCollection) on "HasItemChargeAssignment(PROCEDURE 93)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterRecreatePurchLine(PROCEDURE 93)".


    //Unsupported feature: Property Modification (Name) on "OnAfterRecreatePurchLine(PROCEDURE 93)".



    //Unsupported feature: Code Modification on "OnAfterRecreatePurchLine(PROCEDURE 93)".

    //procedure OnAfterRecreatePurchLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ItemChargeAssgntPurch.SetRange("Document Type","Document Type");
    ItemChargeAssgntPurch.SetRange("Document No.","No.");
    ItemChargeAssgntPurch.SetFilter("Amount to Assign",'<>%1',0);
    exit(not ItemChargeAssgntPurch.IsEmpty);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestNoSeries(PROCEDURE 136)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateShipToAddress(PROCEDURE 137)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdatePurchLinesByChangedFieldName(PROCEDURE 139)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 164)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTransferExtendedTextForPurchaseLineRecreation(PROCEDURE 165)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePurchaseHeaderPayToVendorNo(PROCEDURE 1215)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateCurrencyFactor(PROCEDURE 95)".


    //Unsupported feature: Property Modification (Name) on "OnBeforeUpdateCurrencyFactor(PROCEDURE 95)".



    //Unsupported feature: Code Modification on "OnBeforeUpdateCurrencyFactor(PROCEDURE 95)".

    //procedure OnBeforeUpdateCurrencyFactor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ItemChargeAssgntPurch.SetRange("Document Type","Document Type");
    ItemChargeAssgntPurch.SetRange("Document No.","No.");
    if ItemChargeAssgntPurch.FindSet then begin
      repeat
        TempItemChargeAssgntPurch := ItemChargeAssgntPurch;
        TempItemChargeAssgntPurch.Insert;
      until ItemChargeAssgntPurch.Next = 0;
      ItemChargeAssgntPurch.DeleteAll;
    end;
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "InitRecord(PROCEDURE 10).IsHandled(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "TestNoSeries(PROCEDURE 6).IsHandled(Variable 1000)".


    //Unsupported feature: Property Deletion (Name) on "GetPostingNoSeriesCode(PROCEDURE 8).PostingNos(ReturnValue)".


    //Unsupported feature: Property Deletion (Name) on "GetPostingPrepaymentNoSeriesCode(PROCEDURE 37).PostingNos(ReturnValue)".


    //Unsupported feature: Deletion (VariableCollection) on "ConfirmDeletion(PROCEDURE 11).ConfirmManagement(Variable 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "RecreatePurchLines(PROCEDURE 4).ConfirmManagement(Variable 1008)".


    //Unsupported feature: Deletion (VariableCollection) on "RecreatePurchLines(PROCEDURE 4).IsHandled(Variable 1010)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdateCurrencyFactor(PROCEDURE 12).UpdateCurrencyExchangeRates(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdateCurrencyFactor(PROCEDURE 12).ConfirmManagement(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdateCurrencyFactor(PROCEDURE 12).Updated(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdatePurchLines(PROCEDURE 15).Field(Variable 1002)".


    //Unsupported feature: Property Modification (Name) on "UpdatePurchLinesByFieldNo(PROCEDURE 99).ChangedFieldNo(Parameter 1000)".


    //Unsupported feature: Property Modification (Data type) on "UpdatePurchLinesByFieldNo(PROCEDURE 99).ChangedFieldNo(Parameter 1000)".


    //Unsupported feature: Property Insertion (Length) on "UpdatePurchLinesByFieldNo(PROCEDURE 99).ChangedFieldNo(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "UpdatePurchLinesByFieldNo(PROCEDURE 99).AskQuestion(Parameter 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdatePurchLinesByFieldNo(PROCEDURE 99).Field(Variable 1004)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdatePurchLinesByFieldNo(PROCEDURE 99).PurchLineReserve(Variable 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdatePurchLinesByFieldNo(PROCEDURE 99).Question(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "ConfirmResvDateConflict(PROCEDURE 31).ConfirmManagement(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdateAllLineDim(PROCEDURE 34).ConfirmManagement(Variable 1004)".


    //Unsupported feature: Deletion (VariableCollection) on "SetSecurityFilterOnRespCenter(PROCEDURE 43).IsHandled(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "IsApprovedForPosting(PROCEDURE 50).ConfirmManagement(Variable 1001)".


    //Unsupported feature: Deletion (ReturnValueCollection) on "SendToPosting(PROCEDURE 57).IsSuccess(ReturnValue)".


    //Unsupported feature: Deletion (VariableCollection) on "SendToPosting(PROCEDURE 57).ErrorMessageMgt(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "SendToPosting(PROCEDURE 57).ErrorMessageHandler(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "IsCreditDocType(PROCEDURE 110).CreditDocType(Variable 1000)".


    //Unsupported feature: Property Modification (Length) on "SetShipToAddress(PROCEDURE 117).ShipToName(Parameter 1000)".


    //Unsupported feature: Property Modification (Length) on "SetShipToAddress(PROCEDURE 117).ShipToAddress(Parameter 1002)".


    //Unsupported feature: Property Modification (Length) on "ShowModifyAddressNotification(PROCEDURE 157).VendorName(Parameter 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "IsDocAlreadyExistNotificationEnabled(PROCEDURE 91).InstructionMgt(Variable 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterRecreatePurchLine(PROCEDURE 93).PurchLine(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterRecreatePurchLine(PROCEDURE 93).TempPurchLine(Parameter 1001)".


    //Unsupported feature: Property Modification (Name) on "OnAfterCreateDimTableIDs(PROCEDURE 164).CallingFieldNo(Parameter 1001)".


    //Unsupported feature: Property Modification (Name) on "OnBeforeUpdateCurrencyFactor(PROCEDURE 95).PurchaseHeader(Parameter 1000)".


    //Unsupported feature: Property Modification (Subtype) on "OnBeforeUpdateCurrencyFactor(PROCEDURE 95).PurchaseHeader(Parameter 1000)".


    //Unsupported feature: Property Modification (Name) on "OnBeforeUpdateCurrencyFactor(PROCEDURE 95).Updated(Parameter 1001)".


    //Unsupported feature: Property Modification (Data type) on "OnBeforeUpdateCurrencyFactor(PROCEDURE 95).Updated(Parameter 1001)".


    //Unsupported feature: Property Insertion (Temporary) on "OnBeforeUpdateCurrencyFactor(PROCEDURE 95).Updated(Parameter 1001)".


    //Unsupported feature: Property Insertion (Subtype) on "OnBeforeUpdateCurrencyFactor(PROCEDURE 95).Updated(Parameter 1001)".



    //Unsupported feature: Property Modification (Id) on "ResetItemChargeAssignMsg(Variable 1093)".

    //var
    //>>>> ORIGINAL VALUE:
    //ResetItemChargeAssignMsg : 1093;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ResetItemChargeAssignMsg : 1081;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text032(Variable 1031)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text032 : @@@=You have modified Currency Factor.\\Do you want to update the lines?;ENU=You have modified %1.\\Do you want to update the lines?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text032 : ENU=You have modified %1.\\;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "DocumentNotPostedClosePageQst(Variable 1013)".

    //var
    //>>>> ORIGINAL VALUE:
    //DocumentNotPostedClosePageQst : ENU=The document has been saved but is not yet posted.\\Are you sure you want to exit?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DocumentNotPostedClosePageQst : ENU=The document has not been posted.\Are you sure you want to exit?;
    //Variable type has not been exported.

    var
        Text033: Label 'Do you want to update the lines?';

    var
        Text055: Label 'Change the RFQ Reference No., the existing purchase quote lines will be deleted. Continue?';
        Text056: Label 'Modify RFQ Reference No. Cancelled.';
        Text057: Label 'The selected vendor is not in list of the vendors assigned to RFQ No.:%1';

    var
        ChangeCurrencyQst: Label 'If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created. You may need to update the price information manually.\\Do you want to change %1?';

    var
        RequestforQuotationVendors: Record "Request for Quotation Vendors";
        ProcurementManagement: Codeunit "Procurement Management";
        UserSetup: Record Employee;
        ProcurementUploadDocuments2: Record "Procurement Upload Documents";
        VendorDocs: Record "Vendor Required Documents";
}

