page 50396 "Residual Risk List"
{
    PageType = ListPart;
    SourceTable = "Residual Risk";

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

