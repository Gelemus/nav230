report 50184 "Send Investment Email Messages"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payment Terms";"Payment Terms")
        {

            trigger OnAfterGetRecord()
            begin
                /*IF NOT Table50344."Email Sent" THEN BEGIN
                  CLEAR(EmailBodyInStream);
                  CLEAR(EmailBodyRequest);
                  EmailBody:='';
                
                  Table50344.CALCFIELDS(Table50344.Body);
                  Table50344.Body.CREATEINSTREAM(EmailBodyInStream);
                  EmailBodyRequest.READ(EmailBodyInStream);
                  EmailBodyRequest.GETSUBTEXT(EmailBody,1);
                
                  SMTPMail.CreateMessage(Table50344."Sender Name",Table50344."Sender Address",
                  Table50344.Recipients,Table50344.Subject,EmailBody,TRUE);
                  IF SMTPMail.TrySend THEN BEGIN
                    Table50344."Email Sent":=TRUE;
                    Table50344."Date Sent":=TODAY;
                    Table50344."Time Sent":=TIME;
                    Table50344.MODIFY;
                  END;
                END;
                */

            end;

            trigger OnPreDataItem()
            begin
                //Table50344.SETRANGE(Table50344."Email Sent",FALSE);
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

