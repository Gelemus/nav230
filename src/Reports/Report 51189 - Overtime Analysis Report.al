report 51189 "Overtime Analysis Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Overtime Analysis Report.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("No." = FILTER(<> ''));
            column(OVERTIME_ANALYSIS_FOR_WEEK_NO____________FORMAT_ThisWeek___1_; 'OVERTIME ANALYSIS FOR WEEK NO.' + ' - ' + Format(ThisWeek - 1))
            {
            }
            column(EmpCode_1_; EmpCode[1])
            {
            }
            column(EmpName_1_; EmpName[1])
            {
            }
            column(Dept_1_; Dept[1])
            {
            }
            column(SubDept_1_; SubDept[1])
            {
            }
            column(DateDa_1_; DateDa[1])
            {
            }
            column(NormalHrs_1_; NormalHrs[1])
            {
            }
            column(NorOT_1_; NorOT[1])
            {
            }
            column(WeekOT_1_; WeekOT[1])
            {
            }
            column(HolOT_1_; HolOT[1])
            {
            }
            column(TotalOTHrs_1_; TotalOTHrs[1])
            {
            }
            column(TotalOTHrs_2_; TotalOTHrs[2])
            {
            }
            column(EmpCode_2_; EmpCode[2])
            {
            }
            column(EmpName_2_; EmpName[2])
            {
            }
            column(Dept_2_; Dept[2])
            {
            }
            column(SubDept_2_; SubDept[2])
            {
            }
            column(DateDa_2_; DateDa[2])
            {
            }
            column(NormalHrs_2_; NormalHrs[2])
            {
            }
            column(NorOT_2_; NorOT[2])
            {
            }
            column(WeekOT_2_; WeekOT[2])
            {
            }
            column(HolOT_2_; HolOT[2])
            {
            }
            column(TotalOTHrs_3_; TotalOTHrs[3])
            {
            }
            column(EmpCode_3_; EmpCode[3])
            {
            }
            column(EmpName_3_; EmpName[3])
            {
            }
            column(Dept_3_; Dept[3])
            {
            }
            column(SubDept_3_; SubDept[3])
            {
            }
            column(DateDa_3_; DateDa[3])
            {
            }
            column(NormalHrs_3_; NormalHrs[3])
            {
            }
            column(NorOT_3_; NorOT[3])
            {
            }
            column(WeekOT_3_; WeekOT[3])
            {
            }
            column(HolOT_3_; HolOT[3])
            {
            }
            column(TotalOTHrs_4_; TotalOTHrs[4])
            {
            }
            column(EmpCode_4_; EmpCode[4])
            {
            }
            column(EmpName_4_; EmpName[4])
            {
            }
            column(Dept_4_; Dept[4])
            {
            }
            column(SubDept_4_; SubDept[4])
            {
            }
            column(DateDa_4_; DateDa[4])
            {
            }
            column(NormalHrs_4_; NormalHrs[4])
            {
            }
            column(NorOT_4_; NorOT[4])
            {
            }
            column(WeekOT_4_; WeekOT[4])
            {
            }
            column(HolOT_4_; HolOT[4])
            {
            }
            column(TotalOTHrs_5_; TotalOTHrs[5])
            {
            }
            column(EmpCode_5_; EmpCode[5])
            {
            }
            column(EmpName_5_; EmpName[5])
            {
            }
            column(Dept_5_; Dept[5])
            {
            }
            column(SubDept_5_; SubDept[5])
            {
            }
            column(DateDa_5_; DateDa[5])
            {
            }
            column(NormalHrs_5_; NormalHrs[5])
            {
            }
            column(NorOT_5_; NorOT[5])
            {
            }
            column(WeekOT_5_; WeekOT[5])
            {
            }
            column(HolOT_5_; HolOT[5])
            {
            }
            column(TotalOTHrs_6_; TotalOTHrs[6])
            {
            }
            column(EmpCode_6_; EmpCode[6])
            {
            }
            column(EmpName_6_; EmpName[6])
            {
            }
            column(Dept_6_; Dept[6])
            {
            }
            column(SubDept_6_; SubDept[6])
            {
            }
            column(DateDa_6_; DateDa[6])
            {
            }
            column(NormalHrs_6_; NormalHrs[6])
            {
            }
            column(NorOT_6_; NorOT[6])
            {
            }
            column(WeekOT_6_; WeekOT[6])
            {
            }
            column(HolOT_6_; HolOT[6])
            {
            }
            column(TotalOTHrs_7_; TotalOTHrs[7])
            {
            }
            column(EmpCode_7_; EmpCode[7])
            {
            }
            column(EmpName_7_; EmpName[7])
            {
            }
            column(Dept_7_; Dept[7])
            {
            }
            column(SubDept_7_; SubDept[7])
            {
            }
            column(DateDa_7_; DateDa[7])
            {
            }
            column(NormalHrs_7_; NormalHrs[7])
            {
            }
            column(NorOT_7_; NorOT[7])
            {
            }
            column(WeekOT_7_; WeekOT[7])
            {
            }
            column(HolOT_7_; HolOT[7])
            {
            }
            column(WorkerCaption; WorkerCaptionLbl)
            {
            }
            column(Sub_Caption; Sub_CaptionLbl)
            {
            }
            column(NormalCaption; NormalCaptionLbl)
            {
            }
            column(Normal_OTCaption; Normal_OTCaptionLbl)
            {
            }
            column(Weekend_OTCaption; Weekend_OTCaptionLbl)
            {
            }
            column(Holiday_OTCaption; Holiday_OTCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(CodeCaption; CodeCaptionLbl)
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(NormalCaption_Control1102754079; NormalCaption_Control1102754079Lbl)
            {
            }
            column(HoursCaption; HoursCaptionLbl)
            {
            }
            column(HoursCaption_Control1102754081; HoursCaption_Control1102754081Lbl)
            {
            }
            column(HoursCaption_Control1102754082; HoursCaption_Control1102754082Lbl)
            {
            }
            column(HoursCaption_Control1102754083; HoursCaption_Control1102754083Lbl)
            {
            }
            column(WorkerCaption_Control1102754084; WorkerCaption_Control1102754084Lbl)
            {
            }
            column(DepartmentCaption_Control1102754085; DepartmentCaption_Control1102754085Lbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(Employee_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                gvAllowedPayrolls.Reset;
                gvAllowedPayrolls.SetRange(gvAllowedPayrolls."User ID", UserId);
                gvAllowedPayrolls.SetRange(gvAllowedPayrolls."Last Active Payroll", true);
                if gvAllowedPayrolls.FindFirst then
                    ActPayrollID := gvAllowedPayrolls."Payroll Code";


                Clear(OTHours);
                Clear(OTNonWork);
                Clear(OTHoliday);
                Clear(OTNormal);
                Clear(NonWrkAmt);
                Clear(HoliAmt);
                Clear(NormalAmt);
                Clear(TotalOTAmount);
                Clear(EmpCode);
                Clear(EmpName);
                Clear(Dept);
                Clear(SubDept);
                Clear(DateDa);
                Clear(NormalHrs);
                Clear(NorOT);
                Clear(WeekOT);
                Clear(HolOT);
                Clear(TotalOTHrs);

                I := 1;
                ThisWeek := Date2DWY(ActualDateE, 2);
                PrevWeekFrom := DWY2Date(1, ThisWeek - 1, Date2DWY(ActualDateE, 3));
                PrevWeekTo := DWY2Date(7, ThisWeek - 1, Date2DWY(ActualDateE, 3));
                DateR.Reset;
                DateR.SetRange("Period Type", DateR."Period Type"::Date);
                DateR.SetRange(DateR."Period Start", PrevWeekFrom, PrevWeekTo);
                if DateR.FindFirst then
                    repeat
                        EmpRec.Reset;
                        //EmpRec.SETRANGE(EmpRec."Payroll Code",ActPayrollID);
                        EmpRec.SetRange(EmpRec."No.", "No.");
                        EmpRec.SetRange(EmpRec.Status, EmpRec.Status::Active);
                        if EmpRec.FindFirst then
                            repeat
                                EmpCode[I] := EmpRec."No.";
                                EmpName[I] := EmpRec."First Name" + ' ' + EmpRec."Last Name";
                                Dept[I] := EmpRec."Global Dimension 1 Code";
                                SubDept[I] := EmpRec."Global Dimension 2 Code";
                                DateDa[I] := DateR."Period Start";
                                EmpGrade.Reset;
                                EmpGrade.SetRange(EmpGrade."Grade Code", EmpRec."Employee Grade");
                                EmpGrade.SetRange(EmpGrade."OT Qualifying", true);
                                if EmpGrade.FindFirst then
                                    repeat
                                        Period.Reset;
                                        Period.SetRange(Period."Period Month", Date2DMY(PrevWeekTo, 2));
                                        Period.SetRange(Period."Period Year", Date2DMY(PrevWeekTo, 3));
                                        if Period.FindFirst then
                                            PayRID := Period."Period ID";
                                        TimeRegR.Reset;
                                        TimeRegR.SetRange(TimeRegR."Employee No.", EmpRec."No.");
                                        TimeRegR.SetRange(TimeRegR."From Date", DateR."Period Start");
                                        if TimeRegR.FindFirst then
                                            repeat
                                                CauseofAbs.Reset;
                                                CauseofAbs.SetRange(CauseofAbs.Code, TimeRegR."Cause of Absence Code");
                                                if CauseofAbs.FindFirst then begin
                                                    EDDef.Reset;
                                                    EDDef.SetRange(EDDef."ED Code", CauseofAbs."E/D Code");
                                                    if EDDef.FindFirst then begin
                                                        if EDDef."Calculation Group" = EDDef."Calculation Group"::Payments then
                                                            ActualWeeklyHours += TimeRegR.Quantity;
                                                        /* HRBaseCalender.RESET;
                                                         HRBaseCalender.SETRANGE(HRBaseCalender.Date,TimeRegR."From Date");
                                                         IF HRBaseCalender.FINDFIRST THEN BEGIN
                                                           IF HRBaseCalender.Nonworking THEN BEGIN
                                                             OTNonWork += TimeRegR.Quantity;
                                                             WeekOT[I] := TimeRegR.Quantity;
                                                           END ELSE IF HRBaseCalender.Holiday THEN BEGIN
                                                             OTHoliday +=TimeRegR.Quantity;
                                                             HolOT[I] := TimeRegR.Quantity;
                                                           END ELSE BEGIN
                                                             OTNormal += TimeRegR.Quantity - HRBaseCalender."Max Daily Working Hrs";
                                                             NorOT[I] := TimeRegR.Quantity - HRBaseCalender."Max Daily Working Hrs";
                                                           END;
                                                           NormalHrs[I] := HRBaseCalender."Max Daily Working Hrs";
                                                           IF NorOT[I] <> 0 THEN
                                                             TotalOTHrs[I] := NormalHrs[I] + NorOT[I]+HolOT[I]+WeekOT[I]
                                                           ELSE
                                                             TotalOTHrs[I] := HolOT[I]+WeekOT[I];
                                                         END; */
                                                    end;
                                                end;
                                            /*Week.RESET;
                                            Week.SETRANGE(Week."As of Date",TimeRegR."From Date");
                                            Week.SETRANGE(Week."Week No.",ThisWeek-1);
                                            IF Week.FINDLAST THEN BEGIN
                                              MaxWeekHrs := Week."Max. Working Hrs";
                                            END; */
                                            until TimeRegR.Next = 0;
                                        if ActualWeeklyHours > MaxWeekHrs then begin
                                            OTHours := ActualWeeklyHours - MaxWeekHrs;
                                        end;
                                        TotalOTAmount := NonWrkAmt + HoliAmt + NormalAmt;
                                    until EmpGrade.Next = 0;
                            until EmpRec.Next = 0;
                        I += 1;
                    until DateR.Next = 0;

            end;

            trigger OnPostDataItem()
            begin
                /*IF ExportYesNo THEN BEGIN
                  Window.CLOSE;
                  TempExcelBuffer.CreateBook;
                  TempExcelBuffer.CreateSheet(Text000,Text000,COMPANYNAME,USERID);
                  TempExcelBuffer.GiveUserControl;
                END; */

            end;

            trigger OnPreDataItem()
            begin
                if ExportYesNo then begin
                    Window.Open(Text001 + '@1@@@@@@@@@@@@@@@@@@@@\');
                    Window.Update(1, 0);
                    TotalRecNo := Employee.Count;
                    RecNo := 0;
                    TempExcelBuffer.DeleteAll;
                    Clear(TempExcelBuffer);
                    //-------Row No, Column Heading, For Template ---------
                    EnterCell(1, 1, 'OVERTIME ANALYSIS FOR WEEK NO.' + ' - ' + Format(Date2DWY(ActualDateE, 2) - 1), true, false, false);
                    EnterCell(3, 1, 'Worker', true, false, false);
                    EnterCell(3, 4, 'Sub - ', true, false, false);
                    EnterCell(3, 6, 'Normal', true, false, false);
                    EnterCell(3, 7, 'Normal OT', true, false, false);
                    EnterCell(3, 8, 'Weekend OT', true, false, false);
                    EnterCell(3, 9, 'Holiday OT', true, false, false);
                    EnterCell(3, 10, 'Total OT', true, false, false);
                    EnterCell(4, 1, 'Code', true, true, false);
                    EnterCell(4, 2, 'Worker', true, true, false);
                    EnterCell(4, 3, 'Department', true, true, false);
                    EnterCell(4, 4, 'Department ', true, true, false);
                    EnterCell(4, 6, 'Hours', true, true, false);
                    EnterCell(4, 7, 'Hours', true, true, false);
                    EnterCell(4, 8, 'Hours', true, true, false);
                    EnterCell(4, 9, 'Hours', true, true, false);
                    EnterCell(4, 10, 'Hours', true, true, false);
                    Row := 5;
                    Sno := 0;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1102754001)
                {
                    ShowCaption = false;
                    field(ActualDateE; ActualDateE)
                    {
                        Caption = 'Date';
                    }
                }
            }
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
        gsSegmentPayrollData;
    end;

    var
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
        DateR: Record Date;
        ThisWeek: Integer;
        PrevWeekFrom: Date;
        PrevWeekTo: Date;
        ActualDateE: Date;
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
        "//Display Text": Integer;
        EmpCode: array[1000] of Code[20];
        EmpName: array[1000] of Text[50];
        Dept: array[1000] of Code[20];
        SubDept: array[1000] of Code[20];
        DateDa: array[1000] of Date;
        NormalHrs: array[1000] of Decimal;
        NorOT: array[1000] of Decimal;
        WeekOT: array[1000] of Decimal;
        HolOT: array[1000] of Decimal;
        TotalOTHrs: array[1000] of Decimal;
        I: Integer;
        "//ExporttoExcel": Integer;
        TempExcelBuffer: Record "Excel Buffer";
        Row: Integer;
        TotalRecNo: Integer;
        RecNo: Integer;
        Sno: Integer;
        Window: Dialog;
        ExportYesNo: Boolean;
        Text000: Label 'OT - ANALYSIS';
        Text001: Label 'Analyzing Date....';
        J: Integer;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        MembershipNumbers: Record "Membership Numbers";
        gvPinNo: Code[20];
        ActPayrollID: Code[20];
        WorkerCaptionLbl: Label 'Worker';
        Sub_CaptionLbl: Label 'Sub-';
        NormalCaptionLbl: Label 'Normal';
        Normal_OTCaptionLbl: Label 'Normal OT';
        Weekend_OTCaptionLbl: Label 'Weekend OT';
        Holiday_OTCaptionLbl: Label 'Holiday OT';
        TotalCaptionLbl: Label 'Total';
        CodeCaptionLbl: Label 'Code';
        DepartmentCaptionLbl: Label 'Department';
        NormalCaption_Control1102754079Lbl: Label 'Normal';
        HoursCaptionLbl: Label 'Hours';
        HoursCaption_Control1102754081Lbl: Label 'Hours';
        HoursCaption_Control1102754082Lbl: Label 'Hours';
        HoursCaption_Control1102754083Lbl: Label 'Hours';
        WorkerCaption_Control1102754084Lbl: Label 'Worker';
        DepartmentCaption_Control1102754085Lbl: Label 'Department';
        DateCaptionLbl: Label 'Date';

    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean)
    begin
        TempExcelBuffer.Init;
        TempExcelBuffer.Validate("Row No.", RowNo);
        TempExcelBuffer.Validate("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.Insert;
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

        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID", ServiceInstanceId);
        lvActiveSession.SetRange("Session ID", SessionId);
        lvActiveSession.FindFirst;


        gvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        gvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if not gvAllowedPayrolls.FindFirst then
            Error('You are not allowed access to this payroll dataset.');
    end;
}

