report 50166 "Post Equity Account Invoice"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Tender Answers";"Tender Answers")
        {
            RequestFilterFields = "Line No";

            trigger OnAfterGetRecord()
            begin
                /*IF (RunDate=0D) THEN
                  ERROR('The Run Date cannot be empty.');
                
                "G/LEntry".RESET;
                "G/LEntry".SETRANGE("G/LEntry"."Document No.","Tender Answers"."Line No");
                "G/LEntry".SETRANGE("G/LEntry"."Investment Account No.","Tender Answers"."Question Description");
                "G/LEntry".SETRANGE("G/LEntry"."Posting Date",CALCDATE('CM',RunDate));
                "G/LEntry".SETRANGE("G/LEntry"."Investment Transaction Type","G/LEntry"."Investment Transaction Type"::"Principal Receivable");
                IF NOT "G/LEntry".FINDFIRST THEN BEGIN
                  "InvestmentAccountMgmt.".PostEquityAccountInvoice("Tender Answers"."Line No");
                END ELSE BEGIN
                  "Tender Answers".Status:="Tender Answers".Status::"4";
                  "Tender Answers".Posted:=TRUE;
                  "Tender Answers"."Posted By":=USERID;
                  "Tender Answers"."Date Posted":=TODAY;
                  "Tender Answers"."Time Posted":=TIME;
                  "Tender Answers".MODIFY;
                END;
                */

            end;

            trigger OnPostDataItem()
            begin
                Message('Account Invoice Posted successfully.');
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
}

