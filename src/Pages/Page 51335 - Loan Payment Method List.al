page 51335 "Loan Payment Method List"
{
    Editable = false;
    PageType = List;
    SourceTable = "Loan Payments";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

