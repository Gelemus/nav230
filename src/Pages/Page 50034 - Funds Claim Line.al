page 50034 "Funds Claim Line"
{
    PageType = ListPart;
    SourceTable = "Funds Claim Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Funds Claim Code"; Rec."Funds Claim Code")
                {
                }
                field("Funds Claim Code Description"; Rec."Funds Claim Code Description")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

