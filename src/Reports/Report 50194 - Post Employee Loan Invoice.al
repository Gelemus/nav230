report 50194 "Post Employee Loan Invoice"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payment Terms";"Payment Terms")
        {
            RequestFilterFields = "Code";

            trigger OnAfterGetRecord()
            begin
                /*IF (RunDate=0D) THEN
                  ERROR('The Run Date cannot be empty.');
                
                "G/LEntry".RESET;
                "G/LEntry".SETRANGE("G/LEntry"."Document No.",Table50362."No.");
                "G/LEntry".SETRANGE("G/LEntry"."Investment Account No.",Table50362."Loan Account No.");
                "G/LEntry".SETRANGE("G/LEntry"."Posting Date",CALCDATE('CM',RunDate));
                "G/LEntry".SETRANGE("G/LEntry"."Investment Transaction Type","G/LEntry"."Investment Transaction Type"::"Principal Receivable");
                IF NOT "G/LEntry".FINDFIRST THEN BEGIN
                  HRLoanManagement.PostEmployeeAccountInvoice(Table50362."No.");
                END ELSE BEGIN
                  Table50362.Status:=Table50362.Status::"4";
                  Table50362.Posted:=TRUE;
                  Table50362."Posted By":=USERID;
                  Table50362."Date Posted":=TODAY;
                  Table50362."Time Posted":=TIME;
                  Table50362.MODIFY;
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
        HRLoanManagement: Codeunit "HR Loan Management";
        RunDate: Date;
        "G/LEntry": Record "G/L Entry";
}

