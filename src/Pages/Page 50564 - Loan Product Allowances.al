page 50564 "Loan Product Allowances"
{
    PageType = ListPart;
    SourceTable = "Loan Product Allowances";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Product Code"; Rec."Loan Product Code")
                {
                }
                field("Payroll Transaction Code"; Rec."Payroll Transaction Code")
                {
                }
                field("Payroll Transaction Name"; Rec."Payroll Transaction Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

