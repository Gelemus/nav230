page 50062 "Cluster Codes"
{
    PageType = List;
    SourceTable = "Cluster Codes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cluster Code"; Rec."Cluster Code")
                {
                }
                field("Cluster Name"; Rec."Cluster Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

