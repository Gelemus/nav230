table 50017 "Journal Voucher Lines"
{

    fields
    {
        field(9; "JV No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(11; "Account Type"; Option)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;

            trigger OnValidate()
            begin
                if ("Account Type" in ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Fixed Asset",
                                       "Account Type"::"IC Partner", "Account Type"::Employee]) and
                   ("Bal. Account Type" in ["Bal. Account Type"::Customer, "Bal. Account Type"::Vendor, "Bal. Account Type"::"Fixed Asset",
                                            "Bal. Account Type"::"IC Partner", "Bal. Account Type"::Employee])
                then
                    Error(
                      Text000,
                      FieldCaption("Account Type"), FieldCaption("Bal. Account Type"));

                if ("Account Type" = "Account Type"::Employee) and ("Currency Code" <> '') then
                    Error(OnlyLocalCurrencyForEmployeeErr);

                Validate("Account No.", '');
                Validate(Description, '');

                if "Account Type" in ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Bank Account", "Account Type"::Employee] then begin

                end else
                    if "Bal. Account Type" in [
                                               "Bal. Account Type"::"G/L Account", "Account Type"::"Bank Account", "Bal. Account Type"::"Fixed Asset"]
                    then

                        //UpdateSource;

                        if ("Account Type" <> "Account Type"::"Fixed Asset") and
                   ("Bal. Account Type" <> "Bal. Account Type"::"Fixed Asset")
                then begin
                            "Depreciation Book Code" := '';
                            Validate("FA Posting Type", "FA Posting Type"::" ");
                        end;
                if xRec."Account Type" in
                   [xRec."Account Type"::Customer, xRec."Account Type"::Vendor]
                then begin

                end;
            end;
        }
        field(12; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false))
            ELSE IF ("Account Type" = CONST(Customer)) Customer
            ELSE IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE IF ("Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE IF ("Account Type" = CONST(Employee)) Employee;

            trigger OnValidate()
            begin
                "Account Name" := '';

                if "Account Type" = "Account Type"::"G/L Account" then begin
                    GLAccount.Reset;
                    GLAccount.SetRange(GLAccount."No.", "Account No.");
                    if GLAccount.FindFirst then begin
                        "Account Name" := GLAccount.Name;
                    end;
                end;


                if "Account Type" = "Account Type"::Customer then begin
                    CustomerCard.Reset;
                    CustomerCard.SetRange(CustomerCard."No.", "Account No.");
                    if CustomerCard.FindFirst then begin
                        "Account Name" := CustomerCard.Name;
                    end;
                end;


                if "Account Type" = "Account Type"::Vendor then begin
                    VendorCard.Reset;
                    VendorCard.SetRange(VendorCard."No.", "Account No.");
                    if VendorCard.FindFirst then begin
                        "Account Name" := VendorCard.Name;
                    end;
                end;

                if "Account Type" = "Account Type"::"Fixed Asset" then begin
                    FixedAsset.Reset;
                    FixedAsset.SetRange(FixedAsset."No.", "Account No.");
                    if FixedAsset.FindFirst then begin
                        "Account Name" := FixedAsset.Description;
                    end;
                end;

                if "Account Type" = "Account Type"::"Bank Account" then begin
                    BankAccount.Reset;
                    BankAccount.SetRange(BankAccount."No.", "Account No.");
                    if BankAccount.FindFirst then begin
                        "Account Name" := BankAccount.Name;
                    end;
                end;

                //adde on 03/09/2020
                if "Account Type" = "Account Type"::Employee then begin

                    Employee.Reset;
                    Employee.SetRange(Employee."No.", "Account No.");
                    if Employee.FindFirst then begin
                        "Account Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                        //updated on 9/5/2023
                        "Shortcut Dimension 1 Code" := Employee."Global Dimension 1 Code";
                        "Shortcut Dimension 2 Code" := Employee."Global Dimension 2 Code";
                        //
                    end;
                end;
            end;
        }
        field(13; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ClosingDates = true;
            DataClassification = ToBeClassified;
        }
        field(14; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;

            trigger OnValidate()
            var
                Cust: Record Customer;
                Vend: Record Vendor;
            begin
            end;
        }
        field(15; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(16; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(17; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(18; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                               Blocked = CONST(false))
            ELSE IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE IF ("Bal. Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE IF ("Bal. Account Type" = CONST(Employee)) Employee;

            trigger OnValidate()
            begin
                "Bal. Account Name" := '';

                if "Bal. Account Type" = "Bal. Account Type"::"G/L Account" then begin
                    GLAccount.Reset;
                    GLAccount.SetRange(GLAccount."No.", "Bal. Account No.");
                    if GLAccount.FindFirst then begin
                        "Bal. Account Name" := GLAccount.Name;
                    end;
                end;


                if "Bal. Account Type" = "Bal. Account Type"::Customer then begin
                    CustomerCard.Reset;
                    CustomerCard.SetRange(CustomerCard."No.", "Bal. Account No.");
                    if CustomerCard.FindFirst then begin
                        "Bal. Account Name" := CustomerCard.Name;
                    end;
                end;


                if "Bal. Account Type" = "Bal. Account Type"::Vendor then begin
                    VendorCard.Reset;
                    VendorCard.SetRange(VendorCard."No.", "Bal. Account No.");
                    if VendorCard.FindFirst then begin
                        "Bal. Account Name" := VendorCard.Name;
                    end;
                end;

                if "Bal. Account Type" = "Bal. Account Type"::"Fixed Asset" then begin
                    FixedAsset.Reset;
                    FixedAsset.SetRange(FixedAsset."No.", "Bal. Account No.");
                    if FixedAsset.FindFirst then begin
                        "Bal. Account Name" := FixedAsset.Description;
                    end;
                end;

                if "Bal. Account Type" = "Bal. Account Type"::"Bank Account" then begin
                    BankAccount.Reset;
                    BankAccount.SetRange(BankAccount."No.", "Bal. Account No.");
                    if BankAccount.FindFirst then begin
                        "Bal. Account Name" := BankAccount.Name;
                    end;
                end;
            end;
        }
        field(19; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency;

            trigger OnValidate()
            var
                BankAcc: Record "Bank Account";
            begin
            end;
        }
        field(20; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(21; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GetCurrency;
                "Debit Amount" := Round("Debit Amount", Currency."Amount Rounding Precision");
                if ("Credit Amount" = 0) or ("Debit Amount" <> 0) then begin
                    Amount := "Debit Amount";
                    Validate(Amount);
                end;
            end;
        }
        field(22; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GetCurrency;
                "Credit Amount" := Round("Credit Amount", Currency."Amount Rounding Precision");
                if ("Debit Amount" = 0) or ("Credit Amount" <> 0) then begin
                    Amount := -"Credit Amount";
                    Validate(Amount);
                end;
            end;
        }
        field(23; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*IF "Currency Code" = '' THEN BEGIN
                  Amount := "Amount (LCY)";
                  VALIDATE(Amount);
                END ELSE BEGIN
                  IF CheckFixedCurrency THEN BEGIN
                    GetCurrency;
                    Amount := ROUND(
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          "Posting Date","Currency Code",
                          "Amount (LCY)","Currency Factor"),
                        Currency."Amount Rounding Precision")
                  END ELSE BEGIN
                    TESTFIELD("Amount (LCY)");
                    TESTFIELD(Amount);
                    "Currency Factor" := Amount / "Amount (LCY)";
                  END;
                
                  VALIDATE("VAT %");
                  VALIDATE("Bal. VAT %");
                  UpdateLineBalance;
                END;
                */

            end;
        }
        field(24; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Balance (LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                if ("Currency Code" = '') and ("Currency Factor" <> 0) then
                    FieldError("Currency Factor", StrSubstNo(Text002, FieldCaption("Currency Code")));
                Validate(Amount);
            end;
        }
        field(26; "Shortcut Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
        }
        field(27; "Shortcut Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
        }
        field(28; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;

            trigger OnValidate()
            begin
                if "Applies-to Doc. Type" <> xRec."Applies-to Doc. Type" then
                    Validate("Applies-to Doc. No.", '');
            end;
        }
        field(29; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
                AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
                AccNo: Code[20];
            begin
                xRec.Amount := Amount;
                xRec."Currency Code" := "Currency Code";
                xRec."Posting Date" := "Posting Date";

                /*//GetAccTypeAndNo(Rec,AccType,AccNo);
                CLEAR(CustLedgEntry);
                CLEAR(VendLedgEntry);
                
                CASE AccType OF
                  AccType::Customer:
                    LookUpAppliesToDocCust(AccNo);
                  AccType::Vendor:
                    LookUpAppliesToDocVend(AccNo);
                  AccType::Employee:
                    LookUpAppliesToDocEmpl(AccNo);
                END;
                SetJournalLineFieldsFromApplication;
                
                IF xRec.Amount <> 0 THEN
                  IF NOT PaymentToleranceMgt.PmtTolGenJnl(Rec) THEN
                    EXIT;
                
                IF "Applies-to Doc. Type" = "Applies-to Doc. Type"::Invoice THEN
                  UpdateAppliesToInvoiceID;
                  */

            end;

            trigger OnValidate()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                VendLedgEntry: Record "Vendor Ledger Entry";
                TempGenJnlLine: Record "Gen. Journal Line" temporary;
            begin
                /*IF "Applies-to Doc. No." <> xRec."Applies-to Doc. No." THEN
                  //ClearCustVendApplnEntry;
                
                IF ("Applies-to Doc. No." = '') AND (xRec."Applies-to Doc. No." <> '') THEN BEGIN
                  PaymentToleranceMgt.DelPmtTolApllnDocNo(Rec,xRec."Applies-to Doc. No.");
                
                  TempGenJnlLine := Rec;
                  IF (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Customer) OR
                     (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Vendor) OR
                     (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Employee)
                  THEN
                    CODEUNIT.RUN(CODEUNIT::"Exchange Acc. G/L Journal Line",TempGenJnlLine);
                
                  CASE TempGenJnlLine."Account Type" OF
                    TempGenJnlLine."Account Type"::Customer:
                      BEGIN
                        CustLedgEntry.SETCURRENTKEY("Document No.");
                        CustLedgEntry.SETRANGE("Document No.",xRec."Applies-to Doc. No.");
                        IF NOT (xRec."Applies-to Doc. Type" = "Document Type"::" ") THEN
                          CustLedgEntry.SETRANGE("Document Type",xRec."Applies-to Doc. Type");
                        CustLedgEntry.SETRANGE("Customer No.",TempGenJnlLine."Account No.");
                        CustLedgEntry.SETRANGE(Open,TRUE);
                        IF CustLedgEntry.FINDFIRST THEN BEGIN
                          IF CustLedgEntry."Amount to Apply" <> 0 THEN  BEGIN
                            CustLedgEntry."Amount to Apply" := 0;
                            CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit",CustLedgEntry);
                          END;
                          "Exported to Payment File" := CustLedgEntry."Exported to Payment File";
                          "Applies-to Ext. Doc. No." := '';
                        END;
                      END;
                    TempGenJnlLine."Account Type"::Vendor:
                      BEGIN
                        VendLedgEntry.SETCURRENTKEY("Document No.");
                        VendLedgEntry.SETRANGE("Document No.",xRec."Applies-to Doc. No.");
                        IF NOT (xRec."Applies-to Doc. Type" = "Document Type"::" ") THEN
                          VendLedgEntry.SETRANGE("Document Type",xRec."Applies-to Doc. Type");
                        VendLedgEntry.SETRANGE("Vendor No.",TempGenJnlLine."Account No.");
                        VendLedgEntry.SETRANGE(Open,TRUE);
                        IF VendLedgEntry.FINDFIRST THEN BEGIN
                          IF VendLedgEntry."Amount to Apply" <> 0 THEN  BEGIN
                            VendLedgEntry."Amount to Apply" := 0;
                            CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",VendLedgEntry);
                          END;
                          "Exported to Payment File" := VendLedgEntry."Exported to Payment File";
                        END;
                        "Applies-to Ext. Doc. No." := '';
                      END;
                    TempGenJnlLine."Account Type"::Employee:
                      BEGIN
                        EmplLedgEntry.SETCURRENTKEY("Document No.");
                        EmplLedgEntry.SETRANGE("Document No.",xRec."Applies-to Doc. No.");
                        IF NOT (xRec."Applies-to Doc. Type" = "Document Type"::" ") THEN
                          EmplLedgEntry.SETRANGE("Document Type",xRec."Applies-to Doc. Type");
                        EmplLedgEntry.SETRANGE("Employee No.",TempGenJnlLine."Account No.");
                        EmplLedgEntry.SETRANGE(Open,TRUE);
                        IF EmplLedgEntry.FINDFIRST THEN BEGIN
                          IF EmplLedgEntry."Amount to Apply" <> 0 THEN BEGIN
                            EmplLedgEntry."Amount to Apply" := 0;
                            CODEUNIT.RUN(CODEUNIT::"Empl. Entry-Edit",EmplLedgEntry);
                          END;
                          "Exported to Payment File" := EmplLedgEntry."Exported to Payment File";
                        END;
                      END;
                  END;
                END;
                
                IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND (Amount <> 0) THEN BEGIN
                  IF xRec."Applies-to Doc. No." <> '' THEN
                    PaymentToleranceMgt.DelPmtTolApllnDocNo(Rec,xRec."Applies-to Doc. No.");
                  SetApplyToAmount;
                  PaymentToleranceMgt.PmtTolGenJnl(Rec);
                  xRec.ClearAppliedGenJnlLine;
                END;
                
                CASE "Account Type" OF
                  "Account Type"::Customer:
                    GetCustLedgerEntry;
                  "Account Type"::Vendor:
                    GetVendLedgerEntry;
                  "Account Type"::Employee:
                    GetEmplLedgerEntry;
                END;
                
                ValidateApplyRequirements(Rec);
                SetJournalLineFieldsFromApplication;
                
                IF "Applies-to Doc. Type" = "Applies-to Doc. Type"::Invoice THEN
                  UpdateAppliesToInvoiceID;
                */

            end;
        }
        field(30; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;

            trigger OnValidate()
            begin
                if ("Account Type" in ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Fixed Asset",
                                       "Account Type"::"IC Partner", "Account Type"::Employee]) and
                   ("Bal. Account Type" in ["Bal. Account Type"::Customer, "Bal. Account Type"::Vendor, "Bal. Account Type"::"Fixed Asset",
                                            "Bal. Account Type"::"IC Partner", "Bal. Account Type"::Employee])
                then
                    Error(
                      Text000,
                      FieldCaption("Account Type"), FieldCaption("Bal. Account Type"));

                if ("Bal. Account Type" = "Bal. Account Type"::Employee) and ("Currency Code" <> '') then
                    Error(OnlyLocalCurrencyForEmployeeErr);

                Validate("Bal. Account No.", '');
                if "Bal. Account Type" in
                   ["Bal. Account Type"::Customer, "Bal. Account Type"::Vendor, "Bal. Account Type"::"Bank Account", "Bal. Account Type"::Employee]
                then begin

                end else
                    if "Account Type" in [
                                          "Bal. Account Type"::"G/L Account", "Account Type"::"Bank Account", "Account Type"::"Fixed Asset"]
                    then

                        //UpdateSource;
                        if ("Account Type" <> "Account Type"::"Fixed Asset") and
                   ("Bal. Account Type" <> "Bal. Account Type"::"Fixed Asset")
                then begin
                            "Depreciation Book Code" := '';
                            Validate("FA Posting Type", "FA Posting Type"::" ");
                        end;
                if xRec."Bal. Account Type" in
                   [xRec."Bal. Account Type"::Customer, xRec."Bal. Account Type"::Vendor]
                then begin

                end;
                if ("Account Type" in [
                                       "Account Type"::"G/L Account", "Account Type"::"Bank Account", "Account Type"::"Fixed Asset"]) and
                   ("Bal. Account Type" in [
                                            "Bal. Account Type"::"G/L Account", "Bal. Account Type"::"Bank Account", "Bal. Account Type"::"Fixed Asset"])
                then
                    if "Bal. Account Type" = "Bal. Account Type"::"IC Partner" then begin

                        if GenJnlTemplate.Type <> GenJnlTemplate.Type::Intercompany then
                            FieldError("Bal. Account Type");
                    end;
                if "Bal. Account Type" <> "Bal. Account Type"::"Bank Account" then begin

                end;
            end;
        }
        field(31; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            DataClassification = ToBeClassified;
        }
        field(32; "FA Posting Date"; Date)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            Caption = 'FA Posting Date';
            DataClassification = ToBeClassified;
        }
        field(33; "FA Posting Type"; Option)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            Caption = 'FA Posting Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Acquisition Cost,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Disposal,Maintenance';
            OptionMembers = " ","Acquisition Cost",Depreciation,"Write-Down",Appreciation,"Custom 1","Custom 2",Disposal,Maintenance;

            trigger OnValidate()
            begin
                if not (("Account Type" = "Account Type"::"Fixed Asset") or
                         ("Bal. Account Type" = "Bal. Account Type"::"Fixed Asset")) and
                   ("FA Posting Type" = "FA Posting Type"::" ")
                then begin
                    "FA Posting Date" := 0D;

                end;
            end;
        }
        field(34; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            DataClassification = ToBeClassified;
            TableRelation = "Depreciation Book";

            trigger OnValidate()
            var
                FADeprBook: Record "FA Depreciation Book";
            begin
                if "Depreciation Book Code" = '' then
                    exit;

                if ("Account No." <> '') and
                   ("Account Type" = "Account Type"::"Fixed Asset")
                then begin
                    FADeprBook.Get("Account No.", "Depreciation Book Code");
                    //"Posting Group" := FADeprBook."FA Posting Group";
                end;

                if ("Bal. Account No." <> '') and
                   ("Bal. Account Type" = "Bal. Account Type"::"Fixed Asset")
                then begin
                    FADeprBook.Get("Bal. Account No.", "Depreciation Book Code");
                    //  "Posting Group" := FADeprBook."FA Posting Group";
                end;
            end;
        }
        field(35; Description2; Text[250])
        {
            Caption = 'Description2';
            DataClassification = ToBeClassified;
        }
        field(36; "Shortcut Dimension 3 Code"; Code[50])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(37; "Shortcut Dimension 4 Code"; Code[50])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(38; "Shortcut Dimension 5 Code"; Code[50])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(39; "Shortcut Dimension 6 Code"; Code[50])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(40; "Shortcut Dimension 7 Code"; Code[50])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(41; "Shortcut Dimension 8 Code"; Code[50])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(50; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Posting Group"
            ELSE IF ("Account Type" = CONST(Vendor)) "Vendor Posting Group"
            ELSE IF ("Account Type" = CONST("Fixed Asset")) "FA Posting Group";
        }
        field(60; "Account Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Bal. Account Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(100; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(101; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(102; "Posted By"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(103; "Time Posted"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(104; "Reference No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(105; "Budget GL"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." WHERE("Account Type" = CONST(Posting));
        }
    }

    keys
    {
        key(Key1; "Line No.", "JV No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //updated by Justo 05/03/2024 to check requirement for voting
        /*IF (JvHeader."Requires Voting" <> JvHeader."Requires Voting"::Yes) OR (JvHeader.Voted = FALSE) THEN
          ERROR('Kindly indicate whether the Journal voucher requires voting or no!');*/
        // JvHeader.TESTFIELD("Requires Voting");


    end;

    var
        Text000: Label '%1 or %2 must be a G/L Account or Bank Account.', Comment = '%1=Account Type,%2=Balance Account Type';
        Text001: Label 'You must not specify %1 when %2 is %3.';
        Text002: Label 'cannot be specified without %1';
        ChangeCurrencyQst: Label 'The Currency Code in the Gen. Journal Line will be changed from %1 to %2.\\Do you want to continue?', Comment = '%1=FromCurrencyCode, %2=ToCurrencyCode';
        UpdateInterruptedErr: Label 'The update has been interrupted to respect the warning.';
        Text006: Label 'The %1 option can only be used internally in the system.';
        Text007: Label '%1 or %2 must be a bank account.', Comment = '%1=Account Type,%2=Balance Account Type';
        Text008: Label ' must be 0 when %1 is %2.';
        Text009: Label 'LCY';
        Text010: Label '%1 must be %2 or %3.';
        Text011: Label '%1 must be negative.';
        Text012: Label '%1 must be positive.';
        Text013: Label 'The %1 must not be more than %2.';
        Text014: Label 'The %1 %2 has a %3 %4.\\Do you still want to use %1 %2 in this journal line?', Comment = '%1=Caption of Table Customer, %2=Customer No, %3=Caption of field Bill-to Customer No, %4=Value of Bill-to customer no.';
        Text015: Label 'You are not allowed to apply and post an entry to an entry with an earlier posting date.\\Instead, post %1 %2 and then apply it to %3 %4.';
        Text016: Label '%1 must be G/L Account or Bank Account.';
        Text018: Label '%1 can only be set when %2 is set.';
        Text019: Label '%1 cannot be changed when %2 is set.';
        ExportAgainQst: Label 'One or more of the selected lines have already been exported. Do you want to export them again?';
        NothingToExportErr: Label 'There is nothing to export.';
        NotExistErr: Label 'Document number %1 does not exist or is already closed.', Comment = '%1=Document number';
        DocNoFilterErr: Label 'The document numbers cannot be renumbered while there is an active filter on the Document No. field.';
        DueDateMsg: Label 'This posting date will cause an overdue payment.';
        CalcPostDateMsg: Label 'Processing payment journal lines #1##########';
        NoEntriesToVoidErr: Label 'There are no entries to void.';
        OnlyLocalCurrencyForEmployeeErr: Label 'The value of the Currency Code field must be empty. General journal lines in foreign currency are not supported for employee account type.';
        SalespersonPurchPrivacyBlockErr: Label 'Privacy Blocked must not be true for Salesperson / Purchaser %1.', Comment = '%1 = salesperson / purchaser code.';
        BlockedErr: Label 'The Blocked field must not be %1 for %2 %3.', Comment = '%1=Blocked field value,%2=Account Type,%3=Account No.';
        BlockedEmplErr: Label 'You cannot export file because employee %1 is blocked due to privacy.', Comment = '%1 = Employee no. ';
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        PaymentTerms: Record "Payment Terms";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        EmplLedgEntry: Record "Employee Ledger Entry";
        GenJnlAlloc: Record "Gen. Jnl. Allocation";
        VATPostingSetup: Record "VAT Posting Setup";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        GLSetup: Record "General Ledger Setup";
        Job: Record Job;
        SourceCodeSetup: Record "Source Code Setup";
        TempJobJnlLine: Record "Job Journal Line" temporary;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        GenJnlShowCTEntries: Codeunit "Gen. Jnl.-Show CT Entries";
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
        VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
        EmplEntrySetApplID: Codeunit "Empl. Entry-SetAppl.ID";
        DimMgt: Codeunit DimensionManagement;
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        DeferralUtilities: Codeunit "Deferral Utilities";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Window: Dialog;
        DeferralDocType: Option Purchase,Sales,"G/L";
        CurrencyCode: Code[10];
        TemplateFound: Boolean;
        CurrencyDate: Date;
        HideValidationDialog: Boolean;
        GLSetupRead: Boolean;
        GLAccount: Record "G/L Account";
        CustomerCard: Record Customer;
        VendorCard: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        BankAccount: Record "Bank Account";
        Employee: Record Employee;
        JvHeader: Record "Journal Voucher Header";

    local procedure GetCurrency()
    begin
        /*IF "Additional-Currency Posting" =
           "Additional-Currency Posting"::"Additional-Currency Amount Only"
        THEN BEGIN
          IF GLSetup."Additional Reporting Currency" = '' THEN
            ReadGLSetup;
          CurrencyCode := GLSetup."Additional Reporting Currency";
        END ELSE
          CurrencyCode := "Currency Code";
        
        IF CurrencyCode = '' THEN BEGIN
          CLEAR(Currency);
          Currency.InitRoundingPrecision
        END ELSE
          IF CurrencyCode <> Currency.Code THEN BEGIN
            Currency.GET(CurrencyCode);
            Currency.TESTFIELD("Amount Rounding Precision");
          END;
          */

    end;
}

