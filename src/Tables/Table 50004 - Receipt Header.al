table 50004 "Receipt Header"
{
    Caption = 'Receipt Header';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender";
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Editable = false;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Payment Mode"; Option)
        {
            Caption = 'Payment Mode';
            Editable = true;
            OptionCaption = ' ,Cheque,EFT,RTGS,MPESA,Cash';
            OptionMembers = " ",Cheque,EFT,RTGS,MPESA,Cash;
        }
        field(6; "Receipt Type"; Option)
        {
            Caption = 'Receipt Type';
            OptionCaption = ' ,Staff Loan,Investment Loan,Normal Receipt,Equity';
            OptionMembers = " ","Staff Loan","Investment Loan","Normal Receipt",Equity;
        }
        field(7; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Receipt Types" = CONST(Bank)) "Bank Account"."No."
            ELSE IF ("Receipt Types" = CONST("G/L Account")) "Funds Transaction Code"."Transaction Code";

            trigger OnValidate()
            begin
                TestField("Posting Date");
                "Account Name" := '';
                "Currency Code" := '';

                if "Receipt Types" = "Receipt Types"::Bank then begin
                    BankAccount.Reset;
                    BankAccount.SetRange(BankAccount."No.", "Account No.");
                    if BankAccount.FindFirst then begin
                        "Account Name" := BankAccount.Name;
                        "Currency Code" := BankAccount."Currency Code";
                        Validate("Currency Code");
                    end;
                end;

                if "Receipt Types" = "Receipt Types"::"G/L Account" then begin
                    FundsTransactionCode.Reset;
                    FundsTransactionCode.SetRange("Transaction Code", "Account No.");
                    if FundsTransactionCode.FindFirst then begin
                        "Account Name" := FundsTransactionCode."Account Name";
                    end;
                end;
            end;
        }
        field(8; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
            Editable = false;
        }
        field(9; "Account Balance"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FIELD("Account No.")));
            Caption = 'Bank Account Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Reference No."; Code[20])
        {
            Caption = 'Reference No.';

            trigger OnValidate()
            begin
                /*ReceiptHeader.RESET;
                ReceiptHeader.SETRANGE(ReceiptHeader."Reference No.","Reference No.");
                IF ReceiptHeader.FINDSET THEN BEGIN
                  REPEAT
                    IF ReceiptHeader."No."<>"No." THEN
                      ERROR(ReferenceNoError,"Reference No.",ReceiptHeader."No.");
                  UNTIL ReceiptHeader.NEXT=0;
                END;
                */

            end;
        }
        field(14; "Received From"; Text[100])
        {
            Caption = 'Received From';

            trigger OnValidate()
            begin
                "Received From" := UpperCase("Received From");
            end;
        }
        field(15; "On Behalf of"; Text[100])
        {
            Caption = 'On Behalf of';
        }
        field(16; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                TestField("Account No.");
                TestField("Posting Date");
                if "Currency Code" <> '' then begin
                    if BankAccount.Get("Account No.") then begin
                        BankAccount.TestField(BankAccount."Currency Code", "Currency Code");
                        "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                    end;
                end else begin
                    if BankAccount.Get("Account No.") then begin
                        BankAccount.TestField(BankAccount."Currency Code", '');
                    end;
                end;
                Validate("Amount Received");
            end;
        }
        field(17; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
        }
        field(18; "Amount Received"; Decimal)
        {
            Caption = 'Amount Received';

            trigger OnValidate()
            begin
                if "Currency Code" <> '' then begin
                    "Amount Received(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Amount Received", "Currency Factor"));
                end else begin
                    "Amount Received(LCY)" := "Amount Received";
                end;
            end;
        }
        field(19; "Amount Received(LCY)"; Decimal)
        {
            Caption = 'Amount Received(LCY)';
            Editable = false;
        }
        field(20; "Line Amount"; Decimal)
        {
            CalcFormula = Sum("Receipt Line".Amount WHERE("Document No." = FIELD("No.")));
            Caption = 'Line Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Line Amount(LCY)"; Decimal)
        {
            CalcFormula = Sum("Receipt Line"."Amount(LCY)" WHERE("Document No." = FIELD("No.")));
            Caption = 'Line Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(49; Description; Text[100])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                Description := UpperCase(Description);
            end;
        }
        field(50; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(51; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false),
                                                          test = FIELD("Global Dimension 1 Code"));
        }
        field(52; "Shortcut Dimension 3 Code"; Code[50])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false),
                                                          test = FIELD("Global Dimension 1 Code"));
        }
        field(53; "Shortcut Dimension 4 Code"; Code[50])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false),
                                                          test = FIELD("Global Dimension 1 Code"));
        }
        field(54; "Shortcut Dimension 5 Code"; Code[50])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false),
                                                          test = FIELD("Global Dimension 1 Code"));
        }
        field(55; "Shortcut Dimension 6 Code"; Code[50])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false),
                                                          test = FIELD("Global Dimension 1 Code"));
        }
        field(56; "Shortcut Dimension 7 Code"; Code[50])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false),
                                                          test = FIELD("Global Dimension 1 Code"));
        }
        field(57; "Shortcut Dimension 8 Code"; Code[50])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false),
                                                          test = FIELD("Global Dimension 1 Code"));
        }
        field(58; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center".Code;
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Released,Rejected,Posted,Reversed';
            OptionMembers = Open,"Pending Approval",Released,Rejected,Posted,Reversed;

            trigger OnValidate()
            begin
                ReceiptLine.Reset;
                ReceiptLine.SetRange(ReceiptLine."Document No.", "No.");
                if ReceiptLine.FindSet then begin
                    repeat
                        ReceiptLine.Status := Status;
                        ReceiptLine.Modify;
                    until ReceiptLine.Next = 0;
                end;
            end;
        }
        field(71; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = true;
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
        field(80; "Reversal Posting Date"; Date)
        {
        }
        field(99; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(100; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(102; "Incoming Document Entry No."; Integer)
        {
        }
        field(103; "Receipt Types"; Option)
        {
            Caption = 'Receipt Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Bank,G/L Account';
            OptionMembers = Bank,"G/L Account";
        }
        field(110; "Posted to Cheque Buffer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52137640; "Investment Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            //  TableRelation = "Receipt Type" = CONST("Investment Loan") "Meeting Attendance"."Meeting No" WHERE("Committee Code" = FIELD("Client No."))
        }
        field(52137641; "Loan Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Loan Disbursed,Principal Receivable,Principal Paid,Interest Receivable,Interest Paid,Penalty Receivable,Penalty Paid,Loan Charge Receivable,Loan Charge Paid';
            OptionMembers = " ","Loan Disbursed","Principal Receivable","Principal Paid","Interest Receivable","Interest Paid","Penalty Receivable","Penalty Paid","Loan Charge Receivable","Loan Charge Paid";
        }
        field(52137861; "LP Ready for Posting"; Boolean)
        {
        }
        field(52137862; "Loan Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Table52137625.Field1;
        }
        field(52137880; "Client No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer WHERE("Account Type" = CONST(Investment));

            trigger OnValidate()
            begin
                if Customer.Get("Client No.") then
                    "Client Name" := Customer.Name;
            end;
        }
        field(52137881; "Client Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52137882; "Deposit Transaction No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137883; "Date Cancelled"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(52137884; "Cancelled By"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Status, Status::Open);

        ReceiptLine.Reset;
        ReceiptLine.SetRange(ReceiptLine."Document No.", "No.");
        if ReceiptLine.FindSet then
            ReceiptLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            FundsSetup.Get;
            FundsSetup.TestField(FundsSetup."Receipt Nos.");
            NoSeriesMgt.InitSeries(FundsSetup."Receipt Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Document Type" := "Document Type"::Receipt;
        "Document Date" := Today;
        "User ID" := UserId;
        //"Posting Date":=TODAY;
    end;

    var
        FundsSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        "G/LAccount": Record "G/L Account";
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
        ReceiptHeader: Record "Receipt Header";
        ReceiptLine: Record "Receipt Line";
        CurrExchRate: Record "Currency Exchange Rate";
        ReferenceNoError: Label 'The Reference Number:%1  is already used in Receipt No:%2';
        FundsTransactionCode: Record "Funds Transaction Code";
}

