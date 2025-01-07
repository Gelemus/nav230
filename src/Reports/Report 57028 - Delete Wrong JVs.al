report 57028 "Delete Wrong JVs"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Delete Wrong JVs.rdl';

    dataset
    {
        dataitem(WrongTransactions; WrongTransactions)
        {

            trigger OnAfterGetRecord()
            var
                i: Integer;
            begin
                JournalVourcher.Reset;
                JournalVourcher.SetRange("JV No.", WrongTransactions.No);

                if JournalVourcher.FindFirst then begin

                    JvLine.Reset;
                    JvLine.SetRange("Document No.", JournalVourcher."JV No.");
                    JvLine.DeleteAll;

                    CustLedgerEntry.Reset;
                    CustLedgerEntry.SetRange("Document No.", JournalVourcher."JV No.");
                    CustLedgerEntry.SetRange("Posting Date", JournalVourcher."Posting Date");
                    CustLedgerEntry.DeleteAll;

                    DetailedCustLedgEntry.Reset;
                    DetailedCustLedgEntry.SetRange("Document No.", JournalVourcher."JV No.");
                    DetailedCustLedgEntry.SetRange("Posting Date", JournalVourcher."Posting Date");
                    DetailedCustLedgEntry.DeleteAll;

                    GLEntry.Reset;
                    GLEntry.SetRange("Posting Date", JournalVourcher."Posting Date");
                    GLEntry.SetRange("Document No.", JournalVourcher."JV No.");
                    GLEntry.DeleteAll;

                    /*VATEntry.RESET;
                    VATEntry.SETRANGE("Posting Date",JournalVourcher."Posting Date");
                    VATEntry.SETRANGE("Document No.",JournalVourcher."JV No.");
                    VATEntry.DELETEALL;*/


                end;

                JournalVourcher.Delete;

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
        JournalVourcher: Record "Journal Voucher Header";
        JvLine: Record "Journal Voucher Lines";
}

