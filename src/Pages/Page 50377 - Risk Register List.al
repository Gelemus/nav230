page 50377 "Risk Register List"
{
    CardPageID = "Risk Register Card";
    PageType = List;
    SourceTable = "Risk  Register";
    SourceTableView = WHERE(Status = CONST(open));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Ref Id"; Rec."Ref Id")
                {
                }
                field("Key Process"; Rec."Key Process")
                {
                }
                field(Probability; Rec.Probability)
                {
                }
                field("Accepted Probability"; Rec."Accepted Probability")
                {
                }
                field("Accepted Impact"; Rec."Accepted Impact")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
            }
        }
    }

    actions
    {
    }
}

