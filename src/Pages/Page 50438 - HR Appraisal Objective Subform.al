page 50438 "HR Appraisal Objective Subform"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "HR Appraisal Objectives";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal Objective"; Rec."Appraisal Objective")
                {
                }
                field(Score; Rec.Score)
                {
                }
                field(Comments; Rec.Comments)
                {
                }
            }
        }
    }

    actions
    {
    }
}

