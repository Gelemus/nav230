report 50165 "Generate Equity Invoice"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payment Terms";"Payment Terms")
        {
            RequestFilterFields = "Code";

            trigger OnAfterGetRecord()
            begin
                //RunDate:=TODAY;
                /*
                LoanInvoice.RESET;
                LoanInvoice.SETRANGE(LoanInvoice."Question Description",Table50324."No.");
                LoanInvoice.SETRANGE(LoanInvoice."Date Update",CALCDATE('CM',RunDate));
                IF NOT LoanInvoice.FINDFIRST THEN BEGIN
                  "LoanAccountMgmt.".GenerateEquityAccountInvoice(Table50324."No.",RunDate);
                END;*/

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Run Date";RunDate)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        RunDate: Date;
        "G/LEntry": Record "G/L Entry";
        LoanInvoice: Record "Tender Answers";
}

