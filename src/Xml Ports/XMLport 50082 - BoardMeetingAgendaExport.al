xmlport 50082 BoardMeetingAgendaExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(BoardMeetingAgendaRoot)
        {
            tableelement("Meeting Agenda";"Meeting Agenda")
            {
                XmlName = 'BoardMeetingAgenda';
                fieldelement(BoardMeetingNo;"Meeting Agenda"."Meeting No")
                {
                }
                fieldelement(AgendaCode;"Meeting Agenda"."Agenda Code")
                {
                }
                fieldelement(AgendaItem;"Meeting Agenda"."Agenda Item")
                {
                }
                fieldelement(ScheduledTime;"Meeting Agenda"."Scheduled Time")
                {
                }
                fieldelement(AgendaPapers;"Meeting Agenda"."Agenda Papers")
                {
                }
                fieldelement(Purpose;"Meeting Agenda".Purpose)
                {
                }
                fieldelement(TypeofAgenda;"Meeting Agenda"."Type of Agenda")
                {
                }
                tableelement("Meeting Minutes";"Meeting Minutes")
                {
                    LinkFields = "Agenda No"=FIELD("Agenda Code");
                    LinkTable = "Meeting Agenda";
                    XmlName = 'MeetingMinutesList';
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

