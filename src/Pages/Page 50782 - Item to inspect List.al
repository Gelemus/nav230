page 50782 "Item to inspect List"
{
    PageType = ListPart;
    SourceTable = "Items to Inspect";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No"; Rec."Line No")
                {
                }
                field(Rank; Rec.Rank)
                {
                }
                field("Inspection Type"; Rec."Inspection Type")
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
    }
}

