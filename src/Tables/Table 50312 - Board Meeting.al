table 50312 "Board Meeting"
{

    fields
    {
        field(1;No;Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Title;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Start Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"End Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Start Time";Time)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"End Time";Time)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Venue/Location";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Convened By";Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(9;"Convened By Email";Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(10;Description;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11;Status;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Pending,Upcoming,In progress,Completed,Cancelled';
            OptionMembers = Pending,Upcoming,"In progress",Completed,Cancelled;
        }
        field(12;"Meeting Group Code";Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Board Commitee";

            trigger OnValidate()
            begin
                if "Board Commitee".Get("Meeting Group Code") then begin
                  "Meeting Group" := "Board Commitee".Description;

                  //participants
                  if CommitmeeMembers.FindLast then
                    Entryno:=Entryno+1
                  else
                  Entryno:=1;
                  CommitmeeMembers.Reset;
                  CommitmeeMembers.SetRange("Committee Code","Meeting Group Code");
                  if CommitmeeMembers.FindSet then
                  begin
                    repeat
                      Entryno+=1;
                      MeetingAttendance.Init;
                      MeetingAttendance."Committee Code" := "Meeting Group Code";

                      MeetingAttendance."Committee Name" := "Meeting Group";
                      MeetingAttendance."Meeting No" := No;
                      MeetingAttendance."Entry No" := Entryno;
                      MeetingAttendance."Meeting Date" := "Start Date";
                      MeetingAttendance."Meeting Name" := Title;
                      MeetingAttendance.Venue := "Venue/Location";
                      MeetingAttendance."Member Name" := CommitmeeMembers."Member Name";
                      MeetingAttendance."Member No" := CommitmeeMembers."Member No";
                      MeetingAttendance.Insert
                    until CommitmeeMembers.Next=0;
                  end;

                end;
            end;
        }
        field(13;"Meeting Group";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Conference Venue";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Parking Arrangement";Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(16;"Access Requirement";Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(17;Published;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18;Reference;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(19;"Meeting Papers";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(20;"Meeting Link";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(21;"Meeting UserID";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22;"Meeting Pass Code";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(23;"Nature of the Meeting";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Virtual,Physical,Both Virtual and Physical';
            OptionMembers = " ",Virtual,Physical,"Both Virtual and Physical";
        }
    }

    keys
    {
        key(Key1;No)
        {
        }
    }

    fieldgroups
    {
    }

    var
        "Board Commitee": Record "Board Commitee";
        CommitmeeMembers: Record "Board Committee Members";
        MeetingAttendance: Record "Meeting Attendance";
        Entryno: Integer;
}

