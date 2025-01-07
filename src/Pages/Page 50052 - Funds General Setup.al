page 50052 "Funds General Setups"
{
    PageType = Card;
    SourceTable = "Funds General Setup";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                field("Payment Voucher Nos."; Rec."Payment Voucher Nos.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Salary Advance Account"; Rec."Salary Advance Account")
                {
                }
                field("Cash Voucher Nos."; Rec."Cash Voucher Nos.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Receipt Nos."; Rec."Receipt Nos.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Funds Transfer Nos."; Rec."Funds Transfer Nos.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Allowance Nos"; Rec."Allowance Nos")
                {
                }
                field("Petty Cash Nos"; Rec."Petty Cash Nos")
                {
                }
                field("Imprest Nos."; Rec."Imprest Nos.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Memo Nos"; Rec."Memo Nos")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Imprest Surrender Nos."; Rec."Imprest Surrender Nos.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Petty Cash Surrender Nos"; Rec."Petty Cash Surrender Nos")
                {
                }
                field("Board Member Allowance Nos"; Rec."Board Member Allowance Nos")
                {
                }
                field("Funds Claim Nos."; Rec."Funds Claim Nos.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Travel Advance Nos."; Rec."Travel Advance Nos.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Travel Surrender Nos."; Rec."Travel Surrender Nos.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Payment Voucher Reference Nos."; Rec."Payment Voucher Reference Nos.")
                {
                }
                field("Budget Allocation Nos."; Rec."Budget Allocation Nos.")
                {
                }
                field("Cheque Register No."; Rec."Cheque Register No.")
                {
                }
                field("Overtime Nos"; Rec."Overtime Nos")
                {
                }
                field("Reversal Header"; Rec."Reversal Header")
                {
                }
                field("W-VAT Nos"; Rec."W-VAT Nos")
                {
                }
                field("JV Nos."; Rec."JV Nos.")
                {
                }
                field("Deposit Refund Nos"; Rec."Deposit Refund Nos")
                {
                }
                field("Casual Payment Nos"; Rec."Casual Payment Nos")
                {
                }
            }
            group(Rounding)
            {
                field("Payment Rounding Type"; Rec."Payment Rounding Type")
                {
                }
                field("Payment Rounding Precision"; Rec."Payment Rounding Precision")
                {
                }
                field("W/Tax Rounding Type"; Rec."W/Tax Rounding Type")
                {
                }
                field("W/Tax Rounding Precision"; Rec."W/Tax Rounding Precision")
                {
                }
                field("W/VAT Rounding Type"; Rec."W/VAT Rounding Type")
                {
                }
                field("W/VAT Rounding Precision"; Rec."W/VAT Rounding Precision")
                {
                }
            }
            group("Fixed Deposit")
            {
                field("Fixed Deposit Receivable A/c"; Rec."Fixed Deposit Receivable A/c")
                {
                }
                field("Fixed Deposit Interest A/c"; Rec."Fixed Deposit Interest A/c")
                {
                }
                field("Maximum Imprest Requests"; Rec."Maximum Imprest Requests")
                {
                    // DataClassification = ToBeClassified;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
    }
}

