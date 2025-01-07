page 52217 "Submitted Sent Letters List"
{
    CardPageID = "Letter Sent Card";
    PageType = List;
    SourceTable = Registry;
    SourceTableView = WHERE(Status = CONST(Submitted),
                            "Document Type" = CONST("Sent Letter"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Content of Letter"; Rec."Content of Letter")
                {
                }
                field("Letter sent via Posta"; Rec."Letter sent via Posta")
                {
                }
                field("Posting Date"; Rec."Posting Date")
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
            action(Print)
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
                        REPORT.RunModal(REPORT::"Sent Letterl  Report.", true, false, Rec);
                    end;
                end;
            }
            action(Action15)
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
}

