xmlport 50109 "Supplier Profile Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(SupplierProfileRoot)
        {
            tableelement("Supplier Profile";"Supplier Profile")
            {
                XmlName = 'SupplierProfileHeader';
                fieldelement(No;"Supplier Profile".No)
                {
                }
                fieldelement(Name;"Supplier Profile"."Supplier Name")
                {
                }
                fieldelement(Telephone;"Supplier Profile"."Supplier Telephone")
                {
                }
                fieldelement(CompanyName;"Supplier Profile"."Supplier Company Name")
                {
                }
                fieldelement(PhysicalAddress;"Supplier Profile"."Supplier Physical Address")
                {
                }
                fieldelement(PostalAddress;"Supplier Profile"."Supplier Postal Address")
                {
                }
                fieldelement(Email;"Supplier Profile"."Supplier Email")
                {
                }
                fieldelement(Website;"Supplier Profile"."Supplier Website")
                {
                }
                fieldelement(LegalStatus;"Supplier Profile"."Supplier Legal Status")
                {
                }
                fieldelement(MaxBusinessValue;"Supplier Profile"."Supplier Max Bussiness Value")
                {
                }
                fieldelement(BusinessNature;"Supplier Profile"."Supplier Max Bussiness Value")
                {
                }
                fieldelement(KraPinCertNo;"Supplier Profile"."Supplier Kra Pin Cert No")
                {
                }
                fieldelement(VatCertNo;"Supplier Profile"."Supplier Vat Cert No")
                {
                }
                fieldelement(CompanyRegNo;"Supplier Profile"."Supplier Company Reg Cert No")
                {
                }
                fieldelement(BankersName;"Supplier Profile"."Supplier Bankers Name")
                {
                }
                fieldelement(TradeTerms;"Supplier Profile"."Supplier Trade Terms")
                {
                }
                fieldelement(Country;"Supplier Profile"."Supplier Country")
                {
                }
                fieldelement(County;"Supplier Profile"."Supplier County")
                {
                }
                fieldelement(DateCreated;"Supplier Profile"."Supplier Date Created")
                {
                }
                fieldelement(DateUpdated;"Supplier Profile"."Supplier Date Updated")
                {
                }
                fieldelement(SupplierId;"Supplier Profile"."Supplier Id")
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

