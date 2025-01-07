page 56066 "Internal Memo"
{
    PageType = Card;
    SourceTable = "Internal Memos";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                }
                field(RE; Rec.RE)
                {
                }
                field("Employee UserID"; Rec."Employee UserID")
                {
                }
                field(From; Rec.From)
                {
                }
                field("To CEO"; Rec."To CEO")
                {
                }
                field(Through; Rec.Through)
                {
                }
                field("Paragraph 1"; Rec."Paragraph 1")
                {
                }
                field("Paragraph 2"; Rec."Paragraph 2")
                {
                }
                field("Prepared By Date"; Rec."Prepared By Date")
                {
                }
                field("Approved By"; Rec."Approved By")
                {
                }
                field("CEO Approval"; Rec."CEO Approval")
                {
                }
                field("Approved By Date"; Rec."Approved By Date")
                {
                }
                field("CEO Approval Date"; Rec."CEO Approval Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Title; Rec.Title)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("CEO Comments"; Rec."CEO Comments")
                {
                }
                field("HOD ID"; Rec."HOD ID")
                {
                }
            }
            part(Control21; "Memo Lines")
            {
                SubPageLink = Code = FIELD(Code);
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Print)
            {
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.SetRange(Code, Rec.Code);
                    REPORT.Run(56237, true, true, Rec);
                end;
            }
        }
    }
}

