page 50280 "County List"
{
    PageType = List;
    SourceTable = County;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Name; Rec.Name)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Sub Counties")
            {
                Caption = 'Sub Counties';
                Image = List;
                RunObject = Page "SubCounty List";
                RunPageLink = "County Code" = FIELD(Code);
            }
        }
    }
}

