xmlport 50122 "TenderPersonnel Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(TenderPersonnelRoot)
        {
            tableelement("Tender Personnel";"Tender Personnel")
            {
                XmlName = 'TenderPersonnel';
                fieldelement(LineNo;"Tender Personnel"."Line No")
                {
                }
                fieldelement(Name;"Tender Personnel".Name)
                {
                }
                fieldelement(DateCreated;"Tender Personnel"."Date Created")
                {
                }
                fieldelement(DateUpdated;"Tender Personnel"."Date Update")
                {
                }
                fieldelement(DocumentNo;"Tender Personnel"."Document No")
                {
                }
                fieldelement(Age;"Tender Personnel".Age)
                {
                }
                fieldelement(SupplyProfileId;"Tender Personnel"."Supplier Profile ID")
                {
                }
                fieldelement(DateOfBirth;"Tender Personnel"."Date of Birth")
                {
                }
                fieldelement(Gender;"Tender Personnel".Gender)
                {
                }
                fieldelement(AcademicQualification;"Tender Personnel"."Academic Qualification")
                {
                }
                fieldelement(ProfessionalQualification;"Tender Personnel"."Professional Qualification")
                {
                }
                fieldelement(Status;"Tender Personnel".Status)
                {
                }
                fieldelement(Description;"Tender Personnel".Description)
                {
                }
                fieldelement(AttachUrl;"Tender Personnel"."Attach URL")
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

