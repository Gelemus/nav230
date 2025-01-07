report 57026 "UpdateLedger from table STORES"
{
    //DefaultLayout = RDLC;
    // RDLCLayout = 'src/Layouts/UpdateLedger from table STORES.rdl';
    ProcessingOnly = true;
    dataset
    {
        dataitem("Store Requisition Header"; "Store Requisition Header")
        {
            DataItemTableView = WHERE(Status = CONST(Open), "Store Requistion No" = CONST('ST00249566'));

            trigger OnAfterGetRecord()
            begin
                "Store Requisition Header".Status := "Store Requisition Header".Status::Cancelled;
                "Store Requisition Header".Modify;
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

