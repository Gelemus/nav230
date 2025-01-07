page 50196 "Employee Detail Updates"
{
    CardPageID = "Employee Detail Update Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HR Employee Detail Update";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the  No.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the  Employee No.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the  Employee Name.';
                }
                field("Update Option"; Rec."Update Option")
                {
                    ToolTip = 'Specifies the  update option.';
                }
            }
        }
    }

    actions
    {
    }
}

