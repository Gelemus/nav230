page 50043 "Funds Transaction Code Card"
{
    PageType = Card;
    SourceTable = "Funds Transaction Code";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Funds Claim Code"; Rec."Funds Claim Code")
                {
                    ApplicationArea = All;
                }
            }
            group(Posting)
            {
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field("Imprest Type"; Rec."Imprest Type")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Posting Group"; Rec."Posting Group")
                {
                }
            }
            group(Taxes)
            {
                field("Include VAT"; Rec."Include VAT")
                {
                    ApplicationArea = All;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ApplicationArea = All;
                }
                field("Include Withholding Tax"; Rec."Include Withholding Tax")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ApplicationArea = All;
                }
                field("Include Withholding VAT"; Rec."Include Withholding VAT")
                {
                    ApplicationArea = All;
                }
                field("Withholding VAT Code"; Rec."Withholding VAT Code")
                {
                }
                field("Minimum Non Taxable Amount"; Rec."Minimum Non Taxable Amount")
                {
                    ApplicationArea = All;
                }
            }
            group("HR Integration")
            {
                field("Employee Transaction Type"; Rec."Employee Transaction Type")
                {
                }
            }
            group("Payroll Integration")
            {
                field("Payroll Taxable"; Rec."Payroll Taxable")
                {
                }
                field("Payroll Allowance Code"; Rec."Payroll Allowance Code")
                {
                }
                field("Payroll Deduction Code"; Rec."Payroll Deduction Code")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Transaction Type" := Rec."Transaction Type"::Imprest;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Transaction Type" := Rec."Transaction Type"::Imprest;
    end;
}

