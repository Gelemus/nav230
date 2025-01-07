xmlport 50094 ProjectCasualPayExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(ProjectCasualPayRoot)
        {
            tableelement("Imprest Header";"Imprest Header")
            {
                XmlName = 'ProjectCasualPay';
                SourceTableView = WHERE("Document Type"=FILTER("Casuals Payment"));
                fieldelement(ImprestNo;"Imprest Header"."No.")
                {
                }
                fieldelement(EmployeeNo;"Imprest Header"."Employee No.")
                {
                }
                fieldelement(EmployeeName;"Imprest Header"."Employee Name")
                {
                }
                fieldelement(EndDate;"Imprest Header"."Date To")
                {
                }
                fieldelement(StartDate;"Imprest Header"."Date From")
                {
                }
                fieldelement(Description;"Imprest Header".Description)
                {
                }
                fieldelement(Status;"Imprest Header".Status)
                {
                }
                fieldelement(Amount;"Imprest Header".Amount)
                {
                }
                fieldelement(UnitCode;"Imprest Header"."Global Dimension 2 Code")
                {
                }
                fieldelement(CasualRequisition;"Imprest Header"."Casual Requisition No")
                {
                }
                fieldelement(ProjectNo;"Imprest Header"."Project No")
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

