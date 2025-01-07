page 52216 "Submitted Released Letters"
{
    CardPageID = "Released Letters Card";
    PageType = List;
    SourceTable = Registry;
    SourceTableView = WHERE(Status = CONST(Submitted),
                            "Document Type" = CONST("Released Letter"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("File No"; Rec."File No")
                {
                }
                field("Content of Letter"; Rec."Content of Letter")
                {
                }
                field("Name of Person Receiving"; Rec."Name of Person Receiving")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Outlook)
            {
            }
            systempart(Control9; Notes)
            {
            }
            systempart(Control10; MyNotes)
            {
            }
            systempart(Control11; Links)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Reopen the document")
            {
                Image = ReOpen;
                Promoted = true;

                trigger OnAction()
                begin
                    Rec.Submitted := false;
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                end;
            }
            action("Print ")
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
                        REPORT.RunModal(REPORT::"Released Letterl  Report.", true, false, Rec);
                    end;
                end;
            }
        }
    }
}

