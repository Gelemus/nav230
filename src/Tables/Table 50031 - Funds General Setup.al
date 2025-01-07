table 50031 "Funds General Setup"
{
    Caption = 'Funds General Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Payment Voucher Nos."; Code[20])
        {
            Caption = 'Payment Voucher Nos.';
            TableRelation = "No. Series".Code;
        }
        field(3; "Cash Voucher Nos."; Code[20])
        {
            Caption = 'Cash Voucher Nos.';
            TableRelation = "No. Series".Code;
        }
        field(4; "Receipt Nos."; Code[20])
        {
            Caption = 'Receipt Nos.';
            TableRelation = "No. Series".Code;
        }
        field(5; "Funds Transfer Nos."; Code[20])
        {
            Caption = 'Money Transfer Nos.';
            TableRelation = "No. Series".Code;
        }
        field(6; "Imprest Nos."; Code[20])
        {
            Caption = 'Imprest Nos.';
            TableRelation = "No. Series".Code;
        }
        field(7; "Imprest Surrender Nos."; Code[20])
        {
            Caption = 'Imprest Surrender Nos.';
            TableRelation = "No. Series".Code;
        }
        field(8; "Funds Claim Nos."; Code[20])
        {
            Caption = 'Funds Claim Nos.';
            TableRelation = "No. Series".Code;
        }
        field(9; "Travel Advance Nos."; Code[20])
        {
            Caption = 'Travel Advance Nos.';
            TableRelation = "No. Series".Code;
        }
        field(10; "Travel Surrender Nos."; Code[20])
        {
            Caption = 'Travel Surrender Nos.';
            TableRelation = "No. Series".Code;
        }
        field(11; "Payment Voucher Reference Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(15; "Loan Receipt Nos."; Code[20])
        {
            Caption = 'Receipt Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(20; "Budget Allocation Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(25; "JV Nos."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50; "Payment Rounding Type"; Option)
        {
            Caption = 'Payment Rounding Type';
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest,Up,Down;
        }
        field(51; "Payment Rounding Precision"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Payment Rounding Precision';
        }
        field(52; "W/Tax Rounding Type"; Option)
        {
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest,Up,Down;
        }
        field(53; "W/Tax Rounding Precision"; Decimal)
        {
        }
        field(54; "W/VAT Rounding Type"; Option)
        {
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest,Up,Down;
        }
        field(55; "W/VAT Rounding Precision"; Decimal)
        {
        }
        field(56; "Cheque Register No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(57; "Reversal Header"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(58; "Fixed Deposit Receivable A/c"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(59; "Fixed Deposit Interest A/c"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(60; "Allowance Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(61; "Petty Cash Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(62; "Petty Cash Surrender Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(63; "Petty Cash Amount Max"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Board Member Allowance Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(65; "Deposit Refund Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(66; "Deposit Refund Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Deposit gl Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Transport Requisition Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Overtime Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(70; "Maximum Imprest Requests"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Casual Payment Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(72; "Deposit Refunds Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(73; "Casual Daily Wk  Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(74; "W-VAT Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(75; "Salary Advance Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(76; "Memo Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

