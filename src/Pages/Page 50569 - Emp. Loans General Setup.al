page 50569 "Emp. Loans General Setup"
{
    PageType = List;
    SourceTable = "Employee Loans General Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Application No's"; Rec."Loan Application No's")
                {
                }
            }
        }
    }

    actions
    {
    }
}

