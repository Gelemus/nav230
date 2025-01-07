xmlport 50098 ProjectsReqExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(ProjectsReqRoot)
        {
            tableelement(Job;Job)
            {
                XmlName = 'ProjectReq';
                fieldelement(ProjectNo;Job."No.")
                {
                }
                fieldelement(ProjectName;Job.Description)
                {
                }
                fieldelement(ProjectDescription;Job."Description 2")
                {
                }
                fieldelement(StartDate;Job."Starting Date")
                {
                }
                fieldelement(EndDate;Job."Ending Date")
                {
                }
                fieldelement(Location;Job.Location)
                {
                }
                fieldelement(ProjectManager;Job."Project Manager")
                {
                }
                fieldelement(ContractName;Job.Contractor)
                {
                }
                fieldelement(ContractPhoneNo;Job."Contractor Phone No")
                {
                }
                fieldelement(ContractLocation;Job."Contractor Location")
                {
                }
                fieldelement(BudgetGL;Job."Budget G/L")
                {
                }
                fieldelement(BudgetGLName;Job."Budget G/L Name")
                {
                }
                fieldelement(Status;Job."Project Status")
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

