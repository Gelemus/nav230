page 50440 "HR Appraisal Global Competency"
{
    PageType = List;
    SourceTable = "HR Appraisal Global Competency";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Competency Factor"; Rec."Competency Factor")
                {
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                }
                field(Score; Rec.Score)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control6; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

