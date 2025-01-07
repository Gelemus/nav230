xmlport 50083 BoardCommitteExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(BoardCommitteeRoot)
        {
            tableelement("Board Commitee";"Board Commitee")
            {
                XmlName = 'BoardCommittee';
                fieldelement(BoardComitteeCode;"Board Commitee".Code)
                {
                }
                fieldelement(Description;"Board Commitee".Description)
                {
                }
                fieldelement(StartDate;"Board Commitee"."Start Date")
                {
                }
                fieldelement(EndDate;"Board Commitee"."End Date")
                {
                }
                fieldelement(Mandate;"Board Commitee".Mandate)
                {
                }
                fieldelement(Status;"Board Commitee".Status)
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

