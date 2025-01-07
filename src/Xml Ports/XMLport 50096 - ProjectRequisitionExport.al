xmlport 50096 ProjectRequisitionExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(ProjectRequisitionRoot)
        {
            tableelement("Purchase Requisitions";"Purchase Requisitions")
            {
                XmlName = 'ProjectRequistion';
                fieldelement(RequisitionNo;"Purchase Requisitions"."No.")
                {
                }
                fieldelement(ProjectNo;"Purchase Requisitions"."Project No")
                {
                }
                fieldelement(DocumentDate;"Purchase Requisitions"."Document Date")
                {
                }
                fieldelement(Status;"Purchase Requisitions".Status)
                {
                }
                fieldelement(Description;"Purchase Requisitions".Description)
                {
                }
                fieldelement(EmployeeNo;"Purchase Requisitions"."Employee No.")
                {
                }
                fieldelement(Amount;"Purchase Requisitions".Amount)
                {
                }
                fieldelement(UnitCode;"Purchase Requisitions"."Global Dimension 2 Code")
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

