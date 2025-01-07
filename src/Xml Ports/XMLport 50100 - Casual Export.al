xmlport 50100 "Casual Export"
{
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(HrCasualRequisitionRoot)
        {
            tableelement("HR Employee Requisitions";"HR Employee Requisitions")
            {
                XmlName = 'CasualRequisition';
                fieldelement(CasualRequest;"HR Employee Requisitions"."No.")
                {
                }
                fieldelement(EmployeeNo;"HR Employee Requisitions"."Employee No")
                {
                }
                fieldelement(EmployeeName;"HR Employee Requisitions"."Employee Name")
                {
                }
                fieldelement(DateRequired;"HR Employee Requisitions"."Date Required")
                {
                }
                fieldelement(NumberRequired;"HR Employee Requisitions"."Number Required")
                {
                }
                fieldelement(StartDate;"HR Employee Requisitions"."Start Date")
                {
                }
                fieldelement(EndDate;"HR Employee Requisitions"."End Date")
                {
                }
                fieldelement(Dimension1;"HR Employee Requisitions"."Global Dimension 1 Code")
                {
                }
                fieldelement(Dimension2;"HR Employee Requisitions"."Global Dimension 2 Code")
                {
                }
                fieldelement(MainDuties;"HR Employee Requisitions"."Main Duties")
                {
                }
                fieldelement(QualificationsRequired;"HR Employee Requisitions"."Qualifications Required")
                {
                }
                fieldelement(NoofYaearsExperience;"HR Employee Requisitions"."No of Years of Experience")
                {
                }
                fieldelement(SpecificExperience;"HR Employee Requisitions"."Specific Experience Required")
                {
                }
                fieldelement(SpecificSkills;"HR Employee Requisitions"."Specific Skills Required")
                {
                }
                fieldelement(AgeBracket;"HR Employee Requisitions"."Age bracket")
                {
                }
                fieldelement(JobTitle;"HR Employee Requisitions"."Casual Job Title")
                {
                }
                fieldelement(CasualBudgetVote;"HR Employee Requisitions"."Budget Vote")
                {
                }
                fieldelement(Status;"HR Employee Requisitions".Status)
                {
                }
                fieldelement(Escalated;"HR Employee Requisitions".Escalated)
                {
                }
                fieldelement(EscalatedReason;"HR Employee Requisitions"."Escalation Reason")
                {
                }
                fieldelement(FileName;"HR Employee Requisitions".FileName)
                {
                }
                fieldelement(NumberRequiredSkilled;"HR Employee Requisitions"."Number Required - Skilled")
                {
                }
                fieldelement(NumberRequiredUnSkilled;"HR Employee Requisitions"."Number Required - Unskilled")
                {
                }
                fieldelement(DaysOfEngagementSkilled;"HR Employee Requisitions"."Days for Engagement - Skilled")
                {
                }
                fieldelement(DaysOfEngagementUnSkilled;"HR Employee Requisitions"."Days for Engagement - Unkilled")
                {
                }
                fieldelement(ReasonOfEngagement;"HR Employee Requisitions"."Reason for engagement")
                {
                }
                fieldelement(DailyRateSkilled;"HR Employee Requisitions"."Daily Rate Skilled")
                {
                }
                fieldelement(DailyRateUnskilled;"HR Employee Requisitions"."Daily Rate Unskilled")
                {
                }
                fieldelement(ProjectNo;"HR Employee Requisitions"."Project No")
                {
                }
                fieldelement(ProjectName;"HR Employee Requisitions"."Project Name")
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

