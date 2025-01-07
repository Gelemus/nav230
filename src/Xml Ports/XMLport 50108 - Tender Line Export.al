xmlport 50108 "Tender Line Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(TenderLineRoot)
        {
            tableelement("Tender Lines";"Tender Lines")
            {
                XmlName = 'TenderLine';
                fieldelement(LineNo;"Tender Lines"."Line No.")
                {
                }
                fieldelement(DocumentNo;"Tender Lines"."Document No.")
                {
                }
                fieldelement(SupplierName;"Tender Lines"."Supplier Name")
                {
                }
                fieldelement(Remarks;"Tender Lines".Remarks)
                {
                }
                fieldelement(ReasonForDisqualification;"Tender Lines"."Reason for Disqualification")
                {
                }
                fieldelement(Disqualified;"Tender Lines".Disqualified)
                {
                }
                fieldelement(DisqualifiedPoint;"Tender Lines"."Disqualification point")
                {
                }
                fieldelement(BidAmount;"Tender Lines"."Bid Amount")
                {
                }
                fieldelement(SupplierNo;"Tender Lines"."Supplier No.")
                {
                }
                fieldelement(ApplicationNo;"Tender Lines"."Application No")
                {
                }
                fieldelement(Telephone;"Tender Lines".Telephone)
                {
                }
                fieldelement(Location;"Tender Lines".Location)
                {
                }
                fieldelement(LegalStatus;"Tender Lines"."Legal status")
                {
                }
                fieldelement(IncorporationYear;"Tender Lines"."Incorporation Year")
                {
                }
                fieldelement(BusinessNature;"Tender Lines"."Business Nature")
                {
                }
                fieldelement(MaxBusinessValue;"Tender Lines"."Max Business Value")
                {
                }
                fieldelement(BankersName;"Tender Lines"."Bankers Name")
                {
                }
                fieldelement(Description;"Tender Lines".Description)
                {
                }
                fieldelement(BusinessRegistrationName;"Tender Lines"."Business Registration Name")
                {
                }
                fieldelement(PaymentMode;"Tender Lines"."Payment Mode")
                {
                }
                fieldelement(Website;"Tender Lines".Website)
                {
                }
                fieldelement(KRAPIN;"Tender Lines"."KRA PIN")
                {
                }
                fieldelement(SupplierProfileID;"Tender Lines"."Supplier Profile ID")
                {
                }
                fieldelement(DocumentType;"Tender Lines"."Document Type")
                {
                }
                fieldelement(Status;"Tender Lines".Status)
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

