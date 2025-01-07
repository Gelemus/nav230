page 50363 "Areas of Grievance List"
{
    PageType = List;
    SourceTable = "Areas of Grieavance";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Grievance Code"; Rec."Grievance Code")
                {
                }
                field("Grievance Description"; Rec."Grievance Description")
                {
                }
            }
        }
    }

    actions
    {
    }
}

