codeunit 52002 "HR Dates"
{

    trigger OnRun()
    begin
    end;

    var
        dayOfWeek: Integer;
        weekNumber: Integer;
        year: Integer;
        weekends: Integer;
        NextDay: Date;

    procedure DetermineAge(DateOfBirth: Date;DateOfJoin: Date) AgeString: Text[45]
    var
        dayB: Integer;
        monthB: Integer;
        yearB: Integer;
        dayJ: Integer;
        monthJ: Integer;
        yearJ: Integer;
        Year: Integer;
        Month: Integer;
        Day: Integer;
        monthsToBirth: Integer;
        D: Date;
        DateCat: Integer;
    begin
                  if ((DateOfBirth <> 0D) and (DateOfJoin <> 0D)) then begin
                    dayB:= Date2DMY(DateOfBirth,1);
                    monthB:= Date2DMY(DateOfBirth,2);
                    yearB:= Date2DMY(DateOfBirth,3);
                    dayJ:= Date2DMY(DateOfJoin,1);
                    monthJ:= Date2DMY(DateOfJoin,2);
                    yearJ:= Date2DMY(DateOfJoin,3);
                    Day:= 0; Month:= 0; Year:= 0;
                    DateCat := DateCategory(dayB,dayJ,monthB,monthJ,yearB,yearJ);
                    case (DateCat) of
                        1: begin
                             Year:= yearJ - yearB;
                             if monthJ >= monthB then
                                Month:= monthJ - monthB
                             else begin
                                Month:= (monthJ + 12) - monthB;
                                Year:= Year - 1;
                             end;

                             if (dayJ >= dayB) then
                                Day:= dayJ - dayB
                             else if (dayJ < dayB) then begin
                                Day:= (DetermineDaysInMonth(monthJ,yearJ) + dayJ) - dayB;
                                Month:= Month - 1;
                             end;

                                AgeString:= '%1  Years, %2  Months and #3## Days';
                                AgeString:= StrSubstNo(AgeString,Year,Month,Day);

                            end;

                        2,3,7:begin
                              if (monthJ <> monthB) then begin
                                   if monthJ >= monthB then
                                      Month:= monthJ - monthB
                                   else Error('The wrong date category!');
                               end;

                             if (dayJ <> dayB) then begin
                              if (dayJ >= dayB) then
                                Day:= dayJ - dayB
                              else if (dayJ < dayB) then begin
                                Day:= (DetermineDaysInMonth(monthJ,yearJ) + dayJ) - dayB;
                                Month:= Month - 1;
                              end;
                             end;

                               AgeString:= '%1  Months %2 Days';
                               AgeString:= StrSubstNo(AgeString,Month,Day);
                              end;
                         4: begin
                               Year:= yearJ - yearB;
                               AgeString:='#1## Years';
                               AgeString:= StrSubstNo(AgeString,Year);
                            end;
                         5: begin
                             if (dayJ >= dayB) then
                                Day:= dayJ - dayB
                             else if (dayJ < dayB) then begin
                                Day:= (DetermineDaysInMonth(monthJ,yearJ) + dayJ) - dayB;
                                monthJ:= monthJ - 1;
                                Month:= (monthJ + 12) - monthB;
                                yearJ:= yearJ - 1;
                             end;

                             Year:= yearJ - yearB;
                                AgeString:= '%1  Years, %2 Months and #3## Days';
                                AgeString:= StrSubstNo(AgeString,Year,Month,Day);
                             end;
                         6: begin
                             if monthJ >= monthB then
                                Month:= monthJ - monthB
                             else begin
                                Month:= (monthJ + 12) - monthB;
                                yearJ:= yearJ - 1;
                             end;
                                Year:= yearJ - yearB;
                                AgeString:= '%1  Years and #2## Months';
                                AgeString:= StrSubstNo(AgeString,Year,Month);
                            end;
                        else AgeString:= '';
                        end;
                      end else Message('For Date Calculation Enter All Applicable Dates!');
                       exit;
    end;

    procedure DifferenceStartEnd(StartDate: Date;EndDate: Date) DaysValue: Integer
    var
        dayStart: Integer;
        monthS: Integer;
        yearS: Integer;
        dayEnd: Integer;
        monthE: Integer;
        yearE: Integer;
        Year: Integer;
        Month: Integer;
        Day: Integer;
        monthsBetween: Integer;
        i: Integer;
        j: Integer;
        monthValue: Integer;
        monthEnd: Integer;
        p: Integer;
        q: Integer;
        l: Integer;
        DateCat: Integer;
        daysInYears: Integer;
        m: Integer;
        yearStart: Integer;
        t: Integer;
        s: Integer;
        WeekendDays: Integer;
        AbsencePreferences: Record "Interest Buffer";
        Holidays: Integer;
    begin
                 /*IF ((StartDate <> 0D) AND (EndDate <> 0D)) THEN BEGIN
                    Day:=0; monthValue:= 0; p:=0; q:=0; l:= 0;
                    Year:= 0; daysInYears:=0; DaysValue:= 0;
                    dayStart:= DATE2DMY(StartDate,1);
                    monthS:= DATE2DMY(StartDate,2);
                    yearS:= DATE2DMY(StartDate,3);
                    dayEnd:= DATE2DMY(EndDate,1);
                    monthE:= DATE2DMY(EndDate,2);
                    yearE:= DATE2DMY(EndDate,3);
        
                    WeekendDays:= 0;
                    AbsencePreferences.FIND('-');
                     IF (AbsencePreferences.No = TRUE) THEN
                       WeekendDays:= DetermineWeekends(StartDate,EndDate);
        
                    Holidays:= 0;
                    AbsencePreferences.FIND('-');
                     IF (AbsencePreferences."Account No" = TRUE) THEN
                        Holidays:= DetermineHolidays(StartDate,EndDate);
        
                    DateCat := DateCategory(dayStart,dayEnd,monthS,monthE,yearS,yearE);
                    CASE (DateCat) OF
                        1: BEGIN
                            p:=0; q:=0;
                            Year := yearE - yearS;
                            yearStart := yearS;
                            t := 1; s := 1;
                            IF (monthE <> monthS) THEN BEGIN
        
                             FOR j := 1 TO (monthS - 1) DO BEGIN
                                 q := q + DetermineDaysInMonth(t,yearS);
                                 t := t+1;
                             END;
                                 q:= q + dayStart;
        
                             FOR i := 1 TO (monthE - 1) DO BEGIN
                                 p := p + DetermineDaysInMonth(s,yearE);
                                 s:= s+1;
                             END;
                                 p:= p + dayEnd;
        
                             FOR m := 1 TO Year DO BEGIN
                                IF LeapYear(yearStart) THEN daysInYears := daysInYears + 366
                                ELSE daysInYears:= daysInYears + 365;
                                yearStart := yearStart + 1;
                             END;
                                DaysValue := (((daysInYears - q) + p) - WeekendDays) - Holidays;
                             END;
                           END;
        
                        2,7 : BEGIN
                              FOR l := (monthS + 1) TO (monthE - 1) DO
                                  DaysValue:= DaysValue + DetermineDaysInMonth(l,yearS);
                              DaysValue:= ((DaysValue + (DetermineDaysInMonth(monthS,yearS) - dayStart) + dayEnd)- WeekendDays)- Holidays;
                              END;
        
                        3: BEGIN
                             IF (dayEnd >= dayStart) THEN
                                DaysValue:= dayEnd - dayStart - WeekendDays - Holidays
                                ELSE IF (dayEnd = dayStart) THEN DaysValue:= 0
                                ELSE DaysValue:= ((dayStart - dayEnd) - WeekendDays) - Holidays;
        
                           END;
        
                        4: BEGIN
                            DaysValue:= 0;
                            Year:= yearE - yearS;
                            yearStart := yearS;
                            FOR m:= 1 TO Year DO BEGIN
                             IF (LeapYear(yearStart)) THEN daysInYears:= 366
                                 ELSE daysInYears:= 365;
                                 DaysValue:= DaysValue +  daysInYears;
                                 yearStart:= yearStart + 1;
                            END;
                            DaysValue:= (DaysValue - WeekendDays) - Holidays;
                            END;
        
                         5: BEGIN
                            Year := yearE - yearS;
                            yearStart := yearS;
                             FOR m := 1 TO Year DO BEGIN
                                IF LeapYear(yearStart) THEN daysInYears := daysInYears + 366
                                ELSE daysInYears:= daysInYears + 365;
                                yearStart := yearStart + 1;
                             END;
                                DaysValue:= daysInYears;
                              IF dayEnd > dayStart THEN
                                DaysValue:= (DaysValue + (dayEnd - dayStart) - WeekendDays) - Holidays
                              ELSE IF dayStart > dayEnd THEN
                                DaysValue:= (DaysValue - (dayStart - dayEnd) - WeekendDays) - Holidays;
                            END;
        
                         6: BEGIN
                            q:= 0; p:= 0;
                            Year := yearE - yearS;
                            yearStart := yearS;
                            t := 1; s := 1;
        
                             FOR j := 1 TO monthS DO BEGIN
                                 q := q + DetermineDaysInMonth(t,yearS);
                                 t := t+1;
                             END;
        
                             FOR i := 1 TO monthE DO BEGIN
                                 p := p + DetermineDaysInMonth(s,yearE);
                                 s:= s+1;
                             END;
        
                             FOR m := 1 TO Year DO BEGIN
                                IF LeapYear(yearStart) THEN daysInYears := daysInYears + 366
                                ELSE daysInYears:= daysInYears + 365;
                                yearStart := yearStart + 1;
                             END;
        
                              DaysValue := ((daysInYears - q) + p) - WeekendDays - Holidays;
                             END;
                        ELSE DaysValue:= 0;
        
                    END;
                END ELSE MESSAGE('Enter all applicable dates for calculation!');
                    DaysValue += 1;
                    EXIT;*/

    end;

    procedure DetermineDaysInMonth(Month: Integer;Year: Integer) DaysInMonth: Integer
    begin
                            /*CASE (Month) OF
                                 1              :   DaysInMonth:=31;
                                 2              :   BEGIN
                                                      IF (LeapYear(Year)) THEN DaysInMonth:=29
                                                      ELSE DaysInMonth:= 28;
                                                    END;
                                 3              :   DaysInMonth:=31;
                                 4              :   DaysInMonth:=30;
                                 5              :   DaysInMonth:=31;
                                 6              :   DaysInMonth:=30;
                                 7              :   DaysInMonth:=31;
                                 8              :   DaysInMonth:=31;
                                 9              :   DaysInMonth:= 30;
                                 10             :   DaysInMonth:= 31;
                                 11             :   DaysInMonth:= 30;
                                 12             :   DaysInMonth:= 31;
                                 ELSE MESSAGE('Not valid date. The month must be between 1 and 12');
                            END;
        
                            EXIT;*/

    end;

    procedure DateCategory(BDay: Integer;EDay: Integer;BMonth: Integer;EMonth: Integer;BYear: Integer;EYear: Integer) Category: Integer
    begin
                            /* IF ((EYear > BYear) AND (EMonth <> BMonth) AND (EDay <> BDay)) THEN Category:= 1
                             ELSE IF ((EYear = BYear) AND (EMonth <> BMonth) AND (EDay = BDay)) THEN Category:=2
                             ELSE IF ((EYear = BYear) AND (EMonth = BMonth) AND (EDay <> BDay)) THEN Category:=3
                             ELSE IF ((EYear > BYear) AND (EMonth = BMonth) AND (EDay = BDay)) THEN Category:=4
                             ELSE IF ((EYear > BYear) AND (EMonth = BMonth) AND (EDay <> BDay)) THEN Category:= 5
                             ELSE IF ((EYear > BYear) AND (EMonth <> BMonth) AND (EDay = BDay)) THEN Category:= 6
                             ELSE IF ((EYear = BYear) AND (EMonth <> BMonth) AND (EDay <> BDay)) THEN Category:=7
                             ELSE IF ((EYear = BYear) AND (EMonth = BMonth) AND (EDay = BDay)) THEN Category:=3
                             ELSE BEGIN
                                  Category:=0;
                                  //ERROR('The start date cannot be after the end date.');
                                  END;
                             EXIT;
                             */

    end;

    procedure LeapYear(Year: Integer) LY: Boolean
    var
        CenturyYear: Boolean;
        DivByFour: Boolean;
    begin
                           CenturyYear := Year mod 100 = 0;
                           DivByFour:= Year mod 4 = 0;
                           if ((not CenturyYear and DivByFour) or (Year mod 400 = 0)) then
                            LY:= true
                           else
                            LY:= false;
    end;

    procedure ReservedDates(NewStartDate: Date;NewEndDate: Date;EmployeeNumber: Code[20]) Reserved: Boolean
    var
        AbsenceHoliday: Record "Fixed Deposit Type";
        OK: Boolean;
    begin
                        /*  AbsenceHoliday.SETFILTER(Code,EmployeeNumber);
                          OK:= AbsenceHoliday.FIND('-');
                          REPEAT
                              IF (NewStartDate > AbsenceHoliday.Duration) AND (NewStartDate < AbsenceHoliday.Description) THEN
                                 Reserved := TRUE
                              ELSE
                              IF (NewEndDate < AbsenceHoliday.Description) AND (NewEndDate > AbsenceHoliday.Duration) THEN
                                 Reserved := TRUE
                              ELSE
                              IF (NewStartDate > AbsenceHoliday.Duration) AND (NewEndDate < AbsenceHoliday.Description) THEN
                                 Reserved := TRUE
                              ELSE Reserved := FALSE;
        
                          UNTIL AbsenceHoliday.NEXT = 0;*/

    end;

    procedure DetermineWeekends(DateStart: Date;DateEnd: Date) Weekends: Integer
    begin
             /*    Weekends:= 0;
                 WHILE (DateStart <= DateEnd) DO BEGIN
                   dayOfWeek:= DATE2DWY(DateStart,1);
                     IF (dayOfWeek = 6) OR (dayOfWeek = 7) THEN
                        Weekends:= Weekends + 1;
                   NextDay:= CalculateNextDay(DateStart);
                   DateStart:= NextDay;
                 END;*/

    end;

    procedure CalculateNextDay(Date: Date) NextDate: Date
    var
        today: Integer;
        month: Integer;
        year: Integer;
        nextDay: Integer;
        daysInMonth: Integer;
    begin
                   /* today:= DATE2DMY(Date,1);
                    month:= DATE2DMY(Date,2);
                    year:= DATE2DMY(Date,3);
                    daysInMonth:= DetermineDaysInMonth(month,year);
                    nextDay:= today + 1;
                    IF (nextDay > daysInMonth) THEN BEGIN
                      nextDay:= 1;
                      month:= month + 1;
                      IF (month > 12) THEN BEGIN
                        month:= 1;
                        year:= year + 1;
                      END;
                    END;
                     NextDate:= DMY2DATE(nextDay,month,year);*/

    end;

    procedure DetermineHolidays(DateStart: Date;DateEnd: Date) Holiday: Integer
    var
        StatutoryHoliday: Record "Fixed Deposit Type";
        NextDay: Date;
    begin
                  /*Holiday:= 0;
                  WHILE (DateStart <= DateEnd) DO BEGIN
                    dayOfWeek:= DATE2DWY(DateStart,1);
                    StatutoryHoliday.FIND('-');
                    REPEAT
                     IF (DateStart = StatutoryHoliday."Holiday Date") THEN
                        Holiday:= Holiday + StatutoryHoliday."Duration Of Holiday";
        
                    UNTIL StatutoryHoliday.NEXT = 0;
                    NextDay:= CalculateNextDay(DateStart);
                    DateStart:= NextDay;
                 END;*/
        

    end;
}

