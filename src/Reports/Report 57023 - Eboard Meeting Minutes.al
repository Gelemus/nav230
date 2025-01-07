report 57023 "Eboard Meeting Minutes"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Eboard Meeting Minutes.rdl';

    dataset
    {
        dataitem("Board Meeting"; "Board Meeting")
        {
            RequestFilterFields = No;
            column(No_BoardMeeting; "Board Meeting".No)
            {
            }
            column(Title_BoardMeeting; "Board Meeting".Title)
            {
            }
            column(StartDate_BoardMeeting; "Board Meeting"."Start Date")
            {
            }
            column(EndDate_BoardMeeting; "Board Meeting"."End Date")
            {
            }
            column(StartTime_BoardMeeting; "Board Meeting"."Start Time")
            {
            }
            column(EndTime_BoardMeeting; "Board Meeting"."End Time")
            {
            }
            column(VenueLocation_BoardMeeting; "Board Meeting"."Venue/Location")
            {
            }
            column(ConvenedBy_BoardMeeting; "Board Meeting"."Convened By")
            {
            }
            column(ConvenedByEmail_BoardMeeting; "Board Meeting"."Convened By Email")
            {
            }
            column(Description_BoardMeeting; "Board Meeting".Description)
            {
            }
            column(Status_BoardMeeting; "Board Meeting".Status)
            {
            }
            column(MeetingGroupCode_BoardMeeting; "Board Meeting"."Meeting Group Code")
            {
            }
            column(MeetingGroup_BoardMeeting; "Board Meeting"."Meeting Group")
            {
            }
            column(ConferenceVenue_BoardMeeting; "Board Meeting"."Conference Venue")
            {
            }
            column(ParkingArrangement_BoardMeeting; "Board Meeting"."Parking Arrangement")
            {
            }
            column(AccessRequirement_BoardMeeting; "Board Meeting"."Access Requirement")
            {
            }
            column(Published_BoardMeeting; "Board Meeting".Published)
            {
            }
            column(Reference_BoardMeeting; "Board Meeting".Reference)
            {
            }
            column(MeetingPapers_BoardMeeting; "Board Meeting"."Meeting Papers")
            {
            }
            column(MeetingLink_BoardMeeting; "Board Meeting"."Meeting Link")
            {
            }
            column(MeetingUserID_BoardMeeting; "Board Meeting"."Meeting UserID")
            {
            }
            column(MeetingPassCode_BoardMeeting; "Board Meeting"."Meeting Pass Code")
            {
            }
            column(NatureoftheMeeting_BoardMeeting; "Board Meeting"."Nature of the Meeting")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyNameII; CompanyNameII)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(pic; CompanyInfo."Picture 2")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_Web; CompanyInfo."Home Page")
            {
            }
            dataitem("Meeting Attendance"; "Meeting Attendance")
            {
                DataItemLink = "Meeting No" = FIELD(No);
                column(MeetingNo_MeetingAttendance; "Meeting Attendance"."Meeting No")
                {
                }
                column(MemberNo_MeetingAttendance; "Meeting Attendance"."Member No")
                {
                }
                column(CommitteeCode_MeetingAttendance; "Meeting Attendance"."Committee Code")
                {
                }
                column(CommitteeName_MeetingAttendance; "Meeting Attendance"."Committee Name")
                {
                }
                column(MeetingDate_MeetingAttendance; "Meeting Attendance"."Meeting Date")
                {
                }
                column(MeetingName_MeetingAttendance; "Meeting Attendance"."Meeting Name")
                {
                }
                column(Venue_MeetingAttendance; "Meeting Attendance".Venue)
                {
                }
                column(MemberName_MeetingAttendance; "Meeting Attendance"."Member Name")
                {
                }
                column(Inattendance_MeetingAttendance; "Meeting Attendance"."In attendance")
                {
                }
                column(VisitorInstitution_MeetingAttendance; "Meeting Attendance"."Visitor Institution")
                {
                }
                column(Remarks_MeetingAttendance; "Meeting Attendance".Remarks)
                {
                }
                column(EntryNo_MeetingAttendance; "Meeting Attendance"."Entry No")
                {
                }
                column(TypeofParticipant_MeetingAttendance; "Meeting Attendance"."Type of Participant")
                {
                }
                column(MeetingRole_MeetingAttendance; "Meeting Attendance"."Meeting Role")
                {
                }
                column(Attendanceduringthemeeting_MeetingAttendance; "Meeting Attendance"."Attendance during the meeting")
                {
                }
                column(Confirmationofaninvitation_MeetingAttendance; "Meeting Attendance"."Confirmation of an invitation")
                {
                }
            }
            dataitem("Meeting Agenda"; "Meeting Agenda")
            {
                DataItemLink = "Meeting No" = FIELD(No);
                column(MeetingNo_MeetingAgenda; "Meeting Agenda"."Meeting No")
                {
                }
                column(LineNo_MeetingAgenda; "Meeting Agenda"."Line No")
                {
                }
                column(AgendaCode_MeetingAgenda; "Meeting Agenda"."Agenda Code")
                {
                }
                column(AgendaItem_MeetingAgenda; "Meeting Agenda"."Agenda Item")
                {
                }
                column(AgendaPapers_MeetingAgenda; "Meeting Agenda"."Agenda Papers")
                {
                }
                column(ScheduledTime_MeetingAgenda; "Meeting Agenda"."Scheduled Time")
                {
                }
                column(Purpose_MeetingAgenda; "Meeting Agenda".Purpose)
                {
                }
                column(TypeofAgenda_MeetingAgenda; "Meeting Agenda"."Type of Agenda")
                {
                }
                dataitem("Meeting Minutes"; "Meeting Minutes")
                {
                    DataItemLink = "Agenda No" = FIELD("Agenda Code");
                    column(EntryNo_MeetingMinutes; "Meeting Minutes"."Entry No")
                    {
                    }
                    column(MeetingNo_MeetingMinutes; "Meeting Minutes"."Meeting No")
                    {
                    }
                    column(AgendaNo_MeetingMinutes; "Meeting Minutes"."Agenda No")
                    {
                    }
                    column(Minutes_MeetingMinutes; "Meeting Minutes".Minutes)
                    {
                    }
                }
            }

            trigger OnPreDataItem()
            begin
                if gvMeetingNoFilter <> '' then SetRange(No, gvMeetingNoFilter);
            end;
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

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        CompanyNameII := 'Nyeri Water and Sanitation Company';
    end;

    var
        CompanyInfo: Record "Company Information";
        gvMeetingNoFilter: Code[100];
        CompanyNameII: Text;

    procedure sSetParameters(pMeetingNoFilter: Code[10])
    begin
        //skm080307 this function sets global parameters for filtering the payslip when e-mailing
        gvMeetingNoFilter := pMeetingNoFilter;
    end;
}

