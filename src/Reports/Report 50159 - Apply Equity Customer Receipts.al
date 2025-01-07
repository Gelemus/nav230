report 50159 "Apply Equity Customer Receipts"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payment Terms";"Payment Terms")
        {

            trigger OnAfterGetRecord()
            begin
                /*CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE("Customer No.",Table50324."No.");
                CustLedgerEntry.SETRANGE(Reversed,FALSE);
                IF CustLedgerEntry.FINDSET THEN BEGIN
                  CustLedgerEntry.CALCFIELDS("Remaining Amount");
                  CustLedgerEntry.SETFILTER("Remaining Amount",'<%1',0);
                  REPEAT
                    InvstReceiptApplication.SuggestEquityInvestmentRepaymentsAdvancedRct(CustLedgerEntry."Document No.",CustLedgerEntry."Customer No.",(CustLedgerEntry.Amount*-1));
                  UNTIL CustLedgerEntry.NEXT = 0;
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

    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
}

