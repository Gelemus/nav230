report 50160 "Auto Post Investment Cheques"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Receipt Header";"Receipt Header")
        {
            DataItemTableView = WHERE("Receipt Type"=FILTER("Investment Loan"|Equity|"Normal Receipt"),"Payment Mode"=CONST(Cheque),Posted=CONST(false),"Posted to Cheque Buffer"=CONST(true));

            trigger OnAfterGetRecord()
            begin
                /*//IF "Receipt Header"."Posting Date" = WORKDATE THEN BEGIN
                  InvestmentGeneralSetup.GET;
                  FundsManagement.PostChequeReceipt("Receipt Header"."No.",InvestmentGeneralSetup."Application Journal Template",
                  InvestmentGeneralSetup."Application Journal Batch",FALSE);
                //END;*/

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
        FundsManagement: Codeunit "Funds Management";
}

