report 50604 "Update Employee Posting Group"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Update Employee Posting Group.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {

            trigger OnAfterGetRecord()
            begin
                Employee."Posting Group" := Employee."Payroll Code";
                Employee."Imprest Posting Group" := Employee."Payroll Code";
                Employee."Employee Posting Group" := Employee."Payroll Code";
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

