report 50163 "Accrue Equity Penalty Interest"
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
                  "InvestmentAccountMgmt.".AccrueEquityPenalty(Table50324."No.",StartDate);
                  StartDate:=CALCDATE('+1D',StartDate);
                
                  IF StartDate>EndDate THEN
                    BREAK;
                UNTIL StartDate=CALCDATE('+1D',EndDate);*/

            end;

            trigger OnPostDataItem()
            begin
                Message('Penalty Interest Accrual Complete. Proceed to Post Accrued Penalty Interest.');
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

