page 50588 "Institution  List"
{
    PageType = List;
    SourceTable = Institution;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field("Institution Name"; Rec."Institution Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

