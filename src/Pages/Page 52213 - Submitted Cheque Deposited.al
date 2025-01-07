page 52213 "Submitted Cheque Deposited"
{
    PageType = List;
    SourceTable = Registry;
    SourceTableView = WHERE(Status = CONST(Submitted),
                            "Document Type" = CONST("Cheque to deposit"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Cheque No"; Rec."Cheque No")
                {
                }
                field("Cheque Name"; Rec."Cheque Name")
                {
                }
                field("Account No"; Rec."Account No")
                {
                }
                field("Bank to Deposit"; Rec."Bank to Deposit")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Name of Person Picking"; Rec."Name of Person Picking")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control12; Notes)
            {
            }
            systempart(Control13; MyNotes)
            {
            }
            systempart(Control14; Links)
            {
            }
            systempart(Control15; Outlook)
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
            action("Print Deposited Cheque ")
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
                        REPORT.RunModal(REPORT::"Deposited Cheque Report.", true, false, Rec);
                    end;
                end;
            }
        }
    }
}

