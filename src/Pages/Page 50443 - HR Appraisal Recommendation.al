page 50443 "HR Appraisal Recommendation"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "HR Appraisal Recommendation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Recommendation; Rec.Recommendation)
                {
                }
                field(Reason; Rec.Reason)
                {
                }
            }
        }
    }

    actions
    {
    }
}

