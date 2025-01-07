report 50709 UpdateReceipt
{
    //DefaultLayout = RDLC;
    //RDLCLayout = 'src/Layouts/UpdateReceipt.rdl';
    ProcessingOnly = true;
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
        DocumentNo := 'R234111169640';
        DocumentNo2 := 'R234111169640';

        //RCPT196143 mm/dd/yy
        Postingdate := 20230701D;

        if Postingdate = 0D then Error('Please input date');
        if DocumentNo = '' then Error('Please input document no');

        ReceiptHeader.Reset;
        ReceiptHeader.SetFilter("No.", '%1..%2', DocumentNo, DocumentNo2);
        if ReceiptHeader.FindFirst then begin
            repeat
                i += 1;
                ReceiptHeader."Posting Date" := Postingdate;
                ReceiptHeader.Modify;

            until ReceiptHeader.Next = 0;
            Message('present');
        end;
        if i > 20 then Error('Kimeumana');

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
                ;
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

