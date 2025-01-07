table 50007 "Funds Transfer Line"
{
    Caption = 'Funds Transfer Line';

    fields
    {
        field(1;"Line No.";Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(2;"Document No.";Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
            TableRelation = "Funds Transfer Header"."No.";
        }
        field(3;"Document Type";Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender";
        }
        field(4;"Money Transfer Code";Code[50])
        {
            Caption = 'Money Transfer Code';
        }
        field(5;"Money Transfer Description";Text[100])
        {
            Caption = 'Money Transfer Description';
            Editable = false;
        }
        field(6;"Account Type";Option)
        {
            Caption = 'Account Type';
            OptionCaption = ' ,Bank Account';
            OptionMembers = " ","Bank Account";
        }
        field(7;"Account No.";Code[20])
        {
            Caption = 'Account No.';
            Editable = true;
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                "Account Name":='';

                FundsTransferHeader.Reset;
                FundsTransferHeader.SetRange(FundsTransferHeader."No.","Document No.");
                FundsTransferHeader.SetRange(FundsTransferHeader."Bank Account No.","Account No.");
                if FundsTransferHeader.FindFirst then begin
                   Error(SimilarBank);
                end;

                BankAccount.Reset;
                BankAccount.SetRange(BankAccount."No.","Account No.");
                if BankAccount.FindFirst then begin
                  "Account Name":=BankAccount.Name;
                end;
            end;
        }
        field(8;"Account Name";Text[100])
        {
            Caption = 'Account Name';
            Editable = false;
        }
        field(9;"Posting Group";Code[20])
        {
            Caption = 'Posting Group';
            Editable = false;
        }
        field(10;Description;Text[100])
        {
            Caption = 'Description';
        }
        field(20;"Posting Date";Date)
        {
            Caption = 'Posting Date';
        }
        field(21;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(22;"Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
        }
        field(23;Amount;Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            begin
                FundsTransferHeader.Reset;
                if FundsTransferHeader.Get("Document No.") then begin
                  if FundsTransferHeader."Currency Code"<>'' then begin
                    "Amount(LCY)":= Round(CurrExchRate.ExchangeAmtFCYToLCY(FundsTransferHeader."Posting Date",FundsTransferHeader."Currency Code",Amount,FundsTransferHeader."Currency Factor"));
                  end else begin
                    "Amount(LCY)":=Amount;
                  end;
                end;
            end;
        }
        field(24;"Amount(LCY)";Decimal)
        {
            Caption = 'Amount(LCY)';
            Editable = false;
        }
        field(50;"Global Dimension 1 Code";Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(51;"Global Dimension 2 Code";Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(52;"Shortcut Dimension 3 Code";Code[50])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(53;"Shortcut Dimension 4 Code";Code[50])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(54;"Shortcut Dimension 5 Code";Code[50])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(55;"Shortcut Dimension 6 Code";Code[50])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(56;"Shortcut Dimension 7 Code";Code[50])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(57;"Shortcut Dimension 8 Code";Code[50])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(58;"Responsibility Center";Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center".Code;
        }
        field(70;Status;Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Released,Rejected,Posted,Reversed';
            OptionMembers = Open,"Pending Approval",Released,Rejected,Posted,Reversed;
        }
        field(71;Posted;Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(72;"Posted By";Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(73;"Date Posted";Date)
        {
            Caption = 'Date Posted';
            Editable = false;
        }
        field(74;"Time Posted";Time)
        {
            Caption = 'Time Posted';
            Editable = false;
        }
        field(75;Reversed;Boolean)
        {
            Caption = 'Reversed';
            Editable = false;
        }
        field(76;"Reversed By";Code[50])
        {
            Caption = 'Reversed By';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(77;"Reversal Date";Date)
        {
            Caption = 'Reversal Date';
            Editable = false;
        }
        field(78;"Reversal Time";Time)
        {
            Caption = 'Reversal Time';
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Line No.","Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Status,Status::Open);
    end;

    trigger OnInsert()
    begin
        FundsTransferHeader.Reset;
        FundsTransferHeader.SetRange("No.","Document No.");
        if FundsTransferHeader.FindFirst then begin
          "Document Type":="Document Type"::"Funds Transfer";
          "Posting Date":=FundsTransferHeader."Posting Date";
          "Currency Code":=FundsTransferHeader."Currency Code";
          "Money Transfer Description":=FundsTransferHeader.Description;
          "Currency Factor":=FundsTransferHeader."Currency Factor";
          "Global Dimension 1 Code":=FundsTransferHeader."Global Dimension 1 Code";
          "Global Dimension 2 Code":=FundsTransferHeader."Global Dimension 2 Code";
          "Shortcut Dimension 3 Code":=FundsTransferHeader."Shortcut Dimension 3 Code";
          "Shortcut Dimension 4 Code":=FundsTransferHeader."Shortcut Dimension 4 Code";
          "Shortcut Dimension 5 Code":=FundsTransferHeader."Shortcut Dimension 5 Code";
          "Shortcut Dimension 6 Code":=FundsTransferHeader."Shortcut Dimension 6 Code";
          "Shortcut Dimension 7 Code":=FundsTransferHeader."Shortcut Dimension 7 Code";
          "Shortcut Dimension 8 Code":=FundsTransferHeader."Shortcut Dimension 8 Code";
        end;
    end;

    var
        FundsTransactionCodes: Record "Funds Transaction Code";
        FundsTaxCodes: Record "Funds Tax Code";
        "G/LAccount": Record "G/L Account";
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
        FundsTransferHeader: Record "Funds Transfer Header";
        FundsTransferLine: Record "Funds Transfer Line";
        CurrExchRate: Record "Currency Exchange Rate";
        SimilarBank: Label 'This account is similar to account where money is being received from';
}
