xmlport 50022 "Fixed Asset Export"
{
    DefaultNamespace = 'urn:microsoft-dynamics-schemas/codeunit/FundManagementWS';
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(FixedAssetRoot)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement("Fixed Asset";"Fixed Asset")
            {
                MinOccurs = Zero;
                XmlName = 'FixedAsset';
                fieldelement(No;"Fixed Asset"."No.")
                {
                }
                fieldelement(Description;"Fixed Asset".Description)
                {
                }
                fieldelement(TransportType;"Fixed Asset"."Transport Type")
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

