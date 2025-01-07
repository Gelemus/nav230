page 51205 "Employee Customer Loan Link"
{
    PageType = List;
    SourceTable = "payroll line";

    layout
    {
        area(content)
        {
            repeater(Control1102754000)
            {
                ShowCaption = false;
                field("Employee No"; Rec."Employee No")
                {
                    Visible = false;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                }
                field("Customer No"; Rec."Customer No")
                {
                }
            }
        }
    }

    actions
    {
    }
}

