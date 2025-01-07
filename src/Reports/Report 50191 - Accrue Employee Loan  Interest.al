report 50191 "Accrue Employee Loan  Interest"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payment Terms";"Payment Terms")
        {
            RequestFilterFields = "Code";

            trigger OnAfterGetRecord()
            begin
                /*IF (StartDate=0D) OR (EndDate=0D) THEN
                  ERROR('The Start/End Date cannot be empty.');
                
                IF EndDate < StartDate THEN
                  ERROR('The End Date cannot be earlier than the Start Date.');
                
                REPEAT
                  HRLoanManagement.AccrueEmployeeLoanAccountInterest(Table50356."No.",StartDate);
                  StartDate:=CALCDATE('+1D',StartDate);
                
                  IF StartDate>EndDate THEN
                    BREAK;
                UNTIL StartDate=CALCDATE('+1D',EndDate);
                */

            end;

            trigger OnPostDataItem()
            begin
                Message('Interest Accrual Complete.');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date";StartDate)
                {
                }
                field("End Date";EndDate)
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
        StartDate: Date;
        EndDate: Date;
}

