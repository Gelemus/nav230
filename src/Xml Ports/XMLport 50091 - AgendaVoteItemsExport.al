xmlport 50091 AgendaVoteItemsExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(AgendaVoteItemsRoot)
        {
            tableelement("Agenda Item Voters";"Agenda Item Voters")
            {
                XmlName = 'AgendaVoteItems';
                fieldelement(VoterId;"Agenda Item Voters"."Voter ID")
                {
                }
                fieldelement(AgendaVoterItemCode;"Agenda Item Voters"."Agenda Vote Item code")
                {
                }
                fieldelement(Name;"Agenda Item Voters".Name)
                {
                }
                fieldelement(Voted;"Agenda Item Voters".Voted)
                {
                }
                fieldelement(VoteDecision;"Agenda Item Voters"."Vote decision")
                {
                }
                fieldelement(MeetingNo;"Agenda Item Voters"."Meeting No")
                {
                }
                fieldelement(AgendaNo;"Agenda Item Voters"."Agenda No")
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

