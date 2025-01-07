xmlport 50097 ProjectPettyCashExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(ProjectPettyCashRoot)
        {
            tableelement("Imprest Header";"Imprest Header")
            {
                XmlName = 'ProjectPettyCash';
                SourceTableView = WHERE("Document Type"=FILTER("Petty Cash"));
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

