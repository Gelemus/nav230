page 50442 "HR Appraisal Identified Potent"
{
    AutoSplitKey = true;
    Caption = 'HR Appraisal Identified Potential';
    PageType = ListPart;
    SourceTable = "HR Appraisal Identified Potent";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Identified Potential"; Rec."Identified Potential")
                {
                }
            }
        }
    }

    actions
    {
    }
}

