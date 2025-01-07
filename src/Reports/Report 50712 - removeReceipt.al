report 50712 removeReceipt
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/removeReceipt.rdl';

    dataset
    {
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

    trigger OnPreReport()
    begin
        DocumentNo := 'RCPT339057';

        //RCPT196143
        Postingdate := 20200103D;

        if Postingdate = 0D then Error('Please input date');
        if DocumentNo = '' then Error('Please input document no');

        ReceiptHeader.Reset;
        ReceiptHeader.SetRange("No.", DocumentNo);
        if ReceiptHeader.FindFirst then begin
            repeat
                i += 1;
                ReceiptHeader."Posting Date" := Postingdate;
                ReceiptHeader.Delete;

            until ReceiptHeader.Next = 0;
            Message('present');
        end;
        if i > 1 then Error('Kimeumana');

        GLEntry.Reset;
        GLEntry.SetRange("Document No.", DocumentNo);
        if GLEntry.FindFirst then begin
            repeat
                GLEntry."Posting Date" := Postingdate;
                GLEntry.Delete;
            until GLEntry.Next = 0;
        end;
        BankAccountLedgerEntry.Reset;
        BankAccountLedgerEntry.SetRange("Document No.", DocumentNo);
        if BankAccountLedgerEntry.FindFirst then begin
            repeat
                BankAccountLedgerEntry."Posting Date" := Postingdate;
                BankAccountLedgerEntry.Delete;
            until BankAccountLedgerEntry.Next = 0;
        end;

        CustLedgerEntry.Reset;
        CustLedgerEntry.SetRange("Document No.", DocumentNo);
        if CustLedgerEntry.FindFirst then begin
            repeat
                CustLedgerEntry."Posting Date" := Postingdate;
                CustLedgerEntry.Delete;
            until CustLedgerEntry.Next = 0;

        end;

        DetailedCustLedgEntry.Reset;
        DetailedCustLedgEntry.SetRange("Document No.", DocumentNo);
        if DetailedCustLedgEntry.FindFirst then begin
            repeat

                DetailedCustLedgEntry.Delete
            until DetailedCustLedgEntry.Next = 0;

        end;


        /*GLEntry.RESET;
        GLEntry.SETRANGE("Document No.",DocumentNo);
        IF GLEntry.FINDFIRST THEN BEGIN
          REPEAT
        GLEntry."Posting Date":=Postingdate;
        GLEntry.MODIFY;
        UNTIL GLEntry.NEXT=0;
        END;
        
        BankAccountLedgerEntry.RESET;
        BankAccountLedgerEntry.SETRANGE("Document No.",DocumentNo);
        IF BankAccountLedgerEntry.FINDFIRST THEN BEGIN
          REPEAT
        BankAccountLedgerEntry."Posting Date":=Postingdate;
        BankAccountLedgerEntry.MODIFY;
        UNTIL BankAccountLedgerEntry.NEXT=0;
        END;
        
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE("Document No.",DocumentNo);
        IF CustLedgerEntry.FINDFIRST THEN BEGIN
        REPEAT
        CustLedgerEntry."Posting Date":=Postingdate;
        CustLedgerEntry.MODIFY;
        UNTIL CustLedgerEntry.NEXT=0;
        
        END;
        
        DetailedCustLedgEntry.RESET;
        DetailedCustLedgEntry.SETRANGE("Document No.",DocumentNo);
        IF DetailedCustLedgEntry.FINDFIRST THEN BEGIN
        REPEAT
        DetailedCustLedgEntry."Posting Date":=Postingdate;
        DetailedCustLedgEntry.MODIFY;
        UNTIL DetailedCustLedgEntry.NEXT=0;
        
        END;
        */

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

