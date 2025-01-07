page 52207 "Cheque Released Card"
{
    PageType = Card;
    SourceTable = Registry;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                }
                field("Cheque No"; Rec."Cheque No")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Bank to Deposit"; Rec."Bank to Deposit")
                {
                }
                field("Account No"; Rec."Account No")
                {
                }
                field("Cheque Name"; Rec."Cheque Name")
                {
                }
                field("Name of Person Picking"; Rec."Name of Person Picking")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("USER ID"; Rec."USER ID")
                {
                }
                field("Date Submitted"; Rec."Date Submitted")
                {
                }
                field("Time Submitted"; Rec."Time Submitted")
                {
                }
                field("Submitted By"; Rec."Submitted By")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control15; Outlook)
            {
            }
            systempart(Control16; Notes)
            {
            }
            systempart(Control17; MyNotes)
            {
            }
            systempart(Control18; Links)
            {
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
                    Rec.Submitted := true;
                    Rec.Status := Rec.Status::Submitted;
                    Rec.Modify
                end;
            }
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

