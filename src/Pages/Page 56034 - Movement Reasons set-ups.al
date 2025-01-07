page 56034 "Movement Reasons set-ups"
{
    PageType = List;
    SourceTable = "Movement Reasons set-ups";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control6; Outlook)
            {
            }
            systempart(Control7; Notes)
            {
            }
            systempart(Control8; Links)
            {
            }
        }
    }

    actions
    {
    }
}

