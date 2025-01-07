page 51215 "Non Payroll Receipts"
{
    PageType = List;
    SourceTable = "Non payroll Receipt";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("ED Code"; Rec."ED Code")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

