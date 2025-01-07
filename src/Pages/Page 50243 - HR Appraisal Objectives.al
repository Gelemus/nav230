page 50243 "HR Appraisal Objectives"
{
    PageType = List;
    SourceTable = "HR Appraisal Objective";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Objective Weight"; Rec."Objective Weight")
                {
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                }
                field("Deparment Code"; Rec."Deparment Code")
                {
                }
                field("Appraisal Score Type"; Rec."Appraisal Score Type")
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
                Caption = 'Objective KPI';
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

