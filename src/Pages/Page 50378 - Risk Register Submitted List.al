page 50378 "Risk Register Submitted List"
{
    CardPageID = "Risk Register Submitted Card";
    PageType = List;
    SourceTable = "Risk  Register";
    SourceTableView = WHERE(Status = CONST(Submitted));

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
                field("Date Submitted"; Rec."Date Submitted")
                {
                }
                field("Submitted By"; Rec."Submitted By")
                {
                }
                field("Time Submitted"; Rec."Time Submitted")
                {
                }
            }
        }
    }

    actions
    {
    }
}

