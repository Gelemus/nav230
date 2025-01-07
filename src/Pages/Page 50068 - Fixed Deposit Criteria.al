page 50068 "Fixed Deposit Criteria"
{
    PageType = List;
    SourceTable = "FD Interest Calculation Crite";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                }
                field("Maximum Amount"; Rec."Maximum Amount")
                {
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                }
                field(Duration; Rec.Duration)
                {
                }
                field("On Call Interest Rate"; Rec."On Call Interest Rate")
                {
                }
                field("No of Months"; Rec."No of Months")
                {
                }
            }
        }
    }

    actions
    {
    }
}

