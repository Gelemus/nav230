page 50568 "Employee Loans User Setup"
{
    PageType = List;
    SourceTable = "Employee Loans User Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                }
                field("HR Manager"; Rec."HR Manager")
                {
                }
            }
        }
    }

    actions
    {
    }
}

