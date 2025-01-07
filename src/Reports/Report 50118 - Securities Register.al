report 50118 "Securities Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Securities Register.rdl';

    dataset
    {
        dataitem("Bill Item"; "Bill Item")
        {
            //RequestFilterFields = "Job ID",Field10,"Bill Item No.";
            column(SecurityNo_SecuritiesRegister; "Bill Item"."Job ID")
            {
            }
            column(DateReceived_SecuritiesRegister; "Bill Item"."Bill Item No.")
            {
            }
            column(AssetNo_SecuritiesRegister; "Bill Item".Description)
            {
            }
            column(Description_SecuritiesRegister; "Bill Item"."Bill Item Type")
            {
            }
            column(SerialNo_SecuritiesRegister; "Bill Item"."WIP-Total")
            {
            }
            column(ClientNo_SecuritiesRegister; "Bill Item".Description)
            {
            }
            column(ClientName_SecuritiesRegister; "Bill Item".Description)
            {
            }
            column(ClientEmailAddress_SecuritiesRegister; "Bill Item".Description)
            {
            }
            column(BookValue_SecuritiesRegister; "Bill Item".Description)
            {
            }
            column(ReceivedBy_SecuritiesRegister; "Bill Item".Description)
            {
            }
            column(Timereceived_SecuritiesRegister; "Bill Item".Description)
            {
            }
            column(TODAY; Format(Today, 0, 4))
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

