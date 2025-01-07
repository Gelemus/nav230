page 51249 "Score Setup"
{
    PageType = List;
    SourceTable = "Score Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Score ID"; Rec."Score ID")
                {
                }
                field(Score; Rec.Score)
                {
                }
            }
        }
    }

    actions
    {
    }
}

