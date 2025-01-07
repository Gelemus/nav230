page 52257 "HandOver DocLines"
{
    PageType = ListPart;
    SourceTable = "HandOver Document";

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
                field("Document Name"; Rec."Document Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

