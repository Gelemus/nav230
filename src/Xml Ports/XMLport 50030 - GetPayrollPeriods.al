xmlport 50030 GetPayrollPeriods
{
    DefaultNamespace = 'urn:microsoft-dynamics-schemas/codeunit/FundManagementWS';
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(PeriodsRoot)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement(Periods;Periods)
            {
                MinOccurs = Zero;
                XmlName = 'Periods';
                fieldelement(PeriodID;Periods."Period ID")
                {
                }
                fieldelement(Month;Periods."Period Month")
                {
                }
                fieldelement(Year;Periods."Period Year")
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

