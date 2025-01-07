page 50434 "HR Appraisal Challenge Subform"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "HR Appraisal Problems/Challeng";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Problem/Challenge"; Rec."Problem/Challenge")
                {
                }
            }
        }
    }

    actions
    {
    }
}

