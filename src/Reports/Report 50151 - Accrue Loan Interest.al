report 50151 "Accrue Loan Interest"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Meeting Attendance";"Meeting Attendance")
        {
            RequestFilterFields = "Meeting No";

            trigger OnAfterGetRecord()
            begin
                if (StartDate=0D) or (EndDate=0D) then
                  Error('The Start/End Date cannot be empty.');

                if EndDate < StartDate then
                  Error('The End Date cannot be earlier than the Start Date.');

                repeat
                  //"InvestmentAccountMgmt.".AccrueLoanAccountInterest("Meeting Attendance"."Meeting No",StartDate);
                  StartDate:=CalcDate('+1D',StartDate);

                  if StartDate>EndDate then
                    break;
                until StartDate=CalcDate('+1D',EndDate);
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
        StartDate: Date;
        EndDate: Date;
}

