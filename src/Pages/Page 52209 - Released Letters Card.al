page 52209 "Released Letters Card"
{
    Caption = 'Outgoing  Letters Card';
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
                field("File No"; Rec."File No")
                {
                    Caption = 'From';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Content of Letter"; Rec."Content of Letter")
                {
                }
                field("Time Submitted"; Rec."Time Submitted")
                {
                }
                field("Name of Person Receiving"; Rec."Name of Person Receiving")
                {
                    Caption = 'Marked To';
                }
                field("Motor Registration No"; Rec."Motor Registration No")
                {
                    Caption = 'Remarks';
                }
                field("USER ID"; Rec."USER ID")
                {
                }
                field("Date Submitted"; Rec."Date Submitted")
                {
                    Visible = false;
                }
                field("Submitted By"; Rec."Submitted By")
                {
                    Visible = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Visible = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Visible = false;
                }
                field("Mode of Delivery"; Rec."Mode of Delivery")
                {
                }
                field("Courier Services Name"; Rec."Courier Services Name")
                {
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
            action("Print  ")
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::"Released Letter";
    end;
}

