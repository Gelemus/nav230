report 50710 "UpdateReceipt from Report"
{
    ProcessingOnly = true;
    //DefaultLayout = RDLC;
    //RDLCLayout = 'src/Layouts/UpdateReceipt from Report.rdl';

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

        GLEntry.Reset;
        //GLEntry.SETRANGE("Document No.",'R22102466282');
        GLEntry.SetRange("Document No.", BankAccountLedgerEntry."Document No.");
        if GLEntry.FindFirst then begin
            repeat
                BankAccountLedgerEntry.Reset;
                BankAccountLedgerEntry.SetRange("Document No.", GLEntry."Document No.");
                BankAccountLedgerEntry.SetRange("Bank Account No.", 'BANK0011');
                if BankAccountLedgerEntry.FindSet then begin
                    repeat
                        //IF NOT BankAccountLedgerEntry.Open THEN  ERROR(DocumentNo +' is not open');;
                        BankAccountLedgerEntry."Posting Date" := GLEntry."Posting Date";
                        BankAccountLedgerEntry.Modify;
                    until BankAccountLedgerEntry.Next = 0;
                end;

            until GLEntry.Next = 0;
        end;
        //
        /*BankAccountLedgerEntry.RESET;
        BankAccountLedgerEntry.SETRANGE("Bank Account No.",'BANK0001');
        IF BankAccountLedgerEntry.FINDFIRST THEN BEGIN
          REPEAT
            GLEntry.RESET;
            GLEntry.SETRANGE("Document No.",BankAccountLedgerEntry."Document No.");
            IF GLEntry.FINDSET THEN BEGIN
              REPEAT
                GLEntry."Posting Date" := BankAccountLedgerEntry."Posting Date";
                GLEntry.MODIFY;
              UNTIL GLEntry.NEXT=0;
            END;
          UNTIL BankAccountLedgerEntry.NEXT=0;
        END;*/


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

