table 50015 "Payment Line Import Buffer"
{
    Caption = 'Payment Line Import Buffer';

    fields
    {
        field(1;"Line No.";BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(4;"Payment Code";Code[50])
        {
            Caption = 'Payment Code';
            TableRelation = "Funds Transaction Code"."Transaction Code" WHERE ("Transaction Type"=CONST(Payment));

            trigger OnValidate()
            begin
                FundsTransactionCodes.Reset;
                FundsTransactionCodes.SetRange(FundsTransactionCodes."Transaction Code","Payment Code");
                if FundsTransactionCodes.FindFirst then begin
                  "Account Type":=FundsTransactionCodes."Account Type";
                  "Account No.":=FundsTransactionCodes."Account No.";
                end;
            end;
        }
        field(6;"Account Type";Option)
        {
            Caption = 'Account Type';
            Editable = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(7;"Account No.";Code[20])
        {
            Caption = 'Account No.';
            Editable = false;
            TableRelation = IF ("Account Type"=CONST("G/L Account")) "G/L Account"."No."
                            ELSE IF ("Account Type"=CONST(Customer)) Customer."No."
                            ELSE IF ("Account Type"=CONST(Vendor)) Vendor."No."
                            ELSE IF ("Account Type"=CONST(Employee)) Employee."No.";
        }
        field(10;Description;Text[100])
        {
            Caption = 'Description';
        }
        field(20;"Reference No.";Code[20])
        {
        }
        field(23;"Total Amount";Decimal)
        {
            Caption = 'Amount';
        }
        field(100;"User ID";Code[50])
        {
        }
    }

    keys
    {
        key(Key1;"Line No.","User ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User ID":=UserId;
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
        "Applies-to Ext. Doc. No.": Code[20];
        Text001: Label 'You Cannot Delete line when status is Released';
        FundsTaxCodes2: Record "Funds Tax Code";
}

