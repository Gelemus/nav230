page 52208 "Incoming  Letters Card"
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
                field("Name of Person Picking"; Rec."Name of Person Picking")
                {
                    Caption = 'From';
                }
                field("Content of Letter"; Rec."Content of Letter")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Marked To"; Rec."Marked To")
                {
                }
                field("PF No"; Rec."PF No")
                {
                }
                field("Marked To Name"; Rec."Marked To Name")
                {
                }
                field("Date Submitted"; Rec."Date Submitted")
                {
                }
                field("Time Submitted"; Rec."Time Submitted")
                {
                }
                field("USER ID"; Rec."USER ID")
                {
                }
                field("Submitted By"; Rec."Submitted By")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(52201),
                              "No." = FIELD(No);
            }
            systempart(Control13; Outlook)
            {
            }
            systempart(Control14; Notes)
            {
            }
            systempart(Control15; MyNotes)
            {
            }
            systempart(Control16; Links)
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
                        REPORT.RunModal(REPORT::"Incoming Mail  Report.", true, false, Rec);
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::"Incoming Letters";
    end;
}

