page 50833 "Casual Rates"
{
    PageType = List;
    SourceTable = "Casual l Rates";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field("Casual Rates"; Rec."Casual Rates")
                {
                }
                field(Amount; Rec.Amount)
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

