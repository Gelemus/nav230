xmlport 50093 ProjectCasualReqExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(ProjectCasualReqRoot)
        {
            tableelement("HR Employee Requisitions";"HR Employee Requisitions")
            {
                XmlName = 'ProjectCasualReq';
                SourceTableView = WHERE("Document Type"=FILTER("Casual Request"));
                fieldelement(ReqNo;"HR Employee Requisitions"."No.")
                {
                }
                fieldelement(Projectno;"HR Employee Requisitions"."Project No")
                {
                }
                fieldelement(StartDate;"HR Employee Requisitions"."Start Date")
                {
                }
                fieldelement(EndDate;"HR Employee Requisitions"."End Date")
                {
                }
                fieldelement(BudgetGL;"HR Employee Requisitions"."Budget GL")
                {
                }
                fieldelement(BudgetGLName;"HR Employee Requisitions"."Budget GL Name")
                {
                }
                fieldelement(EmployeeNo;"HR Employee Requisitions"."Employee No")
                {
                }
                fieldelement(EmployeeName;"HR Employee Requisitions"."Employee Name")
                {
                }
                fieldelement(UnitCode;"HR Employee Requisitions"."Global Dimension 2 Code")
                {
                }
                fieldelement(ReasonForEngagement;"HR Employee Requisitions"."Reason for engagement")
                {
                }
                fieldelement(SkilledDailyRate;"HR Employee Requisitions"."Daily Rate Skilled")
                {
                }
                fieldelement(UnskilledDailyRate;"HR Employee Requisitions"."Daily Rate Unskilled")
                {
                }
                fieldelement(SkilledDaysofEngagement;"HR Employee Requisitions"."Days for Engagement - Skilled")
                {
                }
                fieldelement(UnskilledDaysofEngagement;"HR Employee Requisitions"."Days for Engagement - Unkilled")
                {
                }
                fieldelement(SkilledNumberRequired;"HR Employee Requisitions"."Number Required - Skilled")
                {
                }
                fieldelement(UnskilledNumberRequired;"HR Employee Requisitions"."Number Required - Unskilled")
                {
                }
                fieldelement(Status;"HR Employee Requisitions".Status)
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

