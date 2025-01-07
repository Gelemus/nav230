page 52206 "Cheque Deposited Card"
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
                field("Account No"; Rec."Account No")
                {
                }
                field("Cheque Name"; Rec."Cheque Name")
                {
                }
                field("Bank to Deposit"; Rec."Bank to Deposit")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Name of Person Receiving"; Rec."Name of Person Receiving")
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
                field(Status; Rec.Status)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control15; MyNotes)
            {
            }
            systempart(Control16; Links)
            {
            }
            systempart(Control17; Notes)
            {
            }
            systempart(Control18; Outlook)
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::"Cheque to deposit";
    end;
}

