report 50155 "Generate Loan Invoice"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Meeting Attendance";"Meeting Attendance")
        {
            RequestFilterFields = "Meeting No";

            trigger OnAfterGetRecord()
            begin
                //RunDate:=TODAY;
                /*
                LoanInvoice.RESET;
                LoanInvoice.SETRANGE(LoanInvoice."Question Description","Meeting Attendance"."Meeting No");
                LoanInvoice.SETRANGE(LoanInvoice."Date Update",CALCDATE('CM',RunDate));
                IF NOT LoanInvoice.FINDFIRST THEN BEGIN
                  "LoanAccountMgmt.".GenerateAccountInvoice("Meeting Attendance"."Meeting No",RunDate);
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

