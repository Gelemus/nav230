codeunit 50048 "Case Management"
{

    trigger OnRun()
    begin
    end;

    var
        Txt010: Label 'Calender Created in Outlook';
        UserSetup: Record "User Setup";

    procedure CreateOutlookAppointment(CaseManagementLines: Record "File Types"; AllDayEvent: Boolean; Send: Boolean; Display: Boolean; DurationInMins: Integer)
    var
    // [RunOnClient]
    // OutlookItemType: DotNet OlItemType;
    // [RunOnClient]
    // [SuppressDispose]
    // OutlookApplicationClass: DotNet ApplicationClass;
    // [RunOnClient]
    // OutlookAppItem: DotNet AppointmentItem;
    // [RunOnClient]
    // OutlookApplication: DotNet Application;
    // [RunOnClient]
    // OutlookAppItemClass: DotNet AppointmentItemClass;
    begin
        /*CaseManagementLines.TESTFIELD("Next Hearing Date");
        CaseManagementLines.TESTFIELD("Next Hearing Time");
        
        UserSetup.RESET;
        UserSetup.SETRANGE("Receive Legal Notifications",TRUE);
        IF UserSetup.FINDSET THEN BEGIN
          REPEAT
            CaseManagementHeader.RESET;
            CaseManagementHeader.SETRANGE("Case No",CaseManagementLines."Case No");
            IF CaseManagementHeader.FINDFIRST THEN BEGIN
              OutlookItemType:=OutlookItemType.olAppointmentItem;
              OutlookApplication:=OutlookApplicationClass.ApplicationClass();
              OutlookAppItem:=OutlookAppItemClass;
        
              OutlookAppItem:=OutlookApplication.CreateItem(OutlookItemType);
              OutlookAppItem.Subject:=CaseManagementHeader."Case No";
              OutlookAppItem.Body:='Subject Matter:'+CaseManagementHeader."Case Title"+'.'+'Parties:'+CaseManagementHeader."Party (1)";
              OutlookAppItem.StartUTC:=CREATEDATETIME(CaseManagementLines."Next Hearing Date",CaseManagementLines."Next Hearing Time");
              OutlookAppItem.RequiredAttendees:=UserSetup."E-Mail";
              OutlookAppItem.OptionalAttendees:='';
              OutlookAppItem.Location:=CaseManagementHeader.Location;
              OutlookAppItem.AllDayEvent:=AllDayEvent;
        
              IF NOT AllDayEvent THEN
               OutlookAppItem.Duration:=DurationInMins;
        
              OutlookAppItem.ReminderPlaySound:=TRUE;
              OutlookAppItem.ReminderSet:=TRUE;
              OutlookAppItem.ReminderMinutesBeforeStart:=5;
              OutlookAppItem.Save;
        
              CaseManagementLines."Calender Created":=TRUE;
              CaseManagementLines.MODIFY;
        
              IF Send THEN BEGIN
               OutlookAppItem.Send;
              END;
        
              IF Display THEN
               OutlookAppItem.Display(OutlookAppItem);
        
            END;
          UNTIL UserSetup.NEXT =0;
          MESSAGE(Txt010);
        END;
        */

    end;
}

