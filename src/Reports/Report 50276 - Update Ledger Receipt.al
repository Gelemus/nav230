report 50276 "Update Ledger Receipt"
{
    ProcessingOnly = true;
    dataset
    {
        dataitem(UpdateReceipts; UpdateReceipts)
        {
            DataItemTableView = WHERE(Modified = CONST(false));

            trigger OnAfterGetRecord()
            begin
                //TRANSFER RECEIPT
                DocumentNo := UpdateReceipts.ReceiptNo;
                DocumentNo2 := UpdateReceipts.ReceiptNo;

                //IF Postingdate=0D THEN CurrReport.SKIP;
                if DocumentNo = '' then CurrReport.Skip;

                if UpdateReceipts.NewBank = '' then CurrReport.Skip;
                if UpdateReceipts.NewGl = '' then CurrReport.Skip;
                GLEntry.Reset;
                GLEntry.SetFilter("Document No.", '%1..%2', DocumentNo, DocumentNo2);
                GLEntry.SetRange("Source Type", GLEntry."Source Type"::"Bank Account");
                if GLEntry.FindFirst then begin
                    repeat
                        GLEntry."G/L Account No." := UpdateReceipts.NewGl;
                        GLEntry.Validate("G/L Account No.");
                        GLEntry."Source No." := UpdateReceipts.NewBank;
                        GLEntry.Validate("Source No.");
                        GLEntry.Modify;
                    until GLEntry.Next = 0;
                end;

                BankAccountLedgerEntry.Reset;
                BankAccountLedgerEntry.SetFilter("Document No.", '%1..%2', DocumentNo, DocumentNo2);
                if BankAccountLedgerEntry.FindFirst then begin
                    repeat
                        if not BankAccountLedgerEntry.Open then Error(DocumentNo + ' is not open');
                        ;
                        BankAccountLedgerEntry."Bank Account No." := UpdateReceipts.NewBank;
                        BankAccountLedgerEntry."Bank Acc. Posting Group" := UpdateReceipts.NewBank;
                        BankAccountLedgerEntry.Modify;
                    until BankAccountLedgerEntry.Next = 0;
                end;

                UpdateReceipts.Modified := true;
                UpdateReceipts.Modify;

                //UPDATE DATE
                DocumentNo := UpdateReceipts.ReceiptNo;
                DocumentNo2 := UpdateReceipts.ReceiptNo;

                //RCPT196143
                Postingdate := UpdateReceipts.Newdate;

                if Postingdate = 0D then CurrReport.Skip;
                if DocumentNo = '' then CurrReport.Skip;

                ReceiptHeader.Reset;
                ReceiptHeader.SetFilter("No.", '%1..%2', DocumentNo, DocumentNo2);
                if ReceiptHeader.FindFirst then begin
                    repeat
                        i += 1;
                        ReceiptHeader."Posting Date" := Postingdate;
                        ReceiptHeader.Modify;
                        UpdateReceipts.Modified := true;
                        UpdateReceipts.Modify;
                    until ReceiptHeader.Next = 0;
                    //MESSAGE('present');
                end;

                //IF  i >20 THEN ERROR('Kimeumana');

                GLEntry.Reset;
                GLEntry.SetFilter("Document No.", '%1..%2', DocumentNo, DocumentNo2);
                if GLEntry.FindFirst then begin
                    repeat
                        GLEntry."Posting Date" := Postingdate;
                        GLEntry.Modify;
                    until GLEntry.Next = 0;
                end;

                BankAccountLedgerEntry.Reset;
                BankAccountLedgerEntry.SetFilter("Document No.", '%1..%2', DocumentNo, DocumentNo2);
                if BankAccountLedgerEntry.FindFirst then begin
                    repeat
                        if not BankAccountLedgerEntry.Open then Error(DocumentNo + ' is not open');
                        BankAccountLedgerEntry."Posting Date" := Postingdate;
                        BankAccountLedgerEntry.Modify;
                    until BankAccountLedgerEntry.Next = 0;
                end;

                CustLedgerEntry.Reset;
                CustLedgerEntry.SetFilter("Document No.", '%1..%2', DocumentNo, DocumentNo2);
                if CustLedgerEntry.FindFirst then begin
                    repeat
                        CustLedgerEntry."Posting Date" := Postingdate;
                        CustLedgerEntry.Modify;
                    until CustLedgerEntry.Next = 0;

                end;

                DetailedCustLedgEntry.Reset;
                DetailedCustLedgEntry.SetFilter("Document No.", '%1..%2', DocumentNo, DocumentNo2);
                if DetailedCustLedgEntry.FindFirst then begin
                    repeat
                        DetailedCustLedgEntry."Posting Date" := Postingdate;
                        DetailedCustLedgEntry.Modify;
                    until DetailedCustLedgEntry.Next = 0;

                end;
            end;

            trigger OnPostDataItem()
            begin
                //MESSAGE('Posting....');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        Message('Transfered Successfully...');
    end;

    var
        ReceiptHeader: Record "Receipt Header";
        GLEntry: Record "G/L Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        DocumentNo: Code[20];
        Postingdate: Date;
        DocumentNo2: Code[20];
        i: Integer;
}

