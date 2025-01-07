xmlport 50126 "Committee Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(TenderCommiteeRoot)
        {
            tableelement(Employee;Employee)
            {
                XmlName = 'TenderCommittee';
                SourceTableView = WHERE(Status=CONST(Active),"Emplymt. Contract Code"=FILTER(<>'BOARD'));
                fieldelement(No;Employee."No.")
                {
                }
                fieldelement(FirstName;Employee."First Name")
                {
                }
                fieldelement(MiddleName;Employee."Middle Name")
                {
                }
                fieldelement(Gender;Employee.Gender)
                {
                }
                fieldelement(Email;Employee."E-Mail")
                {
                }
                fieldelement(UserID;Employee."User ID")
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

