page 50242 "HR Appraisal Global Objectives"
{
    PageType = List;
    SourceTable = "HR Appraisal Global Objectives";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                }
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Objective Activities")
            {
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Appraisal KPI";
                RunPageLink = "Appraisal Period" = FIELD("Appraisal Period"),
                              "Appraissal Objective" = FIELD(Code);
            }
        }
    }
}

