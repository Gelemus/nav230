xmlport 50075 "ActionPlanLines Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(ActionPlanningLinesRoot)
        {
            tableelement("Action Planning Lines";"Action Planning Lines")
            {
                XmlName = 'ActionPlanningLines';
                fieldelement(LineNo;"Action Planning Lines"."Line No.")
                {
                }
                fieldelement(DocumentNo;"Action Planning Lines"."Document No.")
                {
                }
                fieldelement(PlanDate;"Action Planning Lines"."Plan Date")
                {
                }
                fieldelement(StartDate;"Action Planning Lines"."Start Date")
                {
                }
                fieldelement(EndDate;"Action Planning Lines"."End Date")
                {
                }
                fieldelement(Plan;"Action Planning Lines".Plan)
                {
                }
                fieldelement(PlanDescription;"Action Planning Lines"."Plan Description")
                {
                }
                fieldelement(EmployeeNo;"Action Planning Lines"."Employee No.")
                {
                }
                fieldelement(EmployeeName;"Action Planning Lines"."Employee Name")
                {
                }
                fieldelement(BudgetAmount;"Action Planning Lines"."Budget Amount")
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

