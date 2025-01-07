page 50203 "Employee Location List"
{
    DataCaptionFields = "Code", Description;
    PageType = List;
    SourceTable = "HR Location";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    Caption = 'Code';
                }
                field("<Description>"; Rec.Description)
                {
                    Caption = 'Description';
                }
            }
        }
    }

    actions
    {
    }
}

