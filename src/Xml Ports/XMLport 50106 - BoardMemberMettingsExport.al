xmlport 50106 BoardMemberMettingsExport
{
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(BoardMemberAttMeetingsRoot)
        {
            tableelement("Meeting Attendance";"Meeting Attendance")
            {
                XmlName = 'BoardMemberAttMeetings';
                fieldelement(MeetingNo;"Meeting Attendance"."Meeting No")
                {
                }
                fieldelement(MemberNo;"Meeting Attendance"."Member No")
                {
                }
                fieldelement(CommitteeName;"Meeting Attendance"."Committee Name")
                {
                }
                fieldelement(MeetingRole;"Meeting Attendance"."Meeting Role")
                {
                }
                fieldelement(AttendanceStatus;"Meeting Attendance"."Attendance during the meeting")
                {
                }
                fieldelement(AbsentismReason;"Meeting Attendance"."Absentism Reason")
                {
                }
                fieldelement(TypeOfParticipant;"Meeting Attendance"."Type of Participant")
                {
                }
                tableelement("Board Meeting";"Board Meeting")
                {
                    LinkFields = No=FIELD("Meeting No");
                    LinkTable = "Meeting Attendance";
                    XmlName = 'BoardMemberMeetings';
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

