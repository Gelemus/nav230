xmlport 50078 ProjectsExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(ProjectRoot)
        {
            tableelement("Transport Request";"Transport Request")
            {
                XmlName = 'Project';
                fieldelement(RequestNo;"Transport Request"."Request No.")
                {
                }
                fieldelement(ProjectName;"Transport Request"."Project Name")
                {
                }
                fieldelement(NatureOfRequest;"Transport Request"."P.Nature of Request")
                {
                }
                fieldelement(RequestReason;"Transport Request"."P.Request Reason")
                {
                }
                fieldelement(OtherInformation;"Transport Request"."P.Other Information")
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

