page 50433 "HR Appraisal Performance Fact"
{
    AutoSplitKey = true;
    Caption = 'HR Appraisal Performance Factors Subform';
    PageType = ListPart;
    SourceTable = "HR Appraisal Performance Facto";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Performance Factor"; Rec."Performance Factor")
                {
                }
            }
        }
    }

    actions
    {
    }
}

