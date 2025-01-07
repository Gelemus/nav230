xmlport 50076 "ImplementationLines Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(ImplementationLinesRoot)
        {
            tableelement("Project Implementation Lines";"Project Implementation Lines")
            {
                XmlName = 'ImplementationLines';
                fieldelement(LineNo;"Project Implementation Lines"."Line No.")
                {
                }
                fieldelement(DocumentNo;"Project Implementation Lines"."Document No.")
                {
                }
                fieldelement(Date;"Project Implementation Lines".Date)
                {
                }
                fieldelement(Action;"Project Implementation Lines".Action)
                {
                }
                fieldelement(ActionDescription;"Project Implementation Lines"."Action Description")
                {
                }
                fieldelement(PlanLineNo;"Project Implementation Lines"."Planning Line No.")
                {
                }
                fieldelement(Plan;"Project Implementation Lines".Plan)
                {
                }
                fieldelement(ActualCost;"Project Implementation Lines"."Actual Cost")
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

