xmlport 50085 VoteItemsExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(VoteItemRoot)
        {
            tableelement("Agenda vote items";"Agenda vote items")
            {
                XmlName = 'VoteItem';
                fieldelement(BoardMeetingNo;"Agenda vote items"."Meeting No")
                {
                }
                fieldelement(ItemNo;"Agenda vote items"."Item No")
                {
                }
                fieldelement(AgendaNo;"Agenda vote items"."Agenda No")
                {
                }
                fieldelement(Description;"Agenda vote items".Description)
                {
                }
                fieldelement(StartDate;"Agenda vote items"."Vote start Date")
                {
                }
                fieldelement(EndDate;"Agenda vote items"."Vote Enda date")
                {
                }
                fieldelement(StartTime;"Agenda vote items"."Vote start Time")
                {
                }
                fieldelement(EndTime;"Agenda vote items"."Vote Enda Time")
                {
                }
                fieldelement(YesCount;"Agenda vote items"."Yes Count")
                {
                }
                fieldelement(NoCount;"Agenda vote items"."No Count")
                {
                }
                fieldelement(AbstainCount;"Agenda vote items"."Abstain Count")
                {
                }
                fieldelement(TotalVotes;"Agenda vote items"."Total Votes")
                {
                }
                fieldelement(Status;"Agenda vote items".Status)
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

