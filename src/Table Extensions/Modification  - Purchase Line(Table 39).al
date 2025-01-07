tableextension 60295 tableextension60295 extends "Purchase Line"
{
    fields
    {
        modify("No.")
        {
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE IF (Type = CONST("G/L Account"),
                                     "System-Created Entry" = CONST(false)) "G/L Account" WHERE("Direct Posting" = CONST(true),
                                                                                               "Account Type" = CONST(Posting),
                                                                                               Blocked = CONST(false))
            ELSE IF (Type = CONST("G/L Account"),
                                                                                                        "System-Created Entry" = CONST(true)) "G/L Account"
            ELSE IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE IF (Type = CONST("Charge (Item)")) "Item Charge"
            ELSE IF (Type = CONST(Item)) Item;
        }
        modify(Description)
        {

            //Unsupported feature: Property Modification (Data type) on "Description(Field 11)".

            TableRelation = IF (Type = CONST("G/L Account"),
                                "System-Created Entry" = CONST(false)) "G/L Account" WHERE("Direct Posting" = CONST(true),
                                                                                          "Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false))
            ELSE IF (Type = CONST("G/L Account"),
                                                                                                   "System-Created Entry" = CONST(true)) "G/L Account"
            ELSE IF (Type = CONST(Item)) Item
            ELSE IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE IF (Type = CONST("Charge (Item)")) "Item Charge";
        }

        //Unsupported feature: Property Modification (Data type) on ""Description 2"(Field 12)".


        //Unsupported feature: Property Modification (Data type) on ""Unit of Measure"(Field 13)".


        //Unsupported feature: Property Insertion (DataClassification) on ""Order No."(Field 65)".


        //Unsupported feature: Property Insertion (DataClassification) on ""Order Line No."(Field 66)".

        modify("FA Posting Type")
        {
            OptionCaption = ' ,Acquisition Cost,Maintenance';

            //Unsupported feature: Property Modification (OptionString) on ""FA Posting Type"(Field 5601)".

        }
        modify(Nonstock)
        {
            Caption = 'Nonstock';
        }

        //Unsupported feature: Property Modification (ObsoleteState) on ""Product Group Code"(Field 5712)".


        //Unsupported feature: Property Insertion (DataClassification) on ""Copied From Posted Doc."(Field 6610)".


        //Unsupported feature: Code Modification on ""No."(Field 6).OnValidate".

        //trigger "(Field 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchSetup;
        if PurchSetup."Create Item from Item No." then
          "No." := FindRecordMgt.FindNoFromTypedValue(Type,"No.",not "System-Created Entry");

        TestStatusOpen;
        TestField("Qty. Rcd. Not Invoiced",0);
        #7..25
            Text044,
            FieldCaption(Type),FieldCaption("Prod. Order No."),"Prod. Order No.");

        OnValidateNoOnAfterChecks(Rec,xRec,CurrFieldNo);

        if "No." <> xRec."No." then begin
          if (Quantity <> 0) and ItemExists(xRec."No.") then begin
            ReservePurchLine.VerifyChange(Rec,xRec);
            CalcFields("Reserved Qty. (Base)");
            TestField("Reserved Qty. (Base)",0);
            if Type = Type::Item then
              WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
            OnValidateNoOnAfterVerifyChange(Rec,xRec);
          end;
          if Type = Type::Item then
            DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
          if Type = Type::"Charge (Item)" then
            DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
        end;

        OnValidateNoOnBeforeInitRec(Rec,xRec,CurrFieldNo);
        TempPurchLine := Rec;
        Init;
        if xRec."Line Amount" <> 0 then
        #50..90

        if HasTypeToFillMandatoryFields then begin
          Quantity := xRec.Quantity;
          OnValidateNoOnAfterAssignQtyFromXRec(Rec,TempPurchLine);
          Validate("Unit of Measure Code");
          if Quantity <> 0 then begin
            InitOutstanding;
        #98..111
          end;
        end;

        CreateDim(
          DimMgt.TypeToTableID3(Type),"No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Work Center","Work Center No.");

        PurchHeader.Get("Document Type","Document No.");
        UpdateItemReference;
        #123..130

        PostingSetupMgt.CheckGenPostingSetupPurchAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
        PostingSetupMgt.CheckVATPostingSetupPurchAccount("VAT Bus. Posting Group","VAT Prod. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        "No." := FindRecordMgt.FindNoFromTypedValue(Type,"No.",not "System-Created Entry");
        #4..28
        #31..37
        #39..44
        #47..93
        #95..114
        if not IsTemporary then
          CreateDim(
            DimMgt.TypeToTableID3(Type),"No.",
            DATABASE::Job,"Job No.",
            DATABASE::"Responsibility Center","Responsibility Center",
            DATABASE::"Work Center","Work Center No.");
        #120..133

        //updated 07/09/2020
        if Type = Type::Item then
        "Description 2" := Description;
        "Location Code" := 'CENTRAL';
        //
        */
        //end;


        //Unsupported feature: Code Modification on ""Location Code"(Field 7).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;

        if "Location Code" <> '' then
          if IsNonInventoriableItem then begin
            GetItem(Item);
            Item.TestField(Type,Item.Type::Inventory);
          end;
        if xRec."Location Code" <> "Location Code" then begin
          if "Prepmt. Amt. Inv." <> 0 then
            if not ConfirmManagement.ConfirmProcess(
                 StrSubstNo(
                   Text046,FieldCaption("Direct Unit Cost"),FieldCaption("Location Code"),PRODUCTNAME.Full),true)
            then begin
              "Location Code" := xRec."Location Code";
              exit;
            end;
          TestField("Qty. Rcd. Not Invoiced",0);
          TestField("Receipt No.",'');

          TestField("Return Qty. Shipped Not Invd.",0);
          TestField("Return Shipment No.",'');
        end;

        if "Drop Shipment" then
          Error(
            Text001,
            FieldCaption("Location Code"),"Sales Order No.");
        if "Special Order" then
          Error(
            Text001,
            FieldCaption("Location Code"),"Special Order Sales No.");

        if "Location Code" <> xRec."Location Code" then
          InitItemAppl;

        if (xRec."Location Code" <> "Location Code") and (Quantity <> 0) then begin
          ReservePurchLine.VerifyChange(Rec,xRec);
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
          UpdateWithWarehouseReceive;
          PostingSetupMgt.CheckInvtPostingSetupInventoryAccount("Location Code","Posting Group");
        end;
        "Bin Code" := '';

        if Type = Type::Item then
          UpdateDirectUnitCost(FieldNo("Location Code"));

        if "Location Code" = '' then begin
          if InvtSetup.Get then
            "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
        end else
          if Location.Get("Location Code") then
            "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";

        UpdateLeadTimeFields;
        UpdateDates;

        GetDefaultBin;
        CheckWMS;

        if "Document Type" = "Document Type"::"Return Order" then
          ValidateReturnReasonCode(FieldNo("Location Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
          if IsServiceItem then
            Item.TestField(Type,Item.Type::Inventory);
        if xRec."Location Code" <> "Location Code" then begin
          if "Prepmt. Amt. Inv." <> 0 then
            if not Confirm(Text046,false,FieldCaption("Direct Unit Cost"),FieldCaption("Location Code"),PRODUCTNAME.Full) then begin
        #14..61
        //"Description 2" :=Description;
        */
        //end;


        //Unsupported feature: Code Modification on "Description(Field 11).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if Type = Type::" " then
          exit;

        #4..17
                    exit;
                  if IsReceivedFromOcr then
                    exit;
                  if ConfirmManagement.ConfirmProcess(
                       StrSubstNo(AnotherItemWithSameDescrQst,Item."No.",Item.Description),true)
                  then
                    Validate("No.",Item."No.");
                  exit;
                end;
        #27..39
                  exit;
                if ItemCharge."No." = "No." then
                  exit;
                if ConfirmManagement.ConfirmProcess(
                     StrSubstNo(AnotherChargeItemWithSameDescQst,ItemCharge."No.",ItemCharge.Description),true)
                then
                  Validate("No.",ItemCharge."No.");
              end;
          end;
        #49..54
            end;
          end;

        if ("No." = '') and GuiAllowed and ApplicationAreaMgmtFacade.IsFoundationEnabled then
          if "Document Type" in ["Document Type"::Order] then
            Error(CannotFindDescErr,Type,Description);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..20
                  if Confirm(AnotherItemWithSameDescrQst,false,Item."No.",Item.Description) then
        #24..42
                if Confirm(AnotherChargeItemWithSameDescQst,false,ItemCharge."No.",ItemCharge.Description) then
        #46..57
        if ("No." = '') and GuiAllowed and ApplicationAreaSetup.IsFoundationEnabled then
          if "Document Type" in ["Document Type"::Order] then
            Error(StrSubstNo(CannotFindDescErr,Type,Description));

        //updated 07/09/2020
        if Item.Get("No.") then
        "Description 2" := Item.Description;
        //
        */
        //end;


        //Unsupported feature: Code Modification on "Quantity(Field 15).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IsHandled := false;
        OnValidateQuantityOnBeforeDropShptCheck(Rec,xRec,CurrFieldNo,IsHandled);
        if not IsHandled then
          if "Drop Shipment" and ("Document Type" <> "Document Type"::Invoice) then
            Error(
              Text001,FieldCaption(Quantity),"Sales Order No.");
        "Quantity (Base)" := CalcBaseQty(Quantity);
        if "Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"] then begin
          if (Quantity * "Return Qty. Shipped" < 0) or
        #11..85
        end;

        CheckWMS;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;

        if "Drop Shipment" and ("Document Type" <> "Document Type"::Invoice) then
          Error(
            Text001,
            FieldCaption(Quantity),"Sales Order No.");
        #8..88
        */
        //end;

        //Unsupported feature: Property Deletion (Editable) on ""Outstanding Quantity"(Field 16)".



        //Unsupported feature: Code Modification on ""Qty. to Receive"(Field 18).OnValidate".

        //trigger  to Receive"(Field 18)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetLocation("Location Code");
        if (CurrFieldNo <> 0) and (Type = Type::Item) and (not "Drop Shipment") then begin
          if Location."Require Receive" and ("Qty. to Receive" <> 0) then
            CheckWarehouse;
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        end;
        OnValidateQtyToReceiveOnAfterCheck(Rec,CurrFieldNo);

        if "Qty. to Receive" = Quantity - "Quantity Received" then
          InitQtyToReceive
        #11..31

        if "Job Planning Line No." <> 0 then
          Validate("Job Planning Line No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetLocation("Location Code");
        if (CurrFieldNo <> 0) and
           (Type = Type::Item) and
           (not "Drop Shipment")
        then begin
          if Location."Require Receive" and
             ("Qty. to Receive" <> 0)
          then
        #4..6
        #8..34
        */
        //end;


        //Unsupported feature: Code Modification on ""Unit Cost (LCY)"(Field 23).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        TestField("No.");
        TestField(Quantity);
        #4..8

        if CurrFieldNo = FieldNo("Unit Cost (LCY)") then
          if Type = Type::Item then begin
            GetItem(Item);
            if Item."Costing Method" = Item."Costing Method"::Standard then
              Error(
                Text010,
        #16..47
          TempJobJnlLine.Validate("Unit Cost (LCY)","Unit Cost (LCY)");
          UpdateJobPrices;
        end
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11
            GetItem;
        #13..50
        */
        //end;


        //Unsupported feature: Code Modification on ""Line Discount %"(Field 27).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateLineDiscountPercent(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        GetPurchHeader;
        "Line Discount Amount" :=
          Round(
            Round(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") *
            "Line Discount %" / 100,
            Currency."Amount Rounding Precision");
        "Inv. Discount Amount" := 0;
        "Inv. Disc. Amount to Invoice" := 0;
        UpdateAmounts;
        UpdateUnitCost;
        */
        //end;


        //Unsupported feature: Code Modification on ""Indirect Cost %"(Field 54).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestField("No.");
        TestStatusOpen;

        if Type = Type::"Charge (Item)" then
          TestField("Indirect Cost %",0);

        if (Type = Type::Item) and ("Prod. Order No." = '') then begin
          GetItem(Item);
          Item.TestField(Type,Item.Type::Inventory);
          if Item."Costing Method" = Item."Costing Method"::Standard then
            Error(
              Text010,
              FieldCaption("Indirect Cost %"),Item.FieldCaption("Costing Method"),Item."Costing Method");
        end;

        UpdateUnitCost;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
          GetItem;
        #9..16
        */
        //end;

        //Unsupported feature: Property Deletion (Editable) on ""Outstanding Amount"(Field 57)".


        //Unsupported feature: Property Deletion (Editable) on ""Qty. Rcd. Not Invoiced"(Field 58)".


        //Unsupported feature: Property Deletion (Editable) on ""Amt. Rcd. Not Invoiced"(Field 59)".


        //Unsupported feature: Property Deletion (Editable) on ""Quantity Received"(Field 60)".


        //Unsupported feature: Property Deletion (Editable) on ""Quantity Invoiced"(Field 61)".



        //Unsupported feature: Code Modification on ""Gen. Prod. Posting Group"(Field 75).OnValidate".

        //trigger  Prod()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
          if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") then
            Validate("VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //TestStatusOpen;
        #2..4
        */
        //end;


        //Unsupported feature: Code Modification on ""VAT Prod. Posting Group"(Field 90).OnValidate".

        //trigger  Posting Group"(Field 90)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        VATPostingSetup.Get("VAT Bus. Posting Group","VAT Prod. Posting Group");
        "VAT Difference" := 0;
        GetPurchHeader;
        #5..20
              "Direct Unit Cost" * (100 + "VAT %") / (100 + xRec."VAT %"),
              Currency."Unit-Amount Rounding Precision");
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //TestStatusOpen;
        #2..23
        */
        //end;


        //Unsupported feature: Code Modification on ""IC Partner Ref. Type"(Field 107).OnValidate".

        //trigger  Type"(Field 107)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "IC Partner Code" <> '' then
          "IC Partner Ref. Type" := "IC Partner Ref. Type"::"G/L Account";
        if "IC Partner Ref. Type" <> xRec."IC Partner Ref. Type" then
          "IC Partner Reference" := '';
        if "IC Partner Ref. Type" = "IC Partner Ref. Type"::"Common Item No." then begin
          GetItem(Item);
          Item.TestField("Common Item No.");
          "IC Partner Reference" := Item."Common Item No.";
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
          if Item."No." <> "No." then
            Item.Get("No.");
        #7..9
        */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""Pmt. Discount Amount"(Field 145)".



        //Unsupported feature: Code Modification on ""Unit of Measure Code"(Field 5407).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        TestField("Quantity Received",0);
        TestField("Qty. Received (Base)",0);
        #4..11
          Error(
            Text001,
            FieldCaption("Unit of Measure Code"),"Sales Order No.");
        if (xRec."Unit of Measure Code" <> "Unit of Measure Code") and (Quantity <> 0) then
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        UpdateDirectUnitCost(FieldNo("Unit of Measure Code"));
        if "Unit of Measure Code" = '' then
        #19..31
          UpdateItemReference;
        if "Prod. Order No." = '' then begin
          if (Type = Type::Item) and ("No." <> '') then begin
            GetItem(Item);
            "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
            "Gross Weight" := Item."Gross Weight" * "Qty. per Unit of Measure";
            "Net Weight" := Item."Net Weight" * "Qty. per Unit of Measure";
        #39..47
          "Qty. per Unit of Measure" := 0;

        Validate(Quantity);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..14
        if (xRec."Unit of Measure" <> "Unit of Measure") and (Quantity <> 0) then
        #16..34
            GetItem;
        #36..50
        */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Cross-Reference No."(Field 5705).OnValidate".

        //trigger (Variable: ReturnedCrossRef)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Cross-Reference No."(Field 5705).OnValidate".

        //trigger "(Field 5705)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        "Buy-from Vendor No." := PurchHeader."Buy-from Vendor No.";
        ValidateCrossReferenceNo(ItemCrossReference,true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetPurchHeader;
        "Buy-from Vendor No." := PurchHeader."Buy-from Vendor No.";

        ReturnedCrossRef.Init;
        if "Cross-Reference No." <> '' then begin
          DistIntegration.ICRLookupPurchaseItem(Rec,ReturnedCrossRef,CurrFieldNo <> 0);
          Validate("No.",ReturnedCrossRef."Item No.");
          SetVendorItemNo;
          if ReturnedCrossRef."Variant Code" <> '' then
            Validate("Variant Code",ReturnedCrossRef."Variant Code");
          if ReturnedCrossRef."Unit of Measure" <> '' then
            Validate("Unit of Measure Code",ReturnedCrossRef."Unit of Measure");
          UpdateDirectUnitCost(FieldNo("Cross-Reference No."));
        end;

        "Unit of Measure (Cross Ref.)" := ReturnedCrossRef."Unit of Measure";
        "Cross-Reference Type" := ReturnedCrossRef."Cross-Reference Type";
        "Cross-Reference Type No." := ReturnedCrossRef."Cross-Reference Type No.";
        "Cross-Reference No." := ReturnedCrossRef."Cross-Reference No.";

        if ReturnedCrossRef.Description <> '' then
          Description := ReturnedCrossRef.Description;

        UpdateICPartner;
        */
        //end;
        field(52136923; "Purchase Requisition Line"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Sysre NextGen Addon field, Specifies the purchase requisition line no. for the attached requisition line';
        }
        field(52136924; "Purchase Requisition No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Sysre NextGen Addon field, Specifies the purchase requisition document no. for the attached requisition line';
        }
        field(52136925; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(52136926; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(52136927; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(52136928; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(52136929; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(52136930; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
            end;
        }
        field(52136931; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
        }
        field(52136932; "Amount(LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            Editable = false;

            // trigger OnValidate()
            // begin
            //     GetPurchHeader;
            //     Amount := Round(Amount,Currency."Amount Rounding Precision");
            //     case "VAT Calculation Type" of
            //       "VAT Calculation Type"::"Normal VAT",
            //       "VAT Calculation Type"::"Reverse Charge VAT":
            //         begin
            //           "VAT Base Amount" :=
            //             Round(Amount * (1 - PurchHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
            //           "Amount Including VAT" :=
            //             Round(Amount + "VAT Base Amount" * "VAT %" / 100,Currency."Amount Rounding Precision");
            //         end;
            //       "VAT Calculation Type"::"Full VAT":
            //         if Amount <> 0 then
            //           FieldError(Amount,
            //             StrSubstNo(
            //               Text011,FieldCaption("VAT Calculation Type"),
            //               "VAT Calculation Type"));
            //       "VAT Calculation Type"::"Sales Tax":
            //         begin
            //           PurchHeader.TestField("VAT Base Discount %",0);
            //           "VAT Base Amount" := Amount;
            //           if "Use Tax" then
            //             "Amount Including VAT" := "VAT Base Amount"
            //           else begin
            //             "Amount Including VAT" :=
            //               Amount +
            //               Round(
            //                 SalesTaxCalculate.CalculateTax(
            //                   "Tax Area Code","Tax Group Code","Tax Liable",PurchHeader."Posting Date",
            //                   "VAT Base Amount","Quantity (Base)",PurchHeader."Currency Factor"),
            //                 Currency."Amount Rounding Precision");
            //             if "VAT Base Amount" <> 0 then
            //               "VAT %" :=
            //                 Round(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
            //             else
            //               "VAT %" := 0;
            //           end;
            //         end;
            //     end;

            //     InitOutstandingAmount;
            //     UpdateUnitCost;
            // end;
        }
        field(52136933; "Amount Including VAT(LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            DataClassification = ToBeClassified;
            Editable = false;

            // trigger OnValidate()
            // begin
            //     GetPurchHeader;
            //     "Amount Including VAT" := Round("Amount Including VAT",Currency."Amount Rounding Precision");
            //     case "VAT Calculation Type" of
            //       "VAT Calculation Type"::"Normal VAT",
            //       "VAT Calculation Type"::"Reverse Charge VAT":
            //         begin
            //           Amount :=
            //             Round(
            //               "Amount Including VAT" /
            //               (1 + (1 - PurchHeader."VAT Base Discount %" / 100) * "VAT %" / 100),
            //               Currency."Amount Rounding Precision");
            //           "VAT Base Amount" :=
            //             Round(Amount * (1 - PurchHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
            //         end;
            //       "VAT Calculation Type"::"Full VAT":
            //         begin
            //           Amount := 0;
            //           "VAT Base Amount" := 0;
            //         end;
            //       "VAT Calculation Type"::"Sales Tax":
            //         begin
            //           PurchHeader.TestField("VAT Base Discount %",0);
            //           if "Use Tax" then begin
            //             Amount := "Amount Including VAT";
            //             "VAT Base Amount" := Amount;
            //           end else begin
            //             Amount :=
            //               Round(
            //                 SalesTaxCalculate.ReverseCalculateTax(
            //                   "Tax Area Code","Tax Group Code","Tax Liable",PurchHeader."Posting Date",
            //                   "Amount Including VAT","Quantity (Base)",PurchHeader."Currency Factor"),
            //                 Currency."Amount Rounding Precision");
            //             "VAT Base Amount" := Amount;
            //             if "VAT Base Amount" <> 0 then
            //               "VAT %" :=
            //                 Round(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
            //             else
            //               "VAT %" := 0;
            //           end;
            //         end;
            //     end;

            //     InitOutstandingAmount;
            //     UpdateUnitCost;
            // end;
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
                END;*/
                //End Check

                /*IF CONFIRM(Text055) THEN BEGIN
                  ProcurementManagement.CreatePurchaseQuoteLinesfromRFQ(Rec,"Request for Quotation Code");
                END ELSE BEGIN
                  ERROR(Text056);
                END;*/
                //End Sysre NextGen Addon

            end;
        }
        field(52136984; "Type (Attributes)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Purchase Requisition,LPO,Procurement Planning';
            OptionMembers = "Purchase Requisition",LPO,"Procurement Planning";
        }
        field(52136985; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136986; "LPO No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(52136987; "Purchase Order Line"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(99000760; "PR NO"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(99000761; "PR NO Line"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(99000762; Committed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {

        //Unsupported feature: Property Insertion (SumIndexFields) on ""Document Type","Document No.","Line No."(Key)".


        //Unsupported feature: Property Insertion (Enabled) on ""Document Type","Document No.","Location Code"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Document Type","Pay-to Vendor No.","Currency Code","Document No."(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Document Type","Pay-to Vendor No.","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code","Currency Code","Document No."(Key)".


        //Unsupported feature: Property Deletion (SumIndexFields) on ""Document Type","Document No.","Location Code"(Key)".


        //Unsupported feature: Property Deletion (MaintainSQLIndex) on ""Document Type","Document No.","Location Code"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Document Type","Job No.","Job Task No.","Document No."(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Outstanding Quantity"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Location Code","Quantity Invoiced"(Key)".

        // key(Key1; "Document Type", "Pay-to Vendor No.", "Currency Code")
        // {
        //     MaintainSIFTIndex = false;
        //     SumIndexFields = "Outstanding Amount", "Amt. Rcd. Not Invoiced", "Outstanding Amount (LCY)", "Amt. Rcd. Not Invoiced (LCY)";
        // }
        key(Key2; "Document Type", "Pay-to Vendor No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Currency Code")
        {
            Enabled = false;
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Outstanding Amount", "Amt. Rcd. Not Invoiced", "Outstanding Amount (LCY)", "Amt. Rcd. Not Invoiced (LCY)";
        }
        // key(Key3; "Document Type", "Job No.", "Job Task No.")
        // {
        //     SumIndexFields = "Outstanding Amt. Ex. VAT (LCY)", "A. Rcd. Not Inv. Ex. VAT (LCY)";
        // }
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatusOpen;
    if (Quantity <> 0) and ItemExists("No.") then begin
      ReservePurchLine.DeleteLine(Rec);
    #4..34
      end;
    end;

    CatalogItemMgt.DelNonStockPurch(Rec);

    if "Document Type" = "Document Type"::"Blanket Order" then begin
      PurchLine2.Reset;
    #42..67
      PurchCommentLine.DeleteAll;

    // In case we have roundings on VAT or Sales Tax, we should update some other line
    if (Type <> Type::" ") and (not "Drop Shipment") and ("Line No." <> 0) and ("Attached to Line No." = 0) and
       (Quantity <> 0) and (Amount <> 0) and (Amount <> "Amount Including VAT") and not StatusCheckSuspended
    then
      Validate(Quantity,0);

    if "Deferral Code" <> '' then
      DeferralUtilities.DeferralCodeOnDelete(
        DeferralUtilities.GetPurchDeferralDocType,'','',
        "Document Type","Document No.","Line No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..37
    NonstockItemMgt.DelNonStockPurch(Rec);
    #39..70
    if (Type <> Type::" ") and ("Line No." <> 0) and ("Attached to Line No." = 0) and
    #72..79
    */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatusOpen;
    if Quantity <> 0 then begin
      OnBeforeVerifyReservedQty(Rec,xRec,0);
    #4..6
    PurchHeader."No." := '';
    if ("Deferral Code" <> '') and (GetDeferralAmount <> 0) then
      UpdateDeferralAmounts;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9

    PurchHeader.Reset;
    PurchHeader.SetRange(PurchHeader."No.","Document No.");
    if PurchHeader.FindFirst then begin
      "Shortcut Dimension 1 Code":=PurchHeader."Shortcut Dimension 1 Code";
      "Shortcut Dimension 2 Code":=PurchHeader."Shortcut Dimension 2 Code";
      "Shortcut Dimension 3 Code":=PurchHeader."Shortcut Dimension 3 Code";
      "Shortcut Dimension 4 Code":=PurchHeader."Shortcut Dimension 4 Code";
      "Shortcut Dimension 5 Code":=PurchHeader."Shortcut Dimension 5 Code";
      "Shortcut Dimension 6 Code":=PurchHeader."Shortcut Dimension 6 Code";
      "Shortcut Dimension 7 Code":=PurchHeader."Shortcut Dimension 7 Code";
      "Shortcut Dimension 8 Code":=PurchHeader."Shortcut Dimension 8 Code";
    end;

    "Type (Attributes)":="Type (Attributes)"::LPO;
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitOutstanding(PROCEDURE 16)".



    //Unsupported feature: Code Modification on "InitOutstanding(PROCEDURE 16)".

    //procedure InitOutstanding();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"] then begin
      "Outstanding Quantity" := Quantity - "Return Qty. Shipped";
      "Outstanding Qty. (Base)" := "Quantity (Base)" - "Return Qty. Shipped (Base)";
    #4..8
      "Qty. Rcd. Not Invoiced" := "Quantity Received" - "Quantity Invoiced";
      "Qty. Rcd. Not Invoiced (Base)" := "Qty. Received (Base)" - "Qty. Invoiced (Base)";
    end;

    OnAfterInitOutstandingQty(Rec);
    "Completely Received" := (Quantity <> 0) and ("Outstanding Quantity" = 0);
    InitOutstandingAmount;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..11
    "Completely Received" := (Quantity <> 0) and ("Outstanding Quantity" = 0);
    InitOutstandingAmount;
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitOutstandingAmount(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToReceive(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToShip(PROCEDURE 5803)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToInvoice(PROCEDURE 13)".



    //Unsupported feature: Code Modification on "InitQtyToInvoice(PROCEDURE 13)".

    //procedure InitQtyToInvoice();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Qty. to Invoice" := MaxQtyToInvoice;
    "Qty. to Invoice (Base)" := MaxQtyToInvoiceBase;
    "VAT Difference" := 0;

    OnBeforeCalcInvDiscToInvoice(Rec,CurrFieldNo);
    CalcInvDiscToInvoice;
    if PurchHeader."Document Type" <> PurchHeader."Document Type"::Invoice then
      CalcPrepaymentToDeduct;

    OnAfterInitQtyToInvoice(Rec,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    #6..10
    */
    //end;


    //Unsupported feature: Code Modification on "InitHeaderDefaults(PROCEDURE 97)".

    //procedure InitHeaderDefaults();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchHeader.TestField("Buy-from Vendor No.");

    "Buy-from Vendor No." := PurchHeader."Buy-from Vendor No.";
    "Currency Code" := PurchHeader."Currency Code";
    "Expected Receipt Date" := PurchHeader."Expected Receipt Date";
    "Shortcut Dimension 1 Code" := PurchHeader."Shortcut Dimension 1 Code";
    "Shortcut Dimension 2 Code" := PurchHeader."Shortcut Dimension 2 Code";
    if not IsNonInventoriableItem then
      "Location Code" := PurchHeader."Location Code";
    "Transaction Type" := PurchHeader."Transaction Type";
    "Transport Method" := PurchHeader."Transport Method";
    #12..16
    "Transaction Specification" := PurchHeader."Transaction Specification";
    "Tax Area Code" := PurchHeader."Tax Area Code";
    "Tax Liable" := PurchHeader."Tax Liable";
    if not "System-Created Entry" and ("Document Type" = "Document Type"::Order) and HasTypeToFillMandatoryFields or
       IsServiceCharge
    then
      "Prepayment %" := PurchHeader."Prepayment %";
    "Prepayment Tax Area Code" := PurchHeader."Tax Area Code";
    "Prepayment Tax Liable" := PurchHeader."Tax Liable";
    "Responsibility Center" := PurchHeader."Responsibility Center";
    "Requested Receipt Date" := PurchHeader."Requested Receipt Date";
    "Promised Receipt Date" := PurchHeader."Promised Receipt Date";
    "Inbound Whse. Handling Time" := PurchHeader."Inbound Whse. Handling Time";
    "Order Date" := PurchHeader."Order Date";

    OnAfterInitHeaderDefaults(Rec,PurchHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    if not IsServiceItem then
    #9..19
    if not "System-Created Entry" and ("Document Type" = "Document Type"::Order) and HasTypeToFillMandatoryFields then
    #23..30
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "MaxQtyToInvoice(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "MaxQtyToInvoiceBase(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "CalcInvDiscToInvoice(PROCEDURE 33)".



    //Unsupported feature: Code Modification on "CopyFromItem(PROCEDURE 100)".

    //procedure CopyFromItem();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetItem(Item);
    GetGLSetup;
    OnBeforeCopyFromItem(Rec,Item);
    Item.TestField(Blocked,false);
    Item.TestField("Gen. Prod. Posting Group");
    if Item."Purchasing Blocked" then
      Error(PurchasingBlockedErr);
    if Item.Type = Item.Type::Inventory then begin
      Item.TestField("Inventory Posting Group");
      "Posting Group" := Item."Inventory Posting Group";
    end;
    Description := Item.Description;
    "Description 2" := Item."Description 2";
    "Unit Price (LCY)" := Item."Unit Price";
    "Units per Parcel" := Item."Units per Parcel";
    "Indirect Cost %" := Item."Indirect Cost %";
    #17..20
    "Tax Group Code" := Item."Tax Group Code";
    Nonstock := Item."Created From Nonstock Item";
    "Item Category Code" := Item."Item Category Code";
    "Allow Item Charge Assignment" := true;
    PrepaymentMgt.SetPurchPrepaymentPct(Rec,PurchHeader."Posting Date");
    if Item.Type = Item.Type::Inventory then
    #27..48
    "Unit of Measure Code" := Item."Purch. Unit of Measure";
    InitDeferralCode;
    OnAfterAssignItemValues(Rec,Item);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GetItem;
    GetGLSetup;
    Item.TestField(Blocked,false);
    Item.TestField("Gen. Prod. Posting Group");
    #8..12
    "Description 2" := Description;
    "Location Code":=Item."Location Code";
    #14..23
    //"Product Group Code" := Item."Product Group Code";
    #24..51
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SetPurchHeader(PROCEDURE 12)".



    //Unsupported feature: Code Modification on "GetPurchHeader(PROCEDURE 1)".

    //procedure GetPurchHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestField("Document No.");
    if ("Document Type" <> PurchHeader."Document Type") or ("Document No." <> PurchHeader."No.") then begin
      PurchHeader.Get("Document Type","Document No.");
    #4..8
        Currency.TestField("Amount Rounding Precision");
      end;
    end;

    OnAfterGetPurchHeader(Rec,PurchHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..11
    */
    //end;


    //Unsupported feature: Code Modification on "GetItem(PROCEDURE 4)".

    //procedure GetItem();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestField("No.");
    Item.Get("No.");

    OnAfterGetItem(Item,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TestField("No.");
    if Item."No." <> "No." then
      Item.Get("No.");
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateDirectUnitCost(PROCEDURE 2)".


    //Unsupported feature: Property Insertion (Local) on "UpdateDirectUnitCost(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "UpdateDirectUnitCost(PROCEDURE 2)".

    //procedure UpdateDirectUnitCost();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := false;
    OnBeforeUpdateDirectUnitCost(Rec,xRec,CalledByFieldNo,CurrFieldNo,IsHandled);
    if IsHandled then
      exit;

    if (CurrFieldNo <> 0) and ("Prod. Order No." <> '') then
      UpdateAmounts;
    #8..12

    if Type = Type::Item then begin
      GetPurchHeader;
      IsHandled := false;
      OnUpdateDirectUnitCostOnBeforeFindPrice(PurchHeader,Rec,CalledByFieldNo,CurrFieldNo,IsHandled);
      if not IsHandled then begin
        PurchPriceCalcMgt.FindPurchLinePrice(PurchHeader,Rec,CalledByFieldNo);
        if not ("Copied From Posted Doc." and IsCreditDocType) then
          PurchPriceCalcMgt.FindPurchLineLineDisc(PurchHeader,Rec);
      end;
      Validate("Direct Unit Cost");

      if CalledByFieldNo in [FieldNo("No."),FieldNo("Variant Code"),FieldNo("Location Code")] then
        UpdateItemReference;
    end;

    OnAfterUpdateDirectUnitCost(Rec,xRec,CalledByFieldNo,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    OnBeforeUpdateDirectUnitCost(Rec,xRec,CalledByFieldNo,CurrFieldNo);
    #5..15
      PurchPriceCalcMgt.FindPurchLinePrice(PurchHeader,Rec,CalledByFieldNo);
      PurchPriceCalcMgt.FindPurchLineLineDisc(PurchHeader,Rec);
    #23..29
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateUnitCost(PROCEDURE 5)".



    //Unsupported feature: Code Modification on "UpdateUnitCost(PROCEDURE 5)".

    //procedure UpdateUnitCost();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetPurchHeader;
    GetGLSetup;
    if Quantity = 0 then
    #4..28
      "Unit Cost (LCY)" := "Unit Cost";

    if (Type = Type::Item) and ("Prod. Order No." = '') then begin
      GetItem(Item);
      if Item."Costing Method" = Item."Costing Method"::Standard then begin
        if GetSKU then
          "Unit Cost (LCY)" := SKU."Unit Cost" * "Qty. per Unit of Measure"
    #36..51
      TempJobJnlLine.Validate("Unit Cost (LCY)","Unit Cost (LCY)");
      UpdateJobPrices;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..31
      GetItem;
    #33..54
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateAmounts(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "UpdateAmounts(PROCEDURE 3)".

    //procedure UpdateAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Type = Type::" " then
      exit;
    GetPurchHeader;
    #4..26
        "Prepayment VAT Difference" := 0;
        if not PrePaymentLineAmountEntered then
          "Prepmt. Line Amount" := Round("Line Amount" * "Prepayment %" / 100,Currency."Amount Rounding Precision");
        if "Prepmt. Line Amount" < "Prepmt. Amt. Inv." then begin
          if IsServiceCharge then
            Error(CannotChangePrepaidServiceChargeErr);
          FieldError("Prepmt. Line Amount",StrSubstNo(Text037,"Prepmt. Amt. Inv."));
        end;
        PrePaymentLineAmountEntered := false;
        if "Prepmt. Line Amount" <> 0 then begin
          RemLineAmountToInvoice :=
    #38..48
        end;
    end;

    OnAfterUpdateAmounts(Rec,xRec,CurrFieldNo);

    UpdateVATAmounts;
    if VATBaseAmount <> "VAT Base Amount" then
    #56..65
      UpdateItemChargeAssgnt;

    CalcPrepaymentToDeduct;

    OnAfterUpdateAmountsDone(Rec,xRec,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..29
        if "Prepmt. Line Amount" < "Prepmt. Amt. Inv." then
          FieldError("Prepmt. Line Amount",StrSubstNo(Text037,"Prepmt. Amt. Inv."));
    #35..51
    OnAfterUpdateAmounts(Rec);
    #53..68
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateVATAmounts(PROCEDURE 38)".


    //Unsupported feature: Property Insertion (Local) on "UpdateVATAmounts(PROCEDURE 38)".



    //Unsupported feature: Code Modification on "UpdateVATAmounts(PROCEDURE 38)".

    //procedure UpdateVATAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeUpdateVATAmounts(Rec);

    GetPurchHeader;
    PurchLine2.SetRange("Document Type","Document Type");
    PurchLine2.SetRange("Document No.","Document No.");
    #6..15
          Modify;
        PurchLine2.SetFilter(Amount,'<>0');
        if PurchLine2.Find('<>') then begin
          PurchLine2.ValidateLineDiscountPercent(false);
          PurchLine2.Modify;
        end;
      end;
    #23..36
          TotalAmount := PurchLine2.Amount;
          TotalAmountInclVAT := PurchLine2."Amount Including VAT";
          TotalQuantityBase := PurchLine2."Quantity (Base)";
          OnAfterUpdateTotalAmounts(Rec,PurchLine2,TotalAmount,TotalAmountInclVAT,TotalLineAmount,TotalInvDiscAmount);
        end;

      if PurchHeader."Prices Including VAT" then
    #44..46
            begin
              Amount :=
                Round(
                  (TotalLineAmount - TotalInvDiscAmount + CalcLineAmount) / (1 + "VAT %" / 100),
                  Currency."Amount Rounding Precision") -
                TotalAmount;
              "VAT Base Amount" :=
    #54..69
            begin
              PurchHeader.TestField("VAT Base Discount %",0);
              "Amount Including VAT" :=
                Round(CalcLineAmount,Currency."Amount Rounding Precision");
              if "Use Tax" then
                Amount := "Amount Including VAT"
              else
    #77..94
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            begin
              Amount := Round(CalcLineAmount,Currency."Amount Rounding Precision");
              "VAT Base Amount" :=
                Round(Amount * (1 - PurchHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
              "Amount Including VAT" :=
    #102..108
            begin
              Amount := 0;
              "VAT Base Amount" := 0;
              "Amount Including VAT" := CalcLineAmount;
            end;
          "VAT Calculation Type"::"Sales Tax":
            begin
              Amount := Round(CalcLineAmount,Currency."Amount Rounding Precision");
              "VAT Base Amount" := Amount;
              if "Use Tax" then
                "Amount Including VAT" := Amount
    #120..134
            end;
        end;
    end;

    OnAfterUpdateVATAmounts(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #3..18
          PurchLine2.Validate("Line Discount %");
    #20..39
    #41..49
                  (TotalLineAmount - TotalInvDiscAmount + "Line Amount" - "Inv. Discount Amount") / (1 + "VAT %" / 100),
    #51..72
                Round("Line Amount" - "Inv. Discount Amount",Currency."Amount Rounding Precision");
    #74..97
              Amount := Round("Line Amount" - "Inv. Discount Amount",Currency."Amount Rounding Precision");
    #99..111
              "Amount Including VAT" := "Line Amount" - "Inv. Discount Amount";
    #113..115
              Amount := Round("Line Amount" - "Inv. Discount Amount",Currency."Amount Rounding Precision");
    #117..137
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdatePrepmtSetupFields(PROCEDURE 102)".



    //Unsupported feature: Code Modification on "GetFAPostingGroup(PROCEDURE 10)".

    //procedure GetFAPostingGroup();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if (Type <> Type::"Fixed Asset") or ("No." = '') then
      exit;
    if "Depreciation Book Code" = '' then begin
    #4..12
    FADeprBook.Get("No.","Depreciation Book Code");
    FADeprBook.TestField("FA Posting Group");
    FAPostingGr.Get(FADeprBook."FA Posting Group");
    case "FA Posting Type" of
      "FA Posting Type"::"Acquisition Cost":
        LocalGLAcc.Get(FAPostingGr.GetAcquisitionCostAccount);
      "FA Posting Type"::Appreciation:
        LocalGLAcc.Get(FAPostingGr.GetAppreciationAccount);
      "FA Posting Type"::Maintenance:
        LocalGLAcc.Get(FAPostingGr.GetMaintenanceExpenseAccount);
    end;
    LocalGLAcc.CheckGLAcc;
    LocalGLAcc.TestField("Gen. Prod. Posting Group");
    "Posting Group" := FADeprBook."FA Posting Group";
    "Gen. Prod. Posting Group" := LocalGLAcc."Gen. Prod. Posting Group";
    "Tax Group Code" := LocalGLAcc."Tax Group Code";
    Validate("VAT Prod. Posting Group",LocalGLAcc."VAT Prod. Posting Group");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..15
    if "FA Posting Type" = "FA Posting Type"::"Acquisition Cost" then
      LocalGLAcc.Get(FAPostingGr.GetAcquisitionCostAccount)
    else
      LocalGLAcc.Get(FAPostingGr.GetMaintenanceExpenseAccount);
    #24..29
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateUOMQtyPerStockQty(PROCEDURE 9)".



    //Unsupported feature: Code Modification on "UpdateUOMQtyPerStockQty(PROCEDURE 9)".

    //procedure UpdateUOMQtyPerStockQty();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetItem(Item);
    "Unit Cost (LCY)" := Item."Unit Cost" * "Qty. per Unit of Measure";
    "Unit Price (LCY)" := Item."Unit Price" * "Qty. per Unit of Measure";
    GetPurchHeader;
    #5..9
    else
      "Unit Cost" := "Unit Cost (LCY)";
    UpdateDirectUnitCost(FieldNo("Unit of Measure Code"));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GetItem;
    #2..12
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ShowReservation(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "ShowReservationEntries(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "GetDate(PROCEDURE 28)".



    //Unsupported feature: Code Modification on "GetDate(PROCEDURE 28)".

    //procedure GetDate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetPurchHeader;
    if PurchHeader."Posting Date" <> 0D then
      exit(PurchHeader."Posting Date");
    exit(WorkDate);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #2..4
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "Signed(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "BlanketOrderLookup(PROCEDURE 36)".



    //Unsupported feature: Code Modification on "BlanketOrderLookup(PROCEDURE 36)".

    //procedure BlanketOrderLookup();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := false;
    OnBeforeBlanketOrderLookup(Rec,CurrFieldNo,IsHandled);
    if IsHandled then
      exit;

    PurchLine2.Reset;
    PurchLine2.SetCurrentKey("Document Type",Type,"No.");
    PurchLine2.SetRange("Document Type","Document Type"::"Blanket Order");
    #9..14
      "Blanket Order No." := PurchLine2."Document No.";
      Validate("Blanket Order Line No.",PurchLine2."Line No.");
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #6..17
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "BlockDynamicTracking(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 25)".



    //Unsupported feature: Code Modification on "ShowDimensions(PROCEDURE 25)".

    //procedure ShowDimensions();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OldDimSetID := "Dimension Set ID";
    "Dimension Set ID" :=
      DimMgt.EditDimensionSet("Dimension Set ID",StrSubstNo('%1 %2 %3',"Document Type","Document No.","Line No."));
    VerifyItemLineDim;
    DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
    IsChanged := OldDimSetID <> "Dimension Set ID";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #2..5
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OpenItemTrackingLines(PROCEDURE 6500)".



    //Unsupported feature: Code Modification on "OpenItemTrackingLines(PROCEDURE 6500)".

    //procedure OpenItemTrackingLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := false;
    OnBeforeOpenItemTrackingLines(Rec,IsHandled);
    if IsHandled then
      exit;

    TestField(Type,Type::Item);
    TestField("No.");
    if "Prod. Order No." <> '' then
      Error(Text031,"Prod. Order No.");

    TestField("Quantity (Base)");

    ReservePurchLine.CallItemTracking(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #6..13
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "LookupShortcutDimCode(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemChargeAssgnt(PROCEDURE 5801)".



    //Unsupported feature: Code Modification on "ShowItemChargeAssgnt(PROCEDURE 5801)".

    //procedure ShowItemChargeAssgnt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Get("Document Type","Document No.","Line No.");
    TestField("No.");
    TestField(Quantity);
    #4..17
    else
      if PurchHeader."Prices Including VAT" then
        ItemChargeAssgntLineAmt :=
          Round(CalcLineAmount / (1 + "VAT %" / 100),Currency."Amount Rounding Precision")
      else
        ItemChargeAssgntLineAmt := CalcLineAmount;

    ItemChargeAssgntPurch.Reset;
    ItemChargeAssgntPurch.SetRange("Document Type","Document Type");
    #27..52
    ItemChargeAssgnts.RunModal;

    CalcFields("Qty. to Assign");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..20
          Round(("Line Amount" - "Inv. Discount Amount") / (1 + "VAT %" / 100),
            Currency."Amount Rounding Precision")
      else
        ItemChargeAssgntLineAmt := "Line Amount" - "Inv. Discount Amount";
    #24..55
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateItemChargeAssgnt(PROCEDURE 5807)".



    //Unsupported feature: Code Modification on "UpdateItemChargeAssgnt(PROCEDURE 5807)".

    //procedure UpdateItemChargeAssgnt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Document Type" = "Document Type"::"Blanket Order" then
      exit;

    #4..32
        ShareOfVAT := 1;
        if PurchHeader."Prices Including VAT" then
          ShareOfVAT := 1 + "VAT %" / 100;
        if ItemChargeAssgntPurch."Unit Cost" <>
           Round(CalcLineAmount / Quantity / ShareOfVAT,Currency."Unit-Amount Rounding Precision")
        then
          ItemChargeAssgntPurch."Unit Cost" :=
            Round(CalcLineAmount / Quantity / ShareOfVAT,Currency."Unit-Amount Rounding Precision");
        if TotalQtyToAssign <> 0 then begin
          ItemChargeAssgntPurch."Amount to Assign" :=
            Round(ItemChargeAssgntPurch."Qty. to Assign" / TotalQtyToAssign * TotalAmtToAssign,
    #44..48
      until ItemChargeAssgntPurch.Next = 0;
      CalcFields("Qty. to Assign");
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..35
        if ItemChargeAssgntPurch."Unit Cost" <> Round(
             ("Line Amount" - "Inv. Discount Amount") / Quantity / ShareOfVAT,
             Currency."Unit-Amount Rounding Precision")
        then
          ItemChargeAssgntPurch."Unit Cost" :=
            Round(("Line Amount" - "Inv. Discount Amount") / Quantity / ShareOfVAT,
              Currency."Unit-Amount Rounding Precision");
    #41..51
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CheckItemChargeAssgnt(PROCEDURE 5800)".


    //Unsupported feature: Variable Insertion (Variable: CaptionManagement) (VariableCollection) on "GetCaptionClass(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "GetCaptionClass(PROCEDURE 34)".



    //Unsupported feature: Code Modification on "GetCaptionClass(PROCEDURE 34)".

    //procedure GetCaptionClass();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    exit(PurchLineCaptionClassMgmt.GetPurchaseLineCaptionClass(Rec,FieldNumber));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    exit(CaptionManagement.GetPurchaseLineCaptionClass(Rec,FieldNumber));
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "TestStatusOpen(PROCEDURE 37)".


    //Unsupported feature: Property Insertion (Local) on "TestStatusOpen(PROCEDURE 37)".



    //Unsupported feature: Code Modification on "TestStatusOpen(PROCEDURE 37)".

    //procedure TestStatusOpen();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeTestStatusOpen(Rec,PurchHeader);

    if StatusCheckSuspended then
      exit;
    GetPurchHeader;
    if not "System-Created Entry" then
      if HasTypeToFillMandatoryFields then
        PurchHeader.TestField(Status,PurchHeader.Status::Open);

    OnAfterTestStatusOpen(Rec,PurchHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #3..8
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SuspendStatusCheck(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateLeadTimeFields(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "GetUpdateBasicDates(PROCEDURE 43)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateDates(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "InternalLeadTimeDays(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateVATOnLines(PROCEDURE 32)".



    //Unsupported feature: Code Modification on "UpdateVATOnLines(PROCEDURE 32)".

    //procedure UpdateVATOnLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    LineWasModified := false;
    if QtyType = QtyType::Shipping then
      exit;
    #4..60
                InvDiscAmount := 0;
              if QtyType = QtyType::General then
                if PurchHeader."Prices Including VAT" then begin
                  if (VATAmountLine.CalcLineAmount = 0) or ("Line Amount" = 0) then begin
                    VATAmount := 0;
                    NewAmountIncludingVAT := 0;
                  end else begin
                    VATAmount :=
                      TempVATAmountLineRemainder."VAT Amount" +
                      VATAmountLine."VAT Amount" * CalcLineAmount / VATAmountLine.CalcLineAmount;
                    NewAmountIncludingVAT :=
                      TempVATAmountLineRemainder."Amount Including VAT" +
                      VATAmountLine."Amount Including VAT" * CalcLineAmount / VATAmountLine.CalcLineAmount;
                  end;
                  NewAmount :=
                    Round(NewAmountIncludingVAT,Currency."Amount Rounding Precision") -
    #77..80
                      Currency."Amount Rounding Precision");
                end else begin
                  if "VAT Calculation Type" = "VAT Calculation Type"::"Full VAT" then begin
                    VATAmount := CalcLineAmount;
                    NewAmount := 0;
                    NewVATBaseAmount := 0;
                  end else begin
                    NewAmount := CalcLineAmount;
                    NewVATBaseAmount :=
                      Round(
                        NewAmount * (1 - PurchHeader."VAT Base Discount %" / 100),
    #92..99
                  NewAmountIncludingVAT := NewAmount + Round(VATAmount,Currency."Amount Rounding Precision");
                end
              else begin
                if VATAmountLine.CalcLineAmount = 0 then
                  VATDifference := 0
                else
                  VATDifference :=
                    TempVATAmountLineRemainder."VAT Difference" +
                    VATAmountLine."VAT Difference" * (LineAmountToInvoice - InvDiscAmount) / VATAmountLine.CalcLineAmount;
                if LineAmountToInvoice = 0 then
                  "VAT Difference" := 0
                else
    #112..135
          end;
        until Next = 0;
    end;

    OnAfterUpdateVATOnLines(PurchHeader,PurchLine,VATAmountLine,QtyType);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..63
                  if (VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount" = 0) or
                     ("Line Amount" = 0)
                  then begin
    #65..69
                      VATAmountLine."VAT Amount" *
                      ("Line Amount" - "Inv. Discount Amount") /
                      (VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount");
                    NewAmountIncludingVAT :=
                      TempVATAmountLineRemainder."Amount Including VAT" +
                      VATAmountLine."Amount Including VAT" *
                      ("Line Amount" - "Inv. Discount Amount") /
                      (VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount");
    #74..83
                    VATAmount := "Line Amount" - "Inv. Discount Amount";
    #85..87
                    NewAmount := "Line Amount" - "Inv. Discount Amount";
    #89..102
                if (VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount") = 0 then
    #104..107
                    VATAmountLine."VAT Difference" * (LineAmountToInvoice - InvDiscAmount) /
                    (VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount");
    #109..138
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CalcVATAmountLines(PROCEDURE 24)".



    //Unsupported feature: Code Modification on "CalcVATAmountLines(PROCEDURE 24)".

    //procedure CalcVATAmountLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if IsCalcVATAmountLinesHandled(PurchHeader,PurchLine,VATAmountLine) then
      exit;

    Currency.Initialize(PurchHeader."Currency Code");

    VATAmountLine.DeleteAll;
    #7..97
        VATAmountLine."Calculated VAT Amount" += TotalVATAmount;
        VATAmountLine.Modify;
      end;

    OnAfterCalcVATAmountLines(PurchHeader,PurchLine,VATAmountLine,QtyType);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #4..100
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateWithWarehouseReceive(PROCEDURE 41)".



    //Unsupported feature: Code Modification on "UpdateWithWarehouseReceive(PROCEDURE 41)".

    //procedure UpdateWithWarehouseReceive();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Type = Type::Item then
      case true of
        ("Document Type" in ["Document Type"::Quote,"Document Type"::Order]) and (Quantity >= 0):
    #4..20
          else
            Validate("Return Qty. to Ship","Outstanding Quantity");
      end;

    GetPurchHeader;
    OnAfterUpdateWithWarehouseReceive(PurchHeader,Rec);

    SetDefaultQuantity;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..23
    SetDefaultQuantity;
    */
    //end;


    //Unsupported feature: Code Modification on "GetOverheadRateFCY(PROCEDURE 40)".

    //procedure GetOverheadRateFCY();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Prod. Order No." = '' then
      QtyPerUOM := "Qty. per Unit of Measure"
    else begin
      GetItem(Item);
      QtyPerUOM := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
    end;

    exit(
      CurrExchRate.ExchangeAmtLCYToFCY(
        GetDate,"Currency Code","Overhead Rate" * QtyPerUOM,PurchHeader."Currency Factor"));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      GetItem;
    #5..10
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetItemTranslation(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "AdjustDateFormula(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "RowID1(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "IsInbound(PROCEDURE 75)".


    //Unsupported feature: Property Modification (Attributes) on "CrossReferenceNoLookUp(PROCEDURE 51)".



    //Unsupported feature: Code Modification on "CrossReferenceNoLookUp(PROCEDURE 51)".

    //procedure CrossReferenceNoLookUp();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Type = Type::Item then begin
      GetPurchHeader;
      ItemCrossReference.Reset;
    #4..7
        ItemCrossReference."Cross-Reference Type"::" ");
      ItemCrossReference.SetFilter("Cross-Reference Type No.",'%1|%2',PurchHeader."Buy-from Vendor No.",'');
      if PAGE.RunModal(PAGE::"Cross Reference List",ItemCrossReference) = ACTION::LookupOK then begin
        "Cross-Reference No." := ItemCrossReference."Cross-Reference No.";
        ValidateCrossReferenceNo(ItemCrossReference,false);
        Validate("Cross-Reference No.",ItemCrossReference."Cross-Reference No.");
        PurchPriceCalcMgt.FindPurchLinePrice(PurchHeader,Rec,FieldNo("Cross-Reference No."));
        PurchPriceCalcMgt.FindPurchLineLineDisc(PurchHeader,Rec);
        Validate("Direct Unit Cost");
      end;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
    #13..18
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ItemExists(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "CalcPrepaymentToDeduct(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "IsFinalInvoice(PROCEDURE 116)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountToHandle(PROCEDURE 117)".



    //Unsupported feature: Code Modification on "GetLineAmountToHandle(PROCEDURE 117)".

    //procedure GetLineAmountToHandle();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Line Discount %" = 100 then
      exit(0);

    GetPurchHeader;

    if "Prepmt Amt to Deduct" = 0 then
      LineAmount := Round(QtyToHandle * "Direct Unit Cost",Currency."Amount Rounding Precision")
    else begin
    #9..14
    else
      LineDiscAmount := "Line Discount Amount";

    OnAfterGetLineAmountToHandle(Rec,QtyToHandle,LineAmount,LineDiscAmount);
    exit(LineAmount - LineDiscAmount);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    #6..17
    exit(LineAmount - LineDiscAmount);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "JobTaskIsSet(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "CreateTempJobJnlLine(PROCEDURE 55)".



    //Unsupported feature: Code Modification on "CreateTempJobJnlLine(PROCEDURE 55)".

    //procedure CreateTempJobJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeCreateTempJobJnlLine(TempJobJnlLine,Rec,xRec,GetPrices,CurrFieldNo);

    GetPurchHeader;
    Clear(TempJobJnlLine);
    TempJobJnlLine.DontCheckStdCost;
    #6..36
      TempJobJnlLine.Validate("Unit Cost (LCY)","Unit Cost (LCY)");

    OnAfterCreateTempJobJnlLine(TempJobJnlLine,Rec,xRec,GetPrices,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #3..39
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateJobPrices(PROCEDURE 69)".


    //Unsupported feature: Property Modification (Attributes) on "JobSetCurrencyFactor(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "SetUpdateFromVAT(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToReceive2(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "ClearQtyIfBlank(PROCEDURE 88)".


    //Unsupported feature: Property Modification (Attributes) on "ShowLineComments(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "SetDefaultQuantity(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePrePaymentAmounts(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "SetVendorItemNo(PROCEDURE 64)".



    //Unsupported feature: Code Modification on "SetVendorItemNo(PROCEDURE 64)".

    //procedure SetVendorItemNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetItem(Item);
    ItemVend.Init;
    ItemVend."Vendor No." := "Buy-from Vendor No.";
    ItemVend."Variant Code" := "Variant Code";
    Item.FindItemVend(ItemVend,"Location Code");
    Validate("Vendor Item No.",ItemVend."Vendor Item No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GetItem;
    #2..6
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ZeroAmountLine(PROCEDURE 66)".


    //Unsupported feature: Property Modification (Attributes) on "FilterLinesWithItemToPlan(PROCEDURE 70)".



    //Unsupported feature: Code Modification on "FilterLinesWithItemToPlan(PROCEDURE 70)".

    //procedure FilterLinesWithItemToPlan();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Reset;
    SetCurrentKey("Document Type",Type,"No.","Variant Code","Drop Shipment","Location Code","Expected Receipt Date");
    SetRange("Document Type",DocumentType);
    #4..9
    SetFilter("Shortcut Dimension 1 Code",Item.GetFilter("Global Dimension 1 Filter"));
    SetFilter("Shortcut Dimension 2 Code",Item.GetFilter("Global Dimension 2 Filter"));
    SetFilter("Outstanding Qty. (Base)",'<>0');

    OnAfterFilterLinesWithItemToPlan(Rec,Item);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "FindLinesWithItemToPlan(PROCEDURE 68)".


    //Unsupported feature: Property Modification (Attributes) on "LinesWithItemToPlanExist(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "GetVPGInvRoundAcc(PROCEDURE 72)".


    //Unsupported feature: Property Modification (Attributes) on "IsReceivedShippedItemDimChanged(PROCEDURE 89)".


    //Unsupported feature: Property Modification (Attributes) on "ConfirmReceivedShippedItemDimChange(PROCEDURE 90)".



    //Unsupported feature: Code Modification on "ConfirmReceivedShippedItemDimChange(PROCEDURE 90)".

    //procedure ConfirmReceivedShippedItemDimChange();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if not ConfirmManagement.ConfirmProcess(StrSubstNo(Text049,TableCaption),true) then
      Error(Text050);

    exit(true);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if not Confirm(Text049,true,TableCaption) then
    #2..4
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitType(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "CheckLocationOnWMS(PROCEDURE 79)".



    //Unsupported feature: Code Modification on "CalcTotalAmtToAssign(PROCEDURE 84)".

    //procedure CalcTotalAmtToAssign();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TotalAmtToAssign := CalcLineAmount * TotalQtyToAssign / Quantity;

    if PurchHeader."Prices Including VAT" then
      TotalAmtToAssign := TotalAmtToAssign / (1 + "VAT %" / 100) - "VAT Difference";

    TotalAmtToAssign := Round(TotalAmtToAssign,Currency."Amount Rounding Precision");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TotalAmtToAssign := ("Line Amount" - "Inv. Discount Amount") * TotalQtyToAssign / Quantity;
    #2..6
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "HasTypeToFillMandatoryFields(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "GetDeferralAmount(PROCEDURE 105)".



    //Unsupported feature: Code Modification on "GetDeferralAmount(PROCEDURE 105)".

    //procedure GetDeferralAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "VAT Base Amount" <> 0 then
      DeferralAmount := "VAT Base Amount"
    else
      DeferralAmount := CalcLineAmount;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      DeferralAmount := "Line Amount" - "Inv. Discount Amount";
    */
    //end;


    //Unsupported feature: Code Modification on "InitDeferralCode(PROCEDURE 112)".

    //procedure InitDeferralCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Document Type" in
       ["Document Type"::Order,"Document Type"::Invoice,"Document Type"::"Credit Memo","Document Type"::"Return Order"]
    then
      case Type of
        Type::"G/L Account":
          Validate("Deferral Code",GLAcc."Default Deferral Template Code");
        Type::Item:
          begin
            GetItem(Item);
            Validate("Deferral Code",Item."Default Deferral Template Code");
          end;
      end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
          Validate("Deferral Code",Item."Default Deferral Template Code");
      end;
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "DefaultDeferralCode(PROCEDURE 110)".



    //Unsupported feature: Code Modification on "DefaultDeferralCode(PROCEDURE 110)".

    //procedure DefaultDeferralCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    case Type of
      Type::"G/L Account":
        begin
          GLAcc.Get("No.");
          InitDeferralCode;
        end;
      Type::Item:
        begin
          GetItem(Item);
          InitDeferralCode;
        end;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
          GetItem;
    #10..12
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "IsCreditDocType(PROCEDURE 83)".


    //Unsupported feature: Property Modification (Attributes) on "IsInvoiceDocType(PROCEDURE 91)".


    //Unsupported feature: Property Modification (Attributes) on "CanEditUnitOfMeasureCode(PROCEDURE 115)".


    //Unsupported feature: Property Modification (Attributes) on "TestItemFields(PROCEDURE 93)".


    //Unsupported feature: Property Modification (Attributes) on "ClearPurchaseHeader(PROCEDURE 120)".


    //Unsupported feature: Property Modification (Attributes) on "FormatType(PROCEDURE 149)".


    //Unsupported feature: Property Modification (Attributes) on "RenameNo(PROCEDURE 133)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignFieldsForNo(PROCEDURE 122)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignHeaderValues(PROCEDURE 134)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignStdTxtValues(PROCEDURE 135)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignGLAccountValues(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemValues(PROCEDURE 136)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemChargeValues(PROCEDURE 137)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignFixedAssetValues(PROCEDURE 140)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemUOM(PROCEDURE 118)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateDirectUnitCost(PROCEDURE 126)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateDirectUnitCost(PROCEDURE 127)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeVerifyReservedQty(PROCEDURE 113)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitOutstandingAmount(PROCEDURE 109)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToInvoice(PROCEDURE 128)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToShip(PROCEDURE 129)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToReceive(PROCEDURE 130)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetDefaultQuantity(PROCEDURE 150)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 131)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateAmounts(PROCEDURE 121)".


    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "IsInventoriableItem(PROCEDURE 87)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateAmountsDone(PROCEDURE 87)".


    //Unsupported feature: Property Deletion (Local) on "OnAfterUpdateAmountsDone(PROCEDURE 87)".


    //Unsupported feature: Property Modification (Name) on "OnAfterUpdateAmountsDone(PROCEDURE 87)".



    //Unsupported feature: Code Modification on "OnAfterUpdateAmountsDone(PROCEDURE 87)".

    //procedure OnAfterUpdateAmountsDone();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if Type <> Type::Item then
      exit(false);
    if "No." = '' then
      exit(false);
    //GetItem(Item);
    exit(Item.IsInventoriableType);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateUnitCost(PROCEDURE 98)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateJobPrices(PROCEDURE 106)".


    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "IsServiceItem(PROCEDURE 77)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateTotalAmounts(PROCEDURE 77)".


    //Unsupported feature: Property Deletion (Local) on "OnAfterUpdateTotalAmounts(PROCEDURE 77)".


    //Unsupported feature: Property Modification (Name) on "OnAfterUpdateTotalAmounts(PROCEDURE 77)".



    //Unsupported feature: Code Modification on "OnAfterUpdateTotalAmounts(PROCEDURE 77)".

    //procedure OnAfterUpdateTotalAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if Type <> Type::Item then
      exit(false);
    if "No." = '' then
      exit(false);
    GetItem;
    exit(Item.Type = Item.Type::Service);
    */
    //end;

    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "CalcLineAmount(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalcInvDiscToInvoice(PROCEDURE 31)".


    //Unsupported feature: Property Deletion (Local) on "OnBeforeCalcInvDiscToInvoice(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Name) on "OnBeforeCalcInvDiscToInvoice(PROCEDURE 31)".



    //Unsupported feature: Code Modification on "OnBeforeCalcInvDiscToInvoice(PROCEDURE 31)".

    //procedure OnBeforeCalcInvDiscToInvoice();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    exit("Line Amount" - "Inv. Discount Amount");
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnBeforeJobTaskIsSet(PROCEDURE 111)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateTempJobJnlLine(PROCEDURE 114)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateTypeOnCopyFromTempPurchLine(PROCEDURE 147)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnCopyFromTempPurchLine(PROCEDURE 148)".


    //Unsupported feature: Property Modification (Attributes) on "AssignedItemCharge(PROCEDURE 119)".


    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "IsNonInventoriableItem(PROCEDURE 123)".


    //Unsupported feature: Property Modification (Name) on "ShowDeferralSchedule(PROCEDURE 123)".



    //Unsupported feature: Code Modification on "ShowDeferralSchedule(PROCEDURE 123)".

    //procedure ShowDeferralSchedule();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchaseHeader.Get("Document Type","Document No.");
    ShowDeferrals(PurchaseHeader."Posting Date",PurchaseHeader."Currency Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if Type <> Type::Item then
      exit(false);
    if "No." = '' then
      exit(false);
    //GetItem(Item);
    exit(Item.IsNonInventoriableType);
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "CopyFromItem(PROCEDURE 100).Item(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "GetItem(PROCEDURE 4).Item(Parameter 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdateDirectUnitCost(PROCEDURE 2).IsHandled(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdateUnitCost(PROCEDURE 5).Item(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdateUOMQtyPerStockQty(PROCEDURE 9).Item(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "BlanketOrderLookup(PROCEDURE 36).IsHandled(Variable 1000)".


    //Unsupported feature: Deletion (ReturnValueCollection) on "ShowDimensions(PROCEDURE 25).IsChanged(ReturnValue)".


    //Unsupported feature: Deletion (VariableCollection) on "ShowDimensions(PROCEDURE 25).OldDimSetID(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "OpenItemTrackingLines(PROCEDURE 6500).IsHandled(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "GetCaptionClass(PROCEDURE 34).PurchLineCaptionClassMgmt(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "GetOverheadRateFCY(PROCEDURE 40).Item(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "SetVendorItemNo(PROCEDURE 64).Item(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "ConfirmReceivedShippedItemDimChange(PROCEDURE 90).ConfirmManagement(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "InitDeferralCode(PROCEDURE 112).Item(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "DefaultDeferralCode(PROCEDURE 110).Item(Variable 1000)".


    //Unsupported feature: Property Deletion (AsVar) on "OnAfterAssignFieldsForNo(PROCEDURE 122).xPurchLine(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnBeforeUpdateDirectUnitCost(PROCEDURE 127).Handled(Parameter 1004)".


    //Unsupported feature: Property Modification (Name) on "OnAfterCreateDimTableIDs(PROCEDURE 131).CallingFieldNo(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterUpdateAmounts(PROCEDURE 121).xPurchLine(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterUpdateAmounts(PROCEDURE 121).CurrFieldNo(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterUpdateAmountsDone(PROCEDURE 87).PurchLine(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterUpdateAmountsDone(PROCEDURE 87).xPurchLine(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterUpdateAmountsDone(PROCEDURE 87).CurrFieldNo(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterUpdateTotalAmounts(PROCEDURE 77).PurchaseLine(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterUpdateTotalAmounts(PROCEDURE 77).PurchaseLine2(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterUpdateTotalAmounts(PROCEDURE 77).TotalAmount(Parameter 1003)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterUpdateTotalAmounts(PROCEDURE 77).TotalAmountInclVAT(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterUpdateTotalAmounts(PROCEDURE 77).TotalLineAmount(Parameter 1005)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterUpdateTotalAmounts(PROCEDURE 77).TotalInvDiscAmount(Parameter 1004)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnBeforeCalcInvDiscToInvoice(PROCEDURE 31).PurchaseLine(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnBeforeCalcInvDiscToInvoice(PROCEDURE 31).CallingFieldNo(Parameter 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "ShowDeferralSchedule(PROCEDURE 123).PurchaseHeader(Variable 1000)".


    var
        ApplicationAreaSetup: Record "Application Area Setup";

    var
    //  ReturnedCrossRef: Record "Item Cross Reference";

    var
        Item: Record Item;

    var
        NonstockItemMgt: Codeunit "Catalog Item Management";
}

