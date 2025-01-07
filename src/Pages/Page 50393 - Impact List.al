page 50393 "Impact List"
{
    PageType = ListPart;
    SourceTable = Impact;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Risk Id"; Rec."Risk Id")
                {
                    Caption = 'Line No';
                }
            }
        }
    }

    actions
    {
    }
}

