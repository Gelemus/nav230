codeunit 51153 "Calculate One Payroll"
{
    Permissions = TableData "Payroll Header" = rm,
                  TableData "Payroll Lines" = rimd,
                  TableData "Loan Entry" = rm;
    TableNo = "Payroll Header";

    trigger OnRun()
    var
        lvPayrollDim: Record "Payroll Dimension";
    begin
        gvPayrollUtilities.sGetActivePayroll(gvAllowedPayrolls);
        // "A (LCY)" := 0;
        // "B (LCY)" := 0;
        // "C (LCY)" := 0;
        // "D (LCY)" := 0;
        // "E1 (LCY)" := 0;
        // "E2 (LCY)" := 0;
        // "E3 (LCY)" := 0;
        // "F (LCY)" := 0;
        // "G (LCY)" := 0;
        // "H (LCY)" := 0;
        // "J (LCY)" := 0;
        // "K (LCY)" := 0;
        // "L (LCY)" := 0;
        // "M (LCY)" := 0;

        // Period := "Payroll ID";
        // PeriodRec.Get("Payroll ID", "Payroll Month","Payroll Year", "Payroll Code");
        PeriodInterest := PeriodRec."Low Interest Benefit %";
        gvPostingDate := PeriodRec."Posting Date";


        if EntryLines.Find('+') then
            EntryLineNo := EntryLines."Entry No.";

        EntryLines.SetCurrentKey("Payroll ID", "Employee No.", "ED Code", "Loan Entry", "Basic Pay Entry", "Time Entry");
        // EntryLines.SetRange("Payroll ID","Payroll ID");
        // EntryLines.SetRange("Employee No.","Employee no.");
        EntryLines.SetRange("Loan Entry", true);
        EntryLines.DeleteAll(true);
        EntryLines.SetRange("Loan Entry");

        EntryLines.SetRange("Basic Pay Entry", true);
        EntryLines.DeleteAll(true);
        EntryLines.SetRange("Basic Pay Entry");

        EntryLines.SetRange("Time Entry", true);
        EntryLines.DeleteAll(true);
        EntryLines.SetRange("Time Entry");

        //ICS synchronize payroll header and employee dimensions for dimensions amended after creation of header
        lvPayrollDim.SetRange("Table ID", DATABASE::"Payroll Header");
        // lvPayrollDim.SetRange("Employee No", "Employee no.");
        // lvPayrollDim.SetRange("Payroll ID", "Payroll ID");
        lvPayrollDim.DeleteAll;
        gvPayrollUtilities.sGetDefaultEmpDims(Rec);
        //ICS end

        GetLoans(Rec);
        GetBasicPay(Rec);
        GetTime(Rec);
        GetCommission(Rec);

        //V.6.1.65_07SEP10 >>
        // if "Employee no." <> '' then
        //   Emp.Get("Employee no.");
        if Emp."Customer No." <> '' then begin
            Cust.SetCurrentKey("Customer No.", "Posting Date", "Currency Code");
            Cust.SetRange(Cust."Customer No.", Emp."Customer No.");
            Cust.SetFilter(Cust."On Hold", '%1', '');
            if Cust.FindSet then
                repeat
                    Cust.CalcFields(Cust."Remaining Amt. (LCY)");
                    OutStandingAmt += Cust."Remaining Amt. (LCY)";
                until Cust.Next = 0;
            if OutStandingAmt > 0 then
                PersonalACRecoveries(Rec);
        end;
        //V.6.1.65_07SEP10 <<

        GetInfo;
        // Employee.Get("Employee no.");
        BringFWDrounding;

        Scheme := Employee."Calculation Scheme";
        SchemeControlTmp.SetRange("Scheme ID", Employee."Calculation Scheme");
        SchemeValueTmp.SetRange("Scheme ID", Employee."Calculation Scheme");
        SchemeValueTmp.ModifyAll(Amount, 0);
        SchemeValueTmp.ModifyAll("Amount (LCY)", 0);

        //SKM050505 Special Allowances & Payments Management
        SchemeControlTmp.SetRange("Special Allowance", true);
        SchemeControlTmp.ModifyAll("Special Allowance Calculated", false);
        SchemeControlTmp.SetFilter("Special Allowance", '');

        SchemeControlTmp.SetRange("Special Payment", true);
        SchemeControlTmp.ModifyAll("Special Payment Calculated", false);
        SchemeControlTmp.SetFilter("Special Payment", '');
        //End SKM050505 Special Allowance Management

        SchemeControlTmp.Find('-');
        repeat
            //V.6.1.65_10SEP10 >>
            if (not SchemeControlTmp."Annualize TAX") and (not SchemeControlTmp."Annualize Relief") then begin
                Flag := false;
                Clear(gvPayrollHeader);
                //gvPayrollHeader.Get("Payroll ID",Employee."No.");
                //V.6.1.65_10SEP10 <<
                LineNo := SchemeControlTmp."Line No.";
                GetInput(Rec);

                if (SchemeControlTmp."Special Allowance") and (not SchemeControlTmp."Special Allowance Calculated")
                   then
                    GetSpecialAllowance(Rec);

                if (SchemeControlTmp."Special Payment") and (not SchemeControlTmp."Special Payment Calculated")
                   then
                    GetSpecialPayments(Rec);

                RoundAmount;
                Calculate(Rec);
                Output(Rec);
            end else begin
                PeriodRec.Get(PayrollHeader."Payroll ID", PayrollHeader."Payroll Month",
                PayrollHeader."Payroll Year", PayrollHeader."Payroll Code");
                if (PeriodRec."Annualize TAX") then begin //V.6.1.65_10SEP10 >>
                    Flag := false;
                    Clear(gvPayrollHeader);
                    // gvPayrollHeader.Get("Payroll ID",Employee."No.");

                    LineNo := SchemeControlTmp."Line No.";
                    GetInput(Rec);

                    if (SchemeControlTmp."Special Allowance") and (not SchemeControlTmp."Special Allowance Calculated")
                       then
                        GetSpecialAllowance(Rec);

                    if (SchemeControlTmp."Special Payment") and (not SchemeControlTmp."Special Payment Calculated")
                       then
                        GetSpecialPayments(Rec);

                    RoundAmount;
                    if SchemeControlTmp."Annualize TAX" then
                        if BeforeReliefAmt = 0 then
                            BeforeReliefAmt := Amount1LCY;

                    Calculate(Rec);
                    Output(Rec);
                end;
            end; //V.6.1.65_10SEP10 >>
        until SchemeControlTmp.Next = 0;
        // Calculated := true;
        // if "M (LCY)" < 0 then  "M (LCY)" := 0;
        FlushTmp(Rec);
        //gvPayrollUtilities.sAllocatePayroll(Period, gvAllowedPayrolls."Payroll Code", "Employee no.");
    end;

    var
        SchemeControlTmp: Record "Calculation Scheme" temporary;
        SchemeValueTmp: Record "Calculation Scheme" temporary;
        EntryLines: Record "Payroll Entry";
        EntryLinesTMP: Record "Payroll Entry" temporary;
        PayrollLinesTmp: Record "Payroll Lines" temporary;
        EDDefinitionTmp: Record "ED Definitions" temporary;
        Employee: Record Employee;
        PayrollLinesTmpLineNo: Integer;
        Amount: Decimal;
        "Amount (LCY)": Decimal;
        Amount1: Decimal;
        Amount1LCY: Decimal;
        Cum: Decimal;
        Percent: Decimal;
        PeriodInterest: Decimal;
        Scheme: Code[20];
        Period: Code[10];
        LineNo: Integer;
        EntryLineNo: Integer;
        Quantity: Decimal;
        PeriodRec: Record Periods;
        PayrollHeader: Record "Payroll Header";
        gvLineNo2: Integer;
        gvPostingDate: Date;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        gvPayrollUtilities: Codeunit "Payroll Posting";
        gvCurrExchRate: Record "Currency Exchange Rate";
        gvCurrency: Record Currency;
        PayrollSetup: Record "Payroll Setups";
        "-- V.6.1.65 ---": Integer;
        Cust: Record "Cust. Ledger Entry";
        Emp: Record Employee;
        OutStandingAmt: Decimal;
        gvPayrollHeader: Record "Payroll Header";
        Flag: Boolean;
        Flag1: Boolean;
        AnnualReliefAmt: Decimal;
        BeforeReliefAmt: Decimal;
        AllowedPayrolls2: Record "Allowed Payrolls";
        myPayrollCode: Code[20];
        myPeriod: Record Periods;
        myDate: Date;
        myMonth: Integer;
        myYear: Integer;
        myPeriodHrs: Decimal;
        myPeriodDays: Decimal;
        lvPayrollPeriod: Integer;

    procedure GetLoans(var Header: Record "Payroll Header")
    var
        LoanEntryRec: Record "Loan Entry";
        LoanRec: Record "Loans/Advances";
        LoanTypeRec: Record "Loan Types";
        PayrollSetupRec: Record "Payroll Setups";
        BenefitInterest: Decimal;
    begin
        LoanEntryRec.SetCurrentKey("Loan ID", Employee, Period, "Transfered To Payroll", Posted);
        LoanEntryRec.SetRange(Employee, Header."Employee no.");
        LoanEntryRec.SetRange(Period, Period);
        LoanEntryRec.SetRange(Posted, false);

        if LoanEntryRec.Find('-') then begin

            repeat
                LoanRec.Get(LoanEntryRec."Loan ID");

                if LoanRec."Paid to Employee" then begin
                    EntryLineNo := EntryLineNo + 1;
                    LoanTypeRec.Get(LoanRec."Loan Types");

                    EntryLines."Entry No." := EntryLineNo;
                    EntryLines."Payroll ID" := Period;
                    EntryLines."Employee No." := Header."Employee no.";
                    EntryLines.Date := gvPostingDate;
                    EntryLines.Validate("ED Code", LoanTypeRec."Loan E/D Code");
                    EntryLines.Validate("Currency Code", LoanRec."Currency Code");
                    EntryLines.Quantity := 0;
                    EntryLines.Validate(Rate, 0);
                    EntryLines.Validate(Amount, LoanEntryRec.Interest + LoanEntryRec.Repayment);
                    EntryLines."Copy to next" := false;
                    EntryLines."Reset Amount" := false;
                    EntryLines.Editable := true;
                    EntryLines."Loan ID" := LoanEntryRec."Loan ID";
                    EntryLines.Validate(Interest, LoanEntryRec.Interest);
                    EntryLines.Validate(Repayment, LoanEntryRec.Repayment);
                    EntryLines.Validate("Remaining Debt", LoanEntryRec."Remaining Debt");
                    EntryLines.Validate(Paid, LoanRec.Principal - LoanEntryRec."Remaining Debt");
                    EntryLines."Loan Entry" := true;
                    EntryLines."Basic Pay Entry" := false;
                    EntryLines."Time Entry" := false;
                    EntryLines."Loan Entry No" := LoanEntryRec."No.";
                    EntryLines."Payroll Code" := gvAllowedPayrolls."Payroll Code";
                    EntryLines.Insert;

                    if LoanEntryRec."Calc Benefit Interest" then begin
                        BenefitInterest := (LoanEntryRec.Repayment + LoanEntryRec."Remaining Debt") * PeriodInterest / 12 / 100;
                        case LoanTypeRec.Rounding of
                            LoanTypeRec.Rounding::Nearest:
                                BenefitInterest := Round(BenefitInterest, LoanTypeRec."Rounding Precision", '=');
                            LoanTypeRec.Rounding::Up:
                                BenefitInterest := Round(BenefitInterest, LoanTypeRec."Rounding Precision", '>');
                            LoanTypeRec.Rounding::Down:
                                BenefitInterest := Round(BenefitInterest, LoanTypeRec."Rounding Precision", '<');
                        end;
                    end;

                    if BenefitInterest > LoanEntryRec.Interest then begin
                        PayrollSetupRec.Get(LoanEntryRec."Payroll Code");
                        EntryLineNo := EntryLineNo + 1;
                        EntryLines."Entry No." := EntryLineNo;
                        EntryLines."Payroll ID" := Period;
                        EntryLines."Employee No." := Header."Employee no.";
                        EntryLines.Date := gvPostingDate;
                        EntryLines.Validate("ED Code", PayrollSetupRec."Interest Benefit");
                        EntryLines.Validate("Currency Code", LoanRec."Currency Code");
                        EntryLines.Quantity := 0;
                        EntryLines.Validate(Rate, 0);
                        EntryLines.Validate(Amount, BenefitInterest - LoanEntryRec.Interest);
                        EntryLines."Copy to next" := false;
                        EntryLines."Reset Amount" := false;
                        EntryLines.Editable := false;
                        EntryLines."Loan ID" := LoanEntryRec."Loan ID";
                        EntryLines.Validate(Interest, 0);
                        EntryLines.Validate(Repayment, 0);
                        EntryLines.Validate("Remaining Debt", 0);
                        EntryLines.Validate(Paid, 0);
                        EntryLines."Loan Entry" := true;
                        EntryLines."Basic Pay Entry" := false;
                        EntryLines."Time Entry" := false;
                        EntryLines."Loan Entry No" := LoanEntryRec."No.";
                        EntryLines."Payroll Code" := gvAllowedPayrolls."Payroll Code";
                        EntryLines.Insert;
                    end;

                    LoanEntryRec."Transfered To Payroll" := true;
                    LoanEntryRec.Modify;
                end;
            until LoanEntryRec.Next = 0;
        end;
    end;

    procedure GetTime(var Header: Record "Payroll Header")
    var
        TimeregRec: Record "Employee Absence";
        TimeRegTypesRec: Record "Cause of Absence";
        PeriodRec: Record Periods;
        PayrollSetup: Record "Payroll Setups";
        EmployeeRec: Record Employee;
        lvEDDef: Record "ED Definitions";
        lvPayrollPeriod: Record Periods;
        lvActiveSession: Record "Active Session";
    begin
        /*PeriodRec.GET(Header."Payroll ID", Header."Payroll Month", Header."Payroll Year", Header."Payroll Code");
        TimeregRec.SETRANGE("Employee No.",Header."Employee no.");
        EmployeeRec.GET(Header."Employee no.");
        TimeregRec.SETRANGE("Charge Date",PeriodRec."Start Date",PeriodRec."End Date");
        TimeregRec.SETRANGE(TimeregRec."Transfer to Payroll",TRUE);
        
        IF TimeregRec.FIND('-') THEN BEGIN
          REPEAT
            TimeRegTypesRec.GET(TimeregRec."Cause of Absence Code");
            IF TimeRegTypesRec."Transfer to Payroll" THEN BEGIN
              EntryLineNo := EntryLineNo + 1;
              EntryLines."Entry No." := EntryLineNo;
              EntryLines."Payroll ID" := Period;
              EntryLines."Employee No." := Header."Employee no.";
              EntryLines.VALIDATE("ED Code", TimeRegTypesRec."E/D Code");
              EntryLines.VALIDATE("Currency Code", EmployeeRec."Basic Pay Currency");
              EntryLines.Quantity := TimeregRec.Quantity;
              PayrollSetup.GET(Header."Payroll Code");
        
              //get active session 181213 cmm
              lvActiveSession.RESET;
              lvActiveSession.SETRANGE("Server Instance ID",SERVICEINSTANCEID);
              lvActiveSession.SETRANGE("Session ID",SESSIONID);
              lvActiveSession.FINDFIRST;
        
              AllowedPayrolls2.SETRANGE("User ID", lvActiveSession."User ID");
              AllowedPayrolls2.SETRANGE("Last Active Payroll",TRUE);
              IF AllowedPayrolls2.FINDFIRST THEN
                myPayrollCode := AllowedPayrolls2."Payroll Code";
        
              myMonth := DATE2DMY (TimeregRec."From Date",2);
              myYear :=  DATE2DMY (TimeregRec."From Date",3);
              myDate := DMY2DATE (1,myMonth,myYear);
        
              //cmm added 21052013 check the start date on payroll period
              lvPayrollPeriod.SETRANGE("Period ID", Header."Payroll ID");
              lvPayrollPeriod.SETRANGE("Payroll Code", Header."Payroll Code");
              lvPayrollPeriod.FINDFIRST;
        
              myPeriod.SETRANGE (myPeriod."Start Date",lvPayrollPeriod."Start Date");
              //end cmm
              //myPeriod.SETRANGE (myPeriod."Start Date",myDate);  //cmm commented 2010513
              myPeriod.SETFILTER (myPeriod."Payroll Code",myPayrollCode);
              IF myPeriod.FINDFIRST THEN BEGIN
                IF myPeriod.Hours <> 0 THEN BEGIN
                  myPeriodHrs := myPeriod.Hours;
                  myPeriodDays := myPeriod.Days;
                END;
              END;
              IF myPeriodHrs = 0
                THEN ERROR ('Period must have hours');
              IF myPeriodDays = 0
                THEN ERROR ('Period must have Days');
        
              IF TimeregRec."Day/Hour" = 0 THEN
                EntryLines.VALIDATE(Rate, Header."Day Rate")
              ELSE
                EntryLines.VALIDATE(Rate, Header."Hour Rate");
        
              IF TimeRegTypesRec.Percent >= 0 THEN EntryLines.Rate := EntryLines.Rate * TimeRegTypesRec.Percent / 100;
              lvEDDef.GET(TimeRegTypesRec."E/D Code");
              IF lvEDDef."Overtime ED" THEN BEGIN
                lvEDDef.TESTFIELD("Overtime ED Weight");
                EntryLines.Rate := EntryLines.Rate * lvEDDef."Overtime ED Weight"
              END;
        
              EntryLines.VALIDATE(Amount, EntryLines.Rate * EntryLines.Quantity);
              EntryLines."Copy to next" := FALSE;
              EntryLines."Reset Amount" := FALSE;
              EntryLines.Date := gvPostingDate;
              EntryLines.Editable := FALSE;
              EntryLines."Loan ID" := 0;
              EntryLines.VALIDATE(Interest, 0);
              EntryLines.VALIDATE(Repayment, 0);
              EntryLines.VALIDATE("Remaining Debt", 0);
              EntryLines.VALIDATE(Paid, 0);
              EntryLines."Loan Entry" := FALSE;
              EntryLines."Loan Entry No" := 0;
              EntryLines."Basic Pay Entry" := FALSE;
              EntryLines."Time Entry" := TRUE;
              EntryLines."Payroll Code" := gvAllowedPayrolls."Payroll Code";
              EntryLines.INSERT;
              TimeregRec.Transferred := TRUE;
              TimeregRec.MODIFY;
             END;
          UNTIL TimeregRec.NEXT = 0;
        END;*/

    end;

    procedure GetBasicPay(var Header: Record "Payroll Header") BasicPay: Decimal
    var
        EmployeeRec: Record Employee;
        PeriodRec: Record Periods;
        ScaleStepRec: Record "Salary Scale Step";
        PayrollSetupRec: Record "Payroll Setups";
        BasicPayAmount: Decimal;
        BasicHourRateAmount: Decimal;
        BasicDayRateAmount: Decimal;
        AbsentDays: Integer;
        DaysEmployed: Integer;
    begin
        EmployeeRec.Get(Header."Employee no.");
        if EmployeeRec."Basic Pay" = EmployeeRec."Basic Pay"::" " then exit;

        PayrollSetupRec.Get(Header."Payroll Code");

        PeriodRec.Get(Header."Payroll ID", Header."Payroll Month", Header."Payroll Year", Header."Payroll Code");
        PeriodRec.TestField(Hours);
        PeriodRec.TestField(Days);

        BasicPayAmount := 0;
        BasicHourRateAmount := 0;
        BasicDayRateAmount := 0;

        if (EmployeeRec."Employment Date" > PeriodRec."Start Date") and
           (EmployeeRec."Employment Date" <= PeriodRec."End Date") then begin
            DaysEmployed := (PeriodRec."End Date" - EmployeeRec."Employment Date") + 1;
        end;

        case EmployeeRec."Basic Pay" of
            EmployeeRec."Basic Pay"::None:
                begin
                    if EmployeeRec."Hourly Rate" <> 0 then begin
                        BasicPayAmount := EmployeeRec."Hourly Rate";
                        BasicHourRateAmount := BasicPayAmount * PeriodRec.Hours;
                    end;
                    if EmployeeRec."Daily Rate" <> 0 then begin
                        BasicPayAmount := EmployeeRec."Daily Rate";
                        BasicDayRateAmount := BasicPayAmount * PeriodRec.Days;
                    end;
                end;
            EmployeeRec."Basic Pay"::Fixed:
                begin
                    BasicPayAmount := EmployeeRec."Fixed Pay";
                    BasicHourRateAmount := BasicPayAmount / PeriodRec.Hours;
                    BasicDayRateAmount := BasicPayAmount / PeriodRec.Days;
                end;
            EmployeeRec."Basic Pay"::Scale:
                begin
                    ScaleStepRec.Get(EmployeeRec."Scale Step", EmployeeRec."Salary Scale");
                    if ScaleStepRec."Currency Code" <> EmployeeRec."Basic Pay Currency" then
                        Error('Salary Scale %1 step %2 is not in the basic pay currency of employee %3', EmployeeRec."Salary Scale",
                          EmployeeRec."Scale Step", EmployeeRec."No.");
                    BasicPayAmount := ScaleStepRec.Amount;
                    BasicHourRateAmount := BasicPayAmount / PeriodRec.Hours;
                    BasicDayRateAmount := BasicPayAmount / PeriodRec.Days;
                end;
        end;

        if BasicDayRateAmount > 0 then begin
            case PayrollSetupRec."Daily Rate Rounding" of
                PayrollSetupRec."Daily Rate Rounding"::Up:
                    BasicDayRateAmount := Round(BasicDayRateAmount, PayrollSetupRec."Daily Rounding Precision", '>');
                PayrollSetupRec."Daily Rate Rounding"::Down:
                    BasicDayRateAmount := Round(BasicDayRateAmount, PayrollSetupRec."Daily Rounding Precision", '<');
                PayrollSetupRec."Daily Rate Rounding"::Nearest:
                    BasicDayRateAmount := Round(BasicDayRateAmount, PayrollSetupRec."Daily Rounding Precision", '=');
            end;
        end;

        if BasicHourRateAmount > 0 then begin
            case PayrollSetupRec."Hourly Rate Rounding" of
                PayrollSetupRec."Hourly Rate Rounding"::Up:
                    BasicHourRateAmount := Round(BasicHourRateAmount, PayrollSetupRec."Hourly Rounding Precision", '>');
                PayrollSetupRec."Hourly Rate Rounding"::Down:
                    BasicHourRateAmount := Round(BasicHourRateAmount, PayrollSetupRec."Hourly Rounding Precision", '<');
                PayrollSetupRec."Hourly Rate Rounding"::Nearest:
                    BasicHourRateAmount := Round(BasicHourRateAmount, PayrollSetupRec."Hourly Rounding Precision", '=');
            end;
        end;

        if DaysEmployed <> 0 then BasicPayAmount := DaysEmployed * BasicDayRateAmount;
        Header."Basic Pay" := BasicPayAmount;
        Header."Hour Rate" := BasicHourRateAmount;
        Header."Day Rate" := BasicDayRateAmount;
        if EmployeeRec."Basic Pay Currency" <> '' then begin
            Header."Basic Pay Currency Code" := EmployeeRec."Basic Pay Currency";
            Header."Basic Pay Currency Factor" :=
              gvCurrExchRate.ExchangeRate(gvPostingDate, EmployeeRec."Basic Pay Currency");
            gvCurrency.Get(EmployeeRec."Basic Pay Currency");
            Header."Basic Pay (LCY)" := Round(gvCurrExchRate.ExchangeAmtFCYToLCY(gvPostingDate,
              gvCurrency.Code, BasicPayAmount, Header."Basic Pay Currency Factor"), gvCurrency."Unit-Amount Rounding Precision");
            Header."Hour Rate (LCY)" := Round(gvCurrExchRate.ExchangeAmtFCYToLCY(gvPostingDate,
              gvCurrency.Code, BasicHourRateAmount, Header."Basic Pay Currency Factor"), gvCurrency."Unit-Amount Rounding Precision");
            Header."Day Rate (LCY)" := Round(gvCurrExchRate.ExchangeAmtFCYToLCY(gvPostingDate,
              gvCurrency.Code, BasicDayRateAmount, Header."Basic Pay Currency Factor"), gvCurrency."Unit-Amount Rounding Precision");
        end else begin
            Header."Basic Pay (LCY)" := BasicPayAmount;
            Header."Hour Rate (LCY)" := BasicHourRateAmount;
            Header."Day Rate (LCY)" := BasicDayRateAmount;
        end;
        //skm240807 commented line gave record modified by another user error
        //Header.MODIFY;

        EntryLineNo := EntryLineNo + 1;
        EntryLines."Entry No." := EntryLineNo;
        EntryLines."Payroll ID" := Period;
        EntryLines."Employee No." := Header."Employee no.";
        EntryLines.Validate("ED Code", PayrollSetupRec."Basic Pay E/D Code");
        EntryLines.Date := gvPostingDate;
        EntryLines.Validate("Currency Code", EmployeeRec."Basic Pay Currency");
        EntryLines.Quantity := 0;
        EntryLines.Validate(Rate, 0);
        EntryLines.Validate(Amount, BasicPayAmount);
        EntryLines."Copy to next" := false;
        EntryLines."Reset Amount" := false;
        EntryLines.Editable := false;
        EntryLines."Loan ID" := 0;
        EntryLines.Validate(Interest, 0);
        EntryLines.Validate(Repayment, 0);
        EntryLines.Validate("Remaining Debt", 0);
        EntryLines.Validate(Paid, 0);
        EntryLines."Loan Entry" := false;
        EntryLines."Loan Entry No" := 0;
        EntryLines."Basic Pay Entry" := true;
        EntryLines."Time Entry" := false;
        EntryLines."Payroll Code" := gvAllowedPayrolls."Payroll Code";
        EntryLines.Insert;
    end;

    procedure GetInfo()
    var
        CalcScheme: Record "Calculation Scheme";
        EDDefinition: Record "ED Definitions";
    begin
        CalcScheme.Find('-');
        repeat
            SchemeControlTmp.Copy(CalcScheme);
            SchemeControlTmp.Insert;
            SchemeValueTmp.Copy(CalcScheme);
            SchemeValueTmp.Insert;
        until CalcScheme.Next = 0;

        EDDefinition.Find('-');
        repeat
            EDDefinitionTmp.Copy(EDDefinition);
            EDDefinitionTmp.Insert;
        until EDDefinition.Next = 0;
    end;

    procedure GetInput(var Header: Record "Payroll Header")
    var
        InterestAmount: Decimal;
        RemainingDebt: Decimal;
        PaidAmount: Decimal;
        RepaymentAmount: Decimal;
        InterestAmountLCY: Decimal;
        RemainingDebtLCY: Decimal;
        PaidAmountLCY: Decimal;
        RepaymentAmountLCY: Decimal;
        "---V.6.1.65---": Integer;
        lvPayrollHeader: Record "Payroll Header";
        lvAmount: Decimal;
        lvAmountLCY: Decimal;
    begin
        case SchemeControlTmp.Input of
            SchemeControlTmp.Input::"Calculation Line":
                begin
                    SchemeValueTmp.Get(SchemeControlTmp."Caculation Line", Scheme);
                    Amount := SchemeValueTmp.Amount;
                    "Amount (LCY)" := SchemeValueTmp."Amount (LCY)";
                    SchemeValueTmp.Get(LineNo, Scheme);
                    SchemeValueTmp.Amount := Amount;
                    SchemeValueTmp."Amount (LCY)" := "Amount (LCY)";
                    SchemeValueTmp.Modify;
                end;

            SchemeControlTmp.Input::"Payroll Entry":
                begin
                    EDDefinitionTmp.Get(SchemeControlTmp."Payroll Entry");

                    if (not EDDefinitionTmp."Sum Payroll Entries") and
                       (SchemeControlTmp."Payroll Entry" = SchemeControlTmp."Payroll Lines") then begin
                        SchemeControlTmp.Multiline := true;
                        SchemeControlTmp.Modify;
                    end;

                    EntryLines.SetRange("ED Code", SchemeControlTmp."Payroll Entry");

                    if EntryLines.Find('-') then begin
                        Amount := 0;
                        Quantity := 0;
                        InterestAmount := 0;
                        RemainingDebt := 0;
                        PaidAmount := 0;
                        RepaymentAmount := 0;

                        "Amount (LCY)" := 0;
                        InterestAmountLCY := 0;
                        RemainingDebtLCY := 0;
                        PaidAmountLCY := 0;
                        RepaymentAmountLCY := 0;

                        if SchemeControlTmp.Multiline then EntryLinesTMP.DeleteAll(true);

                        repeat
                            if SchemeControlTmp.Multiline then begin
                                EntryLinesTMP.Copy(EntryLines);
                                case SchemeControlTmp.Round of
                                    SchemeControlTmp.Round::Up:
                                        begin
                                            EntryLinesTMP.Amount := Round(EntryLinesTMP.Amount, SchemeValueTmp."Round Precision", '>');
                                            EntryLinesTMP."Amount (LCY)" := Round(EntryLinesTMP."Amount (LCY)", SchemeValueTmp."Round Precision", '>');
                                        end;

                                    SchemeControlTmp.Round::Down:
                                        begin
                                            EntryLinesTMP.Amount := Round(EntryLinesTMP.Amount, SchemeValueTmp."Round Precision", '<');
                                            EntryLinesTMP."Amount (LCY)" := Round(EntryLinesTMP."Amount (LCY)", SchemeValueTmp."Round Precision", '<');
                                        end;

                                    SchemeControlTmp.Round::Nearest:
                                        begin
                                            EntryLinesTMP.Amount := Round(EntryLinesTMP.Amount, SchemeValueTmp."Round Precision", '=');
                                            EntryLinesTMP."Amount (LCY)" := Round(EntryLinesTMP."Amount (LCY)", SchemeValueTmp."Round Precision", '=');
                                        end;
                                end;

                                EntryLinesTMP.Validate("ED Code");
                                EntryLinesTMP.Insert;
                            end;

                            InterestAmount += EntryLines.Interest;
                            RemainingDebt += EntryLines."Remaining Debt";
                            PaidAmount += EntryLines.Paid;
                            RepaymentAmount += EntryLines.Repayment;

                            InterestAmountLCY += EntryLines."Interest (LCY)";
                            RemainingDebtLCY += EntryLines."Remaining Debt (LCY)";
                            PaidAmountLCY += EntryLines."Paid (LCY)";
                            RepaymentAmountLCY += EntryLines."Repayment (LCY)";

                            Amount += EntryLines.Amount;
                            "Amount (LCY)" += EntryLines."Amount (LCY)";
                            Quantity += EntryLines.Quantity;
                        until EntryLines.Next = 0;

                        SchemeValueTmp.Get(LineNo, Scheme);
                        SchemeValueTmp.Amount := Amount;
                        SchemeValueTmp."Amount (LCY)" := "Amount (LCY)";
                        SchemeValueTmp.Quantity := Quantity;
                        SchemeValueTmp.Interest := InterestAmount;
                        SchemeValueTmp."Interest (LCY)" := InterestAmountLCY;
                        SchemeValueTmp.Repayment := RepaymentAmount;
                        SchemeValueTmp."Repayment (LCY)" := RepaymentAmountLCY;
                        SchemeValueTmp."Remaining Debt" := RemainingDebt;
                        SchemeValueTmp."Remaining Debt (LCY)" := RemainingDebtLCY;
                        SchemeValueTmp.Paid := PaidAmount;
                        SchemeValueTmp."Paid (LCY)" := PaidAmountLCY;
                        SchemeValueTmp."Loan Entry" := EntryLines."Loan Entry";

                        if (Quantity > 0) and (Amount > 0) then SchemeValueTmp.Rate := Amount / Quantity;

                        SchemeValueTmp.Modify;
                    end;
                end;
            SchemeControlTmp.Input::None:
                begin
                    //V.6.1.65_10SEP10 >>
                    if PeriodRec."Annualize TAX" then begin
                        if (SchemeControlTmp."Annualize TAX") or (SchemeControlTmp."Annualize Relief") then begin
                            Flag := true;
                            Clear(lvPayrollHeader);
                            lvPayrollHeader.SetRange("Employee no.", gvPayrollHeader."Employee no.");
                            lvPayrollHeader.SetRange("Payroll Year", gvPayrollHeader."Payroll Year");
                            lvPayrollHeader.SetFilter("Payroll Month", '%1..%2', 1, gvPayrollHeader."Payroll Month");
                            if lvPayrollHeader.FindSet then
                                repeat
                                    lvAmount += lvPayrollHeader."H (LCY)";
                                    lvAmountLCY += lvPayrollHeader."H (LCY)";
                                until lvPayrollHeader.Next = 0;
                            SchemeValueTmp.Amount := lvAmount;
                            SchemeValueTmp."Amount (LCY)" := lvAmountLCY;
                            SchemeValueTmp.Modify;
                            Amount := SchemeValueTmp.Amount;
                            "Amount (LCY)" := SchemeValueTmp."Amount (LCY)";
                        end;
                    end;
                    //V.6.1.65_10SEP10 <<
                end;
        end;
    end;

    procedure RoundAmount()
    begin
        //V.6.1.65_10SEP10 >>
        if not Flag then
            SchemeValueTmp.Get(LineNo, Scheme);
        case SchemeControlTmp.Round of
            SchemeControlTmp.Round::Up:
                begin
                    SchemeValueTmp.Amount := Round(SchemeValueTmp.Amount, SchemeValueTmp."Round Precision", '>');
                    SchemeValueTmp."Amount (LCY)" := Round(SchemeValueTmp."Amount (LCY)", SchemeValueTmp."Round Precision", '>');
                end;
            SchemeControlTmp.Round::Down:
                begin
                    SchemeValueTmp.Amount := Round(SchemeValueTmp.Amount, SchemeValueTmp."Round Precision", '<');
                    SchemeValueTmp."Amount (LCY)" := Round(SchemeValueTmp."Amount (LCY)", SchemeValueTmp."Round Precision", '<');
                end;
            SchemeControlTmp.Round::Nearest:
                begin
                    SchemeValueTmp.Amount := Round(SchemeValueTmp.Amount, SchemeValueTmp."Round Precision", '=');
                    SchemeValueTmp."Amount (LCY)" := Round(SchemeValueTmp."Amount (LCY)", SchemeValueTmp."Round Precision", '=');
                end
        end;
        //V.6.1.65 >>
        if (SchemeValueTmp.P9A = SchemeValueTmp.P9A::L) then begin
            SchemeValueTmp.Amount := SchemeValueTmp.Amount - AnnualReliefAmt;
            SchemeValueTmp."Amount (LCY)" := SchemeValueTmp."Amount (LCY)" - AnnualReliefAmt;
            AnnualReliefAmt := 0;
            Flag1 := false;
        end;
        //V.6.1.65 <<
        SchemeValueTmp.Modify;
    end;

    procedure Calculate(var Header: Record "Payroll Header")
    var
        lvPayrollSetup: Record "Payroll Setups";
        lvEmployee: Record Employee;
    begin
        //CSM 10082010 added to distinguish ethiopian tax calculation
        lvPayrollSetup.Get(Header."Payroll Code");
        if lvPayrollSetup."Tax Calculation" = lvPayrollSetup."Tax Calculation"::Kenya then begin
            case SchemeControlTmp.Calculation of
                SchemeControlTmp.Calculation::Add:
                    begin
                        SchemeValueTmp.Get(LineNo, Scheme);
                        //PMC 20100830: ODC Phase2 FRD P13 - Check if Hse or Commuter Allowance and prorate
                        if lvEmployee.Get(Header."Employee no.") then
                            if lvEmployee."Housing Eligibility" <> lvEmployee."Housing Eligibility"::House then
                                if ((SchemeValueTmp."Payroll Entry" = lvPayrollSetup."House Allowances ED") or
                                    (SchemeValueTmp."Payroll Entry" = lvPayrollSetup."Commuter Allowance ED")) then
                                    /* lvHRMEmpLedger.SETRANGE("Employee No.",Header."Employee no.");
                                     IF lvHRMEmpLedger.FINDFIRST THEN
                                     IF ((lvHRMEmpLedger."Housing Type" = lvHRMEmpLedger."Housing Type"::"1") OR
                                         (lvHRMEmpLedger."Housing Type" = lvHRMEmpLedger."Housing Type"::"0")) THEN
                                         IF ((lvHRMEmpLedger."Posting Date" > PeriodRec."Start Date") AND
                                         (lvHRMEmpLedger."Posting Date" < PeriodRec."End Date")) THEN
                                       BEGIN
                                         Amount := lvEmployee."Fixed Pay" * (lvHRMEmpLedger."Posting Date" - PeriodRec."Start Date")/
                                                   (PeriodRec."End Date"-PeriodRec."Start Date");
                                         "Amount (LCY)" := lvEmployee."Fixed Pay" * (lvHRMEmpLedger."Posting Date" - PeriodRec."Start Date")/
                                                            (PeriodRec."End Date"-PeriodRec."Start Date");
                                       END ELSE
                                     IF ((lvHRMEmpLedger."Housing Type" = lvHRMEmpLedger."Housing Type"::"3") AND
                                         (lvHRMEmpLedger."Posting Date" > PeriodRec."Start Date") AND
                                         (lvHRMEmpLedger."Posting Date" < PeriodRec."End Date")) THEN
                                       BEGIN
                                         Amount := lvEmployee."Fixed Pay" * (PeriodRec."End Date"-lvHRMEmpLedger."Posting Date")/
                                                   (PeriodRec."End Date"-PeriodRec."Start Date");
                                         "Amount (LCY)" := lvEmployee."Fixed Pay" * (PeriodRec."End Date"-lvHRMEmpLedger."Posting Date")/
                                                            (PeriodRec."End Date"-PeriodRec."Start Date");
                                       END ELSE BEGIN
                                     //PMC 20100830: ODC Phase2 FRD P13
                                     Amount := SchemeValueTmp.Amount;
                                     "Amount (LCY)" := SchemeValueTmp."Amount (LCY)";
                                     END;//PMC 20100830: ODC Phase2 FRD P13
                                     */
                  SchemeValueTmp.Get(SchemeControlTmp."Compute To", Scheme);
                        Amount := SchemeValueTmp.Amount;
                        "Amount (LCY)" := SchemeValueTmp."Amount (LCY)";
                        SchemeValueTmp.Amount += Amount;
                        SchemeValueTmp."Amount (LCY)" += "Amount (LCY)";
                        SchemeValueTmp.Modify;
                    end;

                SchemeControlTmp.Calculation::Substract:
                    begin
                        SchemeValueTmp.Get(LineNo, Scheme);
                        Amount := SchemeValueTmp.Amount;
                        "Amount (LCY)" := SchemeValueTmp."Amount (LCY)";
                        SchemeValueTmp.Get(SchemeControlTmp."Compute To", Scheme);
                        SchemeValueTmp.Amount -= Amount;
                        SchemeValueTmp."Amount (LCY)" -= "Amount (LCY)";
                        SchemeValueTmp.Modify;
                    end;

                SchemeControlTmp.Calculation::Multiply:
                    begin
                        SchemeValueTmp.Get(LineNo, Scheme);
                        Amount := SchemeValueTmp.Amount * SchemeValueTmp.Number;
                        "Amount (LCY)" := SchemeValueTmp."Amount (LCY)" * SchemeValueTmp.Number;
                        SchemeValueTmp.Get(SchemeControlTmp."Compute To", Scheme);
                        SchemeValueTmp.Amount := Amount;
                        SchemeValueTmp."Amount (LCY)" := "Amount (LCY)";
                        SchemeValueTmp.Modify;
                    end;

                SchemeControlTmp.Calculation::Divide:
                    begin
                        SchemeValueTmp.Get(LineNo, Scheme);
                        Amount := SchemeValueTmp.Amount / SchemeValueTmp.Number;
                        "Amount (LCY)" := SchemeValueTmp."Amount (LCY)" / SchemeValueTmp.Number;
                        SchemeValueTmp.Get(SchemeControlTmp."Compute To", Scheme);
                        SchemeValueTmp.Amount := Amount;
                        SchemeValueTmp."Amount (LCY)" := "Amount (LCY)";
                        SchemeValueTmp.Modify;
                    end;

                SchemeControlTmp.Calculation::Percent:
                    begin
                        SchemeValueTmp.Get(LineNo, Scheme);
                        Amount := SchemeValueTmp.Amount * SchemeValueTmp.Percent / 100;
                        "Amount (LCY)" := SchemeValueTmp."Amount (LCY)" * SchemeValueTmp.Percent / 100;
                        SchemeValueTmp.Get(SchemeControlTmp."Compute To", Scheme);
                        SchemeValueTmp.Amount := Amount;
                        SchemeValueTmp."Amount (LCY)" := "Amount (LCY)";
                        SchemeValueTmp.Modify;
                    end;

                SchemeControlTmp.Calculation::Highest:
                    begin
                        SchemeValueTmp.Get(SchemeValueTmp."Factor of", Scheme);
                        Amount1 := SchemeValueTmp.Amount;
                        Amount1LCY := SchemeValueTmp."Amount (LCY)";
                        SchemeValueTmp.Get(LineNo, Scheme);
                        Amount := SchemeValueTmp.Amount;
                        "Amount (LCY)" := SchemeValueTmp."Amount (LCY)";
                        SchemeValueTmp.Get(SchemeControlTmp."Compute To", Scheme);
                        if Amount < Amount1 then begin
                            SchemeValueTmp.Amount := Amount1;
                            SchemeValueTmp."Amount (LCY)" := Amount1LCY;
                            Amount := 0;
                            Amount1 := 0;
                            "Amount (LCY)" := 0;
                            Amount1LCY := 0;
                            SchemeValueTmp.Modify;
                        end else begin
                            SchemeValueTmp.Amount := Amount;
                            SchemeValueTmp."Amount (LCY)" := "Amount (LCY)";
                            Amount := 0;
                            Amount1 := 0;
                            "Amount (LCY)" := 0;
                            Amount1LCY := 0;
                            SchemeValueTmp.Modify;
                        end;
                    end;

                SchemeControlTmp.Calculation::Lowest:
                    begin
                        SchemeValueTmp.Get(SchemeControlTmp."Factor of", Scheme);
                        Amount1 := SchemeValueTmp.Amount;
                        Amount1LCY := SchemeValueTmp."Amount (LCY)";
                        SchemeValueTmp.Get(LineNo, Scheme);
                        Amount := SchemeValueTmp.Amount;
                        "Amount (LCY)" := SchemeValueTmp."Amount (LCY)";
                        SchemeValueTmp.Get(SchemeControlTmp."Compute To", Scheme);
                        if Amount < Amount1 then begin
                            SchemeValueTmp.Amount := Amount;
                            SchemeValueTmp."Amount (LCY)" := "Amount (LCY)";
                            Amount := 0;
                            Amount1 := 0;
                            "Amount (LCY)" := 0;
                            Amount1LCY := 0;
                            SchemeValueTmp.Modify;
                        end else begin
                            SchemeValueTmp.Amount := Amount1;
                            SchemeValueTmp."Amount (LCY)" := Amount1LCY;
                            Amount := 0;
                            Amount1 := 0;
                            "Amount (LCY)" := 0;
                            Amount1LCY := 0;
                            SchemeValueTmp.Modify;
                        end;
                    end;
                SchemeControlTmp.Calculation::"Look Up":
                    LookUp(Header);
            end;
        end;
        if lvPayrollSetup."Tax Calculation" = lvPayrollSetup."Tax Calculation"::Ethiopia then begin
            case SchemeControlTmp.Calculation of
                SchemeControlTmp.Calculation::Add:
                    begin
                        SchemeValueTmp.Get(LineNo, Scheme);
                        Amount := SchemeValueTmp.Amount;
                        "Amount (LCY)" := SchemeValueTmp."Amount (LCY)";
                        SchemeValueTmp.Get(SchemeControlTmp."Compute To", Scheme);
                        SchemeValueTmp.Amount += Amount;
                        SchemeValueTmp."Amount (LCY)" += "Amount (LCY)";
                        SchemeValueTmp.Modify;
                    end;

                SchemeControlTmp.Calculation::Substract:
                    begin
                        SchemeValueTmp.Get(LineNo, Scheme);
                        Amount := SchemeValueTmp.Amount;
                        "Amount (LCY)" := SchemeValueTmp."Amount (LCY)";
                        SchemeValueTmp.Get(SchemeControlTmp."Compute To", Scheme);
                        SchemeValueTmp.Amount -= Amount;
                        SchemeValueTmp."Amount (LCY)" -= "Amount (LCY)";
                        SchemeValueTmp.Modify;
                    end;

                SchemeControlTmp.Calculation::Multiply:
                    begin
                        SchemeValueTmp.Get(LineNo, Scheme);
                        Amount := SchemeValueTmp.Amount * SchemeValueTmp.Number;
                        "Amount (LCY)" := SchemeValueTmp."Amount (LCY)" * SchemeValueTmp.Number;
                        SchemeValueTmp.Get(SchemeControlTmp."Compute To", Scheme);
                        SchemeValueTmp.Amount := Amount;
                        SchemeValueTmp."Amount (LCY)" := "Amount (LCY)";
                        SchemeValueTmp.Modify;
                    end;

                SchemeControlTmp.Calculation::Divide:
                    begin
                        SchemeValueTmp.Get(LineNo, Scheme);
                        Amount := SchemeValueTmp.Amount / SchemeValueTmp.Number;
                        "Amount (LCY)" := SchemeValueTmp."Amount (LCY)" / SchemeValueTmp.Number;
                        SchemeValueTmp.Get(SchemeControlTmp."Compute To", Scheme);
                        SchemeValueTmp.Amount := Amount;
                        SchemeValueTmp."Amount (LCY)" := "Amount (LCY)";
                        SchemeValueTmp.Modify;
                    end;

                SchemeControlTmp.Calculation::Percent:
                    begin
                        SchemeValueTmp.Get(LineNo, Scheme);
                        Amount := SchemeValueTmp.Amount * SchemeValueTmp.Percent / 100;
                        "Amount (LCY)" := SchemeValueTmp."Amount (LCY)" * SchemeValueTmp.Percent / 100;
                        SchemeValueTmp.Get(SchemeControlTmp."Compute To", Scheme);
                        SchemeValueTmp.Amount := Amount;
                        SchemeValueTmp."Amount (LCY)" := "Amount (LCY)";
                        SchemeValueTmp.Modify;
                    end;

                SchemeControlTmp.Calculation::Highest:
                    begin
                        SchemeValueTmp.Get(SchemeValueTmp."Factor of", Scheme);
                        Amount1 := SchemeValueTmp.Amount;
                        Amount1LCY := SchemeValueTmp."Amount (LCY)";
                        SchemeValueTmp.Get(LineNo, Scheme);
                        Amount := SchemeValueTmp.Amount;
                        "Amount (LCY)" := SchemeValueTmp."Amount (LCY)";
                        SchemeValueTmp.Get(SchemeControlTmp."Compute To", Scheme);
                        if Amount < Amount1 then begin
                            SchemeValueTmp.Amount := Amount1;
                            SchemeValueTmp."Amount (LCY)" := Amount1LCY;
                            Amount := 0;
                            Amount1 := 0;
                            "Amount (LCY)" := 0;
                            Amount1LCY := 0;
                            SchemeValueTmp.Modify;
                        end else begin
                            SchemeValueTmp.Amount := Amount;
                            SchemeValueTmp."Amount (LCY)" := "Amount (LCY)";
                            Amount := 0;
                            Amount1 := 0;
                            "Amount (LCY)" := 0;
                            Amount1LCY := 0;
                            SchemeValueTmp.Modify;
                        end;
                    end;

                SchemeControlTmp.Calculation::Lowest:
                    begin
                        SchemeValueTmp.Get(SchemeControlTmp."Factor of", Scheme);
                        Amount1 := SchemeValueTmp.Amount;
                        Amount1LCY := SchemeValueTmp."Amount (LCY)";
                        SchemeValueTmp.Get(LineNo, Scheme);
                        Amount := SchemeValueTmp.Amount;
                        "Amount (LCY)" := SchemeValueTmp."Amount (LCY)";
                        SchemeValueTmp.Get(SchemeControlTmp."Compute To", Scheme);
                        if Amount < Amount1 then begin
                            SchemeValueTmp.Amount := Amount;
                            SchemeValueTmp."Amount (LCY)" := "Amount (LCY)";
                            Amount := 0;
                            Amount1 := 0;
                            "Amount (LCY)" := 0;
                            Amount1LCY := 0;
                            SchemeValueTmp.Modify;
                        end else begin
                            SchemeValueTmp.Amount := Amount1;
                            SchemeValueTmp."Amount (LCY)" := Amount1LCY;
                            Amount := 0;
                            Amount1 := 0;
                            "Amount (LCY)" := 0;
                            Amount1LCY := 0;
                            SchemeValueTmp.Modify;
                        end;
                    end;
                SchemeControlTmp.Calculation::"Look Up":
                    LookUpEthiopia(Header);
            end;
        end;

    end;

    procedure LookUp(var Header: Record "Payroll Header")
    var
        LookUpHeader: Record "Lookup Table Header";
        LookUpLine: Record "Lookup Table Lines";
    begin
        LookUpHeader.Get(SchemeControlTmp.LookUp);
        LookUpLine.SetRange("Table ID", SchemeControlTmp.LookUp);
        //V.6.1.65_10SEP10 >>
        if not Flag then
            SchemeValueTmp.Get(LineNo, Scheme);
        Amount := SchemeValueTmp.Amount;
        "Amount (LCY)" := SchemeValueTmp."Amount (LCY)";

        case LookUpHeader.Type of
            LookUpHeader.Type::Percentage:
                begin
                    LookUpLine.Find('-');

                    while "Amount (LCY)" > LookUpLine."Upper Amount (LCY)" do
                        LookUpLine.Find('>');

                    Percent := LookUpLine.Percent;
                    if LookUpLine.Find('<') then begin
                        Cum := LookUpLine."Cumulate (LCY)";
                        Amount1LCY := (("Amount (LCY)" - LookUpLine."Upper Amount (LCY)") * Percent / 100) + Cum;
                    end else begin
                        Amount1LCY := ("Amount (LCY)" * Percent / 100);
                    end;
                    CalculateAnnualTax(Header);//V.6.1.65_10SEP10 >>
                end;
            LookUpHeader.Type::"Extract Amount":
                begin
                    LookUpLine.Find('-');
                    while not ("Amount (LCY)" <= LookUpLine."Upper Amount (LCY)") do
                        LookUpLine.Find('>');

                    Amount1LCY := LookUpLine."Extract Amount (LCY)";
                    CalculateAnnualTax(Header);//V.6.1.65_10SEP10 >>
                end;
            LookUpHeader.Type::Month:
                begin
                    LookUpLine.Find('-');
                    while Header."Payroll Month" <> LookUpLine.Month do
                        LookUpLine.Find('>');
                    Amount1LCY := LookUpLine."Extract Amount (LCY)";

                    CalculateAnnualTax(Header);//V.6.1.65_10SEP10 >>
                end;
            LookUpHeader.Type::"Max Min":
                begin
                    if LookUpHeader."Min Extract Amount (LCY)" <> 0 then
                        if "Amount (LCY)" < LookUpHeader."Min Extract Amount (LCY)" then
                            Amount1LCY := LookUpHeader."Min Extract Amount (LCY)";
                    if LookUpHeader."Max Extract Amount (LCY)" <> 0 then
                        if "Amount (LCY)" > LookUpHeader."Max Extract Amount (LCY)" then
                            Amount1LCY := LookUpHeader."Max Extract Amount (LCY)";
                    CalculateAnnualTax(Header);//V.6.1.65_10SEP10 >>
                end;
        end;
        SchemeValueTmp.Get(SchemeControlTmp."Compute To", Scheme);
        SchemeValueTmp.Amount := Amount1LCY;
        SchemeValueTmp."Amount (LCY)" := Amount1LCY;
        SchemeValueTmp.Modify;
    end;

    procedure Output(var Header: Record "Payroll Header")
    var
        EmployeeRec: Record Employee;
        lvHeader: Record "Payroll Header";
    begin
        EmployeeRec.Get(Header."Employee no.");
        //V.6.1.65_10SEP10 >>
        if not Flag then
            SchemeValueTmp.Get(LineNo, Scheme);
        // SchemeValueTmp.GET(SchemeValueTmp."Compute To",Scheme);
        //ELSE

        //Output payroll header
        case SchemeValueTmp.P9A of
            SchemeValueTmp.P9A::A:
                Header."A (LCY)" := SchemeValueTmp."Amount (LCY)";
            SchemeValueTmp.P9A::B:
                Header."B (LCY)" := SchemeValueTmp."Amount (LCY)";
            SchemeValueTmp.P9A::C:
                Header."C (LCY)" := SchemeValueTmp."Amount (LCY)";
            SchemeValueTmp.P9A::D:
                Header."D (LCY)" := SchemeValueTmp."Amount (LCY)";
            SchemeValueTmp.P9A::E1:
                Header."E1 (LCY)" := SchemeValueTmp."Amount (LCY)";
            SchemeValueTmp.P9A::E2:
                Header."E2 (LCY)" := SchemeValueTmp."Amount (LCY)";
            SchemeValueTmp.P9A::E3:
                Header."E3 (LCY)" := SchemeValueTmp."Amount (LCY)";
            SchemeValueTmp.P9A::F:
                Header."F (LCY)" := SchemeValueTmp."Amount (LCY)";
            SchemeValueTmp.P9A::G:
                Header."G (LCY)" := SchemeValueTmp."Amount (LCY)";
            SchemeValueTmp.P9A::H:
                Header."H (LCY)" := SchemeValueTmp."Amount (LCY)";
            SchemeValueTmp.P9A::J:
                Header."J (LCY)" := SchemeValueTmp."Amount (LCY)";
            SchemeValueTmp.P9A::K:
                Header."K (LCY)" := SchemeValueTmp."Amount (LCY)";
            SchemeValueTmp.P9A::L:
                Header."L (LCY)" := SchemeValueTmp."Amount (LCY)";
            SchemeValueTmp.P9A::M:
                Header."M (LCY)" := SchemeValueTmp."Amount (LCY)";
        end;
        //V.6.1.65_13SEP10 >>
        if gvPayrollHeader."L (LCY)" <> Header."L (LCY)" then begin
            gvPayrollHeader."K (LCY)" := Header."K (LCY)";
            if SchemeValueTmp.P9A = SchemeValueTmp.P9A::L then begin
                gvPayrollHeader."L (LCY)" := Header."L (LCY)";
                gvPayrollHeader.Calculated := true;
                if gvPayrollHeader."M (LCY)" < 0 then gvPayrollHeader."M (LCY)" := 0;
                if PeriodRec."Annualize TAX" then
                    gvPayrollHeader.Modify;
            end;
            gvPayrollHeader."A (LCY)" := Header."A (LCY)";
            gvPayrollHeader."B (LCY)" := Header."B (LCY)";
            gvPayrollHeader."C (LCY)" := Header."C (LCY)";
            gvPayrollHeader."D (LCY)" := Header."D (LCY)";
            gvPayrollHeader."E1 (LCY)" := Header."E1 (LCY)";
            gvPayrollHeader."E2 (LCY)" := Header."E2 (LCY)";
            gvPayrollHeader."E3 (LCY)" := Header."E3 (LCY)";
            gvPayrollHeader."F (LCY)" := Header."F (LCY)";
            gvPayrollHeader."G (LCY)" := Header."G (LCY)";
            gvPayrollHeader."H (LCY)" := Header."H (LCY)";
            gvPayrollHeader.Calculated := true;

            if SchemeValueTmp.P9A = SchemeValueTmp.P9A::L then begin
                if PeriodRec."Annualize TAX" then
                    PayrollHeader."J (LCY)" := BeforeReliefAmt;
                PayrollHeader.Modify;
                BeforeReliefAmt := 0;
            end;

            if SchemeValueTmp.P9A = SchemeValueTmp.P9A::J then begin
                if PeriodRec."Annualize TAX" then
                    gvPayrollHeader."J (LCY)" := BeforeReliefAmt
                else
                    gvPayrollHeader."J (LCY)" := Header."J (LCY)";
                if PeriodRec."Annualize TAX" then begin
                    gvPayrollHeader.Calculated := true;
                    if gvPayrollHeader."M (LCY)" < 0 then gvPayrollHeader."M (LCY)" := 0;
                    gvPayrollHeader.Modify;
                end;
            end;
            gvPayrollHeader."M (LCY)" := Header."M (LCY)";
        end;
        if Flag then begin
            case SchemeValueTmp.P9A of
                SchemeValueTmp.P9A::K:
                    gvPayrollHeader."K (LCY)" := Header."K (LCY)";
                SchemeValueTmp.P9A::L:
                    gvPayrollHeader."L (LCY)" := Header."L (LCY)";
            end;
            if PeriodRec."Annualize TAX" then
                gvPayrollHeader.Modify;
        end;
        //V.6.1.65_13SEP10 <<
        //Output payroll lines
        if SchemeControlTmp."Payroll Lines" <> '' then begin
            if SchemeControlTmp.Multiline then begin
                if EntryLinesTMP.Find('-') then begin
                    repeat
                        if EntryLinesTMP.Amount > 0 then begin
                            PayrollLinesTmpLineNo := PayrollLinesTmpLineNo + 1;
                            EDDefinitionTmp.Get(EntryLinesTMP."ED Code");
                            PayrollLinesTmp."Entry No." := PayrollLinesTmpLineNo;
                            PayrollLinesTmp."Payroll ID" := Period;
                            PayrollLinesTmp."Employee No." := Header."Employee no.";
                            //Bank details
                            PayrollLinesTmp."Bank Account No" := EmployeeRec."Bank Account No.";
                            PayrollLinesTmp."Bank Code" := EmployeeRec."Bank Code";
                            PayrollLinesTmp."Bank Branch Name" := EmployeeRec."Bank Branch Name";
                            PayrollLinesTmp."Bank Name" := EmployeeRec."Bank Name";
                            //Bank details
                            PayrollLinesTmp."Global Dimension 1 Code" := EmployeeRec."Global Dimension 1 Code";
                            PayrollLinesTmp."Global Dimension 2 Code" := EmployeeRec."Global Dimension 2 Code";
                            PayrollLinesTmp."Posting Group" := EmployeeRec."Posting Group";
                            PayrollLinesTmp."ED Code" := EntryLinesTMP."ED Code";
                            PayrollLinesTmp."Currency Code" := EntryLinesTMP."Currency Code";
                            PayrollLinesTmp."Currency Factor" := EntryLinesTMP."Currency Factor";
                            PayrollLinesTmp.Text := EDDefinitionTmp."Payroll Text";
                            PayrollLinesTmp.Amount := EntryLinesTMP.Amount;
                            PayrollLinesTmp."Amount (LCY)" := EntryLinesTMP."Amount (LCY)";
                            PayrollLinesTmp.Quantity := EntryLinesTMP.Quantity;
                            PayrollLinesTmp.Rate := EntryLinesTMP.Rate;
                            PayrollLinesTmp."Rate (LCY)" := EntryLinesTMP."Rate (LCY)";
                            PayrollLinesTmp."Calculation Group" := EDDefinitionTmp."Calculation Group";
                            PayrollLinesTmp.Rounding := EDDefinitionTmp."Rounding ED";
                            PayrollLinesTmp."Loan Entry" := EntryLinesTMP."Loan Entry";
                            PayrollLinesTmp."Loan Entry No" := EntryLinesTMP."Loan Entry No";
                            PayrollLinesTmp."Loan ID" := EntryLinesTMP."Loan ID";
                            PayrollLinesTmp.Interest := EntryLinesTMP.Interest;
                            PayrollLinesTmp."Interest (LCY)" := EntryLinesTMP."Interest (LCY)";
                            PayrollLinesTmp.Repayment := EntryLinesTMP.Repayment;
                            PayrollLinesTmp."Repayment (LCY)" := EntryLinesTMP."Repayment (LCY)";
                            PayrollLinesTmp."Remaining Debt" := EntryLinesTMP."Remaining Debt";
                            PayrollLinesTmp."Remaining Debt (LCY)" := EntryLinesTMP."Remaining Debt (LCY)";
                            PayrollLinesTmp.Paid := EntryLinesTMP.Paid;
                            PayrollLinesTmp."Paid (LCY)" := EntryLinesTMP."Paid (LCY)";
                            PayrollLinesTmp."Posting Date" := gvPostingDate;
                            PayrollLinesTmp."Payroll Code" := gvAllowedPayrolls."Payroll Code";
                            PayrollLinesTmp.Insert;
                            gvPayrollUtilities.sCopyDimsFromEntryToLines(EntryLinesTMP, PayrollLinesTmp)
                        end;
                    until EntryLinesTMP.Next = 0;
                    EntryLinesTMP.DeleteAll(true);
                end;
            end else begin
                if SchemeValueTmp.Amount > 0 then begin
                    PayrollLinesTmpLineNo := PayrollLinesTmpLineNo + 1;
                    EDDefinitionTmp.Get(SchemeValueTmp."Payroll Lines");
                    PayrollLinesTmp."Entry No." := PayrollLinesTmpLineNo;
                    PayrollLinesTmp."Payroll ID" := Period;
                    PayrollLinesTmp."Employee No." := Header."Employee no.";
                    PayrollLinesTmp."Currency Code" := SchemeValueTmp."Currency Code";
                    PayrollLinesTmp."Currency Factor" := SchemeValueTmp."Currency Factor";
                    //Bank details
                    PayrollLinesTmp."Bank Account No" := EmployeeRec."Bank Account No.";
                    PayrollLinesTmp."Bank Code" := EmployeeRec."Bank Code";
                    PayrollLinesTmp."Bank Branch Name" := EmployeeRec."Bank Branch Name";
                    PayrollLinesTmp."Bank Name" := EmployeeRec."Bank Name";
                    //Bank details
                    PayrollLinesTmp."Global Dimension 1 Code" := EmployeeRec."Global Dimension 1 Code";
                    PayrollLinesTmp."Global Dimension 2 Code" := EmployeeRec."Global Dimension 2 Code";
                    PayrollLinesTmp."Posting Group" := EmployeeRec."Posting Group";
                    PayrollLinesTmp."ED Code" := EDDefinitionTmp."ED Code";
                    PayrollLinesTmp.Text := EDDefinitionTmp."Payroll Text";
                    PayrollLinesTmp.Amount := SchemeValueTmp.Amount;
                    PayrollLinesTmp."Amount (LCY)" := SchemeValueTmp."Amount (LCY)";
                    PayrollLinesTmp.Quantity := SchemeValueTmp.Quantity;
                    PayrollLinesTmp.Rate := SchemeValueTmp.Rate;
                    PayrollLinesTmp."Rate (LCY)" := SchemeValueTmp."Rate (LCY)";
                    PayrollLinesTmp."Calculation Group" := EDDefinitionTmp."Calculation Group";
                    PayrollLinesTmp.Rounding := EDDefinitionTmp."Rounding ED";
                    PayrollLinesTmp."Loan Entry" := SchemeValueTmp."Loan Entry";
                    PayrollLinesTmp."Loan Entry No" := EntryLines."Loan Entry No";
                    PayrollLinesTmp."Loan ID" := EntryLines."Loan ID";
                    PayrollLinesTmp.Interest := SchemeValueTmp.Interest;
                    PayrollLinesTmp."Interest (LCY)" := SchemeValueTmp."Interest (LCY)";
                    PayrollLinesTmp.Repayment := SchemeValueTmp.Repayment;
                    PayrollLinesTmp."Repayment (LCY)" := SchemeValueTmp."Repayment (LCY)";
                    PayrollLinesTmp."Remaining Debt" := SchemeValueTmp."Remaining Debt";
                    PayrollLinesTmp."Remaining Debt (LCY)" := SchemeValueTmp."Remaining Debt (LCY)";
                    PayrollLinesTmp.Paid := SchemeValueTmp.Paid;
                    PayrollLinesTmp."Paid (LCY)" := SchemeValueTmp."Paid (LCY)";
                    PayrollLinesTmp."Posting Date" := gvPostingDate;
                    PayrollLinesTmp."Payroll Code" := gvAllowedPayrolls."Payroll Code";
                    PayrollLinesTmp.Insert;
                    gvPayrollUtilities.sGetDefaultEDDims2(PayrollLinesTmp);
                end;
            end;
        end;
    end;

    procedure BringFWDrounding()
    var
        PayrollHeaderRec: Record "Payroll Header";
        PeriodsRec: Record Periods;
        NetAmount: Decimal;
        RoundAmount: Decimal;
        PayrollSetup: Record "Payroll Setups";
        PayrollEntry: Record "Payroll Entry";
    begin
        //Bring Foward Net Pay Rounding from the previous payroll month if any
        PayrollSetup.Get(gvAllowedPayrolls."Payroll Code");

        PayrollEntry.SetCurrentKey("Employee No.", "Payroll ID", "ED Code");
        PayrollEntry.SetRange("Employee No.", Employee."No.");
        PayrollEntry.SetRange("Payroll ID", Period);
        PayrollEntry.SetRange("ED Code", PayrollSetup."Net Pay Rounding B/F");
        PayrollEntry.DeleteAll(true);

        PayrollEntry.Reset;
        PayrollEntry.SetCurrentKey("Employee No.", "Payroll ID", "ED Code");
        PayrollEntry.SetRange("Employee No.", Employee."No.");
        PayrollEntry.SetRange("Payroll ID", Period);
        PayrollEntry.SetRange("ED Code", PayrollSetup."Net Pay Rounding B/F (-Ve)");
        PayrollEntry.DeleteAll(true);

        PayrollEntry.Reset;
        PayrollEntry.SetCurrentKey("Employee No.", "Payroll ID", "ED Code");
        PayrollEntry.SetRange("Employee No.", Employee."No.");
        PayrollEntry.SetRange("Payroll ID", Period);
        PayrollEntry.SetRange("ED Code", PayrollSetup."Overdrawn ED");
        PayrollEntry.DeleteAll(true);

        PeriodsRec.Reset;
        PeriodsRec.SetCurrentKey("Start Date");
        PeriodsRec.Ascending(true);
        PeriodsRec.SetRange(Status, PeriodsRec.Status::Posted);
        if not PeriodsRec.Find('+') then exit;

        PayrollHeaderRec.SetCurrentKey("Payroll ID", "Employee no.");
        PayrollHeaderRec.SetRange("Payroll ID", PeriodsRec."Period ID");
        PayrollHeaderRec.SetRange("Employee no.", Employee."No.");

        if PayrollHeaderRec.Find('-') then
            if PayrollHeader.Get(Period, PayrollHeaderRec."Employee no.") then begin

                PayrollHeaderRec.CalcFields("Total Deduction (LCY)", "Total Payable (LCY)");
                NetAmount := PayrollHeaderRec."Total Payable (LCY)" - PayrollHeaderRec."Total Deduction (LCY)";

                if NetAmount > 0 then begin
                    if PayrollSetup."Net Pay Rounding Precision" <> 0 then
                        RoundAmount := NetAmount mod PayrollSetup."Net Pay Rounding Precision";

                    if (RoundAmount <> 0) and (RoundAmount >= PayrollSetup."Net Pay Rounding Mid Amount") then
                        RoundAmount := PayrollSetup."Net Pay Rounding Precision" - RoundAmount;

                    if RoundAmount <> 0 then begin
                        PayrollEntry.Init;
                        EntryLineNo := EntryLineNo + 1;
                        PayrollEntry."Entry No." := EntryLineNo;

                        if PayrollSetup."Net Pay Rounding Precision" <> 0 then
                            PayrollEntry."Payroll ID" := Period;
                        PayrollEntry."Employee No." := PayrollHeaderRec."Employee no.";

                        if NetAmount mod PayrollSetup."Net Pay Rounding Precision" >= PayrollSetup."Net Pay Rounding Mid Amount" then
                            PayrollEntry.Validate("ED Code", PayrollSetup."Net Pay Rounding B/F (-Ve)")
                        else
                            PayrollEntry.Validate("ED Code", PayrollSetup."Net Pay Rounding B/F");

                        PayrollEntry.Date := gvPostingDate;
                        PayrollEntry.Validate(Amount, RoundAmount);
                        PayrollEntry."Copy to next" := false;
                        PayrollEntry."Reset Amount" := false;
                        PayrollEntry.Editable := false;
                        PayrollEntry."Payroll Code" := gvAllowedPayrolls."Payroll Code";
                        PayrollEntry.Insert;
                        Commit;
                    end;
                end else if NetAmount < 0 then begin
                    PayrollEntry.Init;
                    EntryLineNo := EntryLineNo + 1;
                    PayrollEntry."Entry No." := EntryLineNo;
                    PayrollEntry."Payroll ID" := Period;
                    PayrollEntry."Employee No." := PayrollHeaderRec."Employee no.";
                    PayrollEntry.Date := gvPostingDate;
                    PayrollEntry.Validate("ED Code", PayrollSetup."Overdrawn ED");
                    PayrollEntry.Validate(Amount, Abs(NetAmount));
                    PayrollEntry."Copy to next" := false;
                    PayrollEntry."Reset Amount" := false;
                    PayrollEntry.Editable := false;
                    PayrollEntry."Payroll Code" := gvAllowedPayrolls."Payroll Code";
                    PayrollEntry.Insert;
                    Commit;
                end;
            end;
    end;

    procedure GetLumpSum(PayrollHdr: Record "Payroll Header")
    var
        lvPayrollSetup: Record "Payroll Setups";
        lvPayrollEntry: Record "Payroll Entry";
        lvLumpsumPayments: Record "Lump Sum Payments";
        lvEntryNo: BigInteger;
        lvAssessmentYrsArray: array[20] of Integer;
        lvIndex: Integer;
        lvAssessmentYrsFound: Integer;
        lvEmployee: Record Employee;
        lvPayrollHdr: Record "Payroll Header";
        lvRevisedTotalTaxableIncome: Decimal;
        lvTaxOnRevisedIncome: Decimal;
        lvPayrollLines: Record "Payroll Lines";
        lvLastPayrollLineEntryNo: BigInteger;
        lvEdDef: Record "ED Definitions";
    begin
        //skm200405 Compute Taxation on Lump Sum Payment
        lvLumpsumPayments.SetCurrentKey("Employee No", "Assessment Year", "ED Code");
        lvLumpsumPayments.SetRange("Employee No", PayrollHdr."Employee no.");
        if not lvLumpsumPayments.Find('-') then exit;

        lvPayrollSetup.Get(gvAllowedPayrolls."Payroll Code");

        //Clear payroll entry and line for lumpsum payment EDs
        lvPayrollEntry.SetCurrentKey("Employee No.", "Payroll ID", "ED Code");
        lvPayrollEntry.SetRange("Employee No.", PayrollHdr."Employee no.");
        lvPayrollEntry.SetRange("Payroll ID", PayrollHdr."Payroll ID");
        lvPayrollEntry.SetRange("ED Code", lvPayrollSetup."Tax on Lump Sum ED");
        lvPayrollEntry.DeleteAll(true);

        lvPayrollLines.SetCurrentKey("Payroll ID", "Employee No.", "ED Code");
        lvPayrollLines.SetRange("Employee No.", PayrollHdr."Employee no.");
        lvPayrollLines.SetRange("Payroll ID", PayrollHdr."Payroll ID");
        lvPayrollLines.SetRange("ED Code", lvPayrollSetup."Tax on Lump Sum ED");
        lvPayrollLines.DeleteAll(true);

        repeat
            lvLumpsumPayments.TestField("Employee No");
            lvLumpsumPayments.TestField("ED Code");
            lvLumpsumPayments.TestField("Amount (LCY)");
            lvLumpsumPayments.TestField("Assessment Year");
            lvLumpsumPayments.TestField("Annual Tax Table");

            lvPayrollEntry.SetRange("ED Code", lvLumpsumPayments."ED Code");
            lvPayrollEntry.DeleteAll(true);

            lvPayrollLines.SetRange("ED Code", lvLumpsumPayments."ED Code");
            lvPayrollLines.DeleteAll(true);
        until lvLumpsumPayments.Next = 0;
        //End Clear payroll entry for lumpsum payment EDs

        lvPayrollEntry.Reset;
        if lvPayrollEntry.Find('+') then lvEntryNo := lvPayrollEntry."Entry No.";

        //Retrieve assessment years and put them into a 20 dim array
        //max assessement years 20
        lvLumpsumPayments.Find('-');
        lvIndex += 1;

        repeat
            if lvIndex > 1 then begin
                if lvLumpsumPayments."Assessment Year" > lvAssessmentYrsArray[lvIndex - 1] then begin
                    lvAssessmentYrsArray[lvIndex] := lvLumpsumPayments."Assessment Year";
                    lvIndex += 1;
                end
            end else begin
                lvAssessmentYrsArray[lvIndex] := lvLumpsumPayments."Assessment Year";
                lvIndex += 1;
            end
        until (lvLumpsumPayments.Next = 0) or (lvIndex > 20);

        if (lvIndex > 20) then begin
            Message('More than 20 assessment years have been entered in Lump Sum Payments table. Only the oldest 20 have been assessed.');
            lvAssessmentYrsFound := 20;
        end else
            lvAssessmentYrsFound := lvIndex - 1;
        //end Retrieve assessment years and put them into a 20 dim array

        //Compute tax on lump sum per year
        lvLumpsumPayments.Reset;
        lvLumpsumPayments.SetCurrentKey("Employee No", "Assessment Year", "ED Code");
        lvLumpsumPayments.SetRange("Employee No", PayrollHdr."Employee no.");

        lvPayrollHdr.SetCurrentKey("Employee no.", "Payroll Year");
        lvPayrollHdr.SetRange("Employee no.", PayrollHdr."Employee no.");

        lvPayrollLines.Reset;
        if lvPayrollLines.Find('+') then lvLastPayrollLineEntryNo := lvPayrollLines."Entry No.";
        lvEdDef.Get(lvPayrollSetup."Tax on Lump Sum ED");

        for lvIndex := 1 to lvAssessmentYrsFound do begin
            //Calculate Total Payable for the year as per P9A (Column D)
            lvPayrollHdr.SetRange("Payroll Year", lvAssessmentYrsArray[lvIndex]);
            lvPayrollHdr.CalcSums("D (LCY)", "K (LCY)", "L (LCY)");

            //Calculate Lump Sum pay for the year
            lvLumpsumPayments.SetRange("Assessment Year", lvAssessmentYrsArray[lvIndex]);
            lvLumpsumPayments.CalcSums("Amount (LCY)");

            //Calculate revised taxable income
            lvRevisedTotalTaxableIncome := lvPayrollHdr."D (LCY)" + lvLumpsumPayments."Amount (LCY)";

            //Calculate tax on revised taxable income
            lvTaxOnRevisedIncome := Round(LookUp2(lvLumpsumPayments."Annual Tax Table", lvRevisedTotalTaxableIncome, PayrollHdr), 1, '>');

            //Deduct relief for the year
            lvTaxOnRevisedIncome -= lvPayrollHdr."K (LCY)";

            //Deduct PAYE already deducted and paid
            lvTaxOnRevisedIncome -= lvPayrollHdr."L (LCY)";

            //Insert Tax on Lump Sum Payroll Entry
            lvPayrollEntry.Init;
            lvEntryNo += 1;
            lvPayrollEntry."Entry No." := lvEntryNo;
            lvPayrollEntry."Payroll ID" := PayrollHdr."Payroll ID";
            lvPayrollEntry."Employee No." := PayrollHdr."Employee no.";
            lvPayrollEntry.Date := gvPostingDate;
            lvPayrollEntry.Validate("ED Code", lvPayrollSetup."Tax on Lump Sum ED");
            lvPayrollEntry.Validate(Amount, lvTaxOnRevisedIncome);
            lvPayrollEntry."Copy to next" := false;
            lvPayrollEntry."Reset Amount" := false;
            lvPayrollEntry.Editable := false;
            lvPayrollEntry."Payroll Code" := gvAllowedPayrolls."Payroll Code";
            lvPayrollEntry.Insert;
            //End Insert

            //Insert tax on lump sum into payroll lines
            lvLastPayrollLineEntryNo += 1;
            lvPayrollLines."Entry No." := lvLastPayrollLineEntryNo;
            lvPayrollLines."Payroll ID" := PayrollHdr."Payroll ID";
            lvPayrollLines."Employee No." := PayrollHdr."Employee no.";
            lvPayrollLines."Global Dimension 1 Code" := lvEmployee."Global Dimension 1 Code";
            lvPayrollLines."Global Dimension 2 Code" := lvEmployee."Global Dimension 2 Code";
            lvPayrollLines."Posting Group" := lvEmployee."Posting Group";
            lvPayrollLines."ED Code" := lvPayrollSetup."Tax on Lump Sum ED";
            lvPayrollLines.Text := StrSubstNo('%1 %2', lvEdDef."Payroll Text", lvAssessmentYrsArray[lvIndex]);
            lvPayrollLines.Amount := lvTaxOnRevisedIncome;
            lvPayrollLines."Amount (LCY)" := lvTaxOnRevisedIncome;
            lvPayrollLines."Calculation Group" := lvEdDef."Calculation Group";
            lvPayrollLines."GE PA Lump Sum" := lvPayrollHdr."D (LCY)";
            lvPayrollLines."PAYE Earlier Paid Lump Sum" := lvPayrollHdr."L (LCY)";
            lvPayrollLines."LumpSum Line" := true;
            lvPayrollLines."Posting Date" := gvPostingDate;
            lvPayrollLines."Payroll Code" := gvAllowedPayrolls."Payroll Code";
            lvPayrollLines.Insert;
            gvPayrollUtilities.sGetDefaultEDDims2(lvPayrollLines);
            //end insert
        end;
        //End Compute tax on lump sum per year

        //Insert Lump Sum Payments into Payroll Entry and Payroll Lines tables
        lvLumpsumPayments.Reset;
        lvLumpsumPayments.SetCurrentKey("Employee No", "Assessment Year", "ED Code");
        lvLumpsumPayments.SetRange("Employee No", PayrollHdr."Employee no.");

        for lvIndex := 1 to lvAssessmentYrsFound do begin
            lvLumpsumPayments.SetRange(lvLumpsumPayments."Assessment Year", lvAssessmentYrsArray[lvIndex]);
            lvLumpsumPayments.Find('-');
            repeat
                //Insert Lump Sum Payments into payroll entry
                lvPayrollEntry.Init;
                lvEntryNo += 1;
                lvPayrollEntry."Entry No." := lvEntryNo;
                lvPayrollEntry."Payroll ID" := PayrollHdr."Payroll ID";
                lvPayrollEntry."Employee No." := PayrollHdr."Employee no.";
                lvPayrollEntry.Date := gvPostingDate;
                lvPayrollEntry.Validate("ED Code", lvLumpsumPayments."ED Code");
                lvPayrollEntry.Validate(Amount, lvLumpsumPayments."Amount (LCY)");
                lvPayrollEntry."Copy to next" := false;
                lvPayrollEntry."Reset Amount" := false;
                lvPayrollEntry.Editable := false;
                lvPayrollEntry."Payroll Code" := gvAllowedPayrolls."Payroll Code";
                lvPayrollEntry.Insert;

                //Insert Lump Sum Payments into payroll lines
                lvLastPayrollLineEntryNo += 1;
                lvPayrollLines."Entry No." := lvLastPayrollLineEntryNo;
                lvPayrollLines."Payroll ID" := PayrollHdr."Payroll ID";
                lvPayrollLines."Employee No." := PayrollHdr."Employee no.";
                lvPayrollLines."Global Dimension 1 Code" := lvEmployee."Global Dimension 1 Code";
                lvPayrollLines."Global Dimension 2 Code" := lvEmployee."Global Dimension 2 Code";
                lvPayrollLines."Posting Group" := lvEmployee."Posting Group";
                lvPayrollLines."ED Code" := lvLumpsumPayments."ED Code";
                lvEdDef.Get(lvLumpsumPayments."ED Code");
                lvPayrollLines.Text := StrSubstNo('%1 %2', lvEdDef."Payroll Text", lvLumpsumPayments."Assessment Year");
                lvPayrollLines.Amount := lvLumpsumPayments."Amount (LCY)";
                lvPayrollLines."Amount (LCY)" := lvLumpsumPayments."Amount (LCY)";
                lvPayrollLines."Calculation Group" := lvEdDef."Calculation Group";
                lvPayrollLines."LumpSum Line" := true;
                lvPayrollLines."Posting Date" := gvPostingDate;
                lvPayrollLines."Payroll Code" := gvAllowedPayrolls."Payroll Code";
                lvPayrollLines.Insert;
                gvPayrollUtilities.sGetDefaultEDDims2(lvPayrollLines);

                //flag lump sum payment
                lvLumpsumPayments."Linked Payroll Entry No" := lvEntryNo;
                lvLumpsumPayments."Linked Payroll Line No" := lvLastPayrollLineEntryNo;
                lvLumpsumPayments.Modify
            until lvLumpsumPayments.Next = 0
        end;
        //Insert Lump Sum Payments into Payroll Entry and Payroll Lines tables
    end;

    procedure LookUp2(LookupTableID: Code[20]; LookupAmount: Decimal; PayrollHdr: Record "Payroll Header") Tax: Decimal
    var
        LookUpHeader: Record "Lookup Table Header";
        LookUpLine: Record "Lookup Table Lines";
    begin
        //SKM 200405 This function looks up the tax or relief based on table ID and Amount

        LookUpHeader.Get(LookupTableID);
        LookUpLine.SetRange("Table ID", LookupTableID);
        Amount := LookupAmount;

        case LookUpHeader.Type of
            LookUpHeader.Type::Percentage:
                begin
                    LookUpLine.Find('-');

                    while Amount > LookUpLine."Upper Amount (LCY)" do
                        LookUpLine.Find('>');

                    Percent := LookUpLine.Percent;
                    if LookUpLine.Find('<') then begin
                        Cum := LookUpLine."Cumulate (LCY)";
                        Amount1 := ((Amount - LookUpLine."Upper Amount (LCY)") * Percent / 100) + Cum;
                    end else begin
                        Amount1 := (Amount * Percent / 100);
                    end;

                end;
            LookUpHeader.Type::"Extract Amount":
                begin
                    LookUpLine.Find('-');
                    while not (Amount <= LookUpLine."Upper Amount (LCY)") do
                        LookUpLine.Find('>');

                    Amount1 := LookUpLine."Extract Amount (LCY)";
                end;
            LookUpHeader.Type::Month:
                begin
                    LookUpLine.Find('-');
                    while PayrollHdr."Payroll Month" <> LookUpLine.Month do
                        LookUpLine.Find('>');
                    Amount1 := LookUpLine."Extract Amount (LCY)";
                end;
            LookUpHeader.Type::"Max Min":
                begin
                    if LookUpHeader."Min Extract Amount (LCY)" <> 0 then
                        if Amount < LookUpHeader."Min Extract Amount (LCY)" then
                            Amount1 := LookUpHeader."Min Extract Amount (LCY)";
                    if LookUpHeader."Max Extract Amount (LCY)" <> 0 then
                        if Amount > LookUpHeader."Max Extract Amount (LCY)" then
                            Amount1 := LookUpHeader."Max Extract Amount (LCY)";
                end;
        end;
        exit(Amount1);
    end;

    procedure GetSpecialAllowance(var pPayrollHdr: Record "Payroll Header")
    var
        lvPayrollEntry: Record "Payroll Entry";
        lvSpecialAllowances: Record "Special Allowances";
        lvTotalSpecAllowances: Decimal;
        lvTEB4SAPP: Decimal;
        lvTEB4SAPPLineNo: BigInteger;
        lvChargeablePayB4SAP: Decimal;
        lvChargeablePayB4SAPLineNo: BigInteger;
        lvTotalPayAfterTaxB4SAP: Decimal;
        lvTEWithSAPP: Decimal;
        lvTotalPayAfterTaxWithSAP: Decimal;
        lvPAYETableID: Code[20];
        lvPayeLookUpLineNo: BigInteger;
        lvEmployee: Record Employee;
        lvCurrentControlLineNo: BigInteger;
    begin
        //SKM 250405 this subroutine retrieves the Special Allowance value (net of tax) from Specail Allowances setup table and
        //computes its gross equivalent, it then inserts a recovery deduction for the allowance into employee's payroll
        //
        //A Special Allowance is a payment to an employee where the company pays for a certain expense on behalf of the
        //employee and also bears the tax burden on the allowance on behalf of the employee.

        PeriodRec.Get(pPayrollHdr."Payroll ID", pPayrollHdr."Payroll Month", pPayrollHdr."Payroll Year",
          pPayrollHdr."Payroll Code");
        gvLineNo2 := SchemeControlTmp."Line No."; //Note current control line pointer

        //Check if employee entitled to any special allowances compute total entitlement
        lvSpecialAllowances.SetRange("Employee No", pPayrollHdr."Employee no.");
        if lvSpecialAllowances.Find('-') then begin
            lvSpecialAllowances.CalcSums("Amount (LCY)");
            lvTotalSpecAllowances := lvSpecialAllowances."Amount (LCY)"
        end else begin
            SchemeControlTmp.SetRange("Special Allowance", true);
            SchemeControlTmp.ModifyAll("Special Allowance Calculated", true);
            SchemeControlTmp.SetFilter("Special Allowance", '');
            exit
        end;
        //End Check if employee entitled to any special allowances compute total entitlement

        //Reset Payroll Entry: Delete any Special Allowances earlier computed
        lvPayrollEntry.SetRange("Payroll ID", pPayrollHdr."Payroll ID");
        lvPayrollEntry.SetRange("Employee No.", pPayrollHdr."Employee no.");

        repeat
            lvPayrollEntry.SetFilter("ED Code", '%1|%2', lvSpecialAllowances."Allowance ED Code",
              lvSpecialAllowances."Deduction ED Code");
            lvPayrollEntry.DeleteAll(true);
        until lvSpecialAllowances.Next = 0;
        //End Reset

        //Get Total Payments before pension, Special Allowances and special payments (TEB4SAPP)
        SchemeValueTmp.Reset;
        SchemeValueTmp.SetRange(SchemeValueTmp."Scheme ID", Scheme);
        SchemeValueTmp.SetRange("Total Earnings (B4 SAPP)", true);

        if not SchemeValueTmp.Find('-') then
            Error('Calculation Line for Total Earnings (B4 SAPP) not identified in scheme %1.', Scheme);

        if SchemeValueTmp."Amount (LCY)" = 0 then
            Error('Scheme %1 Calculation Line %2 Total Earnings (B4 SAPP) should be known before a Special Allowance ' +
                  'line can be processed.', Scheme, SchemeValueTmp."Line No.");

        if SchemeValueTmp.Count > 1 then
            Error('Scheme %1: Multiple lines marked as Total Earnings (B4 SAPP)', Scheme);

        lvTEB4SAPP := SchemeValueTmp."Amount (LCY)";
        lvTEB4SAPPLineNo := SchemeValueTmp."Line No.";
        //End Get Total Payments before Special Allowances (TEB4SAPP)

        //Get Total Payments after pension without special allowances
        SchemeValueTmp.Reset;
        SchemeValueTmp.SetRange(SchemeValueTmp."Scheme ID", Scheme);
        SchemeValueTmp.SetRange("Chargeable Pay (B4 SAP)", true);

        if not SchemeValueTmp.Find('-') then
            Error('Calculation Line for Chargeable Pay (B4 SAP) not identified in scheme %1.', Scheme);

        if SchemeValueTmp."Amount (LCY)" = 0 then
            Error('Scheme %1 Calculation Line %2 Chargeable Pay (B4 SAP) should be known before a Special Allowance ' +
                  'line can be processed.', Scheme, SchemeControlTmp."Line No.");

        if SchemeValueTmp.Count > 1 then
            Error('Scheme %1: Multiple lines marked as Chargeable Pay (B4 SAP)', Scheme);

        lvChargeablePayB4SAP := SchemeValueTmp."Amount (LCY)";
        lvChargeablePayB4SAPLineNo := SchemeValueTmp."Line No.";
        //End Get Total Payments after pension without special allowances

        //Compute Payments Total after Tax without Special Allowances
        SchemeValueTmp.Reset;
        SchemeValueTmp.SetRange(SchemeValueTmp."Scheme ID", Scheme);
        SchemeValueTmp.SetRange("PAYE Lookup Line", true);

        if not SchemeValueTmp.Find('-') then
            Error('Calculation Line for PAYE Lookup Line is not identified in scheme %1.', Scheme);

        if SchemeValueTmp.Count > 1 then
            Error('Scheme %1: Multiple lines are marked as PAYE Lookup Lines.', Scheme);

        lvPAYETableID := SchemeValueTmp.LookUp;
        lvTotalPayAfterTaxB4SAP := lvChargeablePayB4SAP - LookUp2(lvPAYETableID, lvChargeablePayB4SAP, pPayrollHdr);
        lvPayeLookUpLineNo := SchemeValueTmp."Line No.";
        //End Compute Payments Total after Tax without Special Allowances

        //Determine the Gross Value of Special Allowance, add it to the initial total payments and recalculate Pension and PAYE
        lvTEWithSAPP := lvTEB4SAPP + lvTotalSpecAllowances;
        SchemeControlTmp.SetRange("Line No.", lvTEB4SAPPLineNo, lvChargeablePayB4SAPLineNo);

        repeat
            lvTEWithSAPP += 5; //Determine new Gross Value Inclusive of Special Allowances in increments of 5

            SchemeValueTmp.Reset;
            SchemeValueTmp.SetRange("Line No.", lvTEB4SAPPLineNo, lvPayeLookUpLineNo);
            SchemeValueTmp.ModifyAll(Amount, 0);
            SchemeValueTmp.Reset;

            SchemeControlTmp.Find('-');
            SchemeValueTmp.Get(SchemeControlTmp."Line No.", SchemeControlTmp."Scheme ID");
            SchemeValueTmp.Amount := lvTEWithSAPP;
            SchemeValueTmp."Amount (LCY)" := lvTEWithSAPP;
            SchemeValueTmp.Modify;
            repeat
                LineNo := SchemeControlTmp."Line No.";
                if SchemeControlTmp."Line No." > lvTEB4SAPPLineNo then GetInput(pPayrollHdr);
                RoundAmount;
                Calculate(pPayrollHdr);

                //Clear Previous payroll lines (gueses)
                if SchemeControlTmp."Payroll Lines" <> '' then begin
                    PayrollLinesTmp.SetRange("Payroll ID", pPayrollHdr."Payroll ID");
                    PayrollLinesTmp.SetRange("Employee No.", pPayrollHdr."Employee no.");
                    PayrollLinesTmp.SetRange("ED Code", SchemeControlTmp."Payroll Lines");
                    PayrollLinesTmp.DeleteAll(true);
                    PayrollLinesTmp.Reset
                end;
                //End Clear Previous payroll lines (gueses)

                Output(pPayrollHdr);
            until SchemeControlTmp.Next = 0;

            SchemeValueTmp.Get(LineNo, SchemeControlTmp."Scheme ID");
            lvTotalPayAfterTaxWithSAP := SchemeValueTmp."Amount (LCY)" - LookUp2(lvPAYETableID, SchemeValueTmp."Amount (LCY)", pPayrollHdr
        );
        until lvTotalPayAfterTaxWithSAP >= (lvTotalPayAfterTaxB4SAP + lvTotalSpecAllowances);
        //End Determine the Gross Value of Special Allowance, add it to the initial total payments and recalculate Pension and PAYE

        lvSpecialAllowances.Find('-');
        lvEmployee.Get(pPayrollHdr."Employee no.");
        repeat
            //Insert Gross Value of Special Allowance ED Line into Payroll Entry & Payroll Lines
            if lvPayrollEntry.Find('+') then
                lvPayrollEntry."Entry No." += 1
            else
                lvPayrollEntry."Entry No." := 1;
            EDDefinitionTmp.Get(lvSpecialAllowances."Allowance ED Code");
            lvPayrollEntry."Entry No." := PayrollLinesTmpLineNo;
            lvPayrollEntry.Date := PeriodRec."Posting Date";
            lvPayrollEntry."Payroll ID" := Period;
            lvPayrollEntry."Employee No." := pPayrollHdr."Employee no.";
            lvPayrollEntry.Validate("ED Code", lvSpecialAllowances."Allowance ED Code");
            lvPayrollEntry.Text := EDDefinitionTmp."Payroll Text";
            //Apportion the gross value of total allowances to individual Special Allowance EDs
            lvPayrollEntry.Validate(Amount,
              Round(lvSpecialAllowances."Amount (LCY)" * (lvTEWithSAPP - lvTEB4SAPP) / lvTotalSpecAllowances, 1));
            lvPayrollEntry."Payroll Code" := gvAllowedPayrolls."Payroll Code";
            lvPayrollEntry.Insert;

            PayrollLinesTmpLineNo := PayrollLinesTmpLineNo + 1;
            PayrollLinesTmp.Init;
            PayrollLinesTmp."Entry No." := PayrollLinesTmpLineNo;
            PayrollLinesTmp."Payroll ID" := Period;
            PayrollLinesTmp."Employee No." := pPayrollHdr."Employee no.";
            PayrollLinesTmp."Global Dimension 1 Code" := lvEmployee."Global Dimension 1 Code";
            PayrollLinesTmp."Global Dimension 2 Code" := lvEmployee."Global Dimension 2 Code";
            PayrollLinesTmp."Posting Group" := lvEmployee."Posting Group";
            PayrollLinesTmp."ED Code" := lvSpecialAllowances."Allowance ED Code";
            PayrollLinesTmp.Text := EDDefinitionTmp."Payroll Text";
            PayrollLinesTmp.Amount := Round(lvSpecialAllowances."Amount (LCY)" * (lvTEWithSAPP - lvTEB4SAPP) / lvTotalSpecAllowances, 1);
            PayrollLinesTmp."Amount (LCY)" :=
              Round(lvSpecialAllowances."Amount (LCY)" * (lvTEWithSAPP - lvTEB4SAPP) / lvTotalSpecAllowances, 1);
            PayrollLinesTmp."Calculation Group" := EDDefinitionTmp."Calculation Group";
            PayrollLinesTmp."Posting Date" := gvPostingDate;
            PayrollLinesTmp."Payroll Code" := gvAllowedPayrolls."Payroll Code";
            PayrollLinesTmp.Insert;
            gvPayrollUtilities.sGetDefaultEDDims2(PayrollLinesTmp);
            //End. Insert Gross Value of Special Allowance ED Line into Payroll Entry & Payroll Lines

            //Insert Special Allowance Recovery ED Line into Payroll Entry & Payroll Lines
            if lvPayrollEntry.Find('+') then
                lvPayrollEntry."Entry No." += 1
            else
                lvPayrollEntry."Entry No." := 1;
            EDDefinitionTmp.Get(lvSpecialAllowances."Deduction ED Code");
            lvPayrollEntry."Payroll ID" := Period;
            lvPayrollEntry.Date := PeriodRec."Posting Date";
            lvPayrollEntry."Employee No." := pPayrollHdr."Employee no.";
            lvPayrollEntry.Validate("ED Code", lvSpecialAllowances."Deduction ED Code");
            lvPayrollEntry.Text := EDDefinitionTmp."Payroll Text";
            lvPayrollEntry.Validate(Amount, lvSpecialAllowances."Amount (LCY)");
            lvPayrollEntry."Payroll Code" := gvAllowedPayrolls."Payroll Code";
            lvPayrollEntry.Insert;

            PayrollLinesTmpLineNo := PayrollLinesTmpLineNo + 1;
            PayrollLinesTmp.Init;
            PayrollLinesTmp."Entry No." := PayrollLinesTmpLineNo;
            PayrollLinesTmp."Payroll ID" := Period;
            PayrollLinesTmp."Employee No." := pPayrollHdr."Employee no.";
            PayrollLinesTmp."Global Dimension 1 Code" := lvEmployee."Global Dimension 1 Code";
            PayrollLinesTmp."Global Dimension 2 Code" := lvEmployee."Global Dimension 2 Code";
            PayrollLinesTmp."Posting Group" := lvEmployee."Posting Group";
            PayrollLinesTmp."ED Code" := lvSpecialAllowances."Deduction ED Code";
            PayrollLinesTmp.Text := EDDefinitionTmp."Payroll Text";
            PayrollLinesTmp.Amount := lvSpecialAllowances."Amount (LCY)";
            PayrollLinesTmp."Amount (LCY)" := lvSpecialAllowances."Amount (LCY)";
            PayrollLinesTmp."Calculation Group" := EDDefinitionTmp."Calculation Group";
            PayrollLinesTmp."Posting Date" := gvPostingDate;
            PayrollLinesTmp."Payroll Code" := gvAllowedPayrolls."Payroll Code";
            PayrollLinesTmp.Insert;
            gvPayrollUtilities.sGetDefaultEDDims2(PayrollLinesTmp);
        //Insert Special Allowance Recovery ED Line into Payroll Entry & Payroll Lines
        until lvSpecialAllowances.Next = 0;

        //Skip subsequent special allowance calculation lines since ALL already calculated
        SchemeControlTmp.Reset;
        SchemeControlTmp.SetRange("Scheme ID", Scheme);
        SchemeControlTmp.SetRange("Special Allowance", true);
        SchemeControlTmp.ModifyAll("Special Allowance Calculated", true);
        //End Skip subsequent special allowance calculation lines since ALL already calculated

        //Restore Control Record Pointer
        SchemeControlTmp.Reset;
        SchemeControlTmp.SetRange("Scheme ID", Scheme);
        LineNo := gvLineNo2;
        SchemeControlTmp.Get(LineNo, Scheme);
        //End Restore Control Record Pointer
    end;

    procedure GetSpecialPayments(var pPayrollHdr: Record "Payroll Header")
    var
        lvPayrollEntry: Record "Payroll Entry";
        lvSpecialPayments: Record "Special Payments";
        lvTEB4SPP: Decimal;
        lvTEB4SPPLineNo: BigInteger;
        lvChargeablePayB4SP: Decimal;
        lvChargeablePayB4SPLineNo: BigInteger;
        lvTotalPayAfterTaxB4SP: Decimal;
        lvTEWithSPP: Decimal;
        lvTotalPayAfterTaxWithSP: Decimal;
        lvPAYETableID: Code[20];
        lvPayeLookUpLineNo: BigInteger;
        lvEmployee: Record Employee;
        lvCurrentControlLineNo: BigInteger;
        lvPayrollSetup: Record "Payroll Setups";
        lvSpecialPaymentED: Record "ED Definitions";
        lvBasicSalary: Decimal;
        lvSalaryScaleStep: Record "Salary Scale Step";
        lvTotalNetSpecialPaymentsLCY: Decimal;
        lvCurrencyFactor: Decimal;
        lvCurrExchRate: Record "Currency Exchange Rate";
        lvIndividualSpecialPaymentLCY: Decimal;
    begin
        //SKM 130505 this subroutine computes the Special Payment value (net of tax) based on the entitlement in the special payments
        //setup table
        //
        //A Special Payment is a payment computed as a percentage of Basic Salary and the company bears the tax burden.

        lvPayrollSetup.Get(pPayrollHdr."Payroll Code");
        lvSpecialPaymentED.SetRange("Special Payment", true);
        if lvSpecialPaymentED.Find('-') then begin
            //Get basic pay
            lvEmployee.Get(pPayrollHdr."Employee no.");
            if lvEmployee."Basic Pay Currency" <> '' then
                lvCurrencyFactor := lvCurrExchRate.ExchangeRate(gvPostingDate, lvEmployee."Basic Pay Currency")
            else
                lvCurrencyFactor := 0;

            if lvEmployee."Basic Pay" = lvEmployee."Basic Pay"::Fixed then begin
                lvEmployee.TestField("Fixed Pay");
                lvBasicSalary := lvEmployee."Fixed Pay";
            end else if lvEmployee."Basic Pay" = lvEmployee."Basic Pay"::Scale then begin
                lvSalaryScaleStep.SetRange(Scale, lvEmployee."Salary Scale");
                lvSalaryScaleStep.SetRange(Code, lvEmployee."Scale Step");
                lvSalaryScaleStep.SetRange("Currency Code", lvEmployee."Basic Pay Currency");
                if not lvSalaryScaleStep.Find('-') then
                    Error('Employee %1, Salary Scale Step in Employee''s Basic Pay Currency not found.', lvEmployee."No.");
                lvSalaryScaleStep.TestField(Amount);
                lvBasicSalary := lvSalaryScaleStep.Amount
            end else begin
                Message('Employee %1: Special Payment not inserted. Basic Salary not defined.', lvEmployee."No.");
                exit
            end;
            //End Get basic pay

            //Reset Payroll Entry: Delete any Special Payments earlier computed and compute Net Total of Special Payments entitled
            lvSpecialPayments.SetCurrentKey("Payment ED Code", "Min Basic Salary");
            lvPayrollEntry.SetRange("Payroll ID", pPayrollHdr."Payroll ID");
            lvPayrollEntry.SetRange("Employee No.", pPayrollHdr."Employee no.");

            repeat
                lvPayrollEntry.SetRange("ED Code", lvSpecialPaymentED."ED Code");
                lvPayrollEntry.DeleteAll(true);

                lvSpecialPayments.SetRange("Payment ED Code", lvSpecialPaymentED."ED Code");
                lvSpecialPayments.SetRange("Min Basic Salary", 0, lvBasicSalary);
                lvSpecialPayments.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                lvSpecialPayments.SetRange("Currency Code", lvEmployee."Basic Pay Currency");
                if not lvSpecialPayments.Find('+') then
                    Error('ED %1, Basic Pay %1, Currency Code %3, no Special Payment entitlement entry found.',
                      lvSpecialPaymentED."ED Code", lvBasicSalary, lvEmployee."Basic Pay Currency");
                lvTotalNetSpecialPaymentsLCY += Round(lvSpecialPayments."Granted Rate (%)" * lvBasicSalary / 100, 0.01)

             until lvSpecialPaymentED.Next = 0;

            lvTotalNetSpecialPaymentsLCY :=
               Round(lvCurrExchRate.ExchangeAmtFCYToLCY(gvPostingDate, lvEmployee."Basic Pay Currency",
               lvTotalNetSpecialPaymentsLCY, lvCurrencyFactor));
            //End Reset
        end else
            Error('Please mark Special Payment EDs or deactivate their insertion on Payroll Setup.');

        if not lvPayrollSetup."Insert Special Payments" then exit;

        PeriodRec.Get(pPayrollHdr."Payroll ID", pPayrollHdr."Payroll Month", pPayrollHdr."Payroll Year",
          pPayrollHdr."Payroll Code");
        gvLineNo2 := SchemeControlTmp."Line No."; //Note current control line pointer

        //Get Total Payments before pension and special payments (lvTEB4SPP)
        SchemeValueTmp.Reset;
        SchemeValueTmp.SetRange(SchemeValueTmp."Scheme ID", Scheme);
        SchemeValueTmp.SetRange("Total Earnings (B4 SAPP)", true);

        if not SchemeValueTmp.Find('-') then
            Error('Calculation Line for Total Earnings (B4 SAPP) not identified in scheme %1.', Scheme);

        if SchemeValueTmp."Amount (LCY)" = 0 then
            Error('Scheme %1 Calculation Line %2 Total Earnings (B4 SAPP) should be known before a Special Allowance ' +
                  'line can be processed.', Scheme, SchemeValueTmp."Line No.");

        if SchemeValueTmp.Count > 1 then
            Error('Scheme %1: Multiple lines marked as Total Earnings (B4 SAPP)', Scheme);

        lvTEB4SPP := SchemeValueTmp."Amount (LCY)";
        lvTEB4SPPLineNo := SchemeValueTmp."Line No.";
        //End Get Total Payments before pension and special payments (lvTEB4SPP)

        //Get Total Payments after pension without special payments
        SchemeValueTmp.Reset;
        SchemeValueTmp.SetRange(SchemeValueTmp."Scheme ID", Scheme);
        SchemeValueTmp.SetRange("Chargeable Pay (B4 SAP)", true);

        if not SchemeValueTmp.Find('-') then
            Error('Calculation Line for Chargeable Pay (B4 SAP) not identified in scheme %1.', Scheme);

        if SchemeValueTmp."Amount (LCY)" = 0 then
            Error('Scheme %1 Calculation Line %2 Chargeable Pay (B4 SAP) should be known before a Special Payment ' +
                  'line can be processed.', Scheme, SchemeControlTmp."Line No.");

        if SchemeValueTmp.Count > 1 then
            Error('Scheme %1: Multiple lines marked as Chargeable Pay (B4 SAP)', Scheme);

        lvChargeablePayB4SP := SchemeValueTmp."Amount (LCY)";
        lvChargeablePayB4SPLineNo := SchemeValueTmp."Line No.";
        //Get Total Payments after pension without special payments

        //Compute Payments Total after Tax without Special Payments
        SchemeValueTmp.Reset;
        SchemeValueTmp.SetRange(SchemeValueTmp."Scheme ID", Scheme);
        SchemeValueTmp.SetRange("PAYE Lookup Line", true);

        if not SchemeValueTmp.Find('-') then
            Error('Calculation Line for PAYE Lookup Line is not identified in scheme %1.', Scheme);

        if SchemeValueTmp.Count > 1 then
            Error('Scheme %1: Multiple lines are marked as PAYE Lookup Lines.', Scheme);

        lvPAYETableID := SchemeValueTmp.LookUp;
        lvTotalPayAfterTaxB4SP := lvChargeablePayB4SP - LookUp2(lvPAYETableID, lvChargeablePayB4SP, pPayrollHdr);
        lvPayeLookUpLineNo := SchemeValueTmp."Line No.";
        //End Compute Payments Total after Tax without Special Payments

        //Determine the Gross Value of Special Payment, add it to the initial total payments and recalculate Pension and PAYE
        lvTEWithSPP := lvTEB4SPP + lvTotalNetSpecialPaymentsLCY;
        SchemeControlTmp.SetRange("Line No.", lvTEB4SPPLineNo, lvChargeablePayB4SPLineNo);

        repeat
            lvTEWithSPP += 5; //Determine new Gross Value Inclusive of Special Payments in increments of 5

            SchemeValueTmp.Reset;
            SchemeValueTmp.SetRange("Line No.", lvTEB4SPPLineNo, lvPayeLookUpLineNo);
            SchemeValueTmp.ModifyAll(Amount, 0);
            SchemeValueTmp.ModifyAll("Amount (LCY)", 0);
            SchemeValueTmp.Reset;

            SchemeControlTmp.Find('-');
            SchemeValueTmp.Get(SchemeControlTmp."Line No.", SchemeControlTmp."Scheme ID");
            SchemeValueTmp.Amount := lvTEWithSPP;
            SchemeValueTmp."Amount (LCY)" := lvTEWithSPP;
            SchemeValueTmp.Modify;
            repeat
                LineNo := SchemeControlTmp."Line No.";
                if SchemeControlTmp."Line No." > lvTEB4SPPLineNo then GetInput(pPayrollHdr);
                RoundAmount;
                Calculate(pPayrollHdr);

                //Clear Previous payroll lines (gueses)
                if SchemeControlTmp."Payroll Lines" <> '' then begin
                    PayrollLinesTmp.SetRange("Payroll ID", pPayrollHdr."Payroll ID");
                    PayrollLinesTmp.SetRange("Employee No.", pPayrollHdr."Employee no.");
                    PayrollLinesTmp.SetRange("ED Code", SchemeControlTmp."Payroll Lines");
                    PayrollLinesTmp.DeleteAll(true);
                    PayrollLinesTmp.Reset
                end;
                //End Clear Previous payroll lines (gueses)

                Output(pPayrollHdr);
            until SchemeControlTmp.Next = 0;

            SchemeValueTmp.Get(LineNo, SchemeControlTmp."Scheme ID");
            lvTotalPayAfterTaxWithSP := SchemeValueTmp.Amount - LookUp2(lvPAYETableID, SchemeValueTmp.Amount, pPayrollHdr);
        until lvTotalPayAfterTaxWithSP >= (lvTotalPayAfterTaxB4SP + lvTotalNetSpecialPaymentsLCY);
        //End Determine the Gross Value of Special Payment, add it to the initial total payments and recalculate Pension and PAYE

        //Insert Gross Value of Special Payment ED Line into Payroll Entry & Payroll Lines
        lvSpecialPaymentED.Find('-');
        repeat
            lvSpecialPayments.Reset;
            lvSpecialPayments.SetCurrentKey("Payment ED Code", "Min Basic Salary");
            lvSpecialPayments.SetRange("Payment ED Code", lvSpecialPaymentED."ED Code");
            lvSpecialPayments.SetRange("Min Basic Salary", 0, lvBasicSalary);
            lvSpecialPayments.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
            lvSpecialPayments.Find('+');

            if lvPayrollEntry.Find('+') then
                lvPayrollEntry."Entry No." += 1
            else
                lvPayrollEntry."Entry No." := 1;

            EDDefinitionTmp.Get(lvSpecialPayments."Payment ED Code");
            lvPayrollEntry."Entry No." := PayrollLinesTmpLineNo;
            lvPayrollEntry.Date := PeriodRec."Posting Date";
            lvPayrollEntry."Payroll ID" := Period;
            lvPayrollEntry."Employee No." := pPayrollHdr."Employee no.";
            lvPayrollEntry.Validate("ED Code", lvSpecialPayments."Payment ED Code");
            lvPayrollEntry.Text := EDDefinitionTmp."Payroll Text";

            //Apportion the gross value of total payment to individual Special Payment EDs
            lvIndividualSpecialPaymentLCY := Round(
              Round(lvSpecialPayments."Granted Rate (%)" * lvBasicSalary / 100, 0.01) *
                   (lvTEWithSPP - lvTEB4SPP) / lvTotalNetSpecialPaymentsLCY, 1);
            if lvSpecialPayments."Currency Code" = '' then
                lvPayrollEntry.Validate(Amount, lvIndividualSpecialPaymentLCY)
            else begin
                lvPayrollEntry."Currency Code" := lvSpecialPayments."Currency Code";
                lvPayrollEntry."Currency Factor" := lvCurrExchRate.ExchangeRate(gvPostingDate, lvSpecialPayments."Currency Code");
                lvPayrollEntry.Validate(Amount,
                  lvCurrExchRate.ExchangeAmtLCYToFCY(gvPostingDate, lvSpecialPayments."Currency Code",
                    lvIndividualSpecialPaymentLCY, lvPayrollEntry."Currency Factor"))
            end;
            lvPayrollEntry."Payroll Code" := gvAllowedPayrolls."Payroll Code";
            lvPayrollEntry.Insert;

            PayrollLinesTmpLineNo := PayrollLinesTmpLineNo + 1;
            PayrollLinesTmp.Init;
            PayrollLinesTmp."Entry No." := PayrollLinesTmpLineNo;
            PayrollLinesTmp."Payroll ID" := Period;
            PayrollLinesTmp."Employee No." := pPayrollHdr."Employee no.";
            PayrollLinesTmp."Global Dimension 1 Code" := lvEmployee."Global Dimension 1 Code";
            PayrollLinesTmp."Global Dimension 2 Code" := lvEmployee."Global Dimension 2 Code";
            PayrollLinesTmp."Posting Group" := lvEmployee."Posting Group";
            PayrollLinesTmp."ED Code" := lvSpecialPayments."Payment ED Code";
            PayrollLinesTmp.Text := EDDefinitionTmp."Payroll Text";
            PayrollLinesTmp."Calculation Group" := EDDefinitionTmp."Calculation Group";
            if lvSpecialPayments."Currency Code" = '' then
                PayrollLinesTmp.Amount := lvIndividualSpecialPaymentLCY
            else begin
                PayrollLinesTmp."Currency Code" := lvSpecialPayments."Currency Code";
                PayrollLinesTmp."Currency Factor" := lvCurrExchRate.ExchangeRate(gvPostingDate, lvSpecialPayments."Currency Code");
                PayrollLinesTmp.Amount :=
                  lvCurrExchRate.ExchangeAmtLCYToFCY(gvPostingDate, lvSpecialPayments."Currency Code",
                    lvIndividualSpecialPaymentLCY, PayrollLinesTmp."Currency Factor")
            end;
            PayrollLinesTmp."Amount (LCY)" := lvIndividualSpecialPaymentLCY;
            PayrollLinesTmp."Posting Date" := gvPostingDate;
            PayrollLinesTmp."Payroll Code" := gvAllowedPayrolls."Payroll Code";
            PayrollLinesTmp.Insert;
            gvPayrollUtilities.sGetDefaultEDDims2(PayrollLinesTmp);
        until lvSpecialPaymentED.Next = 0;
        //End. Insert Gross Value of Special Allowance ED Line into Payroll Entry & Payroll Lines

        //Skip subsequent special payment calculation lines since ALL already calculated
        SchemeControlTmp.Reset;
        SchemeControlTmp.SetRange("Scheme ID", Scheme);
        SchemeControlTmp.SetRange("Special Payment", true);
        SchemeControlTmp.ModifyAll("Special Payment Calculated", true);
        //End Skip subsequent special payment calculation lines since ALL already calculated

        //Restore Control Record Pointer
        SchemeControlTmp.Reset;
        SchemeControlTmp.SetRange("Scheme ID", Scheme);
        LineNo := gvLineNo2;
        SchemeControlTmp.Get(LineNo, Scheme);
        //End Restore Control Record Pointer
    end;

    procedure GetCommission(pPayrollHdr: Record "Payroll Header")
    var
        lvCommissionRate: Record "Commission Rates";
        lvPayrollPeriod: Record Periods;
        lvPayrollEntry: Record "Payroll Entry";
        lvNextPayrollEntryNo: Integer;
        lvSalesInvoiceHeader: Record "Sales Invoice Header";
        lvEmployee: Record Employee;
        lvCommissionAmountLCY: Decimal;
        lvCommissionBaseAmntLCY: Decimal;
        lvCustLedger: Record "Cust. Ledger Entry";
    begin
        //SKM 130505 this subroutine computes the commissionamount based on the entitlements in the
        //Commission Rates table.

        //Get payroll period whose payroll is being processed
        lvPayrollPeriod.SetRange("Period ID", pPayrollHdr."Payroll ID");
        lvPayrollPeriod.SetRange("Payroll Code", pPayrollHdr."Payroll Code");
        lvPayrollPeriod.FindFirst;

        //Check for qualifying commission rates
        lvCommissionRate.SetCurrentKey("Employee No", "Valid To Date", Base);
        lvCommissionRate.SetRange("Employee No", pPayrollHdr."Employee no.");
        lvCommissionRate.SetFilter("Valid To Date", '>=%1', lvPayrollPeriod."Start Date");
        if lvCommissionRate.FindFirst then
            repeat
                lvPayrollEntry.SetRange("ED Code", lvCommissionRate."ED Code");
                lvPayrollEntry.SetRange("Payroll ID", pPayrollHdr."Payroll ID");
                lvPayrollEntry.SetRange("Employee No.", pPayrollHdr."Employee no.");
                lvPayrollEntry.SetRange("Payroll Code", pPayrollHdr."Payroll Code");
                if lvPayrollEntry.FindFirst then lvPayrollEntry.DeleteAll(true);

                lvPayrollEntry.Reset;
                lvPayrollEntry.SetRange("ED Code", lvCommissionRate."ED Code");
                if lvPayrollEntry.FindLast then lvNextPayrollEntryNo := lvPayrollEntry."Entry No." + 1;

                //Calc Commission Base Amount
                lvCommissionBaseAmntLCY := 0;
                lvCommissionAmountLCY := 0;
                lvEmployee.Get(pPayrollHdr."Employee no.");

                case lvCommissionRate.Base of
                    lvCommissionRate.Base::"Basic Salary":
                        begin
                            if pPayrollHdr."Basic Pay" = 0 then
                                Error('Employee %1, commission base of Basic Salary is invalid when Basic Pay is zero.', pPayrollHdr."Employee no.");
                            lvCommissionBaseAmntLCY := pPayrollHdr."Basic Pay (LCY)";
                        end;

                    lvCommissionRate.Base::"Sales Turnover":
                        begin
                            lvEmployee.TestField(lvEmployee."Salespers./Purch. Code");

                            lvSalesInvoiceHeader.SetCurrentKey("Salesperson Code", "Posting Date");
                            lvSalesInvoiceHeader.SetRange("Salesperson Code", lvEmployee."Salespers./Purch. Code");
                            lvSalesInvoiceHeader.SetRange("Posting Date", lvPayrollPeriod."Start Date", lvPayrollPeriod."End Date");

                            if lvSalesInvoiceHeader.FindFirst then
                                repeat
                                    lvSalesInvoiceHeader.CalcFields(Amount);
                                    if lvSalesInvoiceHeader."Currency Code" = '' then
                                        lvCommissionBaseAmntLCY += lvSalesInvoiceHeader.Amount
                                    else
                                        lvCommissionBaseAmntLCY += Round(lvSalesInvoiceHeader.Amount / lvSalesInvoiceHeader."Currency Factor", 1)
                                until lvSalesInvoiceHeader.Next = 0
                        end;

                    lvCommissionRate.Base::"Receipts Collected":
                        begin
                            lvEmployee.TestField(lvEmployee."Salespers./Purch. Code");

                            lvCustLedger.SetCurrentKey("Salesperson Code", "Posting Date");
                            lvCustLedger.SetRange("Salesperson Code", lvEmployee."Salespers./Purch. Code");
                            lvCustLedger.SetRange("Posting Date", lvPayrollPeriod."Start Date", lvPayrollPeriod."End Date");
                            lvCustLedger.SetRange("Document Type", lvCustLedger."Document Type"::Payment);

                            if lvCustLedger.FindFirst then
                                repeat
                                    lvCustLedger.CalcFields("Amount (LCY)");
                                    lvCommissionBaseAmntLCY -= lvCustLedger."Amount (LCY)";
                                until lvCustLedger.Next = 0
                        end;
                end;

                //Check Within Minimum Allowed Threshold
                if lvCommissionBaseAmntLCY >= lvCommissionRate."Threshold Amount LCY" then
                    if lvCommissionRate."Commission %" <> 0 then
                        lvCommissionAmountLCY := Round(lvCommissionBaseAmntLCY * lvCommissionRate."Commission %" / 100, 1)
                    else
                        lvCommissionAmountLCY := lvCommissionRate."Commission Amount LCY";

                //Insert Commission Payroll Entry
                if lvCommissionAmountLCY <> 0 then begin
                    lvPayrollEntry.Init;
                    lvPayrollEntry."Entry No." := lvNextPayrollEntryNo;
                    lvPayrollEntry.Date := gvPostingDate;
                    lvPayrollEntry."Payroll ID" := pPayrollHdr."Payroll ID";
                    lvPayrollEntry."Employee No." := pPayrollHdr."Employee no.";
                    lvPayrollEntry."Payroll Code" := pPayrollHdr."Payroll Code";
                    lvPayrollEntry.Validate("ED Code", lvCommissionRate."ED Code");
                    lvPayrollEntry.Validate(Amount, lvCommissionAmountLCY);
                    lvPayrollEntry.Insert(true);
                end
            until lvCommissionRate.Next = 0;
    end;

    procedure FlushTmp(var Header: Record "Payroll Header")
    var
        PayrollLines: Record "Payroll Lines";
        PayslipEntryNo: Integer;
        NetamountLCY: Decimal;
        RoundAmount1: Decimal;
        PayrollSetupRec: Record "Payroll Setups";
        EdDef: Record "ED Definitions";
        lvPayrollEntry: Record "Payroll Entry";
        lvEntryNo: Integer;
    begin
        PayrollSetupRec.Get(Header."Payroll Code");
        NetamountLCY := 0;
        PayrollLines.SetRange("Payroll ID", Header."Payroll ID");
        PayrollLines.SetRange("Employee No.", Header."Employee no.");
        PayrollLines.DeleteAll(true);

        PayrollLines.Reset;
        if PayrollLines.Find('+') then
            PayslipEntryNo := PayrollLines."Entry No."
        else
            PayslipEntryNo := 0;

        if PayrollLinesTmp.Find('-') then begin
            repeat
                PayslipEntryNo := PayslipEntryNo + 1;
                PayrollLines.Copy(PayrollLinesTmp);
                PayrollLines."Entry No." := PayslipEntryNo;
                PayrollLines."Payroll Code" := gvAllowedPayrolls."Payroll Code";
                PayrollLines.Insert;
                gvPayrollUtilities.sCopyDimsFromLineToLine(PayrollLinesTmp, PayrollLines);
            until PayrollLinesTmp.Next = 0;

            GetLumpSum(Header); //Compute Tax on Lump Sum Payments

            //Compute netpay after lump sum
            PayrollLines.Reset;
            PayrollLines.SetRange("Payroll ID", Header."Payroll ID");
            PayrollLines.SetRange("Employee No.", Header."Employee no.");
            if PayrollLines.Find('-') then
                repeat
                    if PayrollLines."Calculation Group" = PayrollLines."Calculation Group"::Payments then
                        NetamountLCY += PayrollLines."Amount (LCY)";
                    if PayrollLines."Calculation Group" = PayrollLines."Calculation Group"::Deduction then
                        NetamountLCY -= PayrollLines."Amount (LCY)";
                until PayrollLines.Next = 0;
            //End Compute netpay after lump sum

            //Insert Net Pay Rounding Carried Forward
            //IF PayrollSetupRec."Net Pay Rounding Precision" <> 0 THEN BEGIN//rgk added. No need to do the below if rounding not specified
            if NetamountLCY > 0 then begin
                if PayrollSetupRec."Net Pay Rounding Precision" <> 0 then
                    RoundAmount1 := NetamountLCY mod PayrollSetupRec."Net Pay Rounding Precision";

                if (RoundAmount1 <> 0) and (RoundAmount1 >= PayrollSetupRec."Net Pay Rounding Mid Amount") then
                    RoundAmount1 := PayrollSetupRec."Net Pay Rounding Precision" - RoundAmount1;

                if RoundAmount1 <> 0 then begin
                    PayrollLines.Reset;
                    if PayrollLines.Find('+') then
                        PayslipEntryNo := PayrollLines."Entry No."
                    else
                        PayslipEntryNo := 0;

                    PayrollLines.Init;
                    PayslipEntryNo := PayslipEntryNo + 1;


                    PayrollLines."Entry No." := PayslipEntryNo;
                    //rgk 18/01/2010 commented two lines below. Replaced them with the two after them.
                    //PayrollLines."Payroll ID" := PayrollHeader."Payroll ID";
                    //PayrollLines."Employee No." := PayrollHeader."Employee no.";
                    PayrollLines."Payroll ID" := Header."Payroll ID";
                    PayrollLines."Employee No." := Header."Employee no.";

                    PayrollLines."Posting Date" := gvPostingDate;

                    if NetamountLCY mod PayrollSetupRec."Net Pay Rounding Precision" >= PayrollSetupRec."Net Pay Rounding Mid Amount" then begin
                        PayrollLines."ED Code" := PayrollSetupRec."Net Pay Rounding C/F (-ve)";
                        EdDef.Get(PayrollSetupRec."Net Pay Rounding C/F (-ve)");
                    end else begin
                        PayrollLines."ED Code" := PayrollSetupRec."Net Pay Rounding C/F";
                        EdDef.Get(PayrollSetupRec."Net Pay Rounding C/F");
                    end;

                    PayrollLines.Text := EdDef."Payroll Text";
                    PayrollLines.Amount := RoundAmount1;
                    PayrollLines."Amount (LCY)" := RoundAmount1;
                    PayrollLines."Calculation Group" := EdDef."Calculation Group";
                    PayrollLines."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    PayrollLines."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                    PayrollLines."Posting Group" := Employee."Posting Group";
                    PayrollLines.Rounding := EdDef."Rounding ED";
                    PayrollLines."Payroll Code" := gvAllowedPayrolls."Payroll Code";
                    PayrollLines.Insert;
                    gvPayrollUtilities.sGetDefaultEDDims2(PayrollLines);
                end;
            end;
            /*
              //RGK Insert Rounding to Payroll Entry
               lvPayrollEntry.INIT;
               lvEntryNo += 1;
               lvPayrollEntry."Entry No." := lvEntryNo;
               lvPayrollEntry."Payroll ID" := Header."Payroll ID";
               lvPayrollEntry."Employee No." := Header."Employee no.";
               lvPayrollEntry.Date := gvPostingDate;
               //lvPayrollEntry.VALIDATE("ED Code", EdDef."Rounding ED");
               IF NetamountLCY MOD PayrollSetupRec."Net Pay Rounding Precision" >= PayrollSetupRec."Net Pay Rounding Mid Amount" THEN BEGIN
                 lvPayrollEntry.VALIDATE("ED Code",PayrollSetupRec."Net Pay Rounding C/F (-ve)");
                 EdDef.GET(PayrollSetupRec."Net Pay Rounding C/F (-ve)");
               END ELSE BEGIN
                 lvPayrollEntry.VALIDATE("ED Code",PayrollSetupRec."Net Pay Rounding C/F");
                 PayrollLines."ED Code" := PayrollSetupRec."Net Pay Rounding C/F";
                 EdDef.GET(PayrollSetupRec."Net Pay Rounding C/F");
               END;
               lvPayrollEntry.VALIDATE(Amount, RoundAmount1);
               lvPayrollEntry."Copy to next" := FALSE;
               lvPayrollEntry."Reset Amount" := FALSE;
               lvPayrollEntry.Editable := FALSE;
               lvPayrollEntry."Payroll Code" := gvAllowedPayrolls."Payroll Code";
               lvPayrollEntry.INSERT;
               //RGK End Insert
            */
            /*
              //RGK added this Compute netpay after rounding
              NetamountLCY:=0;
              PayrollLines.RESET;
              PayrollLines.SETRANGE("Payroll ID",Header."Payroll ID");
              PayrollLines.SETRANGE("Employee No.",Header."Employee no.");
              IF  PayrollLines.FIND('-') THEN
                REPEAT
                  IF PayrollLines."Calculation Group" = PayrollLines."Calculation Group"::Payments THEN
                    NetamountLCY += PayrollLines."Amount (LCY)";
                  IF PayrollLines."Calculation Group" = PayrollLines."Calculation Group"::Deduction THEN
                    NetamountLCY -= PayrollLines."Amount (LCY)";
                UNTIL PayrollLines.NEXT = 0;
              //RGK End Compute netpay after rounding

             END;//rgk added this line. No need to do the below if rounding not specified
            */

        end;

        PayrollLinesTmp.DeleteAll(true); //skm060606 del any associated dims

    end;

    procedure LookUpEthiopia(var Header: Record "Payroll Header")
    var
        LookUpHeader: Record "Lookup Table Header";
        LookUpLine: Record "Lookup Table Lines";
        Relief: Decimal;
    begin
        // CSM 10082010 Ethiopian Tax tables use a straight percentage for each tax bracket, no cumulation
        LookUpHeader.Get(SchemeControlTmp.LookUp);
        LookUpLine.SetRange("Table ID", SchemeControlTmp.LookUp);
        //V.6.1.65_10SEP10 >>
        if not Flag then
            SchemeValueTmp.Get(LineNo, Scheme);
        Amount := SchemeValueTmp.Amount;
        "Amount (LCY)" := SchemeValueTmp."Amount (LCY)";

        case LookUpHeader.Type of
            LookUpHeader.Type::Percentage:
                begin
                    LookUpLine.Find('-');
                    while "Amount (LCY)" > LookUpLine."Upper Amount (LCY)" do
                        LookUpLine.Find('>');
                    Relief := LookUpLine."Relief Amount"; //070906 Ethiopian Tax modification
                    Percent := LookUpLine.Percent;
                    Amount1LCY := ("Amount (LCY)" * Percent / 100) - Relief;
                    CalculateAnnualTax(Header);//V.6.1.65_10SEP10 >>
                end;
            LookUpHeader.Type::"Extract Amount":
                begin
                    LookUpLine.Find('-');
                    while not ("Amount (LCY)" <= LookUpLine."Upper Amount (LCY)") do
                        LookUpLine.Find('>');

                    Amount1LCY := LookUpLine."Extract Amount (LCY)";
                    CalculateAnnualTax(Header);//V.6.1.65_10SEP10 >>
                end;
            LookUpHeader.Type::Month:
                begin
                    LookUpLine.Find('-');
                    while Header."Payroll Month" <> LookUpLine.Month do
                        LookUpLine.Find('>');
                    Amount1LCY := LookUpLine."Extract Amount (LCY)";
                    CalculateAnnualTax(Header);//V.6.1.65_10SEP10 >>
                end;
            LookUpHeader.Type::"Max Min":
                begin
                    if LookUpHeader."Min Extract Amount (LCY)" <> 0 then
                        if "Amount (LCY)" < LookUpHeader."Min Extract Amount (LCY)" then
                            Amount1LCY := LookUpHeader."Min Extract Amount (LCY)";
                    if LookUpHeader."Max Extract Amount (LCY)" <> 0 then
                        if "Amount (LCY)" > LookUpHeader."Max Extract Amount (LCY)" then
                            Amount1LCY := LookUpHeader."Max Extract Amount (LCY)";
                    CalculateAnnualTax(Header);//V.6.1.65_10SEP10 >>
                end;
        end;
        SchemeValueTmp.Get(SchemeControlTmp."Compute To", Scheme);
        SchemeValueTmp.Amount := Amount1LCY;
        SchemeValueTmp."Amount (LCY)" := Amount1LCY;
        SchemeValueTmp.Modify;
    end;

    procedure "--- V.6.1.65 --"()
    begin
    end;

    procedure PersonalACRecoveries(var Header: Record "Payroll Header")
    var
        PayrollEntry: Record "Payroll Lines";
        PayrollSetup: Record "Payroll Setups";
        EDDefinitionTmp1: Record "ED Definitions";
        lvCust: Record Customer;
    begin
        Clear(PayrollEntry);
        Clear(EDDefinitionTmp1);
        Clear(lvCust);
        if Header."Employee no." <> '' then
            Emp.Get(Header."Employee no.");
        if Emp."Customer No." <> '' then
            lvCust.Get(Emp."Customer No.");

        PayrollSetup.Get(Header."Payroll Code");
        if PayrollEntry.Find('+') then
            PayrollLinesTmp."Entry No." := PayrollEntry."Entry No." + 1
        else
            PayrollLinesTmp."Entry No." := 1;

        /*skm20110314 Enforce complete setup
        IF PayrollSetup."Personal Account Recoveries ED" <> '' THEN
          EDDefinitionTmp1.GET(PayrollSetup."Personal Account Recoveries ED");
        */
        PayrollSetup.TestField("Personal Account Recoveries ED");
        EDDefinitionTmp1.Get(PayrollSetup."Personal Account Recoveries ED");
        //skm end

        PayrollLinesTmp."Payroll ID" := Period;
        PayrollLinesTmp."Employee No." := Header."Employee no.";
        //  PayrollLinesTmp."Currency Code" := lvCust."Currency Code";
        PayrollLinesTmp."Currency Code" := PayrollLinesTmp."Currency Code";
        PayrollLinesTmp."ED Code" := PayrollSetup."Personal Account Recoveries ED";
        PayrollLinesTmp."Posting Group" := Emp."Posting Group";
        PayrollLinesTmp."Calculation Group" := EDDefinitionTmp1."Calculation Group";
        PayrollLinesTmp.Text := EDDefinitionTmp1."Payroll Text";
        PayrollLinesTmp.Amount := OutStandingAmt;
        PayrollLinesTmp."Amount (LCY)" := OutStandingAmt;
        PayrollLinesTmp.Insert;

    end;

    procedure CalculateAnnualTax(var Header: Record "Payroll Header")
    var
        lvPayrollHeader: Record "Payroll Header";
        LastPaidTaxAmt: Decimal;
    begin
        if Flag then begin
            LastPaidTaxAmt := 0;
            Clear(lvPayrollHeader);
            lvPayrollHeader.SetFilter(lvPayrollHeader."Payroll Month", '%1..%2', 1, Header."Payroll Month" - 1);
            lvPayrollHeader.SetRange(lvPayrollHeader."Payroll Year", Header."Payroll Year");
            lvPayrollHeader.SetRange(lvPayrollHeader."Employee no.", Header."Employee no.");
            if lvPayrollHeader.FindSet then
                repeat
                    if not SchemeControlTmp."Annualize Relief" then
                        LastPaidTaxAmt += lvPayrollHeader."L (LCY)"
                    else
                        LastPaidTaxAmt += lvPayrollHeader."K (LCY)";
                until lvPayrollHeader.Next = 0;
            //  IF SchemeControlTmp."Annualize TAX" THEN
            // BeforeReliefAmt := gvPayrollHeader."J (LCY)";
            if SchemeControlTmp."Annualize Relief" then begin
                AnnualReliefAmt := Amount1LCY;
            end;
            Amount1LCY := Amount1LCY - LastPaidTaxAmt;
            if SchemeControlTmp."Annualize Relief" then
                AnnualReliefAmt := AnnualReliefAmt - Amount1LCY;
        end;
    end;
}

