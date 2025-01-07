report 50164 "Post Accr. Equity Penalty Int."
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
                
                IF EndDate<StartDate THEN
                  ERROR('The End Date cannot be earlier than the Start Date.');
                
                REPEAT
                  "G/LEntry".RESET;
                  "G/LEntry".SETRANGE("G/LEntry"."Investment Account No.",Table50324."No.");
                  "G/LEntry".SETRANGE("G/LEntry"."Posting Date",StartDate);
                  "G/LEntry".SETRANGE("G/LEntry"."Investment Transaction Type","G/LEntry"."Investment Transaction Type"::"Penalty Interest Receivable");
                  IF NOT "G/LEntry".FINDFIRST THEN BEGIN
                    "InvestmentAccountMgmt.".PostEquityPenalty(Table50324."No.",StartDate,EndDate);
                  END;
                  StartDate:=CALCDATE('+1D',StartDate);
                
                  IF StartDate>EndDate THEN
                    BREAK;
                UNTIL StartDate=CALCDATE('+1D',EndDate);
                */

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

