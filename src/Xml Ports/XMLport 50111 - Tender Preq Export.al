xmlport 50111 "Tender Preq Export"
{

    schema
    {
        textelement("<tenderpreqcommitteeroot>")
        {
            XmlName = 'TenderPreqCommitteeRoot';
            tableelement("Tender Preq Committee";"Tender Preq Committee")
            {
                XmlName = 'TenderPreqCommitteeHeader';
                fieldelement(No;"Tender Preq Committee".No)
                {
                }
                fieldelement(CreatedDate;"Tender Preq Committee"."Created Date")
                {
                }
                fieldelement(CreatedBy;"Tender Preq Committee"."Created By")
                {
                }
                fieldelement(UpdatedDate;"Tender Preq Committee"."Updated Date")
                {
                }
                fieldelement(UpdatedBy;"Tender Preq Committee"."Updated By")
                {
                }
                fieldelement(Code;"Tender Preq Committee".Code)
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

