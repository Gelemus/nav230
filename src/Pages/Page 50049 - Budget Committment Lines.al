page 50049 "Budget Committment Lines"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Budget Committment";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    Caption = 'Document date';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                }
                field("Gl Name"; Rec."Gl Name")
                {
                }
                field(Budget; Rec.Budget)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Month Budget"; Rec."Month Budget")
                {
                }
                field("Budget Balance"; Rec."Budget Balance")
                {
                }
                field("Month Actual"; Rec."Month Actual")
                {
                }
                field(Committed; Rec.Committed)
                {
                }
                field("Committed By"; Rec."Committed By")
                {
                }
                field("Committed Date"; Rec."Committed Date")
                {
                }
                field("Committed Time"; Rec."Committed Time")
                {
                }
                field(Cancelled; Rec.Cancelled)
                {
                }
                field("Cancelled By"; Rec."Cancelled By")
                {
                }
                field("Cancelled Date"; Rec."Cancelled Date")
                {
                }
                field("Cancelled Time"; Rec."Cancelled Time")
                {
                }
            }
        }
    }

    actions
    {
    }
}

