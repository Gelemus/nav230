page 52244 "Concept Notes Line"
{
    PageType = ListPart;
    SourceTable = "Concept Notes";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(Date; Rec.Date)
                {
                }
                field("Concept Note"; Rec."Concept Note")
                {
                }
            }
        }
    }

    actions
    {
    }
}

