page 50441 "HR Appraisal Training Need/Obj"
{
    AutoSplitKey = true;
    Caption = 'HR Appraisal Training Needs & Objectives';
    PageType = ListPart;
    SourceTable = "HR Appraisal Training Need &Ob";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Training Need & Objective"; Rec."Training Need & Objective")
                {
                }
            }
        }
    }

    actions
    {
    }
}

