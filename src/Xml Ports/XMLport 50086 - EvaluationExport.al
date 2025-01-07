xmlport 50086 EvaluationExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(EvaluationRoot)
        {
            tableelement("Board Meeting";"Board Meeting")
            {
                XmlName = 'Evaluation';
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

