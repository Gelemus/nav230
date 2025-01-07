page 50379 "Risk Register Card"
{
    PageType = Card;
    SourceTable = "Risk  Register";
    SourceTableView = WHERE(Status = CONST(open));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Ref Id"; Rec."Ref Id")
                {
                    Editable = false;
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
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
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

    actions
    {
        area(creation)
        {
            action(Submit)
            {
                Image = SendConfirmation;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //updated 01/04/2020
                    Rec."Submitted By" := UserId;
                    Rec."Date Submitted" := Today;
                    Rec."Time Submitted" := Time;
                    Rec.Status := Rec.Status::Submitted;
                    //Submitted := TRUE;
                    Rec.Modify
                end;
            }
        }
    }
}

