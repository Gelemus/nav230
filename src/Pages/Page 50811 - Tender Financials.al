page 50811 "Tender Financials"
{
    PageType = ListPart;
    SourceTable = "Tender Evaluators";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Evaluator No"; Rec."Evaluator No")
                {
                }
                field("Evaluator Name"; Rec."Evaluator Name")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field("Committee Chairperson"; Rec."Committee Chairperson")
                {
                }
                field("Tender Opening"; Rec."Tender Opening")
                {
                }
                field(Evaluation; Rec.Evaluation)
                {
                }
            }
        }
    }

    actions
    {
    }
}

