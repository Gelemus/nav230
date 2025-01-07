xmlport 50088 BoardMemebrsExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(BoardMembersRoot)
        {
            tableelement(Employee;Employee)
            {
                XmlName = 'BoardMembers';
                SourceTableView = WHERE("Board Members"=FILTER(true));
                fieldelement(MemberNo;Employee."No.")
                {
                }
                fieldelement(FirstName;Employee."First Name")
                {
                }
                fieldelement(MiddleName;Employee."Middle Name")
                {
                }
                fieldelement(LastName;Employee."Last Name")
                {
                }
                fieldelement(Gender;Employee.Gender)
                {
                }
                fieldelement(EmailAddress;Employee."Company E-Mail")
                {
                }
                fieldelement(StartDate;Employee."Board Members Start Date")
                {
                }
                fieldelement(EndDate;Employee."Board Members End Date")
                {
                }
                fieldelement(MemberStatus;Employee."Board Members Status")
                {
                }
                fieldelement(PhoneNumber;Employee."Mobile Phone No.")
                {
                }
                fieldelement(DirectorRepresenting;Employee."Association representing")
                {
                }
                fieldelement(Lengthofservice;Employee."Length of term")
                {
                }
                fieldelement(CurrentDesignation;Employee."Current Deisignation")
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

