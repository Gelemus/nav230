xmlport 50081 BoardMeetingExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(BoardMeetingRoot)
        {
            tableelement("Board Meeting";"Board Meeting")
            {
                XmlName = 'BoardMeeting';
                SourceTableView = WHERE(Published=FILTER(true));
                fieldelement(BoardMeetingNo;"Board Meeting".No)
                {
                }
                fieldelement(Title;"Board Meeting".Title)
                {
                }
                fieldelement(StartDate;"Board Meeting"."Start Date")
                {
                }
                fieldelement(EndDate;"Board Meeting"."End Date")
                {
                }
                fieldelement(StartTime;"Board Meeting"."Start Time")
                {
                }
                fieldelement(EndTime;"Board Meeting"."End Time")
                {
                }
                fieldelement(Venue;"Board Meeting"."Venue/Location")
                {
                }
                fieldelement(Description;"Board Meeting".Description)
                {
                }
                fieldelement(MeetingGroup;"Board Meeting"."Meeting Group")
                {
                }
                fieldelement(Reference;"Board Meeting".Reference)
                {
                }
                fieldelement(MeetingGroupdCode;"Board Meeting"."Meeting Group Code")
                {
                }
                fieldelement(MeetingLink;"Board Meeting"."Meeting Link")
                {
                }
                fieldelement(MeetingUserID;"Board Meeting"."Meeting UserID")
                {
                }
                fieldelement(MeetingPasscode;"Board Meeting"."Meeting Pass Code")
                {
                }
                fieldelement(NatureoftheMeeting;"Board Meeting"."Nature of the Meeting")
                {
                }
                fieldelement(ConvenedByNo;"Board Meeting"."Convened By")
                {
                }
                fieldelement(ConvenedByName;"Board Meeting"."Convened By Email")
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

