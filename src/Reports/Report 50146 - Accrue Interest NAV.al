report 50146 "Accrue Interest NAV"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Meeting Attendance";"Meeting Attendance")
        {
            RequestFilterFields = "Meeting No";

            trigger OnAfterGetRecord()
            begin
                StartDate:=Today;
                EndDate:= Today;
                
                
                //REPEAT
                  //"InvestmentAccountMgmt.".AccrueLoanAccountInterest("Meeting Attendance"."Meeting No",StartDate);
                  /*StartDate:=CALCDATE('+1D',StartDate);
                
                  IF StartDate>EndDate THEN
                    BREAK;
                UNTIL StartDate=CALCDATE('+1D',EndDate);
                */

            end;

            trigger OnPostDataItem()
            begin
                //MESSAGE('Interest Accrual Complete.');
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

