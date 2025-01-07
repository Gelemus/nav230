xmlport 50123 "TenderExperience Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(TenderExperienceRoot)
        {
            tableelement("Tender Experience";"Tender Experience")
            {
                XmlName = 'TenderExperience';
                fieldelement(LineNo;"Tender Experience"."Line No")
                {
                }
                fieldelement(AttachUrl;"Tender Experience"."Attach URL")
                {
                }
                fieldelement(DateCreated;"Tender Experience"."Date Created")
                {
                }
                fieldelement(DateUpdated;"Tender Experience"."Date Update")
                {
                }
                fieldelement(CreatedBy;"Tender Experience"."Created By")
                {
                }
                fieldelement(UpdatedBy;"Tender Experience"."Updated By")
                {
                }
                fieldelement(DocumentNo;"Tender Experience"."Document No")
                {
                }
                fieldelement(Type;"Tender Experience".Type)
                {
                }
                fieldelement(SupplyProfileId;"Tender Experience"."Supplier Profile ID")
                {
                }
                fieldelement(Description;"Tender Experience".Description)
                {
                }
                fieldelement(Status;"Tender Experience".Status)
                {
                }
                fieldelement(StartDate;"Tender Experience"."Start Date")
                {
                }
                fieldelement(EndDate;"Tender Experience"."End Date")
                {
                }
                fieldelement(Institution;"Tender Experience".Institution)
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

