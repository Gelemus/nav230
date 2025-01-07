page 56067 "Memo Lines"
{
    PageType = ListPart;
    SourceTable = "Memo Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field(Rate; Rec.Rate)
                {
                }
                field("Total amount"; Rec."Total amount")
                {
                }
            }
        }
    }

    actions
    {
    }
}

