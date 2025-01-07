page 50619 "Update Receipts Lists"
{
    CardPageID = "Update Receipts cards";
    DeleteAllowed = true;
    PageType = List;
    SourceTable = UpdateReceipts;
    SourceTableView = WHERE(Modified = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ReceiptNo; Rec.ReceiptNo)
                {
                }
                field(NewBank; Rec.NewBank)
                {
                }
                field(NewGl; Rec.NewGl)
                {
                }
                field(Modified; Rec.Modified)
                {
                }
            }
        }
    }

    actions
    {
        // group(Update)
        // {
        //     Caption = 'Update';
        //     action("UpdateLedger from table")
        //     {
        //         Caption = 'Update the receipt';
        //         RunObject = Report "AThird Rule Report1";
        //     }
        // }
    }
}

