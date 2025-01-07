xmlport 50135 "Employee2 Export"
{
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(EmployeeRoot)
        {
            tableelement(Employee;Employee)
            {
                XmlName = 'Employee';
                fieldelement(No;Employee."No.")
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
                fieldelement(JobTitle;Employee."Job Title")
                {
                }
                fieldelement(PhoneNo;Employee."Phone No.")
                {
                }
                fieldelement(Gender;Employee.Gender)
                {
                }
                fieldelement(Contract;Employee."E-Mail")
                {
                }
                fieldelement(Department;Employee."Global Dimension 1 Code")
                {
                }
                fieldelement(Section;Employee."Global Dimension 2 Code")
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

