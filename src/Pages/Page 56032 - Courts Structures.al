page 56032 "Courts Structures"
{
    PageType = List;
    SourceTable = "Courts Structures";

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

