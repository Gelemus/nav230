page 50397 "Risk Register Submitted Card"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Risk  Register";
    SourceTableView = WHERE(Status = CONST(Submitted));

    layout
    {
        area(content)
        {
            group(General)
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
                field("Time Submitted"; Rec."Time Submitted")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Submitted By"; Rec."Submitted By")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                part(Control16; "Risk List")
                {
                    SubPageLink = Code = FIELD("Ref Id");
                }
                part(Control17; "Impact List")
                {
                    SubPageLink = Code = FIELD("Ref Id");
                }
                part(Control18; "Mitigation List")
                {
                    SubPageLink = Code = FIELD("Ref Id");
                }
                part(Control19; "Residual Risk List")
                {
                    SubPageLink = Code = FIELD("Ref Id");
                }
            }
        }
    }

    actions
    {
    }
}

