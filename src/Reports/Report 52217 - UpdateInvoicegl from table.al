report 52217 "UpdateInvoicegl from table"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/UpdateInvoicegl from table.rdl';

    dataset
    {
        dataitem("Fuel Prices"; "Fuel Prices")
        {

            trigger OnAfterGetRecord()
            begin
                /*toGl := "Fuel Prices".NewGl;
                fromGl := "Fuel Prices".OldGL;
                
                GLEntry.RESET;
                GLEntry.SETRANGE("G/L Account No.",fromGl);
                GLEntry.SETRANGE("Document No.","Fuel Prices".Code);
                GLEntry.SETFILTER("Document Type", '%1|%2', GLEntry."Document Type"::Invoice,GLEntry."Document Type"::"Credit Memo");
                //GLEntry.SETRANGE("External Document No.",updateFromTable."External Doc");
                //GLEntry.SETRANGE(Amount,updateFromTable.Amount);
                IF GLEntry.FINDFIRST THEN BEGIN
                   REPEAT
                    IF GLEntry."Document Type" = GLEntry."Document Type"::Invoice THEN BEGIN
                
                    SaleInvoiceLines.RESET;
                    SaleInvoiceLines.SETRANGE("Document No.",GLEntry."Document No.");
                    SaleInvoiceLines.SETRANGE("No.",fromGl);
                
                    IF SaleInvoiceLines.FINDFIRST THEN BEGIN
                      REPEAT
                        i+=1;
                      SaleInvoiceLines."No.":=toGl;
                      SaleInvoiceLines.MODIFY;
                      UNTIL SaleInvoiceLines.NEXT=0;
                    END;
                
                    END ELSE IF GLEntry."Document Type" = GLEntry."Document Type"::Invoice THEN BEGIN
                      CredmemoLines.RESET;
                      CredmemoLines.SETRANGE("Document No.",GLEntry."Document No.");
                      CredmemoLines.SETRANGE("No.",fromGl);
                      //CredmemoLines.SETRANGE(Amount,updateFromTable.Amount);
                      IF CredmemoLines.FINDFIRST THEN BEGIN
                        REPEAT
                          i+=1;
                        CredmemoLines."No.":=toGl;
                        CredmemoLines.MODIFY;
                        UNTIL CredmemoLines.NEXT=0;
                         //MESSAGE('present');
                      END;
                    END;
                
                    GLEntry."G/L Account No." := toGl;
                     GLEntry.MODIFY;
                
                    "Fuel Prices"."Fuel type" := TRUE;
                    "Fuel Prices".MODIFY;
                
                UNTIL GLEntry.NEXT = 0;
                END;*/

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
        SaleInvoiceLines: Record "Sales Invoice Line";
        CredmemoLines: Record "Sales Cr.Memo Line";
        toGl: Code[20];
        fromGl: Code[20];
}

