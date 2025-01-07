xmlport 50080 "Dimension Values"
{
    DefaultNamespace = 'urn:microsoft-dynamics-schemas/codeunit/FundManagementWS';
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(DimensionValuesRoot)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement("Dimension Value";"Dimension Value")
            {
                MinOccurs = Zero;
                XmlName = 'DimensionValues';
                fieldelement(Code;"Dimension Value".Code)
                {
                }
                fieldelement(Name;"Dimension Value".Name)
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

