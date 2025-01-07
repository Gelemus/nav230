report 51190 "Staff Movement Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Staff Movement Report.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("Global Dimension 1 Code", "Global Dimension 2 Code");
            column(No__of_Employees_as_per____FORMAT_PreviousFromMonth_0___Month_Text___Year_______Payroll_; 'No. of Employees as per ' + Format(PreviousFromMonth, 0, '<Month Text> <Year>.') + ' Payroll')
            {
            }
            column(Leavers___FORMAT_PreviousFromMonth_0___Month_Text___Year____; 'Leavers ' + Format(PreviousFromMonth, 0, '<Month Text> <Year>.'))
            {
            }
            column(Joiners___FORMAT_DateCm_0___Month_Text___Year____; 'Joiners ' + Format(DateCm, 0, '<Month Text> <Year>.'))
            {
            }
            column(No__Of_Employees_as_Per____FORMAT_DateCm_0___Month_Text___Year_______Payroll_; 'No. Of Employees as Per ' + Format(DateCm, 0, '<Month Text> <Year>.') + ' Payroll')
            {
            }
            column(Leavers___FORMAT_DateCm_0___Month_Text___Year____; 'Leavers ' + Format(DateCm, 0, '<Month Text> <Year>.'))
            {
            }
            column(Employee__Global_Dimension_1_Code_; "Global Dimension 1 Code")
            {
            }
            column(ToDisplay; ToDisplay)
            {
            }
            column(TransferTo; TransferTo)
            {
            }
            column(TransferFrom; TransferFrom)
            {
            }
            column(Leavers; Leavers)
            {
            }
            column(Joiners; Joiners)
            {
            }
            column(Reinstate; Reinstate)
            {
            }
            column(CurrLeavers; CurrLeavers)
            {
            }
            column(NoofEmpAsPerC; NoofEmpAsPerC)
            {
            }
            column(ExpNoofEmpClos; ExpNoofEmpClos)
            {
            }
            column(DEPTCaption; DEPTCaptionLbl)
            {
            }
            column(Transfer_ToCaption; Transfer_ToCaptionLbl)
            {
            }
            column(Transfer_FromCaption; Transfer_FromCaptionLbl)
            {
            }
            column(Reinstated_for_Final_DuesCaption; Reinstated_for_Final_DuesCaptionLbl)
            {
            }
            column(Expected_No__of_Emp_as_at_closing_of_payrollCaption; Expected_No__of_Emp_as_at_closing_of_payrollCaptionLbl)
            {
            }
            column(Employee_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Moved from Employee Body-presection
                PayrollHdr.Reset;
                PayrollHdr.SetRange("Employee no.", "No.");
                PayrollHdr.SetRange("Payroll Month", Date2DMY(PreviousFromMonth, 2));
                PayrollHdr.SetRange("Payroll Year", Date2DMY(PreviousFromMonth, 3));
                if PayrollHdr.FindFirst then
                    repeat
                        NoofEmpOldP += PayrollHdr.Count;
                    until PayrollHdr.Next = 0;

                EmpRec.Reset;
                EmpRec.SetRange(EmpRec."No.", "No.");
                EmpRec.SetRange(EmpRec."Termination Date", PreviousFromMonth, PreviousToDate);
                if EmpRec.FindFirst then
                    repeat
                        Leavers += 1;
                    until EmpRec.Next = 0;

                EmpRec.Reset;
                EmpRec.SetRange(EmpRec."No.", "No.");
                EmpRec.SetRange(EmpRec."Employment Date", DMY2Date(1, MonthV, YearV), DMY2Date(NoofDays, MonthV, YearV));
                if EmpRec.FindFirst then
                    repeat
                        Joiners += 1;
                    until EmpRec.Next = 0;

                EmpRec.Reset;
                EmpRec.SetRange(EmpRec."No.", "No.");
                EmpRec.SetRange(EmpRec."Termination Date", DMY2Date(1, MonthV, YearV), DMY2Date(NoofDays, MonthV, YearV));
                if EmpRec.FindFirst then
                    repeat
                        CurrLeavers += 1;
                    until EmpRec.Next = 0;

                /*
                HRMELE.RESET;
                HRMELE.SETRANGE("Employee No.","No.");
                HRMELE.SETRANGE("Posting Date",PreviousFromMonth,PreviousToDate);
                HRMELE.SETRANGE("Affiliation Type",HRMELE."Affiliation Type"::"1");
                IF HRMELE.FINDLAST THEN BEGIN
                  HRMOldEN := HRMELE."Entry No." - 1;
                  TransferTo += 1;
                END;
                
                HRMELEFrom.RESET;
                HRMELEFrom.SETRANGE("Employee No.","No.");
                HRMELEFrom.SETRANGE("Posting Date",PreviousFromMonth,PreviousToDate);
                HRMELEFrom.SETRANGE(HRMELEFrom."Entry No.",HRMOldEN);
                HRMELEFrom.SETRANGE("Affiliation Type",HRMELEFrom."Affiliation Type"::"1");
                IF HRMELEFrom.FINDLAST THEN BEGIN
                  TransferFrom += 1;
                END;
                
                HRMELEFrom.RESET;
                HRMELEFrom.SETRANGE("Employee No.","No.");
                HRMELEFrom.SETRANGE("Posting Date",PreviousFromMonth,PreviousToDate);
                HRMELEFrom.SETRANGE(HRMELEFrom."Entry No.",HRMOldEN);
                HRMELEFrom.SETRANGE("Affiliation Type",HRMELEFrom."Affiliation Type"::"3");
                IF HRMELEFrom.FINDFIRST THEN REPEAT
                  Reinstate += 1;
                UNTIL HRMELE.NEXT = 0;   */

            end;

            trigger OnPostDataItem()
            begin
                //Moved from Employee group footer
                //CurrReport.ShowOutput := CurrReport.TotalsCausedBy = FieldNo("Global Dimension 1 Code");
                //CurrReport.SHOWOUTPUT := CurrReport.TOTALSCAUSEDBY = FIELDNO("Global Dimension 2 Code");
                ToDisplay := NoofEmpOldP - ToDisplay;
                NoofEmpOldP := ToDisplay;

                ToDispL := Leavers - ToDispL;
                Leavers := ToDispL;

                ToDispJ := Joiners - ToDispJ;
                Joiners := ToDispJ;

                ToDispRein := Reinstate - ToDispRein;
                Reinstate := ToDispRein;

                DispCurrLeavers := CurrLeavers - DispCurrLeavers;
                CurrLeavers := DispCurrLeavers;

                DispTranFr := TransferFrom - DispTranFr;
                TransferFrom := DispTranFr;

                DispTranTo := TransferTo - DispTranTo;
                TransferTo := DispTranTo;

                NoofEmpAsPerC := NoofEmpOldP - TransferTo + TransferFrom - Leavers;
                ExpNoofEmpClos := NoofEmpAsPerC + Reinstate + Joiners - CurrLeavers;
            end;

            trigger OnPreDataItem()
            begin
                I := 1;
                gvAllowedPayrolls.Reset;
                gvAllowedPayrolls.SetRange(gvAllowedPayrolls."User ID", UserId);
                gvAllowedPayrolls.SetRange(gvAllowedPayrolls."Last Active Payroll", true);
                if gvAllowedPayrolls.FindFirst then
                    ActPayrollID := gvAllowedPayrolls."Payroll Code";
                //Moved code from Employee Presection
                MonthV := Date2DMY(DateCm, 2);
                YearV := Date2DMY(DateCm, 3);
                case MonthV of
                    1:
                        NoofDays := 31;
                    2:
                        begin
                            if Date2DMY(DateCm, 3) mod 4 = 0 then
                                NoofDays := 29
                            else
                                NoofDays := 28;
                        end;
                    3:
                        NoofDays := 31;
                    4:
                        NoofDays := 30;
                    5:
                        NoofDays := 31;
                    6:
                        NoofDays := 30;
                    7:
                        NoofDays := 31;
                    8:
                        NoofDays := 31;
                    9:
                        NoofDays := 30;
                    10:
                        NoofDays := 31;
                    11:
                        NoofDays := 30;
                    12:
                        NoofDays := 31;
                end;

                PrevMonthV := Date2DMY(DateCm, 2) - 1;
                case PrevMonthV of
                    1:
                        PrevNoofDays := 31;
                    2:
                        begin
                            if Date2DMY(DateCm, 3) mod 4 = 0 then
                                PrevNoofDays := 29
                            else
                                PrevNoofDays := 28;
                        end;
                    3:
                        PrevNoofDays := 31;
                    4:
                        PrevNoofDays := 30;
                    5:
                        PrevNoofDays := 31;
                    6:
                        PrevNoofDays := 30;
                    7:
                        PrevNoofDays := 31;
                    8:
                        PrevNoofDays := 31;
                    9:
                        PrevNoofDays := 30;
                    10:
                        PrevNoofDays := 31;
                    11:
                        PrevNoofDays := 30;
                    12:
                        PrevNoofDays := 31;
                end;
                if MonthV <> 1 then begin
                    PreviousFromMonth := DMY2Date(1, MonthV - 1, YearV);
                    PreviousToDate := DMY2Date(PrevNoofDays, MonthV - 1, YearV);
                end else begin
                    PreviousFromMonth := DMY2Date(1, 12, YearV - 1);
                    PreviousToDate := DMY2Date(PrevNoofDays, 12, YearV - 1);
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
                    field(DateCm; DateCm)
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
        HRMOldEN: Integer;
        EmpRec: Record Employee;
        PayrollHdr: Record "Payroll Header";
        DateCm: Date;
        CurrentMonth: Date;
        PreviousFromMonth: Date;
        PreviousToDate: Date;
        MonthV: Integer;
        PrevMonthV: Integer;
        YearV: Integer;
        NoofDays: Integer;
        PrevNoofDays: Integer;
        NoofEmpOldP: Integer;
        TransferTo: Integer;
        TransferFrom: Integer;
        DispTranFr: Integer;
        DispTranTo: Integer;
        ToDisplay: Integer;
        I: Integer;
        Leavers: Integer;
        ToDispL: Integer;
        Joiners: Integer;
        ToDispJ: Integer;
        Reinstate: Integer;
        ToDispRein: Integer;
        CurrLeavers: Integer;
        DispCurrLeavers: Integer;
        NoofEmpAsPerC: Integer;
        ExpNoofEmpClos: Integer;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        MembershipNumbers: Record "Membership Numbers";
        gvPinNo: Code[20];
        ActPayrollID: Code[20];
        DEPTCaptionLbl: Label 'DEPT';
        Transfer_ToCaptionLbl: Label 'Transfer To';
        Transfer_FromCaptionLbl: Label 'Transfer From';
        Reinstated_for_Final_DuesCaptionLbl: Label 'Reinstated for Final Dues';
        Expected_No__of_Emp_as_at_closing_of_payrollCaptionLbl: Label 'Expected No. of Emp as at closing of payroll';

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

