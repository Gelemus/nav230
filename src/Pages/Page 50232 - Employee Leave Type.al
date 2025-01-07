page 50232 "Employee Leave Type"
{
    PageType = List;
    SourceTable = "Employee Leave Type";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Leave Type"; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the Leave Type.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the allocated days.';
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                    ToolTip = 'Specifies the Leave Balance.';
                }
            }
        }
    }

    actions
    {
    }
}

