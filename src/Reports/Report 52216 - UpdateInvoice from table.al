report 52216 "UpdateInvoice from table"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/UpdateInvoice from table.rdl';

    dataset
    {
        dataitem("Fuel Prices"; "Fuel Prices")
        {

            trigger OnAfterGetRecord()
            begin
                /*DocumentNo:="Fuel Prices".Code;
                DocumentNo2:="Fuel Prices".Code;
                
                //RCPT196143
                Postingdate:="Fuel Prices".Amount;
                
                IF Postingdate=0D THEN CurrReport.SKIP;
                IF DocumentNo='' THEN CurrReport.SKIP;
                //IF UpdateInvoice.Type = 'CREDIT' THEN CurrReport.SKIP;
                
                GLEntry.RESET;
                GLEntry.SETFILTER("Document No.",'%1..%2',DocumentNo,DocumentNo2);
                
                IF "Fuel Prices".Comments = 'CREDIT' THEN
                 GLEntry.SETRANGE("Document Type",GLEntry."Document Type"::"Credit Memo")
                ELSE
                 GLEntry.SETRANGE("Document Type",GLEntry."Document Type"::Invoice);
                
                IF GLEntry.FINDFIRST THEN BEGIN
                  REPEAT
                GLEntry."Posting Date":=Postingdate;
                GLEntry.MODIFY;
                UNTIL GLEntry.NEXT=0;
                END;
                
                //IF UpdateInvoice.Type = 'CREDIT' THEN BEGIN
                {
                PostedCreditMemo.RESET;
                PostedCreditMemo.SETFILTER("No.",'%1..%2',DocumentNo,DocumentNo2);
                IF PostedCreditMemo.FINDFIRST THEN BEGIN
                  REPEAT
                    i+=1;
                  PostedCreditMemo."Posting Date":=Postingdate;
                  PostedCreditMemo.MODIFY;
                  UpdateInvoice.Modified:=TRUE;
                 UpdateInvoice.MODIFY;
                  UNTIL PostedCreditMemo.NEXT=0;
                   //MESSAGE('present');
                END ;}
                {END ELSE BEGIN
                  PostedInvoice.RESET;
                PostedInvoice.SETFILTER("No.",'%1..%2',DocumentNo,DocumentNo2);
                IF PostedInvoice.FINDFIRST THEN BEGIN
                  REPEAT
                    i+=1;
                  PostedInvoice."Posting Date":=Postingdate;
                  PostedCreditMemo.MODIFY;
                  UpdateInvoice.Modified:=TRUE;
                 UNTIL PostedInvoice.NEXT=0;
                   //MESSAGE('present');
                END ;
                  END;}
                //IF  i >20 THEN ERROR('Kimeumana');
                
                
                
                
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETFILTER("Document No.",'%1..%2',DocumentNo,DocumentNo2);
                
                IF "Fuel Prices".Comments = 'CREDIT' THEN
                CustLedgerEntry.SETRANGE("Document Type",CustLedgerEntry."Document Type"::"Credit Memo")
                ELSE
                CustLedgerEntry.SETRANGE("Document Type",CustLedgerEntry."Document Type"::Invoice);
                
                IF CustLedgerEntry.FINDFIRST THEN BEGIN
                REPEAT
                CustLedgerEntry."Posting Date":=Postingdate;
                CustLedgerEntry.MODIFY;
                
                DetailedCustLedgEntry.RESET;
                DetailedCustLedgEntry.SETFILTER("Document No.",'%1..%2',DocumentNo,DocumentNo2);
                
                IF "Fuel Prices".Comments = 'CREDIT' THEN
                DetailedCustLedgEntry.SETRANGE("Document Type",DetailedCustLedgEntry."Document Type"::"Credit Memo")
                ELSE
                DetailedCustLedgEntry.SETRANGE("Document Type",DetailedCustLedgEntry."Document Type"::Invoice);
                
                IF DetailedCustLedgEntry.FINDFIRST THEN BEGIN
                REPEAT
                DetailedCustLedgEntry."Posting Date":=Postingdate;
                DetailedCustLedgEntry.MODIFY;
                UNTIL DetailedCustLedgEntry.NEXT=0;
                END;
                
                
                UNTIL CustLedgerEntry.NEXT=0;
                END;
                
                  "Fuel Prices"."Fuel type":=TRUE;
                 "Fuel Prices".MODIFY;*/

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
        Message('DONE');
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
        PostedCreditMemo: Record "Sales Cr.Memo Header";
        PostedInvoice: Record "Sales Invoice Header";
}

