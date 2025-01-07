report 50954 "Delete sales Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Delete sales Invoice.rdl';

    dataset
    {
        dataitem(WrongTransactions; WrongTransactions)
        {

            trigger OnAfterGetRecord()
            var
                i: Integer;
            begin
                SaleInvoiceHeader.Reset;
                SaleInvoiceHeader.SetRange("External Document No.", WrongTransactions.No);

                if SaleInvoiceHeader.FindFirst then begin

                    SaleInvoiceLine.Reset;
                    SaleInvoiceLine.SetRange("Document No.", SaleInvoiceHeader."No.");
                    SaleInvoiceLine.DeleteAll;

                    CustLedgerEntry.Reset;
                    CustLedgerEntry.SetRange("Customer No.", SaleInvoiceHeader."Sell-to Customer No.");
                    CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
                    CustLedgerEntry.SetRange("Document No.", SaleInvoiceHeader."No.");
                    CustLedgerEntry.DeleteAll;

                    DetailedCustLedgEntry.Reset;
                    DetailedCustLedgEntry.SetRange("Customer No.", SaleInvoiceHeader."Sell-to Customer No.");
                    DetailedCustLedgEntry.SetRange("Document Type", DetailedCustLedgEntry."Document Type"::Invoice);
                    DetailedCustLedgEntry.SetRange("Document No.", SaleInvoiceHeader."No.");
                    DetailedCustLedgEntry.DeleteAll;

                    GLEntry.Reset;
                    GLEntry.SetRange("Posting Date", SaleInvoiceHeader."Posting Date");
                    GLEntry.SetRange("Document Type", GLEntry."Document Type"::Invoice);
                    GLEntry.SetRange("Document No.", SaleInvoiceHeader."No.");
                    GLEntry.DeleteAll;

                    VATEntry.Reset;
                    VATEntry.SetRange("Posting Date", SaleInvoiceHeader."Posting Date");
                    VATEntry.SetRange("Document No.", SaleInvoiceHeader."No.");
                    VATEntry.DeleteAll;


                end;

                SaleInvoiceHeader.Delete;

                WrongTransactions.Modified := true;
                WrongTransactions.Modify;
            end;

            trigger OnPreDataItem()
            begin
                //"Sales Invoice Header".SETFILTER("Sales Cr.Memo Header"."No.",'%1|%2|%3','107114','107229','107310');
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
        Message('Done');
    end;

    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        GLEntry: Record "G/L Entry";
        VATEntry: Record "VAT Entry";
        SaleInvoiceHeader: Record "Sales Invoice Header";
        SaleInvoiceLine: Record "Sales Invoice Line";
}

