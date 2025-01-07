report 52004 "Customer Commissions"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Customer Commissions.rdl';

    dataset
    {
        dataitem("Bank Branch"; "Bank Branch")
        {
            column(No_CustomerCommission; "Bank Branch"."Bank Code")
            {
            }
            column(CustomerNo_CustomerCommission; "Bank Branch"."Bank Name")
            {
            }
            column(CustomerName_CustomerCommission; "Bank Branch"."Bank Branch Code")
            {
            }
            column(CommissionPercentage_CustomerCommission; "Bank Branch"."Bank Branch Name")
            {
            }
            column(CommissionAmount_CustomerCommission; "Bank Branch"."Branch Physical Location")
            {
            }
            column(Comments_CustomerCommission; "Bank Branch"."Branch Postal Code")
            {
            }
            column(SalesAmount_CustomerCommission; "Bank Branch"."Branch Address")
            {
            }
            column(NoSeries_CustomerCommission; "Bank Branch"."Branch Phone No.")
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

