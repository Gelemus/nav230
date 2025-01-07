tableextension 60273 tableextension60273 extends "Sales Header" 
{
    fields
    {

        //Unsupported feature: Code Modification on ""Sell-to Customer No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CheckCreditLimitIfLineNotInsertedYet;
            if "No." = '' then
              InitRecord;
            #4..70

            "Sell-to IC Partner Code" := Cust."IC Partner Code";
            "Send IC Document" := ("Sell-to IC Partner Code" <> '') and ("IC Direction" = "IC Direction"::Outgoing);

            if Cust."Bill-to Customer No." <> '' then
              Validate("Bill-to Customer No.",Cust."Bill-to Customer No.")
            #77..98

            if (xRec."Sell-to Customer No." <> '') and (xRec."Sell-to Customer No." <> "Sell-to Customer No.") then
              RecallModifyAddressNotification(GetModifyCustomerAddressNotificationId);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..73
            "Account No." := Cust."Account No.";
            #74..101
            */
        //end;
        field(51000;Template;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,New Conection,Tertiary Connection,Cluster Connections,Stolen Meters';
            OptionMembers = " ","New Conection","Tertiary Connection","Cluster Connections","Stolen Meters";

            trigger OnValidate()
            begin
                //added on 14/07/2020 to select items that have been ticked depending on type of connection
                SalesLine2.Reset;
                SalesLine2.SetRange("Document No.","No.");
                if SalesLine2.FindSet then
                SalesLine2.DeleteAll;

                if Template = Template::"Cluster Connections" then
                begin
                  Items.Reset;
                  Items.SetCurrentKey("Sequence Cluster Connections");
                  Items.SetRange("CLUSTER CONNECTIONS", true);
                  if Items.FindSet then
                  begin
                    repeat
                      SalesLine.Init;
                      SalesLine."Line No." := SalesLine."Line No." + 1;
                      SalesLine."Document No." := "No.";
                      SalesLine.Type := SalesLine.Type::Item;
                      SalesLine."No." := Items."No.";
                      SalesLine.Validate(SalesLine."No.");
                      SalesLine.Description := Items.Description;
                      SalesLine."Unit of Measure Code" := Items."Base Unit of Measure";
                      SalesLine."Unit Cost" := Items."Unit Cost";
                      SalesLine."Unit Price" := Items."Unit Cost";
                      SalesLine.Validate(SalesLine."Unit Price");
                      SalesLine.Quantity := Items."Cluster Quantity";
                      SalesLine.Validate(SalesLine.Quantity);
                      SalesLine."Line Amount" := SalesLine.Quantity * SalesLine."Unit Cost";
                      //SalesLine.VALIDATE(SalesLine."Line Amount" );
                      SalesLine.Insert(true);
                    until Items.Next=0;
                  end;
                end else
                if Template = Template::"New Conection" then
                begin
                  Items.Reset;
                  Items.SetCurrentKey("Sequence New Connections");
                  Items.SetRange("NEW CONNECTIONS", true);
                  if Items.FindSet then
                  begin
                    repeat
                      //MESSAGE('in%1', Items."No.");
                      SalesLine.Init;
                      SalesLine."Line No." := SalesLine."Line No." + 1;
                      SalesLine."Document No." := "No.";
                      SalesLine.Type := SalesLine.Type::Item;
                      SalesLine."No." := Items."No.";
                      SalesLine.Validate(SalesLine."No.");
                      SalesLine.Description := Items.Description;
                      SalesLine."Unit of Measure Code" := Items."Base Unit of Measure";
                      SalesLine."Unit Cost" := Round(Items."Unit Cost",1,'>');
                      SalesLine."Unit Price" := Round(Items."Unit Cost",1,'>');
                      SalesLine.Validate(SalesLine."Unit Price");
                      SalesLine.Quantity := 1;
                      SalesLine.Validate(SalesLine.Quantity);
                      SalesLine."Line Amount" := SalesLine.Quantity * SalesLine."Unit Cost";
                      //SalesLine.VALIDATE(SalesLine."Line Amount" );
                      SalesLine.Insert(true);
                    until Items.Next=0;
                  end;
                end else
                if Template = Template::"Tertiary Connection" then
                begin
                  Items.Reset;
                  Items.SetCurrentKey("Sequence Tertiary Connections");
                  Items.SetRange(TERTIARY, true);
                  if Items.FindSet then
                  begin
                    repeat
                      SalesLine.Init;
                      SalesLine."Line No." := SalesLine."Line No." + 1;
                      SalesLine."Document No." := "No.";
                      SalesLine.Type := SalesLine.Type::Item;
                      SalesLine."No." := Items."No.";
                      SalesLine.Validate(SalesLine."No.");
                      SalesLine.Description := Items.Description;
                      SalesLine."Unit of Measure Code" := Items."Base Unit of Measure";
                      SalesLine."Unit Cost" := Round(Items."Unit Cost",1,'>');
                      SalesLine."Unit Price" := Round(Items."Unit Cost",1,'>');
                      SalesLine.Validate(SalesLine."Unit Price");
                      SalesLine.Quantity := 1;
                      SalesLine.Validate(SalesLine.Quantity);
                      SalesLine."Line Amount" := SalesLine.Quantity * SalesLine."Unit Cost";
                      //SalesLine.VALIDATE(SalesLine."Line Amount" );
                      SalesLine.Insert(true);
                    until Items.Next=0;
                  end;
                end;
                if Template = Template::"Stolen Meters" then
                begin
                  Items.Reset;
                  Items.SetCurrentKey("Sequence Stolen Meter");
                  Items.SetRange("STOLEN METER", true);
                  if Items.FindSet then
                  begin
                    repeat
                      SalesLine.Init;
                      SalesLine."Line No." := SalesLine."Line No." + 1;
                      SalesLine."Document No." := "No.";
                      SalesLine.Type := SalesLine.Type::Item;
                      SalesLine."No." := Items."No.";
                      SalesLine.Validate(SalesLine."No.");
                      SalesLine.Description := Items.Description;
                      SalesLine."Unit of Measure Code" := Items."Base Unit of Measure";
                      SalesLine."Unit Cost" := Round(Items."Unit Cost",1,'>');
                      SalesLine."Unit Price" := Round(Items."Unit Cost",1,'>');
                      SalesLine.Validate(SalesLine."Unit Price");
                      SalesLine.Quantity := 1;
                      SalesLine.Validate(SalesLine.Quantity);
                      SalesLine."Line Amount" := SalesLine.Quantity * SalesLine."Unit Cost";
                      //SalesLine.VALIDATE(SalesLine."Line Amount" );
                      SalesLine.Insert(true);
                    until Items.Next=0;
                  end;
                end;
            end;
        }
        field(51001;"Account No.";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."Account No.";
        }
        field(51002;"Connection No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51003;"Chainage No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51004;"Existing Connections";Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(51005;"Requisition Created";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51006;"Created By";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51007;"Date Created";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51008;"Time Created";Time)
        {
            DataClassification = ToBeClassified;
        }
        field(51009;Submitted;Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Submitted := false;
            end;
        }
        field(51010;"Submitted BY";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(51011;"Date Submitted";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51012;"Time Submitted";Time)
        {
            DataClassification = ToBeClassified;
        }
        field(51013;"Point of Use";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(51014;"Shortcut Dimension 3 Code";Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(51015;"Shortcut Dimension 4 Code";Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(51016;"Shortcut Dimension 5 Code";Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(51017;"Shortcut Dimension 6 Code";Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(51018;"Shortcut Dimension 7 Code";Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(51019;"Shortcut Dimension 8 Code";Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        InitInsert;
        InsertMode := true;

        #4..15

        // Remove view filters so that the cards does not show filtered view notification
        SetView('');
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..18

        //added on 03/09/2020
        "Assigned User ID" := UserId;

        //added on 05/10/2022
        Employee.Reset;
        Employee.SetRange("User ID", "Assigned User ID");
        if Employee.FindSet then
        begin
          "Shortcut Dimension 1 Code" := Employee."Global Dimension 1 Code";
          "Shortcut Dimension 2 Code" := Employee."Global Dimension 2 Code";
        end;
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitInsert(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "InitRecord(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "TestNoSeries(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetNoSeriesCode(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "ConfirmDeletion(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "SalesLinesExist(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "MessageIfSalesLinesExist(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "PriceMessageIfSalesLinesExist(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateCurrencyFactor(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideValidationDialog(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "GetHideValidationDialog(PROCEDURE 123)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateSalesLines(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateSalesLinesByFieldNo(PROCEDURE 154)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "CheckCustomerCreated(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "CheckCreditMaxBeforeInsert(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "CreateInvtPutAwayPick(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "CreateTask(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateShipToAddress(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDocDim(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAllLineDim(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "LookupAdjmtValueEntries(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomerVATRegistrationNumber(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomerVATRegistrationNumberLbl(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomerGlobalLocationNumber(PROCEDURE 164)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomerGlobalLocationNumberLbl(PROCEDURE 161)".


    //Unsupported feature: Property Modification (Attributes) on "GetPstdDocLinesToRevere(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "CalcInvDiscForHeader(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "SetSecurityFilterOnRespCenter(PROCEDURE 43)".


    //Unsupported feature: Property Modification (Attributes) on "InventoryPickConflict(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "WhseShpmntConflict(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "CheckItemAvailabilityInLines(PROCEDURE 142)".


    //Unsupported feature: Property Modification (Attributes) on "QtyToShipIsZero(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "IsApprovedForPosting(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "IsApprovedForPostingBatch(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "GetLegalStatement(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "SendToPosting(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "CancelBackgroundPosting(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "EmailRecords(PROCEDURE 135)".


    //Unsupported feature: Property Modification (Attributes) on "GetDocTypeTxt(PROCEDURE 140)".


    //Unsupported feature: Property Modification (Attributes) on "LinkSalesDocWithOpportunity(PROCEDURE 79)".


    //Unsupported feature: Property Modification (Attributes) on "SynchronizeAsmHeader(PROCEDURE 56)".


    //Unsupported feature: Property Modification (Attributes) on "CheckShippingAdvice(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "TryGetFilterCustNoRange(PROCEDURE 128)".


    //Unsupported feature: Property Modification (Attributes) on "InvoicedLineExists(PROCEDURE 156)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDimSetForPrepmtAccDefaultDim(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "OpenSalesOrderStatistics(PROCEDURE 70)".


    //Unsupported feature: Property Modification (Attributes) on "GetCardpageID(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "CheckAvailableCreditLimit(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "SetStatus(PROCEDURE 99)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckSalesPostRestrictions(PROCEDURE 115)".


    //Unsupported feature: Property Modification (Attributes) on "OnCustomerCreditLimitExceeded(PROCEDURE 74)".


    //Unsupported feature: Property Modification (Attributes) on "OnCustomerCreditLimitNotExceeded(PROCEDURE 76)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckSalesReleaseRestrictions(PROCEDURE 81)".


    //Unsupported feature: Property Modification (Attributes) on "CheckSalesReleaseRestrictions(PROCEDURE 162)".


    //Unsupported feature: Property Modification (Attributes) on "DeferralHeadersExist(PROCEDURE 82)".


    //Unsupported feature: Property Modification (Attributes) on "SetSellToCustomerFromFilter(PROCEDURE 186)".


    //Unsupported feature: Property Modification (Attributes) on "CopySellToCustomerFilter(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "BatchConfirmUpdateDeferralDate(PROCEDURE 130)".


    //Unsupported feature: Property Modification (Attributes) on "GetSelectedPaymentServicesText(PROCEDURE 84)".


    //Unsupported feature: Property Modification (Attributes) on "SetDefaultPaymentServices(PROCEDURE 86)".


    //Unsupported feature: Property Modification (Attributes) on "ChangePaymentServiceSetting(PROCEDURE 87)".


    //Unsupported feature: Property Modification (Attributes) on "IsCreditDocType(PROCEDURE 110)".


    //Unsupported feature: Property Modification (Attributes) on "HasSellToAddress(PROCEDURE 94)".


    //Unsupported feature: Property Modification (Attributes) on "HasShipToAddress(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "HasBillToAddress(PROCEDURE 95)".


    //Unsupported feature: Property Modification (Attributes) on "SetShipToAddress(PROCEDURE 117)".


    //Unsupported feature: Property Modification (Attributes) on "ShipToAddressEqualsSellToAddress(PROCEDURE 111)".


    //Unsupported feature: Property Modification (Attributes) on "CopySellToAddressToShipToAddress(PROCEDURE 112)".


    //Unsupported feature: Property Modification (Attributes) on "CopySellToAddressToBillToAddress(PROCEDURE 92)".


    //Unsupported feature: Property Modification (Attributes) on "ConfirmCloseUnposted(PROCEDURE 104)".


    //Unsupported feature: Property Modification (Attributes) on "InitFromSalesHeader(PROCEDURE 109)".


    //Unsupported feature: Property Modification (Attributes) on "SetWorkDescription(PROCEDURE 120)".


    //Unsupported feature: Property Modification (Attributes) on "GetWorkDescription(PROCEDURE 114)".


    //Unsupported feature: Property Modification (Attributes) on "GetWorkDescriptionWorkDescriptionCalculated(PROCEDURE 160)".


    //Unsupported feature: Property Modification (Attributes) on "SetAllowSelectNoSeries(PROCEDURE 100)".


    //Unsupported feature: Property Modification (Attributes) on "SelltoCustomerNoOnAfterValidate(PROCEDURE 125)".


    //Unsupported feature: Property Modification (Attributes) on "SelectSalesHeaderCustomerTemplate(PROCEDURE 127)".


    //Unsupported feature: Property Modification (Attributes) on "RecallModifyAddressNotification(PROCEDURE 148)".


    //Unsupported feature: Property Modification (Attributes) on "GetModifyCustomerAddressNotificationId(PROCEDURE 193)".


    //Unsupported feature: Property Modification (Attributes) on "GetModifyBillToCustomerAddressNotificationId(PROCEDURE 191)".


    //Unsupported feature: Property Modification (Attributes) on "SetModifyCustomerAddressNotificationDefaultState(PROCEDURE 89)".


    //Unsupported feature: Property Modification (Attributes) on "SetModifyBillToCustomerAddressNotificationDefaultState(PROCEDURE 91)".


    //Unsupported feature: Property Modification (Attributes) on "DontNotifyCurrentUserAgain(PROCEDURE 141)".


    //Unsupported feature: Property Modification (Attributes) on "HasDifferentSellToAddress(PROCEDURE 195)".


    //Unsupported feature: Property Modification (Attributes) on "HasDifferentBillToAddress(PROCEDURE 192)".


    //Unsupported feature: Property Modification (Attributes) on "HasDifferentShipToAddress(PROCEDURE 1059)".


    //Unsupported feature: Property Modification (Attributes) on "ShowInteractionLogEntries(PROCEDURE 131)".


    //Unsupported feature: Property Modification (Attributes) on "GetBillToNo(PROCEDURE 132)".


    //Unsupported feature: Property Modification (Attributes) on "GetCurrencySymbol(PROCEDURE 146)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateSalesPersonOnSalesHeader(PROCEDURE 218)".


    //Unsupported feature: Property Modification (Attributes) on "TestQuantityShippedField(PROCEDURE 190)".


    //Unsupported feature: Property Modification (Attributes) on "TestStatusOpen(PROCEDURE 134)".


    //Unsupported feature: Property Modification (Attributes) on "SuspendStatusCheck(PROCEDURE 133)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitRecord(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitNoSeries(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckCreditLimitCondition(PROCEDURE 290)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterConfirmSalesPrice(PROCEDURE 183)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterRecreateSalesLine(PROCEDURE 152)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterDeleteAllTempSalesLines(PROCEDURE 155)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInsertTempSalesLine(PROCEDURE 158)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetNoSeriesCode(PROCEDURE 166)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetPostingNoSeriesCode(PROCEDURE 175)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetPrepaymentPostingNoSeriesCode(PROCEDURE 178)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestNoSeries(PROCEDURE 136)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateShipToAddress(PROCEDURE 137)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateCurrencyFactor(PROCEDURE 180)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAppliesToDocNoOnLookup(PROCEDURE 163)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateSalesLineByChangedFieldName(PROCEDURE 139)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateShortcutDimCode(PROCEDURE 176)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateSalesLine(PROCEDURE 147)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSalesQuoteAccepted(PROCEDURE 143)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterChangePricesIncludingVAT(PROCEDURE 187)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSendSalesHeader(PROCEDURE 144)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetFieldsBilltoCustomer(PROCEDURE 151)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTransferExtendedTextForSalesLineRecreation(PROCEDURE 145)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromSellToCustTemplate(PROCEDURE 184)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopySellToAddressToShipToAddress(PROCEDURE 198)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopySellToAddressToBillToAddress(PROCEDURE 200)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopySellToCustomerAddressFieldsFromCustomer(PROCEDURE 177)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyShipToCustomerAddressFieldsFromCustomer(PROCEDURE 173)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyShipToCustomerAddressFieldsFromShipToAddr(PROCEDURE 174)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckCreditLimit(PROCEDURE 196)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetNoSeriesCode(PROCEDURE 309)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetPostingNoSeriesCode(PROCEDURE 212)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInitInsert(PROCEDURE 208)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInitRecord(PROCEDURE 210)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateCurrencyFactor(PROCEDURE 153)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeRecreateSalesLines(PROCEDURE 197)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSalesLineByChangedFieldNo(PROCEDURE 168)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSalesLineInsert(PROCEDURE 169)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestNoSeries(PROCEDURE 213)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSetSecurityFilterOnRespCenter(PROCEDURE 207)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateSalesLinesByFieldNo(PROCEDURE 303)".


    //Unsupported feature: Property Modification (Attributes) on "OnCopySelltoCustomerAddressFieldsFromCustomerOnAfterAssignRespCenter(PROCEDURE 182)".


    //Unsupported feature: Property Modification (Attributes) on "OnCreateSalesLineOnAfterAssignType(PROCEDURE 185)".


    //Unsupported feature: Property Modification (Attributes) on "OnInitInsertOnBeforeInitRecord(PROCEDURE 179)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateBillToCustOnAfterSalesQuote(PROCEDURE 188)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateBilltoCustomerTemplateCodeBeforeRecreateSalesLines(PROCEDURE 171)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateSellToCustomerNoAfterInit(PROCEDURE 206)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestQuantityShippedField(PROCEDURE 189)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestStatusOpen(PROCEDURE 202)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestStatusOpen(PROCEDURE 201)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateBillToCont(PROCEDURE 199)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateSellToCont(PROCEDURE 203)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateSellToCust(PROCEDURE 204)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateSalesLines(PROCEDURE 205)".


    //Unsupported feature: Property Modification (Attributes) on "OnRecreateSalesLinesOnBeforeConfirm(PROCEDURE 211)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePricesIncludingVATOnBeforeSalesLineModify(PROCEDURE 214)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateShippingAgentCodeOnBeforeUpdateLines(PROCEDURE 215)".


    //Unsupported feature: Property Modification (Fields) on "Brick(FieldGroup 1)".


    var
        SalesLine2: Record "Sales Line";

    var
        Items: Record Item;
        Employee: Record Employee;
}

