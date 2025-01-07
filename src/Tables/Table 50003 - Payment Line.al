table 50003 "Payment Line"
{
    Caption = 'Payment Line';

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Payment Header"."No.";
        }
        field(3; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender";
        }
        field(4; "Payment Code"; Code[50])
        {
            Caption = 'Payment Code';
            TableRelation = "Funds Transaction Code"."Transaction Code" WHERE("Transaction Type" = CONST(Payment),
                                                                               "Funds Claim Code" = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                "Account Type" := "Account Type"::"G/L Account";
                "Account No." := '';
                "Posting Group" := '';
                "Payment Code Description" := '';
                "VAT Code" := '';
                "Withholding Tax Code" := '';
                "Withholding VAT Code" := '';
                FundsTransactionCodes.Reset;
                FundsTransactionCodes.SetRange(FundsTransactionCodes."Transaction Code", "Payment Code");
                if FundsTransactionCodes.FindFirst then begin
                    "Account Type" := FundsTransactionCodes."Account Type";
                    "Account No." := FundsTransactionCodes."Account No.";
                    "Posting Group" := FundsTransactionCodes."Posting Group";
                    "Payment Code Description" := FundsTransactionCodes.Description;
                    if FundsTransactionCodes."Include VAT" then
                        "VAT Code" := FundsTransactionCodes."VAT Code";
                    if FundsTransactionCodes."Include Withholding Tax" then
                        "Withholding Tax Code" := FundsTransactionCodes."Withholding Tax Code";
                    if FundsTransactionCodes."Include Withholding VAT" then
                        "Withholding VAT Code" := FundsTransactionCodes."Withholding VAT Code";
                    //Employee Transaction Type
                    "Employee Transaction Type" := FundsTransactionCodes."Employee Transaction Type";
                end;

                Validate("Account No.");
            end;
        }
        field(5; "Payment Code Description"; Text[100])
        {
            Caption = 'Payment Code Description';
            Editable = false;
        }
        field(6; "Account Type"; Option)
        {
            Caption = 'Account Type';
            Editable = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee,Imprest';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Imprest;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(7; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"."No."
            ELSE IF ("Account Type" = CONST(Customer)) Customer."No."
            ELSE IF ("Account Type" = CONST(Vendor)) Vendor."No."
            ELSE IF ("Account Type" = CONST(Employee)) Employee."No.";

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                "Account Name" := '';
                if "Account Type" = "Account Type"::"G/L Account" then begin
                    if "G/LAccount".Get("Account No.") then begin
                        "Account Name" := "G/LAccount".Name;
                    end;
                end;

                if "Account Type" = "Account Type"::Customer then begin
                    if Customer.Get("Account No.") then begin
                        "Account Name" := Customer.Name;
                    end;
                end;
                if "Account Type" = "Account Type"::"Bank Account" then begin
                    if BankAccount.Get("Account No.") then begin
                        "Account Name" := BankAccount.Name;
                    end;
                end;
                if "Account Type" = "Account Type"::Vendor then begin
                    Vendor.Reset;
                    if Vendor.Get("Account No.") then begin
                        "Account Name" := Vendor.Name;
                        "Payee Bank Code" := Vendor."Bank Code";
                        "Payee Bank Name" := Vendor."Bank Name";
                        "Payee Bank Branch Code" := Vendor."Bank Branch Code";
                        "Payee Bank Branch Name" := Vendor."Bank Branch Name";
                        "Payee Bank Account No." := Vendor."Bank Account No.";
                        "Mobile Payment Account No." := Vendor."MPESA/Paybill Account No.";

                        PaymentHeader.Reset;
                        PaymentHeader.Get("Document No.");
                        PaymentHeader."Payee Name" := Vendor.Name;
                        PaymentHeader.Modify;
                    end;
                end;

                if "Account Type" = "Account Type"::Employee then begin
                    if Employee.Get("Account No.") then begin
                        "Account Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                        "Payee Bank Code" := Employee."Bank Code-d";
                        "Payee Bank Name" := Employee."Bank Name";
                        "Payee Bank Branch Code" := Employee."Bank Branch Code-d";
                        "Payee Bank Branch Name" := Employee."Bank Branch Name";
                        "Payee Bank Account No." := Employee."Bank Account No.";
                        "Mobile Payment Account No." := Employee."Mobile Phone No.";
                        "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                        "Shortcut Dimension 3 Code" := Employee."Shortcut Dimension 3 Code";
                        "Shortcut Dimension 4 Code" := Employee."Shortcut Dimension 4 Code";
                        "Shortcut Dimension 5 Code" := Employee."Shortcut Dimension 5 Code";
                        "Shortcut Dimension 6 Code" := Employee."Shortcut Dimension 6 Code";
                        "Shortcut Dimension 7 Code" := Employee."Shortcut Dimension 7 Code";
                        "Shortcut Dimension 8 Code" := Employee."Shortcut Dimension 8 Code";
                        PaymentHeader.Reset;
                        PaymentHeader.Get("Document No.");
                        PaymentHeader."Payee Name" := "Account Name";
                        PaymentHeader.Modify;
                    end;
                end;
            end;
        }
        field(8; "Account Name"; Text[50])
        {
            Caption = 'Account Name';
            Editable = false;
        }
        field(9; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Posting Group".Code
            ELSE IF ("Account Type" = CONST(Vendor)) "Vendor Posting Group".Code
            ELSE IF ("Account Type" = CONST(Employee)) "Employee Posting Group".Code;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(10; Description; Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(11; "Reference No."; Code[20])
        {
            Caption = 'Reference No.';
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(21; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(22; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
        }
        field(23; "Total Amount"; Decimal)
        {
            Caption = 'Amount Incl. VAT';

            trigger OnValidate()
            begin
                TestStatusOpen(true);
                //Test if Field is editable
                AmountsNotEditable;

                //Rounding
                if FundsGeneralSetup.Get then begin
                    if FundsGeneralSetup."Payment Rounding Precision" <> 0 then begin
                        if FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Nearest then begin
                            "Total Amount" := Round("Total Amount", FundsGeneralSetup."Payment Rounding Precision", '=');
                        end;
                        if FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Up then begin
                            "Total Amount" := Round("Total Amount", FundsGeneralSetup."Payment Rounding Precision", '>');
                        end;
                        if FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Down then begin
                            "Total Amount" := Round("Total Amount", FundsGeneralSetup."Payment Rounding Precision", '<');
                        end;
                    end;
                end;
                //End Rounding
                "Net Amount" := "Total Amount";
                if "Currency Code" <> '' then begin
                    "Total Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Total Amount", "Currency Factor"));
                    "Net Amount(LCY)" := "Total Amount(LCY)";
                end else begin
                    "Total Amount(LCY)" := "Total Amount";
                    "Net Amount(LCY)" := "Total Amount";
                end;
                Validate("Total Amount(LCY)");
                Validate("Net Amount(LCY)");

                Validate("VAT Code");
                Validate("Withholding Tax Code");
                Validate("Withholding VAT Code");
            end;
        }
        field(24; "Total Amount(LCY)"; Decimal)
        {
            Caption = 'Amount Incl. VAT(LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                //Rounding
                if FundsGeneralSetup.Get then begin
                    if FundsGeneralSetup."Payment Rounding Precision" <> 0 then begin
                        if FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Nearest then begin
                            "Total Amount(LCY)" := Round("Total Amount(LCY)", FundsGeneralSetup."Payment Rounding Precision", '=');
                        end;
                        if FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Up then begin
                            "Total Amount(LCY)" := Round("Total Amount(LCY)", FundsGeneralSetup."Payment Rounding Precision", '>');
                        end;
                        if FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Down then begin
                            "Total Amount(LCY)" := Round("Total Amount(LCY)", FundsGeneralSetup."Payment Rounding Precision", '<');
                        end;
                    end;
                end;
                //End Rounding
            end;
        }
        field(25; "VAT Code"; Code[10])
        {
            Caption = 'VAT Code';
            TableRelation = "Funds Tax Code"."Tax Code" WHERE(Type = CONST(VAT));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
                "VAT Amount" := 0;
                Validate("VAT Amount");
                "Withholding Tax Code" := '';
                Validate("Withholding Tax Code");
                "Withholding VAT Code" := '';
                Validate("Withholding VAT Code");

                /*IF "VAT Code"<>'' THEN BEGIN
                  FundsTaxCodes.RESET;
                  FundsTaxCodes.SETRANGE(FundsTaxCodes."Tax Code","VAT Code");
                  IF FundsTaxCodes.FINDFIRST THEN BEGIN
                    "VAT Amount":="Original Amount"-(("Original Amount"*100)/(FundsTaxCodes.Percentage+100));
                    VALIDATE("VAT Amount");
                  END;
                END;*/
                if "VAT Code" <> '' then begin
                    FundsTaxCodes.Reset;
                    FundsTaxCodes.SetRange(FundsTaxCodes."Tax Code", "VAT Code");
                    if FundsTaxCodes.FindFirst then begin
                        //"VAT Amount":="Total Amount"-(("Total Amount"*100)/(FundsTaxCodes.Percentage+100));
                        //UPDATED OF 13/07/2023
                        "VAT Amount" := "Original Amount" - (("Original Amount" * 100) / (FundsTaxCodes.Percentage + 100));
                        Validate("VAT Amount");
                    end;
                end;

            end;
        }
        field(26; "VAT Amount"; Decimal)
        {
            Caption = 'VAT Amount';
            Editable = false;

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                "Net Amount" := "Total Amount";

                if "Currency Code" <> '' then begin
                    "VAT Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "VAT Amount", "Currency Factor"));
                    "Net Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Net Amount", "Currency Factor"));
                end else begin
                    "VAT Amount(LCY)" := "VAT Amount";
                    "Net Amount(LCY)" := "Net Amount";
                end;
                Validate("Withholding VAT Code");
            end;
        }
        field(27; "VAT Amount(LCY)"; Decimal)
        {
            Caption = 'VAT Amount(LCY)';
            Editable = false;
        }
        field(28; "Withholding Tax Code"; Code[10])
        {
            Caption = 'Withholding Tax Code';
            TableRelation = "Funds Tax Code"."Tax Code" WHERE(Type = CONST("W/TAX"));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
                "Withholding Tax Amount" := 0;
                Validate("Withholding Tax Amount");

                /*IF "Withholding Tax Code"<>'' THEN BEGIN
                  FundsTaxCodes.RESET;
                  FundsTaxCodes.SETRANGE(FundsTaxCodes."Tax Code","Withholding Tax Code");
                  IF FundsTaxCodes.FINDFIRST THEN BEGIN
                    "Withholding Tax Amount":=ROUND(("Original Amount"-"VAT Amount")*(FundsTaxCodes.Percentage/100),1,'>');
                
                    VALIDATE("Withholding Tax Amount");
                  END;
                END;*/
                if "Withholding Tax Code" <> '' then begin
                    FundsTaxCodes.Reset;
                    FundsTaxCodes.SetRange(FundsTaxCodes."Tax Code", "Withholding Tax Code");
                    if FundsTaxCodes.FindFirst then begin
                        //"Withholding Tax Amount":=ROUND(("Total Amount"-"VAT Amount")*(FundsTaxCodes.Percentage/100),1,'>');
                        //UPDATED 13/07/2023
                        "Withholding Tax Amount" := Round(("Original Amount" - "VAT Amount") * (FundsTaxCodes.Percentage / 100), 1, '>');
                        Validate("Withholding Tax Amount");
                    end;
                end;

            end;
        }
        field(29; "Withholding Tax Amount"; Decimal)
        {
            Caption = 'Withholding Tax Amount';

            trigger OnValidate()
            begin
                TestStatusOpen(true);
                //Test if Field is editable
                AmountsNotEditable;
                //Rounding
                if FundsGeneralSetup.Get then begin
                    if FundsGeneralSetup."W/Tax Rounding Precision" <> 0 then begin
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Nearest then begin
                            "Withholding Tax Amount" := Round("Withholding Tax Amount", FundsGeneralSetup."W/Tax Rounding Precision", '=');
                        end;
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Up then begin
                            "Withholding Tax Amount" := Round("Withholding Tax Amount", FundsGeneralSetup."W/Tax Rounding Precision", '>');
                        end;
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Down then begin
                            "Withholding Tax Amount" := Round("Withholding Tax Amount", FundsGeneralSetup."W/Tax Rounding Precision", '<');
                        end;
                    end;
                end;
                //End Rounding
                "Net Amount" := "Total Amount" - "Withholding Tax Amount" - "Withholding VAT Amount" - "PAYE Amount" - "AHL Amount";
                if "Currency Code" <> '' then begin
                    "Withholding Tax Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Withholding Tax Amount", "Currency Factor"));
                    "Net Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Net Amount", "Currency Factor"));
                end else begin
                    "Withholding Tax Amount(LCY)" := "Withholding Tax Amount";
                    "Net Amount(LCY)" := "Net Amount";
                end;
                Validate("Withholding Tax Amount(LCY)");
                Validate("Net Amount(LCY)");
            end;
        }
        field(30; "Withholding Tax Amount(LCY)"; Decimal)
        {
            Caption = 'Withholding Tax Amount(LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                //Rounding
                if FundsGeneralSetup.Get then begin
                    if FundsGeneralSetup."W/Tax Rounding Precision" <> 0 then begin
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Nearest then begin
                            "Withholding Tax Amount(LCY)" := Round("Withholding Tax Amount(LCY)", FundsGeneralSetup."W/Tax Rounding Precision", '=');
                        end;
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Up then begin
                            "Withholding Tax Amount(LCY)" := Round("Withholding Tax Amount(LCY)", FundsGeneralSetup."W/Tax Rounding Precision", '>');
                        end;
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Down then begin
                            "Withholding Tax Amount(LCY)" := Round("Withholding Tax Amount(LCY)", FundsGeneralSetup."W/Tax Rounding Precision", '<');
                        end;
                    end;
                end;
                //End Rounding
            end;
        }
        field(31; "Withholding VAT Code"; Code[10])
        {
            Caption = 'Withholding VAT Code';
            TableRelation = "Funds Tax Code"."Tax Code" WHERE(Type = CONST("W/VAT"));

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                if "Withholding VAT Code" <> '' then begin
                    //TESTFIELD("VAT Amount");
                    FundsTaxCodes.Reset;
                    FundsTaxCodes.SetRange(FundsTaxCodes."Tax Code", "Withholding VAT Code");
                    if FundsTaxCodes.FindFirst then begin
                        if FundsTaxCodes2.Get("VAT Code") then begin
                            "Withholding VAT Amount" := Round(("VAT Amount") * (FundsTaxCodes.Percentage / FundsTaxCodes2.Percentage), 1, '>');

                            Validate("Withholding VAT Amount");
                        end;
                    end;
                end else begin
                    "Withholding VAT Amount" := 0;
                    Validate("Withholding VAT Amount");
                end;
            end;
        }
        field(32; "Withholding VAT Amount"; Decimal)
        {
            Caption = 'Withholding VAT Amount';
            Editable = false;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
                //Rounding
                if FundsGeneralSetup.Get then begin
                    if FundsGeneralSetup."W/VAT Rounding Precision" <> 0 then begin
                        if FundsGeneralSetup."W/VAT Rounding Type" = FundsGeneralSetup."W/VAT Rounding Type"::Nearest then begin
                            "Withholding VAT Amount" := Round("Withholding VAT Amount", FundsGeneralSetup."W/VAT Rounding Precision", '=');
                        end;
                        if FundsGeneralSetup."W/VAT Rounding Type" = FundsGeneralSetup."W/VAT Rounding Type"::Up then begin
                            "Withholding VAT Amount" := Round("Withholding VAT Amount", FundsGeneralSetup."W/VAT Rounding Precision", '>');
                        end;
                        if FundsGeneralSetup."W/VAT Rounding Type" = FundsGeneralSetup."W/VAT Rounding Type"::Down then begin
                            "Withholding VAT Amount" := Round("Withholding VAT Amount", FundsGeneralSetup."W/VAT Rounding Precision", '<');
                        end;
                    end;
                end;
                //End Rounding

                "Net Amount" := "Total Amount" - "Withholding Tax Amount" - "Withholding VAT Amount" - "PAYE Amount" - "AHL Amount";
                if "Currency Code" <> '' then begin
                    "Withholding VAT Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Withholding VAT Amount", "Currency Factor"));
                    "Net Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Net Amount", "Currency Factor"));
                end else begin
                    "Withholding VAT Amount(LCY)" := "Withholding VAT Amount";
                    "Net Amount(LCY)" := "Net Amount";
                end;
                Validate("Withholding VAT Amount(LCY)");
                Validate("Net Amount(LCY)");
            end;
        }
        field(33; "Withholding VAT Amount(LCY)"; Decimal)
        {
            Caption = 'Withholding VAT Amount(LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                //Rounding
                if FundsGeneralSetup.Get then begin
                    if FundsGeneralSetup."W/VAT Rounding Precision" <> 0 then begin
                        if FundsGeneralSetup."W/VAT Rounding Type" = FundsGeneralSetup."W/VAT Rounding Type"::Nearest then begin
                            "Withholding VAT Amount(LCY)" := Round("Withholding VAT Amount(LCY)", FundsGeneralSetup."W/VAT Rounding Precision", '=');
                        end;
                        if FundsGeneralSetup."W/VAT Rounding Type" = FundsGeneralSetup."W/VAT Rounding Type"::Up then begin
                            "Withholding VAT Amount(LCY)" := Round("Withholding VAT Amount(LCY)", FundsGeneralSetup."W/VAT Rounding Precision", '>');
                        end;
                        if FundsGeneralSetup."W/VAT Rounding Type" = FundsGeneralSetup."W/VAT Rounding Type"::Down then begin
                            "Withholding VAT Amount(LCY)" := Round("Withholding VAT Amount(LCY)", FundsGeneralSetup."W/VAT Rounding Precision", '<');
                        end;
                    end;
                end;
                //End Rounding
            end;
        }
        field(34; "Net Amount"; Decimal)
        {
            Caption = 'Net Amount';
            Editable = false;
        }
        field(35; "Net Amount(LCY)"; Decimal)
        {
            Caption = 'Net Amount(LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                //Rounding
                if FundsGeneralSetup.Get then begin
                    if FundsGeneralSetup."Payment Rounding Precision" <> 0 then begin
                        if FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Nearest then begin
                            "Net Amount(LCY)" := Round("Net Amount(LCY)", FundsGeneralSetup."Payment Rounding Precision", '=');
                        end;
                        if FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Up then begin
                            "Net Amount(LCY)" := Round("Net Amount(LCY)", FundsGeneralSetup."Payment Rounding Precision", '>');
                        end;
                        if FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Down then begin
                            "Net Amount(LCY)" := Round("Net Amount(LCY)", FundsGeneralSetup."Payment Rounding Precision", '<');
                        end;
                    end;
                end;
                //End Rounding
            end;
        }
        field(36; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(37; "Applies-to Doc. No."; Code[60])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup()
            var
                VendLedgEntry: Record "Vendor Ledger Entry";
                PayToVendorNo: Code[20];
                OK: Boolean;
                Text000: Label 'You must specify %1 or %2.';
                AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
                AccNo: Code[20];
            begin
                TestStatusOpen(true);

                if ("Account Type" <> "Account Type"::Customer) and ("Account Type" <> Rec."Account Type"::Vendor) then
                    Error(ApplicationNotAllowed, "Account Type");

                xRec."Total Amount" := "Total Amount";
                xRec."Currency Code" := "Currency Code";
                xRec."Posting Date" := "Posting Date";


                GetAccTypeAndNo(Rec, AccType, AccNo);
                Clear(VendLedgEntry);

                case AccType of
                    AccType::Vendor:
                        LookUpAppliesToDocVend(AccNo);
                end;
                SetPaymentLineFieldsFromApplication;
            end;

            trigger OnValidate()
            var
                AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
                AccNo: Code[20];
            begin
                TestStatusOpen(true);
                //Get the Invoice Vatable Amount
                if "Applies-to Doc. Type" = "Applies-to Doc. Type"::Invoice then begin
                    PurchInvHeader.Reset;
                    PurchInvHeader.SetRange(PurchInvHeader."No.", "Applies-to Doc. No.");
                    if PurchInvHeader.FindFirst then begin
                        PurchInvHeader.CalcFields(Amount, "Amount Including VAT");
                        "VAT Amount" := PurchInvHeader."Amount Including VAT" - PurchInvHeader.Amount;
                        "Original Amount" := PurchInvHeader.Amount;
                        "Vendor Invoice No" := PurchInvHeader."Vendor Invoice No.";
                        Validate("VAT Amount");
                    end;
                end;
                //if Applies-to Doc.Type Not Invoice
                /*IF "Applies-to Doc. Type"="Applies-to Doc. Type"::" " THEN BEGIN
                  PurchInvHeader.RESET;
                  PurchInvHeader.SETRANGE(PurchInvHeader."No.","Applies-to Doc. No.");
                  IF PurchInvHeader.FINDFIRST THEN BEGIN
                    PurchInvHeader.CALCFIELDS(Amount,"Amount Including VAT");
                    "VAT Amount":=PurchInvHeader."Amount Including VAT"-PurchInvHeader.Amount;*/
                "Original Amount" := PurchInvHeader.Amount;
                "Vendor Invoice No" := PurchInvHeader."Vendor Invoice No.";
                Validate("VAT Amount");
                //END;
                //END;

            end;
        }
        field(38; "Applies-to ID"; Code[35])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            var
                TempVendLedgEntry: Record "Vendor Ledger Entry";
            begin
            end;
        }
        field(39; Committed; Boolean)
        {
            Caption = 'Committed';
        }
        field(40; "Budget Code"; Code[20])
        {
            Caption = 'Budget Code';
        }
        field(41; "Payee Type"; Option)
        {
            Caption = 'Payee Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Vendor,Employee,Imprest,Customer,Petty Cash Request,Salary Advance,Allowance,Board Allowance,Bank,Casual Payment,Standing Imprest';
            OptionMembers = " ",Vendor,Employee,Imprest,Customer,"Petty Cash Request","Salary Advance",Allowance,"Board Allowance",Bank,"Casual Payment","Standing Imprest";
        }
        field(42; "Payee No."; Code[20])
        {
            Caption = 'Payee No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Payee Type" = CONST(Vendor)) Vendor
            ELSE IF ("Payee Type" = CONST(Employee)) Employee
            ELSE IF ("Payee Type" = CONST(Imprest),
                                     "Payment Type" = CONST("Cheque Payment")) "Imprest Header" WHERE(Posted = CONST(false),
                                                                                                     Status = CONST(Approved),
                                                                                                     Type = CONST(Imprest))
            ELSE IF ("Payee Type" = CONST("Petty Cash Request")) "Imprest Header" WHERE(Posted = CONST(false),
                                                                                                                                                                                Status = CONST(Approved),
                                                                                                                                                                                Type = CONST("Petty Cash"))
            ELSE IF ("Payee Type" = CONST(Customer)) Customer
            ELSE IF ("Payee Type" = CONST("Salary Advance")) "Salary Advance" WHERE(Status = CONST(Approved),
                                                                                                                                                                                                                                                       "Paid to Employee" = CONST(false))
            ELSE IF ("Payee Type" = CONST(Allowance)) "Allowance Header" WHERE(Posted = CONST(true))
            ELSE IF ("Payee Type" = CONST("Board Allowance")) "Imprest Header" WHERE(Posted = CONST(false),
                                                                                                                                                                                                                                                                                                                               Status = CONST(Approved),
                                                                                                                                                                                                                                                                                                                               Type = CONST("Board Allowance"))
            ELSE IF ("Payee Type" = CONST(Bank)) "Bank Account"
            ELSE IF ("Payee Type" = FILTER("Casual Payment")) "Imprest Header" WHERE(Posted = CONST(false),
                                                                                                                                                                                                                                                                                                                                                                                                       Status = CONST(Approved),
                                                                                                                                                                                                                                                                                                                                                                                                       Type = CONST("Casuals Payment"))
            ELSE IF ("Payee Type" = FILTER("Standing Imprest")) "Imprest Header" WHERE(Posted = CONST(false),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 Status = CONST(Approved),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 Type = CONST("Standing Imprest"));

            trigger OnValidate()
            var
                LoansAdvances: Record "Salary Advance";
                AllowanceHeader: Record "Allowance Header";
            begin
                Allowedit := true;
                "Account No." := '';
                //Description:='';
                "Total Amount" := 0;
                "Total Amount(LCY)" := 0;
                //"Global Dimension 1 Code":='';
                //"Global Dimension 2 Code":='';
                //"Shortcut Dimension 3 Code":='';
                "Shortcut Dimension 4 Code" := '';
                "Shortcut Dimension 5 Code" := '';
                "Shortcut Dimension 6 Code" := '';
                "Shortcut Dimension 7 Code" := '';
                "Shortcut Dimension 8 Code" := '';


                if ("Payee Type" = "Payee Type"::Imprest) or ("Payee Type" = "Payee Type"::"Casual Payment") then begin
                    ImprestHeader.Reset;
                    ImprestHeader.SetRange(ImprestHeader."No.", "Payee No.");
                    //BV 27.09.2023
                    ImprestHeader.SetRange(ImprestHeader."Imprest Type", ImprestHeader."Imprest Type"::"General Imprest", ImprestHeader."Imprest Type"::Safari);
                    //BV 27.09.2023
                    if ImprestHeader.FindFirst then begin
                        PaymentLine.Reset;
                        PaymentLine.SetRange(PaymentLine."Payee No.", "Payee No.");
                        if PaymentLine.FindFirst then
                            Error(Text005, PaymentLine."Document No.");

                        ImprestHeader.CalcFields(ImprestHeader.Amount);
                        ImprestHeader.CalcFields(ImprestHeader."Amount(LCY)");
                        //pv no.
                        ImprestHeader."Payment Voucher No" := "Document No.";
                        "Account Type" := "Account Type"::Employee;
                        "Account No." := ImprestHeader."Employee No.";
                        Validate("Account No.");
                        Description := ImprestHeader.Description;
                        "Total Amount" := ImprestHeader.Amount;
                        Validate("Total Amount");
                        "Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
                        "Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
                        "Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
                        "Shortcut Dimension 5 Code" := ImprestHeader."Shortcut Dimension 5 Code";
                        "Shortcut Dimension 6 Code" := ImprestHeader."Shortcut Dimension 6 Code";
                        "Shortcut Dimension 7 Code" := ImprestHeader."Shortcut Dimension 7 Code";
                        "Shortcut Dimension 8 Code" := ImprestHeader."Shortcut Dimension 8 Code";
                        PaymentHeader.Reset;
                        PaymentHeader.SetRange(PaymentHeader."No.", "Document No.");
                        if PaymentHeader.FindFirst then begin
                            PaymentHeader."Payee Name" := ImprestHeader."Employee Name";
                            PaymentHeader."Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                            PaymentHeader."Global Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
                            PaymentHeader."Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
                            PaymentHeader."Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
                            PaymentHeader."Shortcut Dimension 5 Code" := ImprestHeader."Shortcut Dimension 5 Code";
                            PaymentHeader."Shortcut Dimension 6 Code" := ImprestHeader."Shortcut Dimension 6 Code";
                            PaymentHeader."Shortcut Dimension 7 Code" := ImprestHeader."Shortcut Dimension 7 Code";
                            PaymentHeader."Shortcut Dimension 8 Code" := ImprestHeader."Shortcut Dimension 8 Code";
                            PaymentHeader.Modify;
                        end;
                        ImprestHeader.Modify;
                    end;
                end;
                //board Allowance
                if "Payee Type" = "Payee Type"::"Board Allowance" then begin
                    ImprestHeader.Reset;
                    ImprestHeader.SetRange(ImprestHeader."No.", "Payee No.");
                    if ImprestHeader.FindFirst then begin
                        PaymentLine.Reset;
                        PaymentLine.SetRange(PaymentLine."Payee No.", "Payee No.");
                        if PaymentLine.FindFirst then
                            // ERROR(Text005,PaymentLine."Document No.");

                            ImprestHeader.CalcFields(ImprestHeader.Amount);
                        ImprestHeader.CalcFields(ImprestHeader."Amount(LCY)");
                        //pv no.
                        ImprestHeader."Payment Voucher No" := "Document No.";
                        "Account Type" := "Account Type"::Employee;
                        "Account No." := ImprestHeader."Employee No.";
                        Validate("Account No.");
                        Description := ImprestHeader.Description;
                        "Total Amount" := ImprestHeader.Amount;
                        Validate("Total Amount");
                        "Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
                        "Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
                        "Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
                        "Shortcut Dimension 5 Code" := ImprestHeader."Shortcut Dimension 5 Code";
                        "Shortcut Dimension 6 Code" := ImprestHeader."Shortcut Dimension 6 Code";
                        "Shortcut Dimension 7 Code" := ImprestHeader."Shortcut Dimension 7 Code";
                        "Shortcut Dimension 8 Code" := ImprestHeader."Shortcut Dimension 8 Code";
                        PaymentHeader.Reset;
                        PaymentHeader.SetRange(PaymentHeader."No.", "Document No.");
                        if PaymentHeader.FindFirst then begin
                            PaymentHeader."Payee Name" := ImprestHeader."Employee Name";
                            PaymentHeader."Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                            PaymentHeader."Global Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
                            PaymentHeader."Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
                            PaymentHeader."Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
                            PaymentHeader."Shortcut Dimension 5 Code" := ImprestHeader."Shortcut Dimension 5 Code";
                            PaymentHeader."Shortcut Dimension 6 Code" := ImprestHeader."Shortcut Dimension 6 Code";
                            PaymentHeader."Shortcut Dimension 7 Code" := ImprestHeader."Shortcut Dimension 7 Code";
                            PaymentHeader."Shortcut Dimension 8 Code" := ImprestHeader."Shortcut Dimension 8 Code";
                            PaymentHeader.Modify;
                        end;
                        ImprestHeader.Modify;
                    end;
                end;
                //Standing Imprest Petty Cash BV 27.09.2023
                //IF "Payee Type" = "Payee Type"::"Standing Imprest" THEN BEGIN
                if "Payee Type" = "Payee Type"::Imprest then begin
                    ImprestHeader.Reset;
                    ImprestHeader.SetRange(ImprestHeader."No.", "Payee No.");
                    //BV 27.09.2023
                    ImprestHeader.SetRange(ImprestHeader."Imprest Type", ImprestHeader."Imprest Type"::Pettycash);
                    //BV 27.09.2023
                    if ImprestHeader.FindFirst then begin
                        PaymentLine.Reset;
                        PaymentLine.SetRange(PaymentLine."Payee No.", "Payee No.");
                        if PaymentLine.FindFirst then
                            Error(Text005, PaymentLine."Document No.");

                        ImprestHeader.CalcFields(ImprestHeader.Amount);
                        ImprestHeader.CalcFields(ImprestHeader."Amount(LCY)");
                        //pv no.
                        ImprestHeader."Payment Voucher No" := "Document No.";
                        "Account Type" := "Account Type"::"Bank Account";
                        ImprestLine.Reset;
                        ImprestLine.SetRange(ImprestLine."Document No.", Rec."Payee No.");
                        if ImprestLine.FindSet then
                            //IF ImprestLine.GET("Payee No.")THEN
                            "Account No." := ImprestLine."Account No.";
                        "Account Name" := ImprestLine."Account Name";
                        //VALIDATE("Account No.");
                        Description := ImprestHeader.Description;
                        "Total Amount" := ImprestHeader.Amount;
                        //VALIDATE("Total Amount");
                        "Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
                        "Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
                        "Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
                        "Shortcut Dimension 5 Code" := ImprestHeader."Shortcut Dimension 5 Code";
                        "Shortcut Dimension 6 Code" := ImprestHeader."Shortcut Dimension 6 Code";
                        "Shortcut Dimension 7 Code" := ImprestHeader."Shortcut Dimension 7 Code";
                        "Shortcut Dimension 8 Code" := ImprestHeader."Shortcut Dimension 8 Code";
                        PaymentHeader.Reset;
                        PaymentHeader.SetRange(PaymentHeader."No.", "Document No.");
                        if PaymentHeader.FindFirst then begin
                            PaymentHeader."Payee Name" := ImprestHeader."Employee Name";
                            PaymentHeader."Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                            PaymentHeader."Global Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
                            PaymentHeader."Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
                            PaymentHeader."Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
                            PaymentHeader."Shortcut Dimension 5 Code" := ImprestHeader."Shortcut Dimension 5 Code";
                            PaymentHeader."Shortcut Dimension 6 Code" := ImprestHeader."Shortcut Dimension 6 Code";
                            PaymentHeader."Shortcut Dimension 7 Code" := ImprestHeader."Shortcut Dimension 7 Code";
                            PaymentHeader."Shortcut Dimension 8 Code" := ImprestHeader."Shortcut Dimension 8 Code";
                            PaymentHeader.Modify;
                        end;
                        ImprestHeader.Modify;
                    end;
                end;
                //End Standing Imprest
                //Salary Advance
                if "Payee Type" = "Payee Type"::"Salary Advance" then begin
                    LoansAdvances.Reset;
                    LoansAdvances.SetFilter(ID, '=%1', "Payee No.");
                    if LoansAdvances.FindFirst then begin
                        PaymentLine.Reset;
                        PaymentLine.SetRange(PaymentLine."Payee No.", "Payee No.");
                        if PaymentLine.FindFirst then
                            Error(Text005, PaymentLine."Document No.");

                        ModeofPaymentEmp := '';
                        "Account Type" := "Account Type"::"G/L Account";
                        //added on 29/06/2022 to cater for gl posting instead of employee
                        if EmployeeRec.Get(LoansAdvances.Employee) then
                            ModeofPaymentEmp := EmployeeRec."Mode of Payment";

                        if ModeofPayment.Get(ModeofPaymentEmp) then
                            //added on 29/06/2022 to cater for gl posting
                            if FundsGeneralSetup.Get() then begin
                                "Account No." := FundsGeneralSetup."Salary Advance Account";//ModeofPayment."Net Pay Account No";
                            end;

                        Validate("Account No.");
                        Description := LoansAdvances."Purpose of Salary Advance";
                        "Total Amount" := LoansAdvances.Principal;
                        Validate("Total Amount");

                        "Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
                        "Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
                        "Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
                        "Shortcut Dimension 5 Code" := ImprestHeader."Shortcut Dimension 5 Code";
                        "Shortcut Dimension 6 Code" := ImprestHeader."Shortcut Dimension 6 Code";
                        "Shortcut Dimension 7 Code" := ImprestHeader."Shortcut Dimension 7 Code";
                        "Shortcut Dimension 8 Code" := ImprestHeader."Shortcut Dimension 8 Code";

                        PaymentHeader.Reset;
                        PaymentHeader.SetRange(PaymentHeader."No.", "Document No.");
                        if PaymentHeader.FindFirst then begin
                            if EmployeeRec.Get(LoansAdvances.Employee) then
                                PaymentHeader."Payee Name" := "Account Name" + LoansAdvances."File Name" + LoansAdvances."Last Name";
                            /*
                            PaymentHeader."Global Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
                            PaymentHeader."Global Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
                            PaymentHeader."Shortcut Dimension 3 Code":=ImprestHeader."Shortcut Dimension 3 Code";
                            PaymentHeader."Shortcut Dimension 4 Code":=ImprestHeader."Shortcut Dimension 4 Code";
                            PaymentHeader."Shortcut Dimension 5 Code":=ImprestHeader."Shortcut Dimension 5 Code";
                            PaymentHeader."Shortcut Dimension 6 Code":=ImprestHeader."Shortcut Dimension 6 Code";
                            PaymentHeader."Shortcut Dimension 7 Code":=ImprestHeader."Shortcut Dimension 7 Code";
                            PaymentHeader."Shortcut Dimension 8 Code":=ImprestHeader."Shortcut Dimension 8 Code";
                            */
                            PaymentHeader.Modify;
                        end;
                    end;
                end;
                //>>
                if "Payee Type" = "Payee Type"::Allowance then begin
                    AllowanceHeader.Reset;
                    AllowanceHeader.SetFilter("No.", '=%1', "Payee No.");
                    if AllowanceHeader.FindFirst then begin
                        PaymentLine.Reset;
                        PaymentLine.SetRange(PaymentLine."Payee No.", "Payee No.");
                        if PaymentLine.FindFirst then
                            Error(Text005, PaymentLine."Document No.");


                        "Account Type" := "Account Type"::Employee;
                        "Account No." := AllowanceHeader."Employee No.";
                        Validate("Account No.");
                        Description := AllowanceHeader.Description;
                        AllowanceHeader.CalcFields(Amount, "Amount(LCY)");
                        "Total Amount" := AllowanceHeader.Amount;
                        "Total Amount(LCY)" := AllowanceHeader."Amount(LCY)";
                        Validate("Total Amount");
                        /*
                        "Global Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
                        "Global Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
                        "Shortcut Dimension 3 Code":=ImprestHeader."Shortcut Dimension 3 Code";
                        "Shortcut Dimension 4 Code":=ImprestHeader."Shortcut Dimension 4 Code";
                        "Shortcut Dimension 5 Code":=ImprestHeader."Shortcut Dimension 5 Code";
                        "Shortcut Dimension 6 Code":=ImprestHeader."Shortcut Dimension 6 Code";
                        "Shortcut Dimension 7 Code":=ImprestHeader."Shortcut Dimension 7 Code";
                        "Shortcut Dimension 8 Code":=ImprestHeader."Shortcut Dimension 8 Code";
                        */
                        PaymentHeader.Reset;
                        PaymentHeader.SetRange(PaymentHeader."No.", "Document No.");
                        if PaymentHeader.FindFirst then begin
                            PaymentHeader."Payee Name" := "Account Name";
                            /*
                            PaymentHeader."Global Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
                            PaymentHeader."Global Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
                            PaymentHeader."Shortcut Dimension 3 Code":=ImprestHeader."Shortcut Dimension 3 Code";
                            PaymentHeader."Shortcut Dimension 4 Code":=ImprestHeader."Shortcut Dimension 4 Code";
                            PaymentHeader."Shortcut Dimension 5 Code":=ImprestHeader."Shortcut Dimension 5 Code";
                            PaymentHeader."Shortcut Dimension 6 Code":=ImprestHeader."Shortcut Dimension 6 Code";
                            PaymentHeader."Shortcut Dimension 7 Code":=ImprestHeader."Shortcut Dimension 7 Code";
                            PaymentHeader."Shortcut Dimension 8 Code":=ImprestHeader."Shortcut Dimension 8 Code";
                            */
                            PaymentHeader.Modify;
                        end;
                    end;
                end;
                //<<Allowance
                if "Payee Type" = "Payee Type"::"Petty Cash Request" then begin
                    ImprestHeader.Reset;
                    ImprestHeader.SetRange(ImprestHeader."No.", "Payee No.");
                    if ImprestHeader.FindFirst then begin

                        PaymentLine.Reset;
                        PaymentLine.SetRange(PaymentLine."Payee No.", "Payee No.");
                        if PaymentLine.FindFirst then
                            Error(Text006, PaymentLine."Document No.");

                        ImprestHeader.CalcFields(ImprestHeader.Amount);
                        ImprestHeader.CalcFields(ImprestHeader."Amount(LCY)");
                        //Paye NO.
                        ImprestHeader."Payment Voucher No" := "Document No.";
                        "Account Type" := "Account Type"::Employee;
                        "Account No." := ImprestHeader."Employee No.";
                        Validate("Account No.");
                        Description := ImprestHeader.Description;
                        "Total Amount" := ImprestHeader.Amount;
                        Validate("Total Amount");
                        "Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
                        "Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
                        "Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
                        "Shortcut Dimension 5 Code" := ImprestHeader."Shortcut Dimension 5 Code";
                        "Shortcut Dimension 6 Code" := ImprestHeader."Shortcut Dimension 6 Code";
                        "Shortcut Dimension 7 Code" := ImprestHeader."Shortcut Dimension 7 Code";
                        "Shortcut Dimension 8 Code" := ImprestHeader."Shortcut Dimension 8 Code";
                        PaymentHeader.Reset;
                        PaymentHeader.SetRange(PaymentHeader."No.", "Document No.");
                        if PaymentHeader.FindFirst then begin
                            PaymentHeader."Payee Name" := ImprestHeader."Employee Name";
                            PaymentHeader."Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                            PaymentHeader."Global Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
                            PaymentHeader."Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
                            PaymentHeader."Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
                            PaymentHeader."Shortcut Dimension 5 Code" := ImprestHeader."Shortcut Dimension 5 Code";
                            PaymentHeader."Shortcut Dimension 6 Code" := ImprestHeader."Shortcut Dimension 6 Code";
                            PaymentHeader."Shortcut Dimension 7 Code" := ImprestHeader."Shortcut Dimension 7 Code";
                            PaymentHeader."Shortcut Dimension 8 Code" := ImprestHeader."Shortcut Dimension 8 Code";
                            PaymentHeader.Modify;
                        end;
                        ImprestHeader.Modify;
                    end;
                end;


                if "Payee Type" = "Payee Type"::Customer then begin
                    "Account Type" := "Account Type"::Customer;
                    "Account No." := "Payee No.";
                    Validate("Account No.");
                end;

                if "Payee Type" = "Payee Type"::Vendor then begin
                    "Account Type" := "Account Type"::Vendor;
                    "Account No." := "Payee No.";
                    Validate("Account No.");
                end;

                if "Payee Type" = "Payee Type"::Employee then begin
                    "Account Type" := "Account Type"::Employee;
                    "Account No." := "Payee No.";
                    Validate("Account No.");
                end;
                if "Payee Type" = "Payee Type"::Bank then begin
                    "Account Type" := "Account Type"::"Bank Account";
                    "Account No." := "Payee No.";
                    Validate("Account No.");
                end;
                Allowedit := false;

            end;
        }
        field(50; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);
            end;
        }
        field(51; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(52; "Shortcut Dimension 3 Code"; Code[50])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(53; "Shortcut Dimension 4 Code"; Code[50])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(54; "Shortcut Dimension 5 Code"; Code[50])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(55; "Shortcut Dimension 6 Code"; Code[50])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(56; "Shortcut Dimension 7 Code"; Code[50])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(57; "Shortcut Dimension 8 Code"; Code[50])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(58; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center".Code;
        }
        field(60; "Payee Bank Code"; Code[20])
        {
        }
        field(61; "Payee Bank Name"; Text[250])
        {
        }
        field(62; "Payee Bank Branch Code"; Code[20])
        {
        }
        field(63; "Payee Bank Branch Name"; Text[250])
        {
        }
        field(64; "Payee Bank Account No."; Code[20])
        {
        }
        field(65; "Mobile Payment Account No."; Code[20])
        {
            Editable = false;
        }
        field(66; "Payment Type"; Option)
        {
            CalcFormula = Lookup("Payment Header"."Payment Type" WHERE("No." = FIELD("Document No.")));
            Caption = 'Payment Type';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Cheque Payment,Cash Payment,EFT,RTGS,MPESA';
            OptionMembers = "Cheque Payment","Cash Payment",EFT,RTGS,MPESA;
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Released,Rejected,Posted,Reversed';
            OptionMembers = Open,"Pending Approval",Released,Rejected,Posted,Reversed;
        }
        field(71; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(72; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(73; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            Editable = false;
        }
        field(74; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            Editable = false;
        }
        field(75; Reversed; Boolean)
        {
            Caption = 'Reversed';
            Editable = false;
        }
        field(76; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(77; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            Editable = false;
        }
        field(78; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            Editable = false;
        }
        field(79; "Vendor Invoice No"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Invoice Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(81; "PAYE Code"; Code[10])
        {
            Caption = 'PAYE Code';
            DataClassification = ToBeClassified;
            TableRelation = "Funds Tax Code"."Tax Code" WHERE(Type = CONST(PAYE));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
                "PAYE Amount" := 0;
                Validate("PAYE Amount");

                /*IF "Withholding Tax Code"<>'' THEN BEGIN
                  FundsTaxCodes.RESET;
                  FundsTaxCodes.SETRANGE(FundsTaxCodes."Tax Code","Withholding Tax Code");
                  IF FundsTaxCodes.FINDFIRST THEN BEGIN
                    "Withholding Tax Amount":=ROUND(("Original Amount"-"VAT Amount")*(FundsTaxCodes.Percentage/100),1,'>');
                
                    VALIDATE("Withholding Tax Amount");
                  END;
                END;*/
                if "PAYE Code" <> '' then begin
                    FundsTaxCodes.Reset;
                    FundsTaxCodes.SetRange(FundsTaxCodes."Tax Code", "PAYE Code");
                    if FundsTaxCodes.FindFirst then begin
                        //"Withholding Tax Amount":=ROUND(("Total Amount"-"VAT Amount")*(FundsTaxCodes.Percentage/100),1,'>');
                        //UPDATED 13/07/2023
                        "PAYE Amount" := Round(("Original Amount" - "VAT Amount") * (FundsTaxCodes.Percentage / 100), 1, '>');
                        Validate("PAYE Amount");
                    end;
                end;

            end;
        }
        field(82; "PAYE Amount"; Decimal)
        {
            Caption = 'PAYE Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
                //Test if Field is editable
                AmountsNotEditable;
                //Rounding
                if FundsGeneralSetup.Get then begin
                    if FundsGeneralSetup."W/Tax Rounding Precision" <> 0 then begin
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Nearest then begin
                            "Withholding Tax Amount" := Round("Withholding Tax Amount", FundsGeneralSetup."W/Tax Rounding Precision", '=');
                        end;
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Up then begin
                            "Withholding Tax Amount" := Round("Withholding Tax Amount", FundsGeneralSetup."W/Tax Rounding Precision", '>');
                        end;
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Down then begin
                            "Withholding Tax Amount" := Round("Withholding Tax Amount", FundsGeneralSetup."W/Tax Rounding Precision", '<');
                        end;
                    end;
                end;
                //End Rounding
                "Net Amount" := "Total Amount" - "Withholding Tax Amount" - "Withholding VAT Amount" - "PAYE Amount" - "AHL Amount";
                if "Currency Code" <> '' then begin
                    "PAYE Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "PAYE Amount", "Currency Factor"));
                    "Net Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Net Amount", "Currency Factor"));
                end else begin
                    "PAYE Amount(LCY)" := "PAYE Amount";
                    "Net Amount(LCY)" := "Net Amount";
                end;
                Validate("PAYE Amount(LCY)");
                Validate("Net Amount(LCY)");
            end;
        }
        field(83; "PAYE Amount(LCY)"; Decimal)
        {
            Caption = 'PAYE Amount(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                //Rounding
                if FundsGeneralSetup.Get then begin
                    if FundsGeneralSetup."W/Tax Rounding Precision" <> 0 then begin
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Nearest then begin
                            "Withholding Tax Amount(LCY)" := Round("Withholding Tax Amount(LCY)", FundsGeneralSetup."W/Tax Rounding Precision", '=');
                        end;
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Up then begin
                            "Withholding Tax Amount(LCY)" := Round("Withholding Tax Amount(LCY)", FundsGeneralSetup."W/Tax Rounding Precision", '>');
                        end;
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Down then begin
                            "Withholding Tax Amount(LCY)" := Round("Withholding Tax Amount(LCY)", FundsGeneralSetup."W/Tax Rounding Precision", '<');
                        end;
                    end;
                end;
                //End Rounding
            end;
        }
        field(84; "AHL Code"; Code[10])
        {
            Caption = 'AHL Code';
            DataClassification = ToBeClassified;
            TableRelation = "Funds Tax Code"."Tax Code" WHERE(Type = CONST(AHL));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
                "AHL Amount" := 0;
                Validate("AHL Amount");

                /*IF "Withholding Tax Code"<>'' THEN BEGIN
                  FundsTaxCodes.RESET;
                  FundsTaxCodes.SETRANGE(FundsTaxCodes."Tax Code","Withholding Tax Code");
                  IF FundsTaxCodes.FINDFIRST THEN BEGIN
                    "Withholding Tax Amount":=ROUND(("Original Amount"-"VAT Amount")*(FundsTaxCodes.Percentage/100),1,'>');
                
                    VALIDATE("Withholding Tax Amount");
                  END;
                END;*/
                if "AHL Code" <> '' then begin
                    FundsTaxCodes.Reset;
                    FundsTaxCodes.SetRange(FundsTaxCodes."Tax Code", "AHL Code");
                    if FundsTaxCodes.FindFirst then begin
                        //"Withholding Tax Amount":=ROUND(("Total Amount"-"VAT Amount")*(FundsTaxCodes.Percentage/100),1,'>');
                        //UPDATED 13/07/2023
                        "AHL Amount" := Round(("Original Amount") * (FundsTaxCodes.Percentage / 100), 1, '>');
                        Validate("AHL Amount");
                    end;
                end;

            end;
        }
        field(85; "AHL Amount"; Decimal)
        {
            Caption = 'AHL Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
                //Test if Field is editable
                AmountsNotEditable;
                //Rounding
                if FundsGeneralSetup.Get then begin
                    if FundsGeneralSetup."W/Tax Rounding Precision" <> 0 then begin
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Nearest then begin
                            "Withholding Tax Amount" := Round("Withholding Tax Amount", FundsGeneralSetup."W/Tax Rounding Precision", '=');
                        end;
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Up then begin
                            "Withholding Tax Amount" := Round("Withholding Tax Amount", FundsGeneralSetup."W/Tax Rounding Precision", '>');
                        end;
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Down then begin
                            "Withholding Tax Amount" := Round("Withholding Tax Amount", FundsGeneralSetup."W/Tax Rounding Precision", '<');
                        end;
                    end;
                end;
                //End Rounding
                "Net Amount" := "Total Amount" - "Withholding Tax Amount" - "Withholding VAT Amount" - "PAYE Amount" - "AHL Amount";
                if "Currency Code" <> '' then begin
                    "AHL Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "PAYE Amount", "Currency Factor"));
                    "Net Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Net Amount", "Currency Factor"));
                end else begin
                    "AHL Amount(LCY)" := "AHL Amount";
                    "Net Amount(LCY)" := "Net Amount";
                end;
                Validate("AHL Amount(LCY)");
                Validate("Net Amount(LCY)");
            end;
        }
        field(86; "AHL Amount(LCY)"; Decimal)
        {
            Caption = 'AHL Amount(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                //Rounding
                if FundsGeneralSetup.Get then begin
                    if FundsGeneralSetup."W/Tax Rounding Precision" <> 0 then begin
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Nearest then begin
                            "Withholding Tax Amount(LCY)" := Round("Withholding Tax Amount(LCY)", FundsGeneralSetup."W/Tax Rounding Precision", '=');
                        end;
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Up then begin
                            "Withholding Tax Amount(LCY)" := Round("Withholding Tax Amount(LCY)", FundsGeneralSetup."W/Tax Rounding Precision", '>');
                        end;
                        if FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Down then begin
                            "Withholding Tax Amount(LCY)" := Round("Withholding Tax Amount(LCY)", FundsGeneralSetup."W/Tax Rounding Precision", '<');
                        end;
                    end;
                end;
                //End Rounding
            end;
        }


        field(50000; "Original Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
                //Test if Field is editable
                AmountsNotEditable;

                //Rounding
                if FundsGeneralSetup.Get then begin
                    if FundsGeneralSetup."Payment Rounding Precision" <> 0 then begin
                        if FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Nearest then begin
                            "Original Amount" := Round("Original Amount", FundsGeneralSetup."Payment Rounding Precision", '=');
                        end;
                        if FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Up then begin
                            "Original Amount" := Round("Original Amount", FundsGeneralSetup."Payment Rounding Precision", '>');
                        end;
                        if FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Down then begin
                            "Original Amount" := Round("Original Amount", FundsGeneralSetup."Payment Rounding Precision", '<');
                        end;
                    end;
                end;
                //End Rounding
                /*"Net Amount":="Total Amount";
                IF "Currency Code"<>'' THEN BEGIN
                    "Total Amount(LCY)":= ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date","Currency Code","Total Amount","Currency Factor"));
                    "Net Amount(LCY)":="Total Amount(LCY)";
                END ELSE BEGIN
                    "Total Amount(LCY)":="Total Amount";
                    "Net Amount(LCY)":="Total Amount";
                END;
                VALIDATE("Total Amount(LCY)");
                VALIDATE("Net Amount(LCY)");*/
                "Total Amount(LCY)" := "Original Amount";
                Validate("VAT Code");
                Validate("Withholding Tax Code");
                Validate("Withholding VAT Code");

            end;
        }
        field(52136965; "Job No."; Code[50])
        {
            Description = 'Jobs Management Integration';
        }
        field(52137023; "Employee Transaction Type"; Option)
        {
            Caption = 'Employee Transaction Type';
            OptionCaption = ' ,NetPay,Imprest,Allowance';
            OptionMembers = " ",NetPay,Imprest,Allowance;
        }
        field(52137024; "Retention Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Net Amount" := Round("Total Amount" - "Withholding Tax Amount" - "Withholding VAT Amount" - "Retention Amount" - "PAYE Amount" - "AHL Amount");
                //IF "Currency Code"<>'' THEN
                "Net Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Net Amount", "Currency Factor"));
            end;
        }
        field(52137025; "NdovuPay Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Payment In Progress,Payment Successful,Payment Failed';
            OptionMembers = "Payment In Progress","Payment Successful","Payment Failed";
        }
        field(52137026; "NdovuPay Response"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(52137027; "Budget Gl"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." WHERE("Account Type" = CONST(Posting));
        }
    }

    keys
    {
        key(Key1; "Line No.", "Document No.", "Payment Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        PaymentHeader.Reset;
        PaymentHeader.SetRange(PaymentHeader."No.", "Document No.");
        if PaymentHeader.FindFirst then begin
            //PaymentHeader.TESTFIELD(PaymentHeader.Status,PaymentHeader.Status::Open);
            /*IF PaymentHeader.Status=PaymentHeader.Status::Released THEN
              ERROR(Text001);*/
        end;

    end;

    trigger OnInsert()
    begin
        PaymentHeader.Reset;
        PaymentHeader.SetRange(PaymentHeader."No.", "Document No.");
        if PaymentHeader.FindFirst then begin
            PaymentHeader.TestField(Description);
            //PaymentHeader.TESTFIELD("Posting Date");
            "Document Type" := "Document Type"::Payment;
            "Posting Date" := PaymentHeader."Posting Date";
            "Currency Code" := PaymentHeader."Currency Code";
            "Currency Factor" := PaymentHeader."Currency Factor";
            Description := PaymentHeader.Description;
            "Global Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
            "Global Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
            "Shortcut Dimension 3 Code" := PaymentHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := PaymentHeader."Shortcut Dimension 4 Code";
            "Shortcut Dimension 5 Code" := PaymentHeader."Shortcut Dimension 5 Code";
            "Shortcut Dimension 6 Code" := PaymentHeader."Shortcut Dimension 6 Code";
            "Shortcut Dimension 7 Code" := PaymentHeader."Shortcut Dimension 7 Code";
            "Shortcut Dimension 8 Code" := PaymentHeader."Shortcut Dimension 8 Code";
        end;
    end;

    var
        FundsGeneralSetup: Record "Funds General Setup";
        FundsTransactionCodes: Record "Funds Transaction Code";
        FundsTaxCodes: Record "Funds Tax Code";
        "G/LAccount": Record "G/L Account";
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
        Employee: Record Employee;
        PaymentHeader: Record "Payment Header";
        PaymentLine: Record "Payment Line";
        PurchInvHeader: Record "Purch. Inv. Header";
        CurrExchRate: Record "Currency Exchange Rate";
        DocumentNotOpen: Label 'You can only modify Open Documents, Current Status is:%1';
        ApplicationNotAllowed: Label 'You cannot apply to %1';
        VendLedgEntry: Record "Vendor Ledger Entry";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        FromCurrencyCode: Code[10];
        ToCurrencyCode: Code[10];
        "Exported to Payment File": Boolean;
        "Applies-to Ext. Doc. No.": Code[35];
        Text001: Label 'You Cannot Delete line when status is Released';
        FundsTaxCodes2: Record "Funds Tax Code";
        ImprestHeader: Record "Imprest Header";
        Text005: Label 'The Imprest has already been assigned to Payment Voucher no. %1';
        Text006: Label 'The petty cash request has already been assigned to Payment Voucher no. %1';
        Allowedit: Boolean;
        BankAccount2: Record "Bank Account";
        EmployeeRec: Record Employee;
        ModeofPayment: Record "Mode of Payment";
        ModeofPaymentEmp: Code[20];
        ImprestLine: Record "Imprest Line";

    procedure LookUpAppliesToDocVend(AccNo: Code[20])
    var
        ApplyVendEntries: Page "Apply Vendor Entries";
    begin
        Clear(VendLedgEntry);
        VendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive, "Due Date");
        if AccNo <> '' then
            VendLedgEntry.SetRange("Vendor No.", AccNo);
        VendLedgEntry.SetRange(Open, true);
        if "Applies-to Doc. No." <> '' then begin
            VendLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
            VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            if VendLedgEntry.IsEmpty then begin
                VendLedgEntry.SetRange("Document Type");
                VendLedgEntry.SetRange("Document No.");
            end;
        end;
        if "Applies-to ID" <> '' then begin
            VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
            if VendLedgEntry.IsEmpty then
                VendLedgEntry.SetRange("Applies-to ID");
        end;
        if "Applies-to Doc. Type" <> "Applies-to Doc. Type"::" " then begin
            VendLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
            if VendLedgEntry.IsEmpty then
                VendLedgEntry.SetRange("Document Type");
        end;
        if "Applies-to Doc. No." <> '' then begin
            VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            if VendLedgEntry.IsEmpty then
                VendLedgEntry.SetRange("Document No.");
        end;
        if "Total Amount" <> 0 then begin
            VendLedgEntry.SetRange(Positive, "Total Amount" < 0);
            if VendLedgEntry.IsEmpty then;
            VendLedgEntry.SetRange(Positive);
        end;
        ApplyVendEntries.SetPaymentLine(Rec, PaymentLine.FieldNo("Applies-to Doc. No."));
        ApplyVendEntries.SetTableView(VendLedgEntry);
        ApplyVendEntries.SetRecord(VendLedgEntry);
        ApplyVendEntries.LookupMode(true);
        if ApplyVendEntries.RunModal = ACTION::LookupOK then begin
            ApplyVendEntries.GetRecord(VendLedgEntry);
            if AccNo = '' then begin
                AccNo := VendLedgEntry."Vendor No.";
                Validate("Account No.", AccNo);
            end;
            SetAmountWithVendLedgEntry;
            "Applies-to Doc. Type" := VendLedgEntry."Document Type";
            "Applies-to Doc. No." := VendLedgEntry."Document No.";
            "Applies-to ID" := '';
            //added on 13/07/2023
            "Original Amount" := -VendLedgEntry.Amount;
        end;
    end;

    procedure SetApplyToAmount()
    begin
        if "Account Type" = "Account Type"::Vendor then begin
            VendLedgEntry.SetCurrentKey("Document No.");
            VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            VendLedgEntry.SetRange("Vendor No.", "Account No.");
            VendLedgEntry.SetRange(Open, true);
            if VendLedgEntry.Find('-') then
                if VendLedgEntry."Amount to Apply" = 0 then begin
                    VendLedgEntry.CalcFields("Remaining Amount");
                    VendLedgEntry."Amount to Apply" := VendLedgEntry."Remaining Amount";
                    CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", VendLedgEntry);
                end;
        end;
    end;

    local procedure GetAccTypeAndNo(PaymentLine2: Record "Payment Line"; var AccType: Option; var AccNo: Code[20])
    begin
        AccType := PaymentLine2."Account Type";
        AccNo := PaymentLine2."Account No.";
    end;

    local procedure SetAmountWithVendLedgEntry()
    begin
        if "Currency Code" <> VendLedgEntry."Currency Code" then
            CheckModifyCurrencyCode("Account Type"::Vendor, VendLedgEntry."Currency Code");
        if "Total Amount" = 0 then begin
            VendLedgEntry.CalcFields("Remaining Amount");
            SetAmountWithRemaining(false, VendLedgEntry."Amount to Apply", VendLedgEntry."Remaining Amount", VendLedgEntry."Remaining Pmt. Disc. Possible");
        end;
    end;

    procedure CheckModifyCurrencyCode(AccountType: Option; CustVendLedgEntryCurrencyCode: Code[10])
    begin
    end;

    local procedure SetAmountWithRemaining(CalcPmtDisc: Boolean; AmountToApply: Decimal; RemainingAmount: Decimal; RemainingPmtDiscPossible: Decimal)
    begin
        if AmountToApply <> 0 then
            if CalcPmtDisc and (Abs(AmountToApply) >= Abs(RemainingAmount - RemainingPmtDiscPossible)) then
                "Total Amount" := -(RemainingAmount - RemainingPmtDiscPossible)
            else
                "Total Amount" := -AmountToApply
        else
            if CalcPmtDisc then
                "Total Amount" := -(RemainingAmount - RemainingPmtDiscPossible)
            else
                "Total Amount" := -RemainingAmount;
        Validate("Total Amount");
    end;

    local procedure SetPaymentLineFieldsFromApplication()
    var
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        AccNo: Code[20];
    begin
        "Exported to Payment File" := false;
        GetAccTypeAndNo(Rec, AccType, AccNo);
        case AccType of
            AccType::Vendor:
                if "Applies-to ID" <> '' then begin
                    if FindFirstVendLedgEntryWithAppliesToID(AccNo, "Applies-to ID") then begin
                        VendLedgEntry.SetRange("Exported to Payment File", true);
                        "Exported to Payment File" := VendLedgEntry.FindFirst;
                    end
                end else
                    if "Applies-to Doc. No." <> '' then
                        if FindFirstVendLedgEntryWithAppliesToDocNo(AccNo, "Applies-to Doc. No.") then begin
                            "Exported to Payment File" := VendLedgEntry."Exported to Payment File";
                            "Applies-to Ext. Doc. No." := VendLedgEntry."External Document No.";
                            "Vendor Invoice No" := VendLedgEntry."External Document No.";
                        end;
        end;
    end;

    local procedure FindFirstVendLedgEntryWithAppliesToID(AccNo: Code[20]; AppliesToID: Code[50]): Boolean
    begin
        VendLedgEntry.Reset;
        VendLedgEntry.SetCurrentKey("Vendor No.", "Applies-to ID", Open);
        VendLedgEntry.SetRange("Vendor No.", AccNo);
        VendLedgEntry.SetRange("Applies-to ID", AppliesToID);
        VendLedgEntry.SetRange(Open, true);
        exit(VendLedgEntry.FindFirst)
    end;

    local procedure FindFirstVendLedgEntryWithAppliesToDocNo(AccNo: Code[20]; AppliestoDocNo: Code[20]): Boolean
    begin
        VendLedgEntry.Reset;
        VendLedgEntry.SetCurrentKey("Document No.");
        VendLedgEntry.SetRange("Document No.", AppliestoDocNo);
        VendLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
        VendLedgEntry.SetRange("Vendor No.", AccNo);
        VendLedgEntry.SetRange(Open, true);
        exit(VendLedgEntry.FindFirst)
    end;

    local procedure TestStatusOpen(AllowApproverEdit: Boolean)
    var
        PaymentHeader: Record "Payment Header";
        ApprovalEntry: Record "Approval Entry";
    begin
        /*PaymentHeader.GET("Document No.");
        IF AllowApproverEdit THEN BEGIN
          ApprovalEntry.RESET;
          ApprovalEntry.SETRANGE(ApprovalEntry."Document No.",PaymentHeader."No.");
          ApprovalEntry.SETRANGE(ApprovalEntry.Status,ApprovalEntry.Status::Open);
          ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID",USERID);
          IF NOT ApprovalEntry.FINDFIRST THEN BEGIN
            PaymentHeader.TESTFIELD(Status,PaymentHeader.Status::Open);
          END;
        END ELSE BEGIN
          PaymentHeader.TESTFIELD(Status,PaymentHeader.Status::Open);
        END;*/

    end;

    local procedure AmountsNotEditable()
    begin
        if not Allowedit then
            if "Payee Type" in ["Payee Type"::Allowance, "Payee Type"::"Salary Advance", "Payee Type"::Imprest, "Payee Type"::"Petty Cash Request"] then
                Error('You are not allowed to edit this field');
    end;
}

