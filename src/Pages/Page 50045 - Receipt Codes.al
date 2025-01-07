page 50045 "Receipt Codes"
{
    CardPageID = "Funds Transaction Code Card";
    PageType = List;
    SourceTable = "Funds Transaction Code";
    SourceTableView = WHERE("Transaction Type" = CONST(Receipt));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Include VAT"; Rec."Include VAT")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Include Withholding Tax"; Rec."Include Withholding Tax")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Include Withholding VAT"; Rec."Include Withholding VAT")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Withholding VAT Code"; Rec."Withholding VAT Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Employee Transaction Type"; Rec."Employee Transaction Type")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Transaction Type" := Rec."Transaction Type"::Receipt;
    end;
}

