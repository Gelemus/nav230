xmlport 50087 MeetingAttendanceExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(MeetingAttendanceRoot)
        {
            tableelement("Meeting Attendance";"Meeting Attendance")
            {
                XmlName = 'MeetingAttendance';
                fieldelement(MeetingNo;"Meeting Attendance"."Meeting No")
                {
                }
                fieldelement(MemberNo;"Meeting Attendance"."Member No")
                {
                }
                fieldelement(CommitteeCode;"Meeting Attendance"."Committee Code")
                {
                }
                fieldelement(CommitteeName;"Meeting Attendance"."Committee Name")
                {
                }
                fieldelement(MeetingDate;"Meeting Attendance"."Meeting Date")
                {
                }
                fieldelement(MeetingName;"Meeting Attendance"."Meeting Name")
                {
                }
                fieldelement(Venue;"Meeting Attendance".Venue)
                {
                }
                fieldelement(MemberName;"Meeting Attendance"."Member Name")
                {
                }
                fieldelement(Visitor;"Meeting Attendance"."In attendance")
                {
                }
                fieldelement(VisitorInstitution;"Meeting Attendance"."Visitor Institution")
                {
                }
                fieldelement(Remarks;"Meeting Attendance".Remarks)
                {
                }
                fieldelement(MeetingRole;"Meeting Attendance"."Meeting Role")
                {
                }
                fieldelement(TypeofParticipant;"Meeting Attendance"."Type of Participant")
                {
                }
                fieldelement(RSVP;"Meeting Attendance"."Confirmation of an invitation")
                {
                }
                fieldelement(AttendanceStatus;"Meeting Attendance"."Attendance during the meeting")
                {
                }
                fieldelement(AbsentismReason;"Meeting Attendance"."Absentism Reason")
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

