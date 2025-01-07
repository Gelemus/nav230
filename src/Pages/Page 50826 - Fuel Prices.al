page 50826 "Fuel Prices"
{
    PageType = List;
    SourceTable = "Fuel Prices";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field("Fuel type"; Rec."Fuel type")
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

