page 52202 "Cheque Released List"
{
    CardPageID = "Cheque Released Card";
    PageType = List;
    SourceTable = Registry;
    SourceTableView = WHERE(Status = CONST(Open),
                            "Document Type" = CONST("Cheque to Collect"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Cheque Name"; Rec."Cheque Name")
                {
                }
                field("Cheque No"; Rec."Cheque No")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Name of Person Picking"; Rec."Name of Person Picking")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Notes)
            {
            }
            systempart(Control10; MyNotes)
            {
            }
            systempart(Control11; Links)
            {
            }
            systempart(Control12; Outlook)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Print Released Cheque ")
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange(Rec.No, xRec.No);
                    if Rec.FindFirst then begin
                        REPORT.RunModal(REPORT::"Released Cheque Report.", true, false, Rec);
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::"Cheque to Collect";
    end;
}

