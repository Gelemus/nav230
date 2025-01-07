report 50193 "Generate Employee Loan Invoice"
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
                LoanInvoice.SETRANGE(LoanInvoice."Loan Account No.",Table50356."No.");
                LoanInvoice.SETRANGE(LoanInvoice."Posting Date",CALCDATE('CM',RunDate));
                IF NOT LoanInvoice.FINDFIRST THEN BEGIN
                  HRLoanManagement.GenerateEmployeeAccountInvoice(Table50356."No.",RunDate);
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
        HRLoanManagement: Codeunit "HR Loan Management";
        RunDate: Date;
        "G/LEntry": Record "G/L Entry";
}

