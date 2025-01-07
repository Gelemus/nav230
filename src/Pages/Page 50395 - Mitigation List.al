page 50395 "Mitigation List"
{
    PageType = ListPart;
    SourceTable = Mitigation;

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

