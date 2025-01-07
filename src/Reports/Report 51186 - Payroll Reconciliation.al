report 51186 "Payroll Reconciliation"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Payroll Reconciliation.rdl';

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(OpenBal; OpenBal)
            {
            }
            column(AddJoiBP; AddJoiBP)
            {
            }
            column(EmptyString; '')
            {
            }
            column(LeftBP; LeftBP)
            {
            }
            column(CloseBal; CloseBal)
            {
            }
            column(EmpCount1; EmpCount1)
            {
            }
            column(AddJoin; AddJoin)
            {
            }
            column(DedLeav; DedLeav)
            {
            }
            column(TotalCloseBalE; TotalCloseBalE)
            {
            }
            column(Basic_PayCaption; Basic_PayCaptionLbl)
            {
            }
            column(Number_of_EmployeesCaption; Number_of_EmployeesCaptionLbl)
            {
            }
            column(Opening_BalanceCaption; Opening_BalanceCaptionLbl)
            {
            }
            column(Add__JoinersCaption; Add__JoinersCaptionLbl)
            {
            }
            column(Add__Salary_ReviewsCaption; Add__Salary_ReviewsCaptionLbl)
            {
            }
            column(Less__LeaversCaption; Less__LeaversCaptionLbl)
            {
            }
            column(Closing_BalanceCaption; Closing_BalanceCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            var
                lvPeriod: Record Periods;
                lvLastDateLastMonth: Date;
                lvLastDateThisMonth: Date;
            begin
                //Moved from Presection Body for rtc
                MonthV := Date2DMY(StartDate, 2);
                Yearv := Date2DMY(StartDate, 3);
                case MonthV of
                    1:
                        NoofDays := 31;
                    2:
                        begin
                            if Date2DMY(StartDate, 3) mod 4 = 0 then
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
                Clear(EmpCount1);

                lvLastDateLastMonth := CalcDate('-CM', StartDate);
                lvLastDateLastMonth -= 1;
                lvLastDateThisMonth := CalcDate('CM', StartDate);

                gvAllowedPayrolls.Reset;
                gvAllowedPayrolls.SetRange(gvAllowedPayrolls."User ID", UserId);
                gvAllowedPayrolls.SetRange(gvAllowedPayrolls."Last Active Payroll", true);
                if gvAllowedPayrolls.FindFirst then
                    ActPayrollID := gvAllowedPayrolls."Payroll Code";

                //get the payroll period prior to this month
                lvPeriod.Reset;
                lvPeriod.SetCurrentKey("Period Year", lvPeriod."Period Month");
                lvPeriod.SetRange("Payroll Code", ActPayrollID);
                if Date2DMY(StartDate, 2) <> 1 then begin
                    //PayrollHeader1.SETRANGE("Payroll Month",1,DATE2DMY(StartDate,2)-1);
                    lvPeriod.SetRange("Period Year", Date2DMY(StartDate, 3));
                    lvPeriod.SetRange("Period Month", Date2DMY(StartDate, 2) - 1);
                end else begin
                    lvPeriod.SetRange("Period Year", Date2DMY(StartDate, 3) - 1);
                    lvPeriod.SetRange("Period Month", 1, 12);
                end;
                lvPeriod.FindFirst;

                //Opening Bal as at the payroll of last month
                PayrollHeader1.Reset;
                PayrollHeader1.SetRange("Payroll Code", ActPayrollID);
                PayrollHeader1.SetRange("Payroll ID", lvPeriod."Period ID");
                if PayrollHeader1.FindFirst then
                    repeat
                        OpenBal += PayrollHeader1."Basic Pay";
                    until PayrollHeader1.Next = 0;

                //get the employee as at end of active last month
                EmpRec.Reset;
                EmpRec.SetRange(EmpRec."Payroll Code", ActPayrollID);
                EmpRec.SetFilter(EmpRec."Employment Date", '<>%1|<=%2', 0D, lvLastDateLastMonth);
                EmpRec.SetFilter(EmpRec."Termination Date", '%1|>%2', 0D, lvLastDateLastMonth);
                EmpCount1 := EmpRec.Count;

                // newly employed
                //get the payroll period for this month
                lvPeriod.Reset;
                lvPeriod.SetCurrentKey("Period Year", lvPeriod."Period Month");
                lvPeriod.SetRange("Payroll Code", ActPayrollID);
                lvPeriod.SetRange("Period Year", Date2DMY(StartDate, 3));
                lvPeriod.SetRange("Period Month", Date2DMY(StartDate, 2));
                lvPeriod.FindFirst;

                //add joiners
                EmpRec.Reset;
                EmpRec.SetRange(EmpRec."Payroll Code", ActPayrollID);
                EmpRec.SetFilter(EmpRec."Employment Date", '>%1&<=%2', lvLastDateLastMonth, lvLastDateThisMonth);
                if EmpRec.FindFirst then
                    repeat
                        PayrollHeader.Reset;
                        PayrollHeader.SetRange(PayrollHeader."Payroll ID", lvPeriod."Period ID");
                        PayrollHeader.SetRange("Payroll Code", lvPeriod."Payroll Code");
                        PayrollHeader.SetRange("Employee no.", EmpRec."No.");
                        if PayrollHeader.FindFirst then
                            repeat
                                AddJoiBP += PayrollHeader."Basic Pay";
                            until PayrollHeader.Next = 0;
                        AddJoin += 1;
                    until EmpRec.Next = 0;

                // terminated employees
                EmpRec.Reset;
                EmpRec.SetRange(EmpRec."Payroll Code", ActPayrollID);
                EmpRec.SetFilter(EmpRec."Termination Date", '>%1&<=%2', lvLastDateLastMonth, lvLastDateThisMonth, 0D);
                if EmpRec.FindFirst then
                    repeat
                        PayrollHeader.Reset;
                        PayrollHeader.SetRange(PayrollHeader."Payroll ID", lvPeriod."Period ID");
                        PayrollHeader.SetRange("Payroll Code", lvPeriod."Payroll Code");
                        PayrollHeader.SetRange("Employee no.", EmpRec."No.");
                        if PayrollHeader.FindFirst then
                            repeat
                                LeftBP += PayrollHeader."Basic Pay";
                            until PayrollHeader.Next = 0;
                        DedLeav += 1;
                    until EmpRec.Next = 0;


                //get the employee who are active as at end of this month
                EmpRec.Reset;
                EmpRec.SetRange(EmpRec."Payroll Code", ActPayrollID);
                EmpRec.SetFilter(EmpRec."Employment Date", '<>%1|<=%2', 0D, lvLastDateThisMonth);
                EmpRec.SetFilter(EmpRec."Termination Date", '%1|>%2', 0D, lvLastDateThisMonth);
                TotalCloseBalE := EmpRec.Count;

                //get the closing balance
                PayrollHeader.Reset;
                PayrollHeader.SetRange(PayrollHeader."Payroll ID", lvPeriod."Period ID");
                PayrollHeader.SetRange("Payroll Code", lvPeriod."Payroll Code");
                if PayrollHeader.FindFirst then
                    repeat
                        CloseBal += PayrollHeader."Basic Pay";
                    until PayrollHeader.Next = 0;
                /*
                IF DATE2DMY(StartDate,2) <> 1 THEN BEGIN
                  PayrollHeader.RESET;
                  PayrollHeader.SETRANGE(PayrollHeader."Payroll ID",ActPayrollID);
                  PayrollHeader.SETRANGE("Payroll Month",DATE2DMY(StartDate,2),12);
                  PayrollHeader.SETRANGE("Payroll Year",DATE2DMY(StartDate,3));
                  IF PayrollHeader.FINDFIRST THEN REPEAT
                    NegateOpenBal += PayrollHeader."Basic Pay";
                  UNTIL PayrollHeader.NEXT = 0;
                END;
                OpenBal := OpenBal - NegateOpenBal;
                
                //Closing Balace
                PayrollHeader.RESET;
                PayrollHeader.SETRANGE(PayrollHeader."Payroll ID",lvPeriod."Period ID");
                PayrollHeader.SETRANGE("Payroll Code",lvPeriod."Payroll Code");
                IF PayrollHeader.FINDFIRST THEN REPEAT
                  CloseBalMonth+=PayrollHeader."Basic Pay";
                UNTIL PayrollHeader.NEXT = 0;
                  CloseBal := CloseBalMonth + OpenBal;
                
                */
                /*
                //Newly Employed
                EmpRec.RESET;
                EmpRec.SETRANGE(EmpRec."Payroll Code",ActPayrollID);
                EmpRec.SETFILTER(EmpRec."Employment Date",'<>%1',0D);
                EmpRec.SETRANGE(EmpRec."Employment Date",DMY2DATE(1,DATE2DMY(StartDate,2),DATE2DMY(StartDate,3)),
                DMY2DATE(NoofDays,DATE2DMY(StartDate,2),DATE2DMY(StartDate,3)));
                IF EmpRec.FINDFIRST THEN REPEAT
                  PayrollHeader.RESET;
                  PayrollHeader.SETRANGE(PayrollHeader."Payroll ID",ActPayrollID);
                  PayrollHeader.SETRANGE(PayrollHeader."Employee no.",EmpRec."No.");
                  PayrollHeader.SETRANGE(PayrollHeader."Payroll Month",DATE2DMY(StartDate,2));
                  PayrollHeader.SETRANGE(PayrollHeader."Payroll Year",DATE2DMY(StartDate,3));
                  IF PayrollHeader.FINDFIRST THEN REPEAT
                    AddJoiBP += PayrollHeader."Basic Pay";
                  UNTIL PayrollHeader.NEXT = 0;
                  AddJoin +=1;
                UNTIL EmpRec.NEXT = 0;
                */


                /*
                //Terminated Employees
                EmpRec.RESET;
                EmpRec.SETRANGE(EmpRec."Payroll Code",ActPayrollID);
                EmpRec.SETFILTER(EmpRec."Termination Date",'<>%1',0D);
                EmpRec.SETRANGE(EmpRec."Termination Date",DMY2DATE(1,DATE2DMY(StartDate,2),DATE2DMY(StartDate,3)),
                DMY2DATE(NoofDays,DATE2DMY(StartDate,2),DATE2DMY(StartDate,3)));
                IF EmpRec.FINDFIRST THEN REPEAT
                  PayrollHeader.RESET;
                  PayrollHeader.SETRANGE(PayrollHeader."Payroll ID",ActPayrollID);
                  PayrollHeader.SETRANGE(PayrollHeader."Employee no.",EmpRec."No.");
                  PayrollHeader.SETRANGE(PayrollHeader."Payroll Month",DATE2DMY(StartDate,2));
                  PayrollHeader.SETRANGE(PayrollHeader."Payroll Year",DATE2DMY(StartDate,3));
                  IF PayrollHeader.FINDFIRST THEN REPEAT
                    LeftBP += PayrollHeader."Basic Pay";
                  UNTIL PayrollHeader.NEXT = 0;
                  DedLeav +=1;
                UNTIL EmpRec.NEXT = 0;
                */

            end;

            trigger OnPreDataItem()
            begin
                Clear(OpenBal);
                Clear(NegateOpenBal);
                Clear(AddJoiBP);
                Clear(LeftBP);
                Clear(CloseBalMonth);
                Clear(CloseBal);
                Clear(EmpCount1);
                Clear(AddJoin);
                Clear(DedLeav);
                Clear(CloseBalEmp);
                Clear(TotalCloseBalE);
                Clear(ActPayrollID);
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
                    field(StartDate; StartDate)
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

        if StartDate = 0D then
            Error('Please Specify the Start Date');
    end;

    var
        PayrollHeader: Record "Payroll Header";
        PayrollHeader1: Record "Payroll Header";
        EmpRec: Record Employee;
        StartDate: Date;
        DateVal: Date;
        OpenBal: Decimal;
        NegateOpenBal: Decimal;
        AddJoiBP: Decimal;
        LeftBP: Decimal;
        CloseBalMonth: Decimal;
        CloseBal: Decimal;
        MonthV: Integer;
        NoofDays: Integer;
        EmpCount1: Integer;
        Yearv: Integer;
        EmpCountNeg: Integer;
        AddJoin: Integer;
        DedLeav: Integer;
        CloseBalEmp: Integer;
        TotalCloseBalE: Integer;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        MembershipNumbers: Record "Membership Numbers";
        gvPinNo: Code[20];
        ActPayrollID: Code[20];
        Basic_PayCaptionLbl: Label 'Basic Pay';
        Number_of_EmployeesCaptionLbl: Label 'Number of Employees';
        Opening_BalanceCaptionLbl: Label 'Opening Balance';
        Add__JoinersCaptionLbl: Label 'Add: Joiners';
        Add__Salary_ReviewsCaptionLbl: Label 'Add: Salary Reviews';
        Less__LeaversCaptionLbl: Label 'Less: Leavers';
        Closing_BalanceCaptionLbl: Label 'Closing Balance';

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

