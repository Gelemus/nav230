page 50381 "Leave Types WS"
{
    PageType = List;
    SourceTable = "HR Leave Types";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the Gender.';
                }
                field(Days; Rec.Days)
                {
                    ToolTip = 'Specifies the Days.';
                }
                field("Annual Leave"; Rec."Annual Leave")
                {
                }
                field("Inclusive of Non Working Days"; Rec."Inclusive of Non Working Days")
                {
                }
                field("Take as Block"; Rec."Take as Block")
                {
                }
                field("Max Carry Forward Days"; Rec."Max Carry Forward Days")
                {
                }
            }
        }
    }

    actions
    {
    }
}

