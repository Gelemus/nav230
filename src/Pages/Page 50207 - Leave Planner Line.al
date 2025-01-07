page 50207 "Leave Planner Line"
{
    PageType = ListPart;
    SourceTable = "HR Leave Planner Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies start Date.';
                }
                field("No. of Days"; Rec."No. of Days")
                {
                    ToolTip = 'Specifies No. of days.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the End Date.';
                }
                field("Reliever No."; Rec."Reliever No.")
                {
                    ToolTip = 'Specifies subsititute Employee No.';
                }
                field("Reliever Name"; Rec."Reliever Name")
                {
                    ToolTip = 'Specifies the Substitute Employee Name.';
                }
            }
        }
    }

    actions
    {
    }
}

