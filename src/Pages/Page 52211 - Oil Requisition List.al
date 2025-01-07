page 52211 "Oil Requisition List"
{
    CardPageID = "Oil Requistion Card";
    PageType = List;
    SourceTable = Registry;
    SourceTableView = WHERE(Status = CONST(Open),
                            "Document Type" = CONST("Oil Requistion"));

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
                field("USER ID"; Rec."USER ID")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Motor Cycle No"; Rec."Motor Cycle No")
                {
                }
                field("Motor Cycle Description"; Rec."Motor Cycle Description")
                {
                }
                field("Marked To"; Rec."Marked To")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Motor Registration No"; Rec."Motor Registration No")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control14; Outlook)
            {
            }
            systempart(Control15; Notes)
            {
            }
            systempart(Control16; MyNotes)
            {
            }
            systempart(Control17; Links)
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
                        REPORT.RunModal(REPORT::"Oil Requistion  Report.", true, false, Rec);
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::"Oil Requistion";
    end;
}

