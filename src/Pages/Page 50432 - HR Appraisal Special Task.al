page 50432 "HR Appraisal Special Task"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "HR Appraisal Special Task";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Task; Rec.Task)
                {
                }
            }
        }
    }

    actions
    {
    }
}

