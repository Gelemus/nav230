page 50279 "HR Job Grade Levels"
{
    PageType = List;
    SourceTable = "HR Job Grade Levels";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job Grade"; Rec."Job Grade")
                {
                }
                field("Job Grade Level"; Rec."Job Grade Level")
                {
                }
                field(Sequence; Rec.Sequence)
                {
                }
                field("Basic Pay Amount"; Rec."Basic Pay Amount")
                {
                }
                field("Basic Pay Difference"; Rec."Basic Pay Difference")
                {
                }
            }
        }
    }

    actions
    {
    }
}

