xmlport 50079 JobTaskExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(JobTaskRoot)
        {
            tableelement(Job;Job)
            {
                XmlName = 'JobTask';
                fieldelement(JobNo;Job."No.")
                {
                }
                fieldelement(JobName;Job.Description)
                {
                }
                fieldelement(StartDate;Job."Starting Date")
                {
                }
                fieldelement(EndDate;Job."Ending Date")
                {
                }
                fieldelement(Status;Job.Status)
                {
                }
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
}

