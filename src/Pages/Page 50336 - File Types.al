page 50336 "File Types"
{
    PageType = List;
    SourceTable = "File Types";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Type Code"; Rec."Type Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Files; Rec.Files)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

