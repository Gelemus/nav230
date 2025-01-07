page 50229 "Leave Types"
{
    CardPageID = "Leave Type Card";
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
            }
        }
    }

    actions
    {
    }
}

