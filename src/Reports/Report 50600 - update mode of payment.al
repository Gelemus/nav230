report 50600 "update mode of payment"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/update mode of payment.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {

            trigger OnAfterGetRecord()
            begin
                Employee."Mode of Payment" := 'EFT';
                Modify;
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
}

