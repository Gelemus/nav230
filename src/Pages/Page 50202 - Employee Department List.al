page 50202 "Employee Department List"
{
    DataCaptionFields = "Code", Decription;
    PageType = List;
    SourceTable = "HR Department";

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
                field("<Description>"; Rec.Decription)
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

