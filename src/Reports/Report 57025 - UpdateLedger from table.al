report 57025 "UpdateLedger from table"
{
    //DefaultLayout = RDLC;
    // RDLCLayout = 'src/Layouts/UpdateLedger from table.rdl';
    ProcessingOnly = true;
    dataset
    {
        dataitem(UpdateReceipts; UpdateReceipts)
        {
            DataItemTableView = WHERE(Modified = CONST(false));

            trigger OnAfterGetRecord()
            begin
                DocumentNo := UpdateReceipts.ReceiptNo;
                DocumentNo2 := UpdateReceipts.ReceiptNo;

                //RCPT196143
                //Postingdate:=UpdateReceipts.Newdate;

                //IF Postingdate=0D THEN CurrReport.SKIP;
                if DocumentNo = '' then CurrReport.Skip;

                if UpdateReceipts.NewBank = '' then CurrReport.Skip;
                if UpdateReceipts.NewGl = '' then CurrReport.Skip;
                /*
                ReceiptHeader.RESET;
                ReceiptHeader.SETFILTER("No.",'%1..%2',DocumentNo,DocumentNo2);
                IF ReceiptHeader.FINDFIRST THEN BEGIN
                  REPEAT
                    i+=1;
                  ReceiptHeader."Posting Date":=Postingdate;
                  ReceiptHeader.MODIFY;
                  UpdateReceipts.Modified:=TRUE;
                 UpdateReceipts.MODIFY;
                  UNTIL ReceiptHeader.NEXT=0;
                   //MESSAGE('present');
                END ;*/

                //IF  i >20 THEN ERROR('Kimeumana');

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
        Message('Done...');
    end;

    trigger OnPreReport()
    begin



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

