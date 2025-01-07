page 50273 "HR Base Cal. Entries Subform"
{
    Caption = 'Lines';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = Date;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Period Type"; Rec."Period Type")
                {
                    Visible = false;
                }
                field(CurrentCalendarCode; CurrentCalendarCode)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Base Calendar Code';
                    Editable = false;
                    ToolTip = 'Specifies which base calendar was used as the basis.';
                }
                field("Period Start"; Rec."Period Start")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Date';
                    Editable = false;
                    ToolTip = 'Specifies the date.';
                }
                field("Period Name"; Rec."Period Name")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Day';
                    Editable = false;
                    ToolTip = 'Specifies the day of the week.';
                }
                field(WeekNo; WeekNo)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Week No.';
                    Editable = false;
                    ToolTip = 'Specifies the week number for the calendar entries.';
                }
                field(Nonworking; Nonworking)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Nonworking';
                    Editable = true;
                    ToolTip = 'Specifies the date entry as a nonworking day. You can also remove the check mark to return the status to working day.';

                    trigger OnValidate()
                    begin
                        UpdateBaseCalendarChanges;
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Description';
                    ToolTip = 'Specifies the description of the entry to be applied.';

                    trigger OnValidate()
                    begin
                        UpdateBaseCalendarChanges;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Nonworking := CalendarMgmt.CheckDateStatus(CurrentCalendarCode, Rec."Period Start", Description);
        WeekNo := Date2DWY(Rec."Period Start", 2);
        CurrentCalendarCodeOnFormat;
        PeriodStartOnFormat;
        PeriodNameOnFormat;
        DescriptionOnFormat;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        // exit(PeriodFormMgt.FindDate(Which,Rec,PeriodType));
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        //  exit(PeriodFormMgt.NextDate(Steps,Rec,PeriodType));
    end;

    trigger OnOpenPage()
    begin
        Rec.Reset;
        Rec.SetFilter("Period Start", '>=%1', 00000101D);
    end;

    var
        BaseCalendarChange: Record "HR Base Calendar Change";
        // PeriodFormMgt: Codeunit PeriodFormManagement;
        CalendarMgmt: Codeunit "HR Calendar Management";
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        Nonworking: Boolean;
        WeekNo: Integer;
        Description: Text[30];
        CurrentCalendarCode: Code[10];

    [Scope('Personalization')]
    procedure SetCalendarCode(CalendarCode: Code[10])
    begin
        CurrentCalendarCode := CalendarCode;
        CurrPage.Update;
    end;

    local procedure UpdateBaseCalendarChanges()
    begin
        BaseCalendarChange.Reset;
        BaseCalendarChange.SetRange("Base Calendar Code", CurrentCalendarCode);
        BaseCalendarChange.SetRange(Date, Rec."Period Start");
        if BaseCalendarChange.FindFirst then
            BaseCalendarChange.Delete;
        BaseCalendarChange.Init;
        BaseCalendarChange."Base Calendar Code" := CurrentCalendarCode;
        BaseCalendarChange.Date := Rec."Period Start";
        BaseCalendarChange.Description := Description;
        BaseCalendarChange.Nonworking := Nonworking;
        BaseCalendarChange.Day := Rec."Period No.";
        BaseCalendarChange.Insert;
    end;

    local procedure CurrentCalendarCodeOnFormat()
    begin
        if Nonworking then;
    end;

    local procedure PeriodStartOnFormat()
    begin
        if Nonworking then;
    end;

    local procedure PeriodNameOnFormat()
    begin
        if Nonworking then;
    end;

    local procedure DescriptionOnFormat()
    begin
        if Nonworking then;
    end;
}

