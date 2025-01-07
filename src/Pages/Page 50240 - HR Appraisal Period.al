page 50240 "HR Appraisal Period"
{
    PageType = List;
    SourceTable = "HR Calendar Period";

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
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(Closed; Rec.Closed)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Appraisal Objectives")
            {
                Image = OpportunityList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Appraisal Objectives";
                RunPageLink = "Appraisal Period" = FIELD(Code);
            }
        }
    }
}

