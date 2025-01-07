page 50281 "SubCounty List"
{
    PageType = List;
    SourceTable = "Sub-County";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("County Code"; Rec."County Code")
                {
                }
                field("Sub-County Code"; Rec."Sub-County Code")
                {
                }
                field("Sub-County Name"; Rec."Sub-County Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

