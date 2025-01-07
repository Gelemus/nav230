xmlport 50072 "Import/Export Travelling Emp"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(TravellingEmployeeRoot)
        {
            tableelement("Travelling Employee";"Travelling Employee")
            {
                XmlName = 'TravellingEmp';
                fieldelement(ReqNo;"Travelling Employee"."Request No.")
                {
                }
                fieldelement(EmpNo;"Travelling Employee"."Employee No.")
                {
                }
                fieldelement(EmpName;"Travelling Employee"."Employee Name")
                {
                }
                fieldelement(EmpType;"Travelling Employee"."Employee Name")
                {
                }
                fieldelement(Description;"Travelling Employee".Description)
                {
                }
                fieldelement(Quantity;"Travelling Employee".Quantity)
                {
                }
                fieldelement(Amount;"Travelling Employee".Amount)
                {
                }
                fieldelement(PricePerUnit;"Travelling Employee"."Price per Unit")
                {
                }
                fieldelement(LineNo;"Travelling Employee"."Line No")
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

