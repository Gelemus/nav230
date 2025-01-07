report 50117 "Security Withdrawal Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Security Withdrawal Register.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
            //RequestFilterFields = "Code","Discount Date Calculation","Calc. Pmt. Disc. on Cr. Memos",Field10;
            column(DateDischarged_SecuritiesDischargeHeader; "Payment Terms".Code)
            {
            }
            column(SecurityDescription_SecuritiesDischargeHeader; "Payment Terms".Code)
            {
            }
            column(ClientNo_SecuritiesDischargeHeader; "Payment Terms".Code)
            {
            }
            column(ClientName_SecuritiesDischargeHeader; "Payment Terms".Code)
            {
            }
            column(PersonCollected_SecuritiesDischargeHeader; "Payment Terms".Code)
            {
            }
            column(IDPassportNo_SecuritiesDischargeHeader; "Payment Terms".Code)
            {
            }
            column(TODAY; Format(Today, 0, 4))
            {
            }
            column(DischargedBy_SecuritiesDischargeHeader; "Payment Terms".Code)
            {
            }
            column(TimeDischarged_SecuritiesDischargeHeader; "Payment Terms".Code)
            {
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
}

