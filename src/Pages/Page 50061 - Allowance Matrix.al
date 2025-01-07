page 50061 "Allowance Matrix"
{
    PageType = List;
    SourceTable = "Allowance Matrix";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job Group"; Rec."Job Group")
                {
                }
                field("Allowance Code"; Rec."Allowance Code")
                {
                }
                field("Cluster Code"; Rec."Cluster Code")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(City; Rec.Tos)
                {
                }
            }
        }
    }

    actions
    {
    }
}

