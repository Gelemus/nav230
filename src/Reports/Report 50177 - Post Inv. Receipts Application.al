report 50177 "Post Inv. Receipts Application"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Evaluation Category";"Evaluation Category")
        {

            trigger OnAfterGetRecord()
            begin

                //InvstReceiptApplication.PostInvestmentApplication("Evaluation Category".LineNo,FALSE);
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
        AccountApplicationHeader: Record "Evaluation Category";
}

