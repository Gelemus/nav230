report 50056 "Send CRM Email Messages"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loan Product Allowances";"Loan Product Allowances")
        {

            trigger OnAfterGetRecord()
            begin
                /*IF NOT "Loan Product Allowances"."Email Sent" THEN BEGIN
                  CLEAR(EmailBodyInStream);
                  CLEAR(EmailBodyRequest);
                  EmailBody:='';
                
                  "Loan Product Allowances".CALCFIELDS("Loan Product Allowances".Body);
                  "Loan Product Allowances".Body.CREATEINSTREAM(EmailBodyInStream);
                  EmailBodyRequest.READ(EmailBodyInStream);
                  EmailBodyRequest.GETSUBTEXT(EmailBody,1);
                
                  SMTPMail.CreateMessage("Loan Product Allowances"."Payroll Transaction Code","Loan Product Allowances"."Payroll Transaction Name",
                  "Loan Product Allowances".Recipients,"Loan Product Allowances".Subject,EmailBody,TRUE);
                  IF SMTPMail.TrySend THEN BEGIN
                    "Loan Product Allowances"."Email Sent":=TRUE;
                    "Loan Product Allowances"."Date Sent":=TODAY;
                    "Loan Product Allowances"."Time Sent":=TIME;
                    "Loan Product Allowances".MODIFY;
                  END;
                END;*/

            end;

            trigger OnPreDataItem()
            begin
                //"Loan Product Allowances".SETRANGE("Loan Product Allowances"."Email Sent",FALSE);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        //SMTPMailSetup: Record "SMTP Mail Setup";
        //SMTPMail: Codeunit "SMTP Mail";
        EmailBodyInStream: InStream;
        EmailBodyRequest: BigText;
        EmailBody: Text;
}

