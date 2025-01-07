report 50603 "uPDATE LOANDS"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/uPDATE LOANDS.rdl';

    dataset
    {
        dataitem("Loans/Advances"; "Loans/Advances")
        {
            DataItemTableView = WHERE(ID = FILTER(109 | 110));

            trigger OnAfterGetRecord()
            begin
                /*"Loans/Advances".VALIDATE("Loans/Advances"."Loan Types");
                "Loans/Advances".VALIDATE(Principal);
                "Loans/Advances".VALIDATE("Start Period");
                
                "Loans/Advances"."Interest Rate":=12;
                "Loans/Advances".CreateLoan;
                "Loans/Advances".PayLoan;
                "Loans/Advances".MODIFY;
                */

                "Loans/Advances"."Paid to Employee" := false;
                "Loans/Advances".CreateLoan;
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

