page 50078 "Tender Evaluators"
{
    PageType = ListPart;
    SourceTable = "Tender Evaluators";
    ApplicationArea = All;

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

