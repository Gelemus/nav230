xmlport 50099 MeetingMinutesExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(MeetingMinutesRoot)
        {
            tableelement("Meeting Minutes";"Meeting Minutes")
            {
                XmlName = 'MeetingMinutes';
                fieldelement(EntryNo;"Meeting Minutes"."Entry No")
                {
                }
                fieldelement(MeetingNo;"Meeting Minutes"."Meeting No")
                {
                }
                fieldelement(AgendaNo;"Meeting Minutes"."Agenda No")
                {
                }
                fieldelement(Minutes;"Meeting Minutes".Minutes)
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

