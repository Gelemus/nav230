report 50158 "Apply Loan Customer Receipts"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Meeting Attendance";"Meeting Attendance")
        {

            trigger OnAfterGetRecord()
            begin
                CustLedgerEntry.Reset;
                CustLedgerEntry.SetRange("Customer No.","Meeting Attendance"."Meeting No");
                CustLedgerEntry.SetRange(Reversed,false);
                if CustLedgerEntry.FindSet then begin
                  CustLedgerEntry.CalcFields("Remaining Amount");
                  CustLedgerEntry.SetFilter("Remaining Amount",'<%1',0);
                  repeat
                  //  InvstReceiptApplication.SuggestEquityInvestmentRepaymentsAdvancedRct(CustLedgerEntry."Document No.",CustLedgerEntry."Customer No.",(CustLedgerEntry.Amount*-1));
                  until CustLedgerEntry.Next = 0;
                end;
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

