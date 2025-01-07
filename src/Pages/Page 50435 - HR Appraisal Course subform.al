page 50435 "HR Appraisal Course subform"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "HR Appraisal Course/Training";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Course/Training"; Rec."Course/Training")
                {
                }
            }
        }
    }

    actions
    {
    }
}

