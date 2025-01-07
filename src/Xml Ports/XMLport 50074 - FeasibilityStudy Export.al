xmlport 50074 "FeasibilityStudy Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(FeasibilityStudyRoot)
        {
            tableelement("Transport Request";"Transport Request")
            {
                XmlName = 'FeasibilityStudy';
                fieldelement(RequestNo;"Transport Request"."Request No.")
                {
                }
                fieldelement(ProjectNo;"Transport Request"."Project No")
                {
                }
                fieldelement(Desciption;"Transport Request".Description)
                {
                }
                fieldelement(RequestDate;"Transport Request"."Request Date")
                {
                }
                fieldelement(SupervisorNo;"Transport Request"."Supervisor No.")
                {
                }
                fieldelement(SupervisorName;"Transport Request"."Supervisor Name")
                {
                }
                fieldelement(DocumentType;"Transport Request"."Document Type")
                {
                }
                fieldelement(ProposedOffTakePressure;"Transport Request"."Proposed Offtake Pressure")
                {
                }
                fieldelement(StartDate;"Transport Request"."Start Date")
                {
                }
                fieldelement(EndDate;"Transport Request"."Return Date")
                {
                }
                fieldelement(LengthOfProposedLine;"Transport Request"."Length of Proposed Line")
                {
                }
                fieldelement(ElevationAtRequiredPoint;"Transport Request"."Elevation At Required Points")
                {
                }
                fieldelement(ActionPlanNo;"Transport Request"."Action Plan No")
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

