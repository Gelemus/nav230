xmlport 50021 "Imprest Codes"
{
    DefaultNamespace = 'urn:microsoft-dynamics-schemas/codeunit/FundManagementWS';
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(Imprestcodesroot)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement("Funds Transaction Code";"Funds Transaction Code")
            {
                MinOccurs = Zero;
                XmlName = 'Imprestcodes';
                fieldelement(Code;"Funds Transaction Code"."Transaction Code")
                {
                }
                fieldelement(Description;"Funds Transaction Code".Description)
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

