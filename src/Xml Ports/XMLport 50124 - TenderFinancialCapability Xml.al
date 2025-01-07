xmlport 50124 "TenderFinancialCapability Xml"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(TenderFinancialCapabilityRoot)
        {
            tableelement("Tender Financial Capability";"Tender Financial Capability")
            {
                XmlName = 'TenderFinancialCapability';
                fieldelement(LineNo;"Tender Financial Capability"."Line No")
                {
                }
                fieldelement(TotalAssets;"Tender Financial Capability"."Total Assets")
                {
                }
                fieldelement(DateCreated;"Tender Financial Capability"."Date Created")
                {
                }
                fieldelement(DateUpdated;"Tender Financial Capability"."Date Update")
                {
                }
                fieldelement(CreatedBy;"Tender Financial Capability"."Created By")
                {
                }
                fieldelement(UpdatedBy;"Tender Financial Capability"."Updated By")
                {
                }
                fieldelement(DocumentNo;"Tender Financial Capability"."Document No")
                {
                }
                fieldelement(CurrentAssets;"Tender Financial Capability"."Current Assets")
                {
                }
                fieldelement(SupplyProfileId;"Tender Financial Capability"."Supplier Profile ID")
                {
                }
                fieldelement(TotalLiabilities;"Tender Financial Capability"."Total Liabities")
                {
                }
                fieldelement(CurrentLiabilities;"Tender Financial Capability"."Current Liabilities")
                {
                }
                fieldelement(AttachUrl;"Tender Financial Capability"."Attach URL")
                {
                }
                fieldelement(Status;"Tender Financial Capability".Status)
                {
                }
                fieldelement(Description;"Tender Financial Capability".Description)
                {
                }
                fieldelement(FinancialYear;"Tender Financial Capability"."Financial Year")
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

