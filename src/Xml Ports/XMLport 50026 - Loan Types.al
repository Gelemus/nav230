xmlport 50026 "Loan Types"
{
    DefaultNamespace = 'urn:microsoft-dynamics-schemas/codeunit/FundManagementWS';
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(LoanTypesRoot)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement("Loan Types";"Loan Types")
            {
                MinOccurs = Zero;
                XmlName = 'LoanTypes';
                SourceTableView = WHERE(Type=CONST(Advance),"Payroll Code"=CONST('PERMANENT'));
                fieldelement(Code;"Loan Types".Code)
                {
                }
                fieldelement(Description;"Loan Types".Description)
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

