page 50048 "Funds User Setup"
{
    PageType = List;
    SourceTable = "Funds User Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(UserID; UserID)
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Receipt Journal Template"; Rec."Receipt Journal Template")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Receipt Journal Batch"; Rec."Receipt Journal Batch")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Payment Journal Template"; Rec."Payment Journal Template")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Payment Journal Batch"; Rec."Payment Journal Batch")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Fund Transfer Template Name"; Rec."Fund Transfer Template Name")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Fund Transfer Batch Name"; Rec."Fund Transfer Batch Name")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Funds Claim Template"; Rec."Funds Claim Template")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Funds Claim  Batch"; Rec."Funds Claim  Batch")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Imprest Template"; Rec."Imprest Template")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Imprest Batch"; Rec."Imprest Batch")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("JV Template"; Rec."JV Template")
                {
                }
                field("JV Batch"; Rec."JV Batch")
                {
                }
                field("Reversal Template"; Rec."Reversal Template")
                {
                }
                field("Reversal Batch"; Rec."Reversal Batch")
                {
                }
                field("Default Receipts Bank"; Rec."Default Receipts Bank")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Default Payment Bank"; Rec."Default Payment Bank")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Default Petty Cash Bank"; Rec."Default Petty Cash Bank")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Allowance Template"; Rec."Allowance Template")
                {
                }
                field("Allowance Batch"; Rec."Allowance Batch")
                {
                }
            }
        }
    }

    actions
    {
    }
}

