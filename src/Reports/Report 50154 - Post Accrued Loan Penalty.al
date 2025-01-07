report 50154 "Post Accrued Loan Penalty"
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
                
                if EndDate<StartDate then
                  Error('The End Date cannot be earlier than the Start Date.');
                
                /*REPEAT
                  "G/LEntry".RESET;
                  "G/LEntry".SETRANGE("G/LEntry"."Loan Account No.","Loan Accounts"."No.");
                  "G/LEntry".SETRANGE("G/LEntry"."Posting Date",StartDate);
                  "G/LEntry".SETRANGE("G/LEntry"."Loan Transaction Type","G/LEntry"."Loan Transaction Type"::"Penalty Interest Receivable");
                  IF NOT "G/LEntry".FINDFIRST THEN BEGIN*/
                    //"InvestmentAccountMgmt.".PostLoanPenalty("Meeting Attendance"."Meeting No",StartDate,EndDate);
                 /* END;
                  StartDate:=CALCDATE('+1D',StartDate);
                
                  IF StartDate>EndDate THEN
                    BREAK;
                UNTIL StartDate=CALCDATE('+1D',EndDate);*/

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
        "G/LEntry": Record "G/L Entry";
}

