page 50394 "Risk List"
{
    PageType = ListPart;
    SourceTable = Risk;

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

