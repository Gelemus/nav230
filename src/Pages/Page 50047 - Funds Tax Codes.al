page 50047 "Funds Tax Codes"
{
    PageType = List;
    SourceTable = "Funds Tax Code";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tax Code"; Rec."Tax Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Type; Rec.Type)
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
                field(Percentage; Rec.Percentage)
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ToolTip = 'Specifies the field name';
                }
            }
        }
    }

    actions
    {
    }
}

