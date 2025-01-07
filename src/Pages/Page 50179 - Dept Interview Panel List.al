page 50179 "Dept Interview Panel List"
{
    CardPageID = "Dept Interview Panel Card";
    PageType = List;
    SourceTable = "Interview Committee Dep Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Department Code"; Rec."Department Code")
                {
                }
                field("Dept Committee Name"; Rec."Dept Committee Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

