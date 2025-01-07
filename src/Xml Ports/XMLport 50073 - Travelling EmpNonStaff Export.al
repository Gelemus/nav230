xmlport 50073 "Travelling EmpNonStaff Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(TravellingEmployeeNonStaffRoot)
        {
            tableelement("Non Staff Travelling";"Non Staff Travelling")
            {
                XmlName = 'TravellingEmpNonStaff';
                fieldelement(ReqNo;"Non Staff Travelling"."Request No.")
                {
                }
                fieldelement(IdNo;"Non Staff Travelling"."ID No")
                {
                }
                fieldelement(StaffName;"Non Staff Travelling".Name)
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

