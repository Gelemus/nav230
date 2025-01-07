xmlport 50019 "Purchase Req Codes Export"
{
    DefaultNamespace = 'urn:microsoft-dynamics-schemas/codeunit/FundManagementWS';
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(GLroot)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement("Purchase Requisition Codes";"Purchase Requisition Codes")
            {
                MinOccurs = Zero;
                XmlName = 'PurchaseReqcodes';
                fieldelement(Code;"Purchase Requisition Codes"."Requisition Code")
                {
                }
                fieldelement(Name;"Purchase Requisition Codes".Name)
                {
                }
                fieldelement(Description;"Purchase Requisition Codes".Description)
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

