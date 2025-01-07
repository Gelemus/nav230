xmlport 50125 "TenderLitigation Xml"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(TenderLitigationRoot)
        {
            tableelement("Tender Litigation";"Tender Litigation")
            {
                XmlName = 'TenderLitigation';
                fieldelement(LineNo;"Tender Litigation"."Line No")
                {
                }
                fieldelement(Year;"Tender Litigation".Year)
                {
                }
                fieldelement(DateCreated;"Tender Litigation"."Date Created")
                {
                }
                fieldelement(DateUpdated;"Tender Litigation"."Date Update")
                {
                }
                fieldelement(DocumentNo;"Tender Litigation"."Document No")
                {
                }
                fieldelement(NameOfClient;"Tender Litigation"."Name of Client")
                {
                }
                fieldelement(SupplyProfileId;"Tender Litigation"."Supplier Profile ID")
                {
                }
                fieldelement(Description;"Tender Litigation".Description)
                {
                }
                fieldelement(DisputedAmount;"Tender Litigation"."Disputed Amount")
                {
                }
                fieldelement(AwardForOrAganist;"Tender Litigation"."Award for/or Aganist")
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

