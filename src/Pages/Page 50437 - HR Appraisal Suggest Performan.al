page 50437 "HR Appraisal Suggest Performan"
{
    AutoSplitKey = true;
    Caption = 'HR Appraisal  Performance Suggestions';
    PageType = ListPart;
    SourceTable = "Hr Appraisal Performace Sugge";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Suggestion; Rec.Suggestion)
                {
                }
            }
        }
    }

    actions
    {
    }
}

