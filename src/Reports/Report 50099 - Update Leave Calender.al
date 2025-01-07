report 50099 "Update Leave Calender"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Update Leave Calender.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {

            trigger OnAfterGetRecord()
            begin
                Employee."Leave Calendar" := 'HR BASE';
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

