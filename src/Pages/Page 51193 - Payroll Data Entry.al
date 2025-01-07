page 51193 "Payroll Data Entry"
{
    PageType = Document;
    Permissions = TableData "Employee Grades2"=rimd;

    layout
    {
        area(content)
        {
            field(gvPeriodFilter;gvPeriodFilter)
            {
                Caption = 'Period Filter';
                TableRelation = Periods."Period ID" WHERE (Status=CONST(Open));

                trigger OnValidate()
                begin
                    gvPeriodFilterOnAfterValidate;
                end;
            }
            part(SubFrm;"Payroll Entry2")
            {
                SubPageView = SORTING("Payroll ID","Employee No.","ED Code")
                              ORDER(Ascending);
            }
            field(gvEDFilter;gvEDFilter)
            {
                Caption = 'ED Filter';
                TableRelation = "ED Definitions"."ED Code" WHERE ("System Created"=CONST(false));

                trigger OnValidate()
                begin
                    gvEDFilterOnAfterValidate;
                end;
            }
            field(gvEmployeeFilter;gvEmployeeFilter)
            {
                Caption = 'Employee Filter';
                TableRelation = Employee."No.";

                trigger OnValidate()
                begin
                    gvEmployeeFilterOnAfterValidat;
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("Insert Batch...")
                {
                    Caption = 'Insert Batch...';

                    trigger OnAction()
                    var
                        lvRptInsertBatch: Report "NHIF Report1";
                    begin
                        lvRptInsertBatch.RunModal;
                    end;
                }
                separator(Separator1102754005)
                {
                }
                action("Compute Over Time")
                {
                    Caption = 'Compute Over Time';

                    trigger OnAction()
                    var
                        PeriodStartDate: Date;
                        PeriodEndDate: Date;
                        lvEmp: Record Employee;
                        lvEmpCalendar: Code[10];
                    begin
                        Clear(OTHours);
                        Clear(OTNonWork);
                        Clear(OTHoliday);
                        Clear(OTNormal);
                        Clear(NonWrkAmt);
                        Clear(HoliAmt);
                        Clear(NormalAmt);
                        Clear(TotalOTAmount);
                        gvAllowedPayrolls.Reset;
                        gvAllowedPayrolls.SetRange(gvAllowedPayrolls."User ID",UserId);
                        gvAllowedPayrolls.SetRange(gvAllowedPayrolls."Last Active Payroll",true);
                        if gvAllowedPayrolls.FindFirst then
                          ActPayrollID := gvAllowedPayrolls."Payroll Code";
                        
                        EmpRec.Reset;
                        EmpRec.SetRange(EmpRec."Payroll Code",ActPayrollID);
                        EmpRec.SetRange(EmpRec.Status,EmpRec.Status::Active);
                        if EmpRec.FindFirst then repeat
                          EmpGrade.Reset;
                          EmpGrade.SetRange(EmpGrade."Grade Code",EmpRec."Employee Grade");
                          EmpGrade.SetRange(EmpGrade."OT Qualifying",true);
                          if EmpGrade.FindFirst then repeat
                            //ThisWeek := DATE2DWY(TODAY,2);
                            //PrevWeekFrom := DWY2DATE(1,ThisWeek-1,DATE2DWY(TODAY,3));
                            //PrevWeekTo := DWY2DATE(7,ThisWeek-1,DATE2DWY(TODAY,3));
                            Period.Reset;
                            Period.SetRange(Period."Period Month",Date2DMY(Today,2));
                            Period.SetRange(Period."Period Year",Date2DMY(Today,3));
                            if Period.FindFirst then begin
                              PayRID := Period."Period ID";
                              PeriodStartDate:=Period."Start Date";
                              PeriodEndDate:=Period."End Date";
                            end;
                        Clear(OTHours);
                        Clear(OTNonWork);
                        Clear(OTHoliday);
                        Clear(OTNormal);
                            TimeRegR.Reset;
                            TimeRegR.SetRange(TimeRegR."Employee No.",EmpRec."No.");
                            TimeRegR.SetFilter(TimeRegR.Quantity,'<>%1',0);
                            TimeRegR.SetRange(TimeRegR."From Date",PeriodStartDate,PeriodEndDate);
                            if TimeRegR.FindFirst then repeat
                              CauseofAbs.Reset;
                              CauseofAbs.SetRange(CauseofAbs.Code,TimeRegR."Cause of Absence Code");
                              if CauseofAbs.FindFirst then begin
                                EDDef.Reset;
                                EDDef.SetRange(EDDef."ED Code",CauseofAbs."E/D Code");
                                if EDDef.FindFirst then begin
                                  if EDDef."Calculation Group" = EDDef."Calculation Group"::Payments then
                                    ActualWeeklyHours += TimeRegR.Quantity;
                                //RGK Get employee's base calendar
                                //lvEmpCalendar:=EmpRec."Base Calendar Code";
                                //end RGK Get employee's base calendar
                                 /* HRBaseCalender.RESET;
                                  HRBaseCalender.SETRANGE(HRBaseCalender."Base Calendar Code",lvEmpCalendar);
                                  HRBaseCalender.SETRANGE(HRBaseCalender.Date,TimeRegR."From Date");
                                  IF HRBaseCalender.FINDFIRST THEN BEGIN
                                    IF HRBaseCalender.Nonworking THEN
                                      OTNonWork += TimeRegR.Quantity
                                    ELSE IF HRBaseCalender.Holiday THEN
                                      OTHoliday +=TimeRegR.Quantity
                                    ELSE BEGIN
                                      OTNormal += TimeRegR.Quantity - HRBaseCalender."Max Daily Working Hrs";
                                    END;
                                  END; */
                                end;
                              end;
                              /*
                              Week.RESET;
                              Week.SETRANGE(Week."As of Date",TimeRegR."From Date");
                              Week.SETRANGE(Week."Week No.",ThisWeek-1);
                              IF Week.FINDLAST THEN BEGIN
                                MaxWeekHrs := Week."Max. Working Hrs";
                              END;
                              */
                              until TimeRegR.Next = 0;
                              //IF ActualWeeklyHours > MaxWeekHrs THEN BEGIN
                              //  OTHours := ActualWeeklyHours - MaxWeekHrs;
                                PayrollSetup.Reset;
                                PayrollSetup.SetRange(PayrollSetup."Payroll Code",ActPayrollID);
                                if PayrollSetup.FindFirst then begin
                                  //OT Non Working days
                                  if OTNonWork <> 0 then begin
                                    if PayrollSetup."Weekend OT ED" <> '' then begin
                                      EdDefR2.Reset;
                                      EdDefR2.SetRange(EdDefR2."ED Code",PayrollSetup."Weekend OT ED");
                                      if EdDefR2.FindFirst then begin
                                        NonWrkAmt := OTNonWork * EdDefR2."Overtime ED Weight"*EmpRec."Hourly Rate";
                                      PayrollEntry.Reset;
                                      PayrollEntry.SetRange(PayrollEntry."ED Code",PayrollSetup."Weekend OT ED");
                                      PayrollEntry.SetRange(PayrollEntry."Employee No.",EmpRec."No.");
                                      PayrollEntry.SetRange(PayrollEntry."Payroll ID",PayRID);
                                      PayrollEntry.SetRange(PayrollEntry.Amount,NonWrkAmt);
                                      if not PayrollEntry.FindFirst then begin
                                        ParollEntry.Reset;
                                        if ParollEntry.FindLast then
                                          PayrollEntryNo := ParollEntry."Entry No.";
                                        PayrollEntry."Entry No." := PayrollEntryNo + 1;
                                        PayrollEntry.Validate("ED Code",EdDefR2."ED Code");
                                        PayrollEntry.Validate("Payroll ID",PayRID);
                                        PayrollEntry.Validate("Employee No.",EmpRec."No.");
                                        PayrollEntry.Quantity := 1;
                                        PayrollEntry.Validate(PayrollEntry.Rate,NonWrkAmt);
                                        PayrollEntry.Date := Today;
                                        PayrollEntry.Insert;
                                      end;
                                     end;
                                    end;
                                  end;
                                  //OT Holiday
                                  if OTHoliday <> 0 then begin
                                    if PayrollSetup."Holiday OT ED" <> '' then begin
                                      EdDefR2.Reset;
                                      EdDefR2.SetRange(EdDefR2."ED Code",PayrollSetup."Holiday OT ED");
                                      if EdDefR2.FindFirst then begin
                                        HoliAmt := OTHoliday * EdDefR2."Overtime ED Weight"*EmpRec."Hourly Rate";
                                      PayrollEntry.Reset;
                                      PayrollEntry.SetRange(PayrollEntry."ED Code",PayrollSetup."Holiday OT ED");
                                      PayrollEntry.SetRange(PayrollEntry."Employee No.",EmpRec."No.");
                                      PayrollEntry.SetRange(PayrollEntry."Payroll ID",PayRID);
                                      PayrollEntry.SetRange(PayrollEntry.Amount,HoliAmt);
                                      if not PayrollEntry.FindFirst then begin
                                        ParollEntry.Reset;
                                        if ParollEntry.FindLast then
                                          PayrollEntryNo := ParollEntry."Entry No.";
                                        PayrollEntry."Entry No." := PayrollEntryNo + 1;
                                        PayrollEntry.Validate("ED Code",EdDefR2."ED Code");
                                        PayrollEntry.Validate("Payroll ID",PayRID);
                                        PayrollEntry.Validate("Employee No.",EmpRec."No.");
                                        PayrollEntry.Quantity := 1;
                                        PayrollEntry.Validate(PayrollEntry.Rate,HoliAmt);
                                        PayrollEntry.Date := Today;
                                        PayrollEntry.Insert;
                                      end;
                                     end;
                                    end;
                                  end;
                                  Clear(NormalAmt);
                                  //OT Normal Working day
                                  if OTNormal <> 0 then begin
                                    if PayrollSetup."Normal OT ED" <> '' then begin
                                      EdDefR2.Reset;
                                      EdDefR2.SetRange(EdDefR2."ED Code",PayrollSetup."Normal OT ED");
                                      if EdDefR2.FindFirst then begin
                                        NormalAmt := OTNormal * EdDefR2."Overtime ED Weight"*EmpRec."Hourly Rate";
                                      PayrollEntry.Reset;
                                      PayrollEntry.SetRange(PayrollEntry."ED Code",PayrollSetup."Normal OT ED");
                                      PayrollEntry.SetRange(PayrollEntry."Employee No.",EmpRec."No.");
                                      PayrollEntry.SetRange(PayrollEntry."Payroll ID",PayRID);
                                      PayrollEntry.SetRange(PayrollEntry.Amount,NormalAmt);
                                      if not PayrollEntry.FindFirst then begin
                                        ParollEntry.Reset;
                                        if ParollEntry.FindLast then
                                          PayrollEntryNo := ParollEntry."Entry No.";
                                        PayrollEntry."Entry No." := PayrollEntryNo + 1;
                                        PayrollEntry.Validate("ED Code",EdDefR2."ED Code");
                                        PayrollEntry.Validate("Payroll ID",PayRID);
                                        PayrollEntry.Validate("Employee No.",EmpRec."No.");
                                        PayrollEntry.Quantity := 1;
                                        PayrollEntry.Validate(PayrollEntry.Rate,NormalAmt);
                                        PayrollEntry.Date := Today;
                                        PayrollEntry.Insert;
                                      end;
                                     end;
                                    end;
                                  end;
                                end;
                              //END;
                                  TotalOTAmount := NonWrkAmt + HoliAmt + NormalAmt;
                            if TotalOTAmount <> 0 then
                              Posted := true;
                          until EmpGrade.Next = 0;
                        until EmpRec.Next = 0;
                        if Posted then
                          Message('Computation Updated Successfully')
                        else
                          Message('Nothing to update');

                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        lvPeriods: Record Periods;
    begin
        gsSegmentPayrollData;

        lvPeriods.SetCurrentKey("Start Date");
        lvPeriods.SetRange(Status, lvPeriods.Status::Open);
        lvPeriods.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
        if lvPeriods.Find('-') then gvPeriodFilter := lvPeriods."Period ID";
        ApplySubFormFilter
    end;

    var
        gvPeriodFilter: Code[10];
        gvEmployeeFilter: Code[20];
        gvEDFilter: Code[20];
        gvAllowedPayrolls: Record "Allowed Payrolls";
        "//OT Calculation": Integer;
        EmpRec: Record Employee;
        EmpGrade: Record "Employee Grades2";
        TimeRegR: Record "Employee Absence";
        CauseofAbs: Record "Cause of Absence";
        EDDef: Record "ED Definitions";
        EdDefR2: Record "ED Definitions";
        PayrollSetup: Record "Payroll Setups";
        PayrollEntry: Record "Payroll Entry";
        ParollEntry: Record "Payroll Entry";
        Period: Record Periods;
        ThisWeek: Integer;
        PrevWeekFrom: Date;
        PrevWeekTo: Date;
        ActualWeeklyHours: Decimal;
        MaxWeekHrs: Decimal;
        OTHours: Decimal;
        OTNonWork: Decimal;
        OTHoliday: Decimal;
        OTNormal: Decimal;
        NonWrkAmt: Decimal;
        HoliAmt: Decimal;
        NormalAmt: Decimal;
        TotalOTAmount: Decimal;
        PayRID: Code[20];
        PayrollEntryNo: Integer;
        Posted: Boolean;
        ActPayrollID: Code[20];

    procedure ApplySubFormFilter()
    var
        lvPayrollEntry: Record "Payroll Entry";
    begin
        lvPayrollEntry.Reset;
        lvPayrollEntry.SetCurrentKey("Payroll ID", "Employee No.", "ED Code");

        if gvPeriodFilter <> '' then lvPayrollEntry.SetRange("Payroll ID", gvPeriodFilter);
        if gvEmployeeFilter <> '' then lvPayrollEntry.SetRange("Employee No.", gvEmployeeFilter);
        if gvEDFilter <> '' then lvPayrollEntry.SetRange("ED Code", gvEDFilter);
        lvPayrollEntry.SetRange("Payroll Code",gvAllowedPayrolls."Payroll Code");
        lvPayrollEntry.FilterGroup(10);

        CurrPage.SubFrm.PAGE.SetTableView(lvPayrollEntry);
    end;

    local procedure gvPeriodFilterOnAfterValidate()
    begin
        ApplySubFormFilter;
    end;

    local procedure gvEDFilterOnAfterValidate()
    begin
        ApplySubFormFilter
    end;

    local procedure gvEmployeeFilterOnAfterValidat()
    begin
        ApplySubFormFilter
    end;

    procedure gsSegmentPayrollData()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lvPayrollUtilities: Codeunit "Payroll Posting";
        UsrID: Code[10];
        UsrID2: Code[10];
        StringLen: Integer;
        lvActiveSession: Record "Active Session";
    begin
        /*lvSession.SETRANGE("My Session", TRUE);
        lvSession.FINDFIRST; //fire error in absence of a login
        IF lvSession."Login Type" = lvSession."Login Type"::Database THEN
          lvAllowedPayrolls.SETRANGE("User ID", USERID)
        ELSE*/
        
        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID",ServiceInstanceId);
        lvActiveSession.SetRange("Session ID",SessionId);
        lvActiveSession.FindFirst;
        
        lvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        lvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if not lvAllowedPayrolls.FindFirst then
          Error('You are not allowed access to this payroll dataset.');

    end;
}

