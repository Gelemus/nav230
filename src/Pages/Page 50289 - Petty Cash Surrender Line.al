page 50289 "Petty Cash Surrender Line"
{
    PageType = ListPart;
    SourceTable = "Imprest Surrender Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Imprest Code"; Rec."Imprest Code")
                {
                    Caption = 'Petty Cash Code';
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
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Gross Amount"; Rec."Gross Amount")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Gross Amount(LCY)"; Rec."Gross Amount(LCY)")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Paid Amount"; Rec."Paid Amount")
                {
                }
                field("Tax Amount"; Rec."Tax Amount")
                {
                }
                field("Actual Spent"; Rec."Actual Spent")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Actual Spent(LCY)"; Rec."Actual Spent(LCY)")
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Difference; Rec.Difference)
                {
                }
                field("Difference(LCY)"; Rec."Difference(LCY)")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("FA Depreciation Book"; Rec."FA Depreciation Book")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

