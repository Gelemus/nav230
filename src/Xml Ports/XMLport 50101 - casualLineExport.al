xmlport 50101 casualLineExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(CasualLineRoot)
        {
            tableelement("HR Employee Requisitions Lines";"HR Employee Requisitions Lines")
            {
                XmlName = 'CasualRequestLine';
                fieldattribute(LineNo;"HR Employee Requisitions Lines"."Line No")
                {
                }
                fieldattribute(Station;"HR Employee Requisitions Lines".Section)
                {
                }
                fieldattribute(HeaderNo;"HR Employee Requisitions Lines"."No.")
                {
                }
                fieldattribute(NoRequested;"HR Employee Requisitions Lines"."Number Required")
                {
                }
                fieldattribute(JobCode;"HR Employee Requisitions Lines"."Job No.")
                {
                }
                fieldattribute(JobTitle;"HR Employee Requisitions Lines"."Job Title")
                {
                }
                fieldattribute(UnitCost;"HR Employee Requisitions Lines"."Vacant Positions")
                {
                }
                fieldattribute(AdministrativeCost;"HR Employee Requisitions Lines"."Maximum Positions")
                {
                }
                fieldattribute(GrossAmount;"HR Employee Requisitions Lines"."Requested Employees")
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

