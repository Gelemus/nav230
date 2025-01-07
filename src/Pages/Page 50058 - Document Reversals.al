page 50058 "Document Reversals"
{
    CardPageID = "Document Reversal Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Document Reversal Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Doc. Posting date"; Rec."Doc. Posting date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Reversal Posted"; Rec."Reversal Posted")
                {
                }
                field("Reversal Posted By"; Rec."Reversal Posted By")
                {
                }
                field("Reversal Posting Date"; Rec."Reversal Posting Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

