page 52210 "Letter Sent Card"
{
    PageType = List;
    SourceTable = Registry;

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
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Letter sent via Posta"; Rec."Letter sent via Posta")
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

