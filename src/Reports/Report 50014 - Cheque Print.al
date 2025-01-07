report 50014 "Cheque Print"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Cheque Print.rdl';

    dataset
    {
        dataitem("Payment Header"; "Payment Header")
        {
            column(Payee; "Payment Header"."Payee Name")
            {
            }
            column(BankAccountName; "Payment Header"."Payee Bank Account Name")
            {
            }
            column(PayDate; "Payment Header"."Posting Date")
            {
            }
            column(Amount; "Payment Header"."Net Amount(LCY)")
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(PayeeName_PaymentHeader; "Payment Header"."Payee Name")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Payment Header"."Payee Name" := UpperCase("Payment Header"."Payee Name");
                CalcFields("Net Amount(LCY)");

                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, "Net Amount(LCY)", "Payment Header"."Currency Code");
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
        NumberText: array[2] of Text[100];
        CheckReport: Report Check;
}

