page 51214 "Master Roll Group"
{
    PageType = List;
    SourceTable = "Calculation Scheme Master Roll";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payroll Code"; Rec."Payroll Code")
                {
                }
                field(Number; Rec.Number)
                {
                }
                field("ED Code"; Rec."ED Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Value Source"; Rec."Value Source")
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

