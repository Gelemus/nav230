page 50111 "Tender Evaluation Lines"
{
    InsertAllowed = false;
    PageType = ListPart;
    ApplicationArea= All;
    SourceTable = "Tender Evaluation Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field(Evaluator; Rec.Evaluator)
                {
                }
                field("Evaluator Name"; Rec."Evaluator Name")
                {
                }
                field(Marks; Rec.Marks)
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

