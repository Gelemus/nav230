page 52205 "Sent Letters List"
{
    CardPageID = "Letter Sent Card";
    PageType = List;
    SourceTable = Registry;
    SourceTableView = WHERE(Status = CONST(Open),
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
                        REPORT.RunModal(REPORT::"Sent Letterl  Report.", true, false, Rec);
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::"Sent Letter";
    end;
}

