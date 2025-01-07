xmlport 50089 BoardMeetingApprovalItemExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(ApprovalItemsRoot)
        {
            tableelement(Employee;Employee)
            {
                XmlName = 'ApprovalItems';
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
                fieldelement(DirectorRepresenting;Employee."Phone No.")
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

