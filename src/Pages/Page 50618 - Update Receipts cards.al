page 50618 "Update Receipts cards"
{
    DeleteAllowed = true;
    PageType = Card;
    SourceTable = UpdateReceipts;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(ReceiptNo; Rec.ReceiptNo)
                {
                }
                field(NewBank; Rec.NewBank)
                {
                    TableRelation = "Bank Account"."No.";
                }
                field(NewGl; Rec.NewGl)
                {
                    Enabled = false;
                    TableRelation = "G/L Account"."No.";
                }
                field(Modified; Rec.Modified)
                {
                    Editable = false;
                }
                field(Newdate; Rec.Newdate)
                {

                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("UpdateLedger from table")
            {
                Caption = 'Update Bank/Change Date';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Update Ledger Receipt";
                RunPageOnRec = true;
            }
        }
    }
}

