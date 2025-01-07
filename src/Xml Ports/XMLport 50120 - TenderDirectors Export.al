xmlport 50120 "TenderDirectors Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(TenderDirectorsProfileRoot)
        {
            tableelement("Tender Directors";"Tender Directors")
            {
                XmlName = 'TenderDirectorsProfile';
                fieldelement(LineNo;"Tender Directors"."Line No")
                {
                }
                fieldelement(ApplicationNo;"Tender Directors"."Application No")
                {
                }
                fieldelement(DirectorName;"Tender Directors"."Director Name")
                {
                }
                fieldelement(DirectorNationality;"Tender Directors"."Director Nationality")
                {
                }
                fieldelement(DirectorShares;"Tender Directors"."Director Shares")
                {
                }
                fieldelement(Status;"Tender Directors".Status)
                {
                }
                fieldelement(DateCreated;"Tender Directors"."Date Created")
                {
                }
                fieldelement(DateUpdate;"Tender Directors"."Date Updated")
                {
                }
                fieldelement(CreatedBy;"Tender Directors"."Created By")
                {
                }
                fieldelement(UpdateBy;"Tender Directors"."Updated By")
                {
                }
                fieldelement(SupplierProfile;"Tender Directors"."Supplier Profile ID")
                {
                }
                fieldelement(Description;"Tender Directors".Description)
                {
                }
                fieldelement(AttachUrl;"Tender Directors"."Attach URL")
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

