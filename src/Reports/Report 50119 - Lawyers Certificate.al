report 50119 "Lawyers Certificate"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Lawyers Certificate.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
            column(Name_SecuritiesPreparations; "Payment Terms".Code)
            {
            }
            dataitem(Currency; Currency)
            {
                DataItemLink = Code = FIELD(Code);
                column(Typeofsecurity_SecurityVerification; "Payment Terms".Code)
                {
                }
                column(DocumentState_SecurityVerification; "Payment Terms".Code)
                {
                }
                column(Status_SecurityVerification; "Payment Terms".Code)
                {
                }
                column(Remarks_SecurityVerification; "Payment Terms".Code)
                {
                }
                column(LNo; LNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LNo := LNo + 1;
                end;
            }
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
        LNo: Integer;
}

