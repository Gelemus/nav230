page 56069 "Posted Visitor Pass"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Visitors Pass";
    SourceTableView = WHERE(Status = FILTER(Released));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Date of visit"; Rec."Date of visit")
                {
                }
                field("Time of visit"; Rec."Time of visit")
                {
                }
                field("Visitor Name"; Rec."Visitor Name")
                {
                }
                field("ID No"; Rec."ID No")
                {
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                }
                field(From; Rec.From)
                {
                }
                field("Officer to see No"; Rec."Officer to see No")
                {
                }
                field("Officer to see Name"; Rec."Officer to see Name")
                {
                }
                field(Reason; Rec.Reason)
                {
                }
                field(Status; Rec.Status)
                {
                }
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
                    Rec.SetRange(No, Rec.No);
                    REPORT.Run(56236, true, true, Rec);
                end;
            }
        }
    }
}

