codeunit 50078 "HR Loan Management"
{

    trigger OnRun()
    begin
    end;

    var
        "NoSeriesMgt.": Codeunit NoSeriesManagement;
        EmployeeLoanProducts: Record "Employee Loan Products";
        EmployeeLoanAccounts: Record "Employee Loan Accounts";
        LoanRepaymentSchedule: Record "Employee Repayment Schedule";
        GenJnlLine: Record "Gen. Journal Line";
        DisbursementRequest: Record "Employee Loan Disbursement";
        Text_0001: Label 'A payment voucher will be generated for this disbursement. Continue?';
        Text_0002: Label 'Payment voucher no.'' %1 successfully created for disbursement no. %2';
        DisbursementRequest2: Record "Employee Loan Disbursement";
        Text_0003: Label 'You cannot apply an amount higher than %1  for loan product: %1';
        Text_0004: Label 'The loan limit amounts have not been setup for loan product: %1  job grade: %2';
        Text_0005: Label 'Your salary cannot support the repayment of %1, the net salary will be less than 1/3 of your basic salary %2';
        Text_0006: Label 'The amount applied cannot be higher than %1  times you monthly salary.';
        Text_0007: Label '%1 has not been attached., this is a required document.';
        Text_0008: Label 'The following document has not been attached. %1, this is a required document.';
        // SMTPMailSetup: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit "SMTP Mail";
        UserSetup: Record "User Setup";
        Text_0030: Label 'Kindly recommend to the Executive Director and attach a valuation report where applicable.<br> Loan Application details:<br>';
        Text_0031: Label 'Loan Application No. <br> Product Code:';
        LoanRepaymentSchedule2: Record "Employee App. Repay. Schedule";
        LoanRepaymentSchedule3: Record "Employee App. Repay. Schedule";
        LoanApplications: Record "Employee Loan Applications";
        Text_0009: Label 'A deduction for the loan repayment has been added to the employee payroll.';
        Customer2: Record Customer;
        HumanResourcesSetup: Record "Human Resources Setup";
        LoanProduct: Record "Employee Loan Products";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        SourceCode: Code[20];
        EmailBody: Text;

    procedure GenerateLoanAmortizationSchedule("AccountNo.": Code[20])
    var
        EmployeeRepaymentSchedule: Record "Employee Repayment Schedule";
        GLEntry: Record "G/L Entry";
        InstallmentCount2: Integer;
        AccountBalance: Decimal;
        RepaymentStartDate: Date;
        OriginalRepaymentDate: Date;
        RepaymentDate: Date;
        RepaymentEndDate: Date;
        InstallmentCount: Integer;
        NoOfInstallments: Integer;
        RepaymentAmount: Decimal;
        PrincipalAmount: Decimal;
        InterestRate: Decimal;
        InterestAmount: Decimal;
        InterestAmount2: Decimal;
        AdditionalInterestAmount: Decimal;
        RepaymentPeriod: DateFormula;
    begin
        EmployeeRepaymentSchedule.Reset;
        EmployeeRepaymentSchedule.SetRange(EmployeeRepaymentSchedule."Loan No.", "AccountNo.");
        if EmployeeRepaymentSchedule.FindSet then begin
            EmployeeRepaymentSchedule.DeleteAll;
        end;

        Commit;

        AccountBalance := 0;
        NoOfInstallments := 0;
        InstallmentCount := 0;
        InstallmentCount2 := 0;

        EmployeeLoanAccounts.Reset;
        EmployeeLoanAccounts.Get("AccountNo.");
        EmployeeLoanAccounts.SetRange("Date Filter", 0D, Today);
        EmployeeLoanAccounts.CalcFields(EmployeeLoanAccounts."Disbursed Amount");

        EmployeeLoanProducts.Get(EmployeeLoanAccounts."Loan Product Code");

        GLEntry.Reset;
        GLEntry.SetRange("G/L Account No.", EmployeeLoanProducts."Disbursement Account No.");
        //GLEntry.SetRange("Investment Account No.",EmployeeLoanAccounts."No.");
        GLEntry.SetFilter(Amount, '>%1', 0);
        if GLEntry.FindFirst then
            RepaymentStartDate := GLEntry."Posting Date";

        case EmployeeLoanAccounts."Repayment Frequency" of
            EmployeeLoanAccounts."Repayment Frequency"::Daily:
                Evaluate(RepaymentPeriod, '+' + Format(EmployeeLoanAccounts."Repayment Period") + 'D');
            EmployeeLoanAccounts."Repayment Frequency"::Monthly:
                Evaluate(RepaymentPeriod, '+' + Format(EmployeeLoanAccounts."Repayment Period") + 'M');
            EmployeeLoanAccounts."Repayment Frequency"::Quarterly:
                Evaluate(RepaymentPeriod, '+' + Format(EmployeeLoanAccounts."Repayment Period") + 'Q');
            EmployeeLoanAccounts."Repayment Frequency"::Annually:
                Evaluate(RepaymentPeriod, '+' + Format(EmployeeLoanAccounts."Repayment Period") + 'Y');
        end;

        RepaymentEndDate := CalcDate(RepaymentPeriod, RepaymentStartDate);

        EmployeeLoanProducts.Reset;
        EmployeeLoanProducts.Get(EmployeeLoanAccounts."Loan Product Code");

        RepaymentDate := CalcDate('-CM', RepaymentStartDate);

        if Date2DMY(RepaymentStartDate, 1) > 14 then begin
            RepaymentDate := CalcDate('+1M', RepaymentDate);
            RepaymentEndDate := CalcDate('+1M', RepaymentEndDate);
        end;

        OriginalRepaymentDate := RepaymentDate;

        repeat
            if GetRemainingPeriod("AccountNo.", RepaymentDate, OriginalRepaymentDate, RepaymentStartDate) > 0 then begin
                NoOfInstallments := GetRemainingPeriod("AccountNo.", RepaymentDate, OriginalRepaymentDate, RepaymentStartDate);
            end;

            InterestAmount := 0;
            InterestAmount2 := 0;

            if GetLoanBalance("AccountNo.", RepaymentDate, RepaymentStartDate) > 0 then begin
                AccountBalance := GetLoanBalance("AccountNo.", RepaymentDate, RepaymentStartDate);
                RepaymentAmount := (EmployeeLoanProducts."Interest Rate(%)" / 12 / 100) / (1 - Power((1 + (EmployeeLoanProducts."Interest Rate(%)" / 12 / 100)), -NoOfInstallments)) * AccountBalance;
            end;

            InterestAmount2 := GetInterestAmounts("AccountNo.", RepaymentDate);

            InstallmentCount := InstallmentCount + 1;
            PrincipalAmount := 0;

            if InterestAmount2 = 0 then begin
                InterestAmount := (((EmployeeLoanProducts."Interest Rate(%)" / 100) * AccountBalance) / 365) * Date2DMY((CalcDate('CM', RepaymentDate)), 1);
            end else begin
                InterestAmount := InterestAmount2;
            end;

            if InstallmentCount > EmployeeLoanProducts."Principal Moratorium Period" then begin
                if CalcDate('CM', RepaymentDate) = CalcDate('CM', CalcDate('-1M', RepaymentEndDate)) then begin
                    PrincipalAmount := AccountBalance;
                    AccountBalance := AccountBalance - PrincipalAmount;
                    EmployeeRepaymentSchedule."Principal Moratorium Period" := false;
                end else begin
                    PrincipalAmount := RepaymentAmount - InterestAmount;
                    AccountBalance := AccountBalance - PrincipalAmount;
                    EmployeeRepaymentSchedule."Principal Moratorium Period" := false;
                end;
            end;


            if AccountBalance < 0 then break;

            EmployeeRepaymentSchedule.Init;
            EmployeeRepaymentSchedule."Loan No." := EmployeeLoanAccounts."No.";
            EmployeeRepaymentSchedule."Repayment Date" := CalcDate('CM', RepaymentDate);
            EmployeeRepaymentSchedule."Instalment No." := InstallmentCount;
            EmployeeRepaymentSchedule."Instalment No." := InstallmentCount;
            EmployeeRepaymentSchedule."Principal Repayment" := PrincipalAmount;
            EmployeeRepaymentSchedule."Interest Repayment" := InterestAmount;
            EmployeeRepaymentSchedule."Interest Moratorium Period" := false;
            EmployeeRepaymentSchedule."Total Repayment" := PrincipalAmount + InterestAmount;
            EmployeeRepaymentSchedule."Loan Balance" := AccountBalance;
            EmployeeRepaymentSchedule.Insert;

            RepaymentDate := CalcDate('+1M', RepaymentDate);
        until RepaymentDate = CalcDate('-CM', RepaymentEndDate);

        Commit;
    end;

    procedure GenerateLoanApplicationRepaymentSchedule(ApplicationNo: Code[20])
    var
        LoanBalance: Decimal;
        RepaymentStartDate: Date;
        RepaymentDate: Date;
        RepaymentEndDate: Date;
        InstallmentCount: Integer;
        NoOfInstallments: Integer;
        RepaymentAmount: Decimal;
        PrincipalAmount: Decimal;
        InterestRate: Decimal;
        InterestAmount: Decimal;
        AdditionalInterestAmount: Decimal;
    begin
        LoanRepaymentSchedule2.Reset;
        LoanRepaymentSchedule2.SetRange(LoanRepaymentSchedule2."Application No.", ApplicationNo);
        if LoanRepaymentSchedule2.FindSet then begin
            LoanRepaymentSchedule2.DeleteAll;
        end;

        Commit;

        LoanBalance := 0;
        InterestRate := 0;
        NoOfInstallments := 0;
        InstallmentCount := 0;

        LoanApplications.Reset;
        if LoanApplications.Get(ApplicationNo) then begin
            RepaymentStartDate := LoanApplications."Repayment Start Date";
            RepaymentEndDate := LoanApplications."Repayment End Date";

            LoanBalance := LoanApplications."Applied Amount";
            InterestRate := LoanApplications."Interest Rate";


            EmployeeLoanProducts.Reset;
            EmployeeLoanProducts.Get(LoanApplications."Loan Product Code");
            NoOfInstallments := LoanApplications."No. of Installments" - EmployeeLoanProducts."Principal Moratorium Period";

            RepaymentDate := CalcDate('-CM', RepaymentStartDate);
            if Date2DMY(RepaymentStartDate, 1) > 14 then begin
                RepaymentDate := CalcDate('+1M', RepaymentDate);
                RepaymentEndDate := CalcDate('+1M', RepaymentEndDate);
            end;

            RepaymentAmount := (InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -NoOfInstallments)) * LoanBalance;

            repeat
                InstallmentCount := InstallmentCount + 1;
                PrincipalAmount := 0;
                InterestAmount := 0;
                InterestAmount := ((InterestRate / 100) * LoanBalance) / 12;

                if InstallmentCount > EmployeeLoanProducts."Principal Moratorium Period" then begin
                    PrincipalAmount := RepaymentAmount - InterestAmount;
                    LoanBalance := LoanBalance - PrincipalAmount;
                    LoanRepaymentSchedule2."Principal Moratorium Period" := false;
                end;

                LoanRepaymentSchedule2.Init;
                LoanRepaymentSchedule2."Application No." := LoanApplications."No.";
                //LoanRepaymentSchedule."Loan Disbursement No.":=
                LoanRepaymentSchedule2."Employee No." := LoanApplications."Employee No.";
                LoanRepaymentSchedule2."Repayment Date" := CalcDate('CM', RepaymentDate);
                LoanRepaymentSchedule2."Instalment No." := InstallmentCount;
                LoanRepaymentSchedule2."Principal Repayment" := PrincipalAmount;
                LoanRepaymentSchedule2."Principal Moratorium Period" := false;
                LoanRepaymentSchedule2."Interest Repayment" := InterestAmount;
                LoanRepaymentSchedule2."Interest Moratorium Period" := false;
                LoanRepaymentSchedule2."Total Repayment" := RepaymentAmount;
                LoanRepaymentSchedule2."Loan Balance" := LoanBalance;
                LoanRepaymentSchedule2.Insert;
                RepaymentDate := CalcDate('+1M', RepaymentDate);
            until RepaymentDate = CalcDate('-CM', RepaymentEndDate);
        end;
    end;

    procedure UpdateFirstMonthInterestAmount("ApplicationNo.": Code[20])
    var
        GLEntry: Record "G/L Entry";
        Dates: Record Date;
        NoOfDays: Integer;
        InterestAmount: Decimal;
    begin
        /*InterestAmount:=0;
        LoanApplications.GET("ApplicationNo.");
        EmployeeLoanProducts.GET(EmployeeLoanAccounts."Loan Product Code");
        
        LoanRepaymentSchedule3.RESET;
        LoanRepaymentSchedule3.SETRANGE("Application No.","Application No.");
        IF LoanRepaymentSchedule3.FINDFIRST THEN BEGIN
          GLEntry.RESET;
          GLEntry.SETRANGE("G/L Account No.",EmployeeLoanProducts."Disbursement Account No.");
          GLEntry.SETRANGE("Investment Account No.",LoanAccountNo);
          GLEntry.SETFILTER(Amount,'>%1',0);
          IF GLEntry.FINDFIRST THEN BEGIN
            IF DATE2DMY(GLEntry."Posting Date",1)>14 THEN BEGIN
              IF  (CALCDATE('-CM',CALCDATE('+1M',GLEntry."Posting Date"))) = CALCDATE('-CM',LoanRepaymentSchedule3."Repayment Date") THEN BEGIN
                //get no of days
                Dates.RESET;
                Dates.SETRANGE("Period Type",Dates."Period Type"::Date);
                Dates.SETRANGE("Period Start",GLEntry."Posting Date",CALCDATE('CM',GLEntry."Posting Date"));
                NoOfDays:=Dates.COUNT;
                //calculate interest previous days
                InterestAmount:=((((EmployeeLoanProducts."Interest Rate(%)")/100)*GLEntry.Amount)/365)*NoOfDays;
              END;
              LoanRepaymentSchedule3."Interest Repayment":=LoanRepaymentSchedule3."Interest Repayment"+InterestAmount;
              LoanRepaymentSchedule3."Total Repayment":=LoanRepaymentSchedule3."Interest Repayment"+LoanRepaymentSchedule3."Principal Repayment";
              LoanRepaymentSchedule3.MODIFY;
            END ELSE BEGIN
               IF  (CALCDATE('-CM',GLEntry."Posting Date")) = CALCDATE('-CM',LoanRepaymentSchedule3."Repayment Date") THEN BEGIN
              //get no of days
                Dates.RESET;
                Dates.SETRANGE("Period Type",Dates."Period Type"::Date);
                Dates.SETRANGE("Period Start",GLEntry."Posting Date",CALCDATE('CM',GLEntry."Posting Date"));
                NoOfDays:=Dates.COUNT;
                //calculate interest previous days
                InterestAmount:=((((EmployeeLoanProducts."Interest Rate(%)")/100)*GLEntry.Amount)/365)*NoOfDays;
               END;
              LoanRepaymentSchedule3."Interest Repayment":=InterestAmount;
              LoanRepaymentSchedule3."Total Repayment":=LoanRepaymentSchedule3."Interest Repayment"+LoanRepaymentSchedule3."Principal Repayment";
              LoanRepaymentSchedule3.MODIFY;
            END;
          END;
        END;*/

    end;

    procedure GetLoanBalance("LoanAccountNo.": Code[20]; RepaymentDate: Date; RepaymentStartDate: Date) LoanBalance: Decimal
    var
        GLEntry: Record "G/L Entry";
        GLEntry2: Record "G/L Entry";
        GLEntry3: Record "G/L Entry";
        DisbursementCount: Integer;
    begin
        EmployeeLoanAccounts.Get("LoanAccountNo.");
        EmployeeLoanProducts.Get(EmployeeLoanAccounts."Loan Product Code");
        LoanBalance := 0;

        GLEntry.Reset;
        GLEntry.SetRange("G/L Account No.", EmployeeLoanProducts."Disbursement Account No.");
        //GLEntry.SetRange("Investment Account No.","LoanAccountNo.");
        GLEntry.SetFilter(Amount, '>%1', 0);
        if GLEntry.Count > 0 then begin
            GLEntry2.Reset;
            GLEntry2.SetRange("G/L Account No.", EmployeeLoanProducts."Disbursement Account No.");
            // GLEntry2.SetRange("Investment Account No.","LoanAccountNo.");
            GLEntry2.SetFilter(Amount, '>%1', 0);
            if GLEntry2.FindSet then begin
                DisbursementCount := 0;
                repeat
                    if DisbursementCount > 0 then begin
                        if Date2DMY(GLEntry2."Posting Date", 1) > 14 then begin
                            if (CalcDate('-CM', GLEntry2."Posting Date")) = RepaymentDate then begin
                                GLEntry3.Reset;
                                GLEntry3.SetRange("G/L Account No.", EmployeeLoanProducts."Disbursement Account No.");
                                //  GLEntry3.SetRange("Investment Account No.","LoanAccountNo.");
                                GLEntry3.SetFilter(Amount, '>%1', 0);
                                if GLEntry3.FindSet then begin
                                    repeat
                                        if (CalcDate('-CM', GLEntry3."Posting Date")) <= RepaymentDate then
                                            LoanBalance := LoanBalance + GLEntry3.Amount;
                                    until GLEntry3.Next = 0;
                                    LoanBalance := LoanBalance - GetPaidPrinciple("LoanAccountNo.");
                                end else begin
                                    LoanBalance := 0;
                                end;
                            end;
                        end else begin
                            if (CalcDate('-CM', GLEntry2."Posting Date")) = RepaymentDate then begin
                                GLEntry3.Reset;
                                GLEntry3.SetRange("G/L Account No.", EmployeeLoanProducts."Disbursement Account No.");
                                //GLEntry3.SetRange("Investment Account No.",GLEntry2."Investment Account No.");
                                GLEntry3.SetFilter(Amount, '>%1', 0);
                                if GLEntry3.FindSet then begin
                                    repeat
                                        if (CalcDate('-CM', GLEntry3."Posting Date")) <= RepaymentDate then
                                            LoanBalance := LoanBalance + GLEntry3.Amount;
                                    until GLEntry3.Next = 0;
                                    LoanBalance := LoanBalance - GetPaidPrinciple("LoanAccountNo.");
                                end else begin
                                    LoanBalance := 0;
                                end;
                            end;
                        end;
                    end else begin
                        //<0
                        if Date2DMY(GLEntry2."Posting Date", 1) > 14 then begin
                            if (CalcDate('-CM', CalcDate('+1M', GLEntry2."Posting Date"))) = RepaymentDate then begin
                                GLEntry3.Reset;
                                GLEntry3.SetRange("G/L Account No.", EmployeeLoanProducts."Disbursement Account No.");
                                // GLEntry3.SetRange("Investment Account No.","LoanAccountNo.");
                                GLEntry3.SetFilter(Amount, '>%1', 0);
                                if GLEntry3.FindSet then begin
                                    repeat
                                        if (CalcDate('-CM', GLEntry3."Posting Date")) <= RepaymentDate then
                                            LoanBalance := LoanBalance + GLEntry3.Amount;
                                    until GLEntry3.Next = 0;
                                    LoanBalance := LoanBalance - GetPaidPrinciple("LoanAccountNo.");
                                end else begin
                                    LoanBalance := 0;
                                end;
                            end;
                        end else begin
                            if (CalcDate('-CM', GLEntry2."Posting Date")) = RepaymentDate then begin
                                GLEntry3.Reset;
                                GLEntry3.SetRange("G/L Account No.", EmployeeLoanProducts."Disbursement Account No.");
                                //GLEntry3.SetRange("Investment Account No.","LoanAccountNo.");
                                GLEntry3.SetFilter(Amount, '>%1', 0);
                                if GLEntry3.FindSet then begin
                                    repeat
                                        if (CalcDate('-CM', GLEntry3."Posting Date")) <= RepaymentDate then
                                            LoanBalance := LoanBalance + GLEntry3.Amount;
                                    until GLEntry3.Next = 0;
                                    LoanBalance := LoanBalance - GetPaidPrinciple("LoanAccountNo.");
                                end else begin
                                    LoanBalance := 0;
                                end;
                            end;
                        end;
                        //end <0
                    end;
                    DisbursementCount := DisbursementCount + 1;
                until GLEntry2.Next = 0;
            end;
        end else begin
            EmployeeLoanAccounts.CalcFields("Account Balance");
            LoanBalance := EmployeeLoanAccounts."Account Balance";
        end;
    end;

    procedure GetInterestAmounts("LoanAccountNo.": Code[20]; RepaymentDate: Date) InterestAmount: Decimal
    var
        GLEntry: Record "G/L Entry";
        GLEntry2: Record "G/L Entry";
        GLEntry3: Record "G/L Entry";
        Dates: Record Date;
        DisbursementCount: Integer;
        NoOfDays: Integer;
        NoOfDays2: Decimal;
        TotalLoanAmount: Decimal;
        InterestAmount1: Decimal;
        InterestAmount2: Decimal;
        InterestRate: Decimal;
    begin
        EmployeeLoanAccounts.Get("LoanAccountNo.");

        TotalLoanAmount := 0;
        InterestAmount := 0;
        InterestAmount1 := 0;
        InterestAmount2 := 0;
        NoOfDays := 0;
        NoOfDays2 := 0;

        EmployeeLoanProducts.Get(EmployeeLoanAccounts."Loan Product Code");

        GLEntry2.Reset;
        GLEntry2.SetRange("G/L Account No.", EmployeeLoanProducts."Disbursement Account No.");
        //GLEntry2.SetRange("Investment Account No.","LoanAccountNo.");
        GLEntry2.SetFilter(Amount, '>%1', 0);
        if GLEntry2.FindSet then begin
            DisbursementCount := 0;
            repeat
                TotalLoanAmount := TotalLoanAmount + GLEntry2.Amount;
                if DisbursementCount > 0 then begin
                    if Date2DMY(GLEntry2."Posting Date", 1) > 14 then begin
                        //> 14th
                        if (CalcDate('-CM', GLEntry2."Posting Date")) = RepaymentDate then begin
                            //get no of days
                            Dates.Reset;
                            Dates.SetRange("Period Type", Dates."Period Type"::Date);
                            Dates.SetRange("Period Start", CalcDate('-CM', GLEntry2."Posting Date"), GLEntry2."Posting Date");
                            NoOfDays := Dates.Count;
                            NoOfDays := NoOfDays - 1;

                            //get days 2
                            Dates.Reset;
                            Dates.SetRange("Period Type", Dates."Period Type"::Date);
                            Dates.SetRange("Period Start", GLEntry2."Posting Date", CalcDate('CM', GLEntry2."Posting Date"));
                            NoOfDays2 := Dates.Count;

                            //calculate interest previous days
                            InterestAmount1 := ((((EmployeeLoanProducts."Interest Rate(%)") / 100) * ((TotalLoanAmount - GetPaidPrinciple("LoanAccountNo.")) - GLEntry2.Amount)) / 365) * NoOfDays;
                            InterestAmount2 := ((((EmployeeLoanProducts."Interest Rate(%)") / 100) * (TotalLoanAmount - GetPaidPrinciple("LoanAccountNo."))) / 365) * NoOfDays2;
                            InterestAmount := InterestAmount1 + InterestAmount2;
                            exit(InterestAmount);
                        end else begin
                            InterestAmount := 0;
                        end;
                    end else begin
                        //less than 14
                        if (CalcDate('-CM', GLEntry2."Posting Date")) = RepaymentDate then begin
                            //get no of days
                            Dates.Reset;
                            Dates.SetRange("Period Type", Dates."Period Type"::Date);
                            Dates.SetRange("Period Start", CalcDate('-CM', GLEntry2."Posting Date"), GLEntry2."Posting Date");
                            NoOfDays := Dates.Count;
                            NoOfDays := NoOfDays - 1;

                            //get days 2
                            Dates.Reset;
                            Dates.SetRange("Period Type", Dates."Period Type"::Date);
                            Dates.SetRange("Period Start", GLEntry2."Posting Date", CalcDate('CM', GLEntry2."Posting Date"));
                            NoOfDays2 := Dates.Count;

                            //calculate interest previous days
                            InterestAmount1 := ((((EmployeeLoanProducts."Interest Rate(%)") / 100) * (TotalLoanAmount - GLEntry2.Amount - GetPaidPrinciple("LoanAccountNo."))) / 365) * NoOfDays;
                            InterestAmount2 := ((((EmployeeLoanProducts."Interest Rate(%)") / 100) * (TotalLoanAmount - GetPaidPrinciple("LoanAccountNo."))) / 365) * NoOfDays2;
                            InterestAmount := InterestAmount1 + InterestAmount2;
                            exit(InterestAmount);
                        end else begin
                            InterestAmount := 0;
                        end;
                    end;
                end else begin
                    //<0
                    if Date2DMY(GLEntry2."Posting Date", 1) > 14 then begin
                        if (CalcDate('-CM', CalcDate('+1M', GLEntry2."Posting Date"))) = RepaymentDate then begin
                            Dates.Reset;
                            Dates.SetRange("Period Type", Dates."Period Type"::Date);
                            Dates.SetRange("Period Start", GLEntry2."Posting Date", CalcDate('CM', GLEntry2."Posting Date"));
                            NoOfDays := Dates.Count;
                            //calculate interest previous days
                            InterestAmount1 := ((((EmployeeLoanProducts."Interest Rate(%)") / 100) * (GLEntry2.Amount)) / 365) * NoOfDays;
                            InterestAmount2 := ((((EmployeeLoanProducts."Interest Rate(%)") / 100) * (GLEntry2.Amount)) / 365) * Date2DMY(CalcDate('CM', RepaymentDate), 1);
                            InterestAmount := InterestAmount1 + InterestAmount2;
                            exit(InterestAmount);
                        end else begin
                            InterestAmount := 0;
                        end;
                    end else begin
                        if (CalcDate('-CM', GLEntry2."Posting Date")) = RepaymentDate then begin
                            GLEntry3.Reset;
                            GLEntry3.SetRange("G/L Account No.", EmployeeLoanProducts."Disbursement Account No.");
                            //GLEntry3.SetRange("Investment Account No.","LoanAccountNo.");
                            GLEntry3.SetFilter(Amount, '>%1', 0);
                            if GLEntry3.FindFirst then begin
                                Dates.Reset;
                                Dates.SetRange("Period Type", Dates."Period Type"::Date);
                                Dates.SetRange("Period Start", GLEntry3."Posting Date", CalcDate('CM', GLEntry3."Posting Date"));
                                NoOfDays := Dates.Count;
                                //calculate interest previous days
                                InterestAmount := ((((EmployeeLoanProducts."Interest Rate(%)") / 100) * (GLEntry3.Amount)) / 365) * NoOfDays;
                                exit(InterestAmount);
                            end else begin
                                InterestAmount := 0;
                            end;
                        end;
                    end;
                    //end <0
                end;
                DisbursementCount := DisbursementCount + 1;
            until GLEntry2.Next = 0;
        end;
    end;

    procedure GetPaidPrinciple(LoanAccountNo: Code[20]) PrinciplePaid: Decimal
    var
        EmployeeRepaymentSchedule: Record "Employee Repayment Schedule";
    begin
        PrinciplePaid := 0;
        EmployeeRepaymentSchedule.Reset;
        EmployeeRepaymentSchedule.SetRange("Loan No.", LoanAccountNo);
        if EmployeeRepaymentSchedule.FindSet then begin
            repeat
                PrinciplePaid := PrinciplePaid + EmployeeRepaymentSchedule."Principal Repayment";
            until EmployeeRepaymentSchedule.Next = 0;
        end else
            PrinciplePaid := 0;
    end;

    procedure GetRemainingPeriod("LoanAccountNo.": Code[20]; RepaymentDate: Date; OriginalRepaymentDate: Date; RepaymentStartDate: Date) InstallmenCount: Integer
    var
        GLEntry: Record "G/L Entry";
        GLEntry2: Record "G/L Entry";
        GLEntry3: Record "G/L Entry";
        EmployeeLoanAccounts: Record "Employee Loan Accounts";
        FirstPaymentDate: Date;
        Dates: Record Date;
        NoOfMonths: Integer;
        TotalLoanAmount: Decimal;
        DisbursementCount: Decimal;
    begin
        EmployeeLoanAccounts.Get("LoanAccountNo.");
        EmployeeLoanProducts.Get(EmployeeLoanAccounts."Loan Product Code");

        InstallmenCount := 0;
        NoOfMonths := 0;

        GLEntry2.Reset;
        GLEntry2.SetRange("G/L Account No.", EmployeeLoanProducts."Disbursement Account No.");
        //GLEntry2.SetRange("Investment Account No.","LoanAccountNo.");
        GLEntry2.SetFilter(Amount, '>%1', 0);
        if GLEntry2.FindSet then begin
            FirstPaymentDate := GLEntry2."Posting Date";
            DisbursementCount := 0;
            repeat
                if DisbursementCount > 0 then begin
                    if Date2DMY(GLEntry2."Posting Date", 1) > 14 then begin
                        if CalcDate('-CM', GLEntry2."Posting Date") = RepaymentDate then begin
                            Dates.Reset;
                            Dates.SetRange("Period Type", Dates."Period Type"::Month);
                            Dates.SetRange("Period Start", FirstPaymentDate, RepaymentDate);
                            NoOfMonths := Dates.Count;

                            if NoOfMonths > 1 then begin
                                if Date2DMY(FirstPaymentDate, 1) > 14 then begin
                                    NoOfMonths := NoOfMonths - 1;
                                end else begin
                                    NoOfMonths := NoOfMonths;
                                end;
                            end;

                            if NoOfMonths = 1 then
                                InstallmenCount := EmployeeLoanAccounts."Repayment Period" - EmployeeLoanProducts."Principal Moratorium Period";
                            if NoOfMonths < EmployeeLoanProducts."Principal Moratorium Period" then begin
                                InstallmenCount := EmployeeLoanAccounts."Repayment Period" - EmployeeLoanProducts."Principal Moratorium Period";
                            end else begin
                                InstallmenCount := EmployeeLoanAccounts."Repayment Period" - NoOfMonths;
                            end;
                        end;

                    end else begin
                        //< less than 14
                        if (CalcDate('-CM', GLEntry2."Posting Date")) = RepaymentDate then begin
                            Dates.Reset;
                            Dates.SetRange("Period Type", Dates."Period Type"::Month);
                            Dates.SetRange("Period Start", FirstPaymentDate, RepaymentDate);
                            NoOfMonths := Dates.Count;

                            /*IF NoOfMonths >1 THEN BEGIN
                              IF DATE2DMY(FirstPaymentDate,1) > 14 THEN BEGIN
                                NoOfMonths:=NoOfMonths-;
                              END ELSE BEGIN
                                NoOfMonths:=NoOfMonths;
                              END;
                            END;*/

                            if NoOfMonths = 1 then
                                InstallmenCount := EmployeeLoanAccounts."Repayment Period" - EmployeeLoanProducts."Principal Moratorium Period";

                            if NoOfMonths < EmployeeLoanProducts."Principal Moratorium Period" then
                                InstallmenCount := EmployeeLoanAccounts."Repayment Period" - EmployeeLoanProducts."Principal Moratorium Period"
                            else
                                InstallmenCount := EmployeeLoanAccounts."Repayment Period" - NoOfMonths + 1;
                            if NoOfMonths = EmployeeLoanProducts."Principal Moratorium Period" then
                                InstallmenCount := EmployeeLoanAccounts."Repayment Period" - EmployeeLoanProducts."Principal Moratorium Period";
                        end;
                    end;
                end else begin
                    //<1 disbursement count
                    InstallmenCount := EmployeeLoanAccounts."Repayment Period" - EmployeeLoanProducts."Principal Moratorium Period";
                end;
                DisbursementCount := DisbursementCount + 1;
            until GLEntry2.Next = 0;
        end;

    end;

    procedure PostLoanPrincipal("LoanNo.": Code[20]; PrincipalAmount: Decimal; RunDate: Date; LineNo: Integer)
    begin
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", 'INTEREST');
        GenJnlLine.SetRange("Journal Batch Name", 'INTBAT');
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;

        Commit;

        EmployeeLoanAccounts.Reset;
        EmployeeLoanAccounts.Get("LoanNo.");

        EmployeeLoanProducts.Reset;
        EmployeeLoanProducts.Get(EmployeeLoanAccounts."Loan Product Code");

        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := 'INTEREST';
        GenJnlLine.Validate("Journal Template Name");
        GenJnlLine."Journal Batch Name" := 'INTBAT';
        GenJnlLine.Validate("Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := '';
        GenJnlLine."Posting Date" := CalcDate('CM', RunDate);
        GenJnlLine."Document No." := CopyStr('PR/' + "LoanNo.", 1, 20);
        GenJnlLine."External Document No." := '';
        GenJnlLine."Cheque No." := '';
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := EmployeeLoanAccounts."Employee No.";
        GenJnlLine.Validate("Account No.");
        GenJnlLine."Currency Code" := '';
        GenJnlLine.Amount := PrincipalAmount;  //Debit Amount
        GenJnlLine.Validate(Amount);
        GenJnlLine."Posting Group" := EmployeeLoanProducts."Principal Receivable PG";
        GenJnlLine.Validate("Posting Group");
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := EmployeeLoanProducts."Disbursement Account No.";
        GenJnlLine.Validate("Bal. Account No.");
        GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Principal Receivable";
        GenJnlLine."Investment Account No." := EmployeeLoanAccounts."No.";
        GenJnlLine."Shortcut Dimension 1 Code" := '';
        GenJnlLine.Validate("Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := '';
        GenJnlLine.Validate("Shortcut Dimension 2 Code");
        GenJnlLine.Description := 'Principal Receivable for' + "LoanNo.";
        GenJnlLine.Description2 := 'Principal Receivable for' + "LoanNo.";
        GenJnlLine.Validate(Description);
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;

        Commit;
        //Post the Journal Lines
        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Line", GenJnlLine);
        Commit;
    end;

    procedure InsertLoanInterestBuffer("LoanNo.": Code[20]; InterestAmount: Decimal; RunDate: Date; LineNo: Integer)
    var
        LoanIntAccrualBuffer: Record "Emp. Loan Int. Accrual Buffer";
        EmployeeLoanAccounts: Record "Employee Loan Accounts";
        LoanIntAccrualBuffer2: Record "Emp. Loan Int. Accrual Buffer";
    begin
        LoanIntAccrualBuffer2.Reset;
        LoanIntAccrualBuffer2.SetRange("Loan Account No.", "LoanNo.");
        LoanIntAccrualBuffer2.SetRange("Posting Date", RunDate);
        if not LoanIntAccrualBuffer2.FindFirst then begin
            LoanIntAccrualBuffer.Init;
            LoanIntAccrualBuffer."Loan Account No." := "LoanNo.";
            LoanIntAccrualBuffer."Posting Date" := RunDate;
            LoanIntAccrualBuffer."Loan Transaction Type" := LoanIntAccrualBuffer."Loan Transaction Type"::"Interest Receivable";
            LoanIntAccrualBuffer."Document No" := CopyStr('LINT/' + "LoanNo.", 1, 20);
            LoanIntAccrualBuffer.Description := 'Loan Interest for Loan account' + "LoanNo." + ' ' + Format(RunDate);
            LoanIntAccrualBuffer.Amount := InterestAmount;
            LoanIntAccrualBuffer."Amount LCY" := InterestAmount;
            if EmployeeLoanAccounts.Get(LoanIntAccrualBuffer."Loan Account No.") then
                LoanIntAccrualBuffer."Employee No" := EmployeeLoanAccounts."Employee No.";
            LoanIntAccrualBuffer.Insert;
        end;
    end;

    procedure PostLoanInterest("LoanNo.": Code[20]; InterestAmount: Decimal; RunDate: Date; LineNo: Integer)
    begin
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", 'INTEREST');
        GenJnlLine.SetRange("Journal Batch Name", 'INTBAT');
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;

        Commit;

        EmployeeLoanAccounts.Reset;
        EmployeeLoanAccounts.Get("LoanNo.");

        EmployeeLoanProducts.Reset;
        EmployeeLoanProducts.Get(EmployeeLoanAccounts."Loan Product Code");

        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := 'INTEREST';
        GenJnlLine.Validate("Journal Template Name");
        GenJnlLine."Journal Batch Name" := 'INTBAT';
        GenJnlLine.Validate("Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := '';
        GenJnlLine."Posting Date" := RunDate;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := CopyStr('LINT/' + "LoanNo.", 1, 20);
        GenJnlLine."External Document No." := '';
        GenJnlLine."Cheque No." := '';
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := EmployeeLoanAccounts."Employee No.";
        GenJnlLine.Validate("Account No.");
        GenJnlLine."Currency Code" := '';
        GenJnlLine.Amount := InterestAmount;  //Debit Amount
        GenJnlLine.Validate(Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := EmployeeLoanProducts."Interest Receivable Account";
        GenJnlLine."Posting Group" := EmployeeLoanProducts."Interest Receivable PG";
        GenJnlLine.Validate("Posting Group");
        GenJnlLine.Validate("Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := '';
        GenJnlLine.Validate("Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := '';
        GenJnlLine.Validate("Shortcut Dimension 2 Code");
        GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Interest Receivable";
        GenJnlLine."Investment Account No." := EmployeeLoanAccounts."Loan Account No";
        GenJnlLine.Description := 'Loan Interest for Loan account' + "LoanNo.";
        GenJnlLine.Description2 := 'Loan Interest for Loan account' + "LoanNo.";
        GenJnlLine.Validate(Description);
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;

        Commit;
        //Post the Journal Lines
        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Line", GenJnlLine);
        Commit;
    end;

    local procedure CreateValuationReport()
    begin
    end;

    local procedure CreateLegalDueDiligence()
    begin
    end;

    procedure CreateCustomerAccount(EmployeeLoanApplications: Record "Employee Loan Applications")
    var
        Customer: Record Customer;
    begin
        Customer2.Reset;
        Customer2.SetRange("No.", EmployeeLoanApplications."Employee No.");
        if not Customer2.FindFirst then begin
            Customer.Init;
            Customer."No." := EmployeeLoanApplications."Employee No.";
            Customer.Name := EmployeeLoanApplications."Employee Name";
            Customer."Account Type" := Customer."Account Type"::Employee;
            Customer.Insert;
        end;
    end;

    procedure CreatePaymentVoucher("DisbursementNo.": Code[20]) Generated: Boolean
    var
        PaymentHeader: Record "Payment Header";
        PaymentLine: Record "Payment Line";
        "PaymentNo.": Code[20];
        FundsGeneralSetup: Record "Funds General Setup";
        PaymentHeader2: Record "Payment Header";
        PaymentCard: Page "Payment Card";
        EmployeeLoanProducts: Record "Employee Loan Products";
    begin
        "PaymentNo." := '';

        DisbursementRequest.Reset;
        DisbursementRequest.Get("DisbursementNo.");
        DisbursementRequest.TestField(DisbursementRequest.Status, DisbursementRequest.Status::Released);

        EmployeeLoanAccounts.Reset;
        EmployeeLoanAccounts.Get(DisbursementRequest."Loan No.");

        EmployeeLoanProducts.Reset;
        EmployeeLoanProducts.Get(EmployeeLoanAccounts."Loan Product Code");

        if Confirm(Text_0001) then begin
            FundsGeneralSetup.Get;
            FundsGeneralSetup.TestField(FundsGeneralSetup."Payment Voucher Nos.");
            "PaymentNo." := "NoSeriesMgt.".GetNextNo(FundsGeneralSetup."Payment Voucher Nos.", 0D, true);
            PaymentHeader.Reset;
            PaymentHeader."No." := "PaymentNo.";
            PaymentHeader."Document Type" := PaymentHeader."Document Type"::Payment;
            PaymentHeader."Document Date" := Today;
            PaymentHeader."Posting Date" := Today;
            PaymentHeader."Payment Type" := PaymentHeader."Payment Type"::"Cheque Payment";
            PaymentHeader."Payment Mode" := PaymentHeader."Payment Mode"::Cheque;
            PaymentHeader."Payee Name" := DisbursementRequest."Employee Name";
            PaymentHeader."Global Dimension 1 Code" := DisbursementRequest."Global Dimension 1 Code";
            PaymentHeader."Global Dimension 2 Code" := DisbursementRequest."Global Dimension 2 Code";
            PaymentHeader."Shortcut Dimension 3 Code" := DisbursementRequest."Shortcut Dimension 3 Code";
            PaymentHeader."Shortcut Dimension 4 Code" := DisbursementRequest."Shortcut Dimension 4 Code";
            PaymentHeader."Shortcut Dimension 5 Code" := DisbursementRequest."Shortcut Dimension 5 Code";
            PaymentHeader."Shortcut Dimension 6 Code" := DisbursementRequest."Shortcut Dimension 6 Code";
            PaymentHeader."Shortcut Dimension 7 Code" := DisbursementRequest."Shortcut Dimension 7 Code";
            PaymentHeader."Shortcut Dimension 8 Code" := DisbursementRequest."Shortcut Dimension 8 Code";
            PaymentHeader.Description := DisbursementRequest.Description;
            PaymentHeader."Loan Disbursement" := true;
            PaymentHeader."Loan No." := DisbursementRequest."Loan No.";
            PaymentHeader."Loan Disbursement No." := DisbursementRequest."No.";
            PaymentHeader."Loan Disbursement Type" := PaymentHeader."Loan Disbursement Type"::"Staff Loan";
            if PaymentHeader.Insert then begin
                PaymentLine.Reset;
                PaymentLine."Line No." := 0;
                PaymentLine."Document No." := "PaymentNo.";
                PaymentLine."Payment Code" := EmployeeLoanProducts."Disbursement Payment Code";
                PaymentLine.Validate(PaymentLine."Payment Code");
                PaymentLine."Payee Type" := PaymentLine."Payee Type"::Employee;
                PaymentLine."Payee No." := DisbursementRequest."Employee No.";
                PaymentLine.Validate(PaymentLine."Payee No.");
                PaymentLine."Account Type" := PaymentLine."Account Type"::"G/L Account";
                if EmployeeLoanProducts.Get(DisbursementRequest."Loan Product Code") then begin
                    EmployeeLoanProducts.TestField("Disbursement Account No.");
                    PaymentLine."Account No." := EmployeeLoanProducts."Disbursement Account No.";
                    PaymentLine.Validate(PaymentLine."Account No.");
                end;
                PaymentLine."Posting Date" := Today;
                PaymentLine."Posting Group" := '';
                PaymentLine.Description := DisbursementRequest.Description;
                PaymentLine."Total Amount" := DisbursementRequest."Amount to Disburse";
                PaymentLine.Validate("Total Amount");
                if PaymentLine.Insert then begin
                    DisbursementRequest2.Reset;
                    DisbursementRequest2.SetRange("No.", "DisbursementNo.");
                    if DisbursementRequest2.FindFirst then begin
                        DisbursementRequest2."Payment Voucher Created" := true;
                        DisbursementRequest2."Payment Voucher No" := "PaymentNo.";
                        DisbursementRequest2.Modify;
                        Message(Text_0002, "PaymentNo.", DisbursementRequest."No.");
                    end;
                end;



                PaymentHeader2.Reset;
                PaymentHeader2.SetRange("No.", PaymentHeader."No.");
                PaymentCard.SetTableView(PaymentHeader2);
                PaymentCard.Run;
            end;
        end;
    end;

    procedure CreateLoanPayrollDeduction("PaymentNo.": Code[20]; LoanAccountNo: Code[20]; TotalDisbursedAmount: Decimal)
    var
        PaymentHeader: Record "Payment Header";
        PaymentLine: Record "Payment Line";
        PaymentCode: Record "Funds Transaction Code";
        EmployeeDeductions: Record "HR Appraisal Competency Factor";
        LoanRepayment: Record "Employee Repayment Schedule";
        EmployeeLoanAccounts: Record "Employee Loan Accounts";
        EmployeeLoanProducts: Record "Employee Loan Products";
    begin
        /*PaymentHeader.RESET;
        PaymentHeader.GET("PaymentNo.");
        
        EmployeeLoanAccounts.RESET;
        EmployeeLoanAccounts.GET(PaymentHeader."Loan No.");
        
        PaymentLine.RESET;
        PaymentLine.SETRANGE(PaymentLine."Document No.",PaymentHeader."No.");
        IF PaymentLine.FINDFIRST THEN BEGIN
          PaymentCode.RESET;
          PaymentCode.GET(PaymentLine."Payment Code");
          PaymentCode.TESTFIELD(PaymentCode."Payroll Deduction Code");
        
          //remove payroll deduction if exist
          RemovePayrollDeduction("PaymentNo.",PaymentCode."Payroll Deduction Code");
          //end remove
        
        
          EmployeeDeductions.INIT;
          EmployeeDeductions."Appraisal No.":=EmployeeLoanAccounts."Employee No.";
          //EmployeeDeductions."Line No.":='SALARY';
          EmployeeDeductions."Competency Factor":=PaymentCode."Payroll Deduction Code";
          EmployeeDeductions.VALIDATE(EmployeeDeductions."Competency Factor");
          IF DATE2DMY(PaymentHeader."Posting Date",1)<15 THEN BEGIN
           // EmployeeDeductions.Comments:=CALCDATE('-CM',TODAY);
          END ELSE BEGIN
            //EmployeeDeductions.Comments:=CALCDATE('-CM',CALCDATE('+1M',TODAY));
          END;
          LoanRepayment.RESET;
          LoanRepayment.SETRANGE(LoanRepayment."Loan No.",EmployeeLoanAccounts."No.");
          LoanRepayment.SETRANGE(LoanRepayment."Employee No.",EmployeeLoanAccounts."Employee No.");
          IF LoanRepayment.FINDFIRST THEN BEGIN
           // EmployeeDeductions.Amount:=LoanRepayment."Total Repayment";
          END;
         // EmployeeDeductions.Balance:=TotalDisbursedAmount;
          EmployeeDeductions.VALIDATE(Balance);
          EmployeeDeductions."Loan No.":=EmployeeLoanAccounts."No.";
          EmployeeDeductions.VALIDATE(EmployeeDeductions.Amount);
          EmployeeDeductions."Start Date":=CALCDATE('-CM',EmployeeLoanAccounts."Repayment Start Date");
          EmployeeDeductions."End Date":=CALCDATE('-CM',EmployeeLoanAccounts."Repayment End Date");
          IF EmployeeDeductions.INSERT THEN BEGIN
            EmployeeLoanAccounts."Repayment Start Date":=PaymentHeader."Posting Date";
            EmployeeLoanAccounts.MODIFY;
           MESSAGE(Text_0009);
          END;
        END;*/

    end;

    procedure RemovePayrollDeduction("PaymentNo.": Code[20]; TransactionCode: Code[50])
    var
        PaymentHeader: Record "Payment Header";
        PaymentLine: Record "Payment Line";
        PaymentCode: Record "Funds Transaction Code";
        EmployeeDeductions: Record "HR Appraisal Competency Factor";
        LoanRepayment: Record "Employee Repayment Schedule";
        EmployeeLoanAccounts: Record "Employee Repayment Schedule";
        EmployeeLoanProducts: Record "Employee Loan Products";
    begin
        EmployeeDeductions.Reset;
        EmployeeDeductions.SetRange("Competency Factor", TransactionCode);
        EmployeeDeductions.SetRange("Appraisal No.", EmployeeLoanAccounts."Employee No.");
        if EmployeeDeductions.FindFirst then
            EmployeeDeductions.Delete;
    end;

    procedure UpdateDisbursementVoucher("PaymentNo.": Code[20])
    var
        EmployeeLoanAccounts: Record "Employee Loan Accounts";
        EmployeeLoanDisbursement: Record "Employee Loan Disbursement";
        PaymentHeader: Record "Payment Header";
    begin
        PaymentHeader.Get("PaymentNo.");
        PaymentHeader.CalcFields("Net Amount");

        EmployeeLoanDisbursement.Reset;
        EmployeeLoanDisbursement.SetRange("No.", PaymentHeader."Loan Disbursement No.");
        if EmployeeLoanDisbursement.FindFirst then begin
            EmployeeLoanDisbursement.Status := EmployeeLoanDisbursement.Status::Disbursed;
            EmployeeLoanDisbursement."Disbursed Amount" := PaymentHeader."Net Amount";
            EmployeeLoanDisbursement.Posted := true;
            EmployeeLoanDisbursement."Posted By" := PaymentHeader."Posted By";
            EmployeeLoanDisbursement."Date Posted" := PaymentHeader."Date Posted";
            EmployeeLoanDisbursement."Time Posted" := Time;
            EmployeeLoanDisbursement.Modify;
        end;
    end;

    procedure GetLoanDocuments(LoanProductCode: Code[50]; No: Code[20])
    var
        LoanProduct: Record "Employee Loan Products";
        LoanProductDocuments: Record "Employee Loan Product Document";
        ApplicationDocuments: Record "Loan Application Documents";
        ApplicationDocuments2: Record "Loan Application Documents";
    begin
        ApplicationDocuments2.Reset;
        ApplicationDocuments2.SetRange(ApplicationDocuments2."Application No.", No);
        if ApplicationDocuments2.FindSet then begin
            ApplicationDocuments2.DeleteAll
        end;
        Commit;

        EmployeeLoanProducts.Reset;
        EmployeeLoanProducts.SetRange(EmployeeLoanProducts.Code, LoanProductCode);
        if EmployeeLoanProducts.FindFirst then begin
            LoanProductDocuments.Reset;
            LoanProductDocuments.SetRange(LoanProductDocuments."Product Code", LoanProductCode);
            if LoanProductDocuments.FindSet then begin
                repeat
                    ApplicationDocuments.Init;
                    ApplicationDocuments."Application No." := No;
                    ApplicationDocuments."Document Code" := LoanProductDocuments."Document Code";
                    ApplicationDocuments."Document Description" := LoanProductDocuments."Document Description";
                    ApplicationDocuments."Product Code" := LoanProductCode;
                    ApplicationDocuments."Document Mandatory Stage" := LoanProductDocuments."Document Mandatory Stage";
                    ApplicationDocuments."Document Attached" := false;
                    ApplicationDocuments.Insert;
                until LoanProductDocuments.Next = 0;
            end else begin
            end;
        end;
    end;

    procedure ValidateEmployeeLoanAppliedAmount(EmployeeLoanApplications: Record "Employee Loan Applications") RepaymentAmount: Decimal
    var
        Employee: Record Employee;
        LoanProductGrades: Record "Loan Product Grades";
        EmployeeLoanProductDocs: Record "Employee Loan Product Document";
        EmployeeSalary: Record "Cover Letter";
        EmployeeSalaryLedger: Record "Employee Salary Ledger1";
        NewNetPay: Decimal;
    begin
        //check applied amounts if higher than loan limits
        /*Employee.RESET;
        Employee.GET(EmployeeLoanApplications."Employee No.");
        
        EmployeeLoanProducts.RESET;
        EmployeeLoanProducts.GET(EmployeeLoanApplications."Loan Product Code");
        IF EmployeeLoanProducts."Multiple of Basic Salary"=0 THEN BEGIN
          LoanProductGrades.RESET;
          IF LoanProductGrades.GET(EmployeeLoanApplications."Loan Product Code",Employee."Job Grade-d") THEN BEGIN
            IF EmployeeLoanApplications."Applied Amount">LoanProductGrades."Max. Loan Amount" THEN BEGIN
              ERROR(Text_0003,FORMAT(LoanProductGrades."Max. Loan Amount"),EmployeeLoanApplications."Loan Product Code");
            END;
          END ELSE BEGIN
            ERROR(Text_0004,EmployeeLoanApplications."Loan Product Code",EmployeeLoanApplications."Job Grade");
          END;
        END;
        
        //check if salary can support repayment and if netpay will be less than 1/3 of basic
        RepaymentAmount:=0;
        EmployeeLoanProducts.RESET;
        IF EmployeeLoanProducts.GET(EmployeeLoanApplications."Loan Product Code") THEN BEGIN
          EmployeeSalary.RESET;
          IF EmployeeSalary.GET(EmployeeLoanApplications."Employee No.") THEN BEGIN
            EmployeeSalary.TESTFIELD(EmployeeSalary."Basic Pay");
            IF EmployeeLoanApplications."Interest Rate"<>0 THEN BEGIN
              RepaymentAmount:=(EmployeeLoanApplications."Interest Rate"/12/100) / (1 - POWER((1 + (EmployeeLoanApplications."Interest Rate"/12/100)),-EmployeeLoanApplications."Repayment Period")) * EmployeeLoanApplications."Applied Amount";
            END ELSE BEGIN
              RepaymentAmount:=EmployeeLoanApplications."Applied Amount"/EmployeeLoanProducts."Repayment Period";
            END;
        
            //Netpay
            NewNetPay:=0;
            EmployeeSalaryLedger.RESET;
            EmployeeSalaryLedger.SETRANGE(EmployeeSalaryLedger."Employee No.",EmployeeLoanApplications."Employee No.");
            EmployeeSalaryLedger.SETRANGE(EmployeeSalaryLedger."Transaction Code",'NPAY');
            IF EmployeeSalaryLedger.FINDFIRST THEN BEGIN
              NewNetPay:=EmployeeSalaryLedger.Amount-RepaymentAmount;
            END;
        
            IF ((NewNetPay) < (EmployeeSalary."Basic Pay"*1/3)) THEN BEGIN
              ERROR(Text_0005,FORMAT(ROUND(RepaymentAmount)),FORMAT(EmployeeSalary."Basic Pay"));
            END;
        
            IF EmployeeLoanProducts."Multiple of Basic Salary"<>0 THEN BEGIN
              IF EmployeeLoanApplications."Applied Amount">EmployeeSalary."Basic Pay"*EmployeeLoanProducts."Multiple of Basic Salary" THEN
                ERROR(Text_0006,FORMAT(EmployeeLoanProducts."Multiple of Basic Salary"));
            END;
          END;
        END;*/

    end;

    procedure GetEntitlementAmount(EmployeeLoanApplications: Record "Employee Loan Applications") EntitledAmount: Decimal
    var
        EmployeeLoanProductDocs: Record "Employee Loan Product Document";
        EntitledAmount2: Decimal;
        EntitledAmount3: Decimal;
        TotalCashPay: Decimal;
        TotalAllowances: Decimal;
        JobGradeLevels: Record "HR Job Grade Levels";
        BasicPay: Decimal;
        Employee: Record Employee;
        PayrollPeriod: Date;
        LoanProductAllowances: Record "Loan Product Allowances";
        EmployeeAllowance: Record "HR Appraisal Resp/Duties";
        LoanProductGrades: Record "Loan Product Grades";
    begin
        //et amount based on limits
        /*Employee.GET(EmployeeLoanApplications."Employee No.");
        EntitledAmount2:=0;
        LoanProductGrades.RESET;
        IF LoanProductGrades.GET(EmployeeLoanApplications."Loan Product Code",Employee."Job Grade-d") THEN BEGIN
          EntitledAmount2:=LoanProductGrades."Max. Loan Amount";
        END;
        
        
        //get amount based on multipliers
        EntitledAmount3:=0;
        IF EmployeeLoanProducts.GET(EmployeeLoanApplications."Loan Product Code") THEN BEGIN
          IF EmployeeLoanProducts."Multiplier of" <> EmployeeLoanProducts."Multiplier of"::" " THEN BEGIN
            IF Employee.GET(EmployeeLoanApplications."Employee No.") THEN BEGIN
              JobGradeLevels.RESET;
              JobGradeLevels.SETRANGE("Job Grade",Employee."Job Grade-d");
              JobGradeLevels.SETRANGE("Job Grade Level",Employee."HR Salary Notch");
              IF JobGradeLevels.FINDFIRST THEN BEGIN
                BasicPay:=JobGradeLevels."Basic Pay Amount";
        
                //get allowances
                PayrollPeriod:=CALCDATE('-CM',TODAY);
                LoanProductAllowances.RESET;
                LoanProductAllowances.SETRANGE(LoanProductAllowances."Loan Product Code",EmployeeLoanApplications."Loan Product Code");
                IF LoanProductAllowances.FINDSET THEN BEGIN
                  REPEAT
                    EmployeeAllowance.RESET;
                    EmployeeAllowance.SETRANGE(EmployeeAllowance."Responsibility/Duty",LoanProductAllowances."Payroll Transaction Code");
                    EmployeeAllowance.SETRANGE(EmployeeAllowance."Appraisal Code",EmployeeLoanApplications."Employee No.");
                    EmployeeAllowance.SETRANGE(EmployeeAllowance."Payroll Period",PayrollPeriod);
                    IF EmployeeAllowance.FINDFIRST THEN BEGIN
                      TotalAllowances:=TotalAllowances+EmployeeAllowance.Amount;
                    END;
                  UNTIL LoanProductAllowances.NEXT=0;
                END;
              END;
            END;
          END;
         EntitledAmount3:=(TotalAllowances+BasicPay)*EmployeeLoanProducts."Multiple of Basic Salary";
        END;
        
        IF EntitledAmount2 > EntitledAmount3 THEN
          EntitledAmount:=EntitledAmount2 ELSE
          EntitledAmount:=EntitledAmount3;*/

    end;

    procedure CheckLoanApplicationRequiredDocuments(EmployeeLoanApplications: Record "Employee Loan Applications")
    var
        LoanProductDocs: Record "Employee Loan Product Document";
        LoanAppDocuments: Record "Loan Application Documents";
    begin
        //Check required documents
        /*LoanProductDocs.RESET;
        LoanProductDocs.SETRANGE(LoanProductDocs."Product Code",EmployeeLoanApplications."Loan Product Code");
        LoanProductDocs.SETRANGE(LoanProductDocs."Document Mandatory Stage",LoanProductDocs."Document Mandatory Stage"::Application);
        IF LoanProductDocs.FINDSET THEN BEGIN
          REPEAT
            LoanAppDocuments.RESET;
            LoanAppDocuments.SETRANGE(LoanAppDocuments."Application No.",EmployeeLoanApplications."No.");
            LoanAppDocuments.SETRANGE(LoanAppDocuments."Document Code",LoanProductDocs."Document Code");
            IF LoanAppDocuments.FINDFIRST THEN BEGIN
              IF NOT LoanAppDocuments.HASLINKS THEN
                ERROR(Text_0007,LoanProductDocs."Document Code");
            END ELSE BEGIN
              ERROR(Text_0008,LoanProductDocs."Document Code");
            END;
          UNTIL LoanProductDocs.NEXT=0;
        END;*/
        //End Check required documents

    end;

    procedure CheckLoanApprovalRequiredDocuments(EmployeeLoanApplications: Record "Employee Loan Applications")
    var
        LoanProductDocs: Record "Employee Loan Product Document";
        LoanAppDocuments: Record "Loan Application Documents";
    begin
        //Check required documents
        /*LoanProductDocs.RESET;
        LoanProductDocs.SETRANGE(LoanProductDocs."Product Code",EmployeeLoanApplications."Loan Product Code");
        LoanProductDocs.SETRANGE(LoanProductDocs."Document Mandatory Stage",LoanProductDocs."Document Mandatory Stage"::Approval);
        IF LoanProductDocs.FINDSET THEN BEGIN
          REPEAT
            LoanAppDocuments.RESET;
            LoanAppDocuments.SETRANGE(LoanAppDocuments."Application No.",EmployeeLoanApplications."No.");
            LoanAppDocuments.SETRANGE(LoanAppDocuments."Document Code",LoanProductDocs."Document Code");
            IF LoanAppDocuments.FINDFIRST THEN BEGIN
              IF NOT LoanAppDocuments.HASLINKS THEN
                ERROR(Text_0007,LoanProductDocs."Document Code");
            END ELSE BEGIN
              ERROR(Text_0008,LoanProductDocs."Document Code");
            END;
          UNTIL LoanProductDocs.NEXT=0;
        END;*/
        //End Check required documents

    end;

    procedure CheckLoanAccountCreationRequiredDocuments(EmployeeLoanApplications: Record "Employee Loan Applications")
    var
        LoanProductDocs: Record "Employee Loan Product Document";
        LoanAppDocuments: Record "Loan Application Documents";
    begin
        //Check required documents
        /*LoanProductDocs.RESET;
        LoanProductDocs.SETRANGE(LoanProductDocs."Product Code",EmployeeLoanApplications."Loan Product Code");
        LoanProductDocs.SETRANGE(LoanProductDocs."Document Mandatory Stage",LoanProductDocs."Document Mandatory Stage"::"Account Creation");
        IF LoanProductDocs.FINDSET THEN BEGIN
          REPEAT
            LoanAppDocuments.RESET;
            LoanAppDocuments.SETRANGE(LoanAppDocuments."Application No.",EmployeeLoanApplications."No.");
            LoanAppDocuments.SETRANGE(LoanAppDocuments."Document Code",LoanProductDocs."Document Code");
            IF LoanAppDocuments.FINDFIRST THEN BEGIN
              IF NOT LoanAppDocuments.HASLINKS THEN
                ERROR(Text_0007,LoanProductDocs."Document Code");
            END ELSE BEGIN
              ERROR(Text_0008,LoanProductDocs."Document Code");
            END;
          UNTIL LoanProductDocs.NEXT=0;
        END;*/
        //End Check required documents

    end;

    procedure CreateLoanNotificationEmailHR(EmployeeLoanApplications: Record "Employee Loan Applications"; EmailAddress: Text)
    var
        Employee: Record Employee;
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
    begin
        // SMTPMailSetup.Get;
        if Employee.Get(EmployeeLoanApplications."Employee No.") then begin
            EmailBody := '';
            EmailBody := EmailBody + 'Kindly recommend to the Executive Director and attach a valuation report where applicable.<br>';
            EmailBody := EmailBody + 'Loan Application details:<br>';
            EmailBody := EmailBody + '_______________________________________________________<br>';
            EmailBody := EmailBody + 'Loan Application No.:' + EmployeeLoanApplications."No." + '<br>';
            EmailBody := EmailBody + 'Product Code:' + EmployeeLoanApplications."Loan Product Code" + '<br>';
            EmailBody := EmailBody + 'Amount Applied:' + Format(EmployeeLoanApplications."Applied Amount") + '<br>';
            EmailBody := EmailBody + 'Kind Regards<br>';
            EmailBody := EmailBody + Employee."First Name" + ' ' + Employee."Last Name" + '<br>';
            EmailBody := EmailBody + '_____________________________________________________________________________<br>';
            EmailBody := EmailBody + '<i>This is a system generated email, do not reply to this email</i><br>';

            SenderName := 'ICDC HR Department';
            //SenderAddress:=SMTPMailSetup."User ID";
            Subject := EmployeeLoanApplications."Loan Product Description" + ' Application.';
            Recipients := EmailAddress;
            RecipientsBCC := '';

            InsertHREmailMessage(SenderName, SenderAddress, Subject, Recipients, RecipientsCC, RecipientsBCC, EmailBody);
        end;
    end;

    procedure CreateLoanNotificationEmployee(EmployeeLoanApplications: Record "Employee Loan Applications"; EmailAddress: Text)
    var
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
    begin
        // SMTPMailSetup.Get;
        EmailBody := '';
        EmailBody := EmailBody + 'Your loan application was successfully submitted to the human resource department for appraisal. Loan details:<br>';
        EmailBody := EmailBody + 'Loan Application No.: ' + EmployeeLoanApplications."No." + '<br>';
        EmailBody := EmailBody + 'Product Code: ' + EmployeeLoanApplications."Loan Product Code" + '<br>';
        EmailBody := EmailBody + 'Amount Applied: ' + Format(EmployeeLoanApplications."Applied Amount") + '<br>';
        EmailBody := EmailBody + 'Further communication will be via your official email address ' + EmailAddress + '.<br><br>';
        EmailBody := EmailBody + '_____________________________________________________________________________<br>';
        EmailBody := EmailBody + '<i>This is a system generated email, do not reply to this email</i><br>';

        SenderName := 'ICDC HR Department';
        //SenderAddress:=SMTPMailSetup."User ID";
        Subject := EmployeeLoanApplications."Loan Product Description" + ' Application.';
        Recipients := EmailAddress;
        RecipientsBCC := '';

        InsertHREmailMessage(SenderName, SenderAddress, Subject, Recipients, RecipientsCC, RecipientsBCC, EmailBody);
    end;

    procedure CreateLoanNotificationEmailED(EmployeeLoanApplications: Record "Employee Loan Applications"; EmailAddress: Text)
    var
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
    begin
        //SMTPMailSetup.Get;
        EmailBody := '';
        EmailBody := EmailBody + 'A staff loan application awaits your approval.<br>';
        EmailBody := EmailBody + 'Loan Application details:<br>';
        EmailBody := EmailBody + '_______________________________________________________<br>';
        EmailBody := EmailBody + 'Employee No.: ' + EmployeeLoanApplications."Employee No." + '<br>';
        EmailBody := EmailBody + 'Employee Name:  ' + EmployeeLoanApplications."Employee Name" + '<br>';
        EmailBody := EmailBody + 'Loan Application No.: ' + EmployeeLoanApplications."No." + '<br>';
        EmailBody := EmailBody + 'Product Code: ' + EmployeeLoanApplications."Loan Product Code" + '<br>';
        EmailBody := EmailBody + 'Amount Applied: ' + Format(EmployeeLoanApplications."Applied Amount") + '<br><br>';
        EmailBody := EmailBody + 'Kind Regards<br>';
        EmailBody := EmailBody + 'Human Resource Department<br><br>';
        EmailBody := EmailBody + '_____________________________________________________________________________<br>';
        EmailBody := EmailBody + '<i>This is a system generated email, do not reply to this email</i><br>';

        SenderName := 'ICDC HR Department';
        //SenderAddress:=SMTPMailSetup."User ID";
        Subject := EmployeeLoanApplications."Loan Product Description" + ' Application.';
        Recipients := EmailAddress;
        RecipientsBCC := '';

        InsertHREmailMessage(SenderName, SenderAddress, Subject, Recipients, RecipientsCC, RecipientsBCC, EmailBody);
    end;

    procedure CreateNotificationEmailLegal(EmployeeLoanApplications: Record "Employee Loan Applications"; EmailAddress: Text)
    var
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
    begin
        // SMTPMailSetup.Get;
        EmailBody := '';
        EmailBody := EmailBody + 'The staff loan below has been approved, Kindly issue offer letter and where applicable facilitate registration of securities.<br>';
        EmailBody := EmailBody + 'Loan Application details:<br>';
        EmailBody := EmailBody + '_______________________________________________________<br>';
        EmailBody := EmailBody + 'Employee No.:' + EmployeeLoanApplications."Employee No." + '<br>';
        EmailBody := EmailBody + 'Employee Name:' + EmployeeLoanApplications."Employee Name" + '<br>';
        EmailBody := EmailBody + 'Loan Application No.:' + EmployeeLoanApplications."No." + '<br>';
        EmailBody := EmailBody + 'Product Code:' + EmployeeLoanApplications."Loan Product Code" + '<br>';
        EmailBody := EmailBody + 'Amount Applied:' + Format(EmployeeLoanApplications."Applied Amount") + '<br><br>';
        EmailBody := EmailBody + 'Kind Regards<br>';
        EmailBody := EmailBody + 'Executive Director Department<br><br>';
        EmailBody := EmailBody + '_____________________________________________________________________________<br>';
        EmailBody := EmailBody + '<i>This is a system generated email, do not reply to this email</i><br>';

        SenderName := 'ICDC HR Department';
        //SenderAddress:=SMTPMailSetup."User ID";
        Subject := EmployeeLoanApplications."Loan Product Description" + ' Application.';
        Recipients := EmailAddress;
        RecipientsBCC := '';

        InsertHREmailMessage(SenderName, SenderAddress, Subject, Recipients, RecipientsCC, RecipientsBCC, EmailBody);
        //End Email to Legal
    end;

    procedure CreateRejectionNotificationEmailApplicant(EmployeeLoanApplications: Record "Employee Loan Applications"; EmailAddress: Text)
    var
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
    begin
        // SMTPMailSetup.Get;
        EmailBody := '';
        EmailBody := EmailBody + 'Your loan application was rejected.<br>';
        EmailBody := EmailBody + 'Reason for rejection:' + EmployeeLoanApplications."Rejection Comment" + '<br>';
        EmailBody := EmailBody + 'Loan Application details:<br>';
        EmailBody := EmailBody + '_______________________________________________________<br>';
        EmailBody := EmailBody + 'Loan Application No.:' + EmployeeLoanApplications."No." + '<br>';
        EmailBody := EmailBody + 'Product Code:' + EmployeeLoanApplications."Loan Product Code" + '<br>';
        EmailBody := EmailBody + 'Amount Applied:' + Format(EmployeeLoanApplications."Applied Amount") + '<br><br>';
        EmailBody := EmailBody + 'Kind Regards<br>';
        EmailBody := EmailBody + 'Human Resource Department<br><br>';
        EmailBody := EmailBody + '_____________________________________________________________________________<br>';
        EmailBody := EmailBody + '<i>This is a system generated email, do not reply to this email</i><br>';

        SenderName := 'ICDC HR Department';
        //SenderAddress:=SMTPMailSetup."User ID";
        Subject := EmployeeLoanApplications."Loan Product Description" + ' Application.';
        Recipients := EmailAddress;
        RecipientsBCC := '';

        InsertHREmailMessage(SenderName, SenderAddress, Subject, Recipients, RecipientsCC, RecipientsBCC, EmailBody);
    end;

    procedure CreateApprovalNotificationEmailApplicant(EmployeeLoanApplications: Record "Employee Loan Applications"; EmailAddress: Text)
    var
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
    begin
        // SMTPMailSetup.Get;

        EmailBody := '';
        EmailBody := EmailBody + 'Your loan application has been approved.<br>';
        EmailBody := EmailBody + 'Loan Application details:<br>';
        EmailBody := EmailBody + '_______________________________________________________<br>';
        EmailBody := EmailBody + 'Loan Application No.:' + EmployeeLoanApplications."No." + '<br>';
        EmailBody := EmailBody + 'Product Code:' + EmployeeLoanApplications."Loan Product Code" + '<br>';
        EmailBody := EmailBody + 'Amount Applied:' + Format(EmployeeLoanApplications."Applied Amount") + '<br><br>';
        EmailBody := EmailBody + 'Kind Regards<br>';
        EmailBody := EmailBody + 'Human Resource Department<br><br>';
        EmailBody := EmailBody + '_____________________________________________________________________________<br>';
        EmailBody := EmailBody + '<i>This is a system generated email, do not reply to this email</i><br>';

        SenderName := 'ICDC HR Department';
        // SenderAddress:=SMTPMailSetup."User ID";
        Subject := EmployeeLoanApplications."Loan Product Description" + ' Application.';
        Recipients := EmailAddress;
        RecipientsBCC := '';

        InsertHREmailMessage(SenderName, SenderAddress, Subject, Recipients, RecipientsCC, RecipientsBCC, EmailBody);
    end;

    local procedure InsertHREmailMessage("Sender Name": Text[100]; "Sender Address": Text[80]; Subject: Text[100]; Recipients: Text[250]; "Recipients CC": Text[250]; "Recipients BCC": Text[250]; Body: Text) EmailMessageInserted: Boolean
    var
        HREmailMessage: Record "HR Email Messages";
        EmailBodyText: BigText;
        EmailBodyOutStream: OutStream;
    begin
        EmailMessageInserted := false;

        HREmailMessage.Init;
        HREmailMessage."Entry No." := 0;
        HREmailMessage."Sender Name" := "Sender Name";
        HREmailMessage."Sender Address" := "Sender Address";
        HREmailMessage.Subject := Subject;
        HREmailMessage.Recipients := Recipients;
        HREmailMessage."Recipients CC" := "Recipients CC";
        HREmailMessage."Recipients BCC" := "Recipients BCC";
        EmailBodyText.AddText(Body);
        HREmailMessage.Body.CreateOutStream(EmailBodyOutStream);
        EmailBodyText.Write(EmailBodyOutStream);
        HREmailMessage.HtmlFormatted := true;
        HREmailMessage."Created By" := UserId;
        HREmailMessage."Date Created" := Today;
        HREmailMessage."Time Created" := Time;
        if HREmailMessage.Insert then
            EmailMessageInserted := true;
    end;

    procedure ApplyLoanCustomerReceipts("ReceiptNo.": Code[20]; "CustomerNo.": Code[20])
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntry2: Record "Cust. Ledger Entry";
        ApplyingCustLedgEntry: Record "Cust. Ledger Entry";
        NewDocumentNo: Code[20];
        NewApplicationDate: Date;
        CustEntryApplyPostedEntries: Codeunit "CustEntry-Apply Posted Entries";
        CustLedgEntry3: Record "Cust. Ledger Entry";
        AmountToApply: Decimal;
        AppliedAmount: Decimal;
    begin
        AmountToApply := 0;
        CustLedgEntry2.Reset;
        CustLedgEntry2.SetRange(CustLedgEntry2."Document No.", "ReceiptNo.");
        CustLedgEntry2.SetRange(CustLedgEntry2.Open, true);
        if CustLedgEntry2.FindFirst then begin
            ApplyingCustLedgEntry.Reset;
            ApplyingCustLedgEntry.SetRange(ApplyingCustLedgEntry."Entry No.", CustLedgEntry2."Entry No.");
            ApplyingCustLedgEntry.SetRange(ApplyingCustLedgEntry.Open, true);
            if ApplyingCustLedgEntry.FindFirst then begin
                ApplyingCustLedgEntry."Applying Entry" := true;
                ApplyingCustLedgEntry."Applies-to ID" := UserId;
                ApplyingCustLedgEntry.CalcFields("Remaining Amount");
                ApplyingCustLedgEntry."Amount to Apply" := ApplyingCustLedgEntry."Remaining Amount";
                ApplyingCustLedgEntry.Modify;
                Commit;

                AmountToApply := ApplyingCustLedgEntry."Amount to Apply";
                repeat
                    AmountToApply := AmountToApply - AppliedAmount;
                    AppliedAmount := 0;
                    //Invoice Applied to
                    EmployeeLoanAccounts.Reset;
                    EmployeeLoanAccounts.SetRange("Employee No.", "CustomerNo.");
                    if EmployeeLoanAccounts.FindSet then begin
                        repeat
                            CustLedgEntry.Reset;
                            CustLedgEntry.SetRange(CustLedgEntry."Customer No.", ApplyingCustLedgEntry."Customer No.");
                            CustLedgEntry.SetRange(CustLedgEntry."Investment Account No.", EmployeeLoanAccounts."No.");
                            CustLedgEntry.SetFilter("Investment Transaction Type", '=%1|%2|%3|%4', 2, 4, 6, 8);
                            CustLedgEntry.SetFilter(Amount, '>%1', 0);
                            CustLedgEntry.SetRange(Open, true);
                            if CustLedgEntry.FindSet then begin
                                repeat
                                    CustLedgEntry.CalcFields(CustLedgEntry."Remaining Amount");
                                    CustLedgEntry."Applies-to ID" := UserId;
                                    if CustLedgEntry."Remaining Amount" > (ApplyingCustLedgEntry."Remaining Amount" * -1) then
                                        CustLedgEntry."Amount to Apply" := ApplyingCustLedgEntry."Remaining Amount" * -1;
                                    AppliedAmount := CustLedgEntry."Amount to Apply";
                                    if CustLedgEntry."Remaining Amount" <= (ApplyingCustLedgEntry."Remaining Amount" * -1) then
                                        CustLedgEntry."Amount to Apply" := CustLedgEntry."Remaining Amount";
                                    AppliedAmount := CustLedgEntry."Amount to Apply";
                                    CustLedgEntry.Modify;
                                    Commit;
                                until CustLedgEntry.Next = 0;
                            end;
                        until EmployeeLoanAccounts.Next = 0;
                    end;
                until AmountToApply = 0;
                //Post Application
                NewDocumentNo := ApplyingCustLedgEntry."Document No.";
                if ApplyingCustLedgEntry."Posting Date" > CustLedgEntry."Posting Date" then
                    NewApplicationDate := ApplyingCustLedgEntry."Posting Date"
                else
                    NewApplicationDate := CustLedgEntry."Posting Date";

                //CustEntryApplyPostedEntries.Apply(ApplyingCustLedgEntry,NewDocumentNo,NewApplicationDate);
            end;
            Commit;

            ApplyingCustLedgEntry.Reset;
            ApplyingCustLedgEntry.SetRange(ApplyingCustLedgEntry."Entry No.", CustLedgEntry2."Entry No.");
            if ApplyingCustLedgEntry.FindFirst then begin
                ApplyingCustLedgEntry."Applying Entry" := false;
                ApplyingCustLedgEntry."Applies-to ID" := '';
                ApplyingCustLedgEntry."Amount to Apply" := 0;
                ApplyingCustLedgEntry.Modify;
                Commit;
            end;
        end;
    end;

    procedure AccrueEmployeeLoanAccountInterest("AccountNo.": Code[20]; RunDate: Date)
    var
        AccountInterestAccrual: Record "Employee Interest Accrual";
        AccountInterestAccrual2: Record "Employee Interest Accrual";
        AmortizationSchedule: Record "Employee Repayment Schedule";
        InterestRate: Decimal;
        InterestAmount: Decimal;
        "LineNo.": Integer;
        "DocNo.": Code[20];
        MonthFormatStr: Label '<Month Text> <Day>';
    begin
        HumanResourcesSetup.Reset;
        HumanResourcesSetup.Get;
        HumanResourcesSetup.TestField(HumanResourcesSetup."Interest Journal Template");
        HumanResourcesSetup.TestField(HumanResourcesSetup."Interest Journal Batch");

        EmployeeLoanAccounts.Reset;
        EmployeeLoanAccounts.Get("AccountNo.");

        LoanProduct.Reset;
        LoanProduct.Get(EmployeeLoanAccounts."Loan Product Code");
        LoanProduct.TestField("Interest Accrual Account");

        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", HumanResourcesSetup."Interest Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", HumanResourcesSetup."Interest Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        Commit;

        AccountInterestAccrual2.Reset;
        AccountInterestAccrual2.SetRange(AccountInterestAccrual2."Account No.", "AccountNo.");
        AccountInterestAccrual2.SetRange(AccountInterestAccrual2."Accrual Type", AccountInterestAccrual2."Accrual Type"::"Interest Accrual");
        AccountInterestAccrual2.SetRange(AccountInterestAccrual2."Accrual Date", RunDate);
        if AccountInterestAccrual2.FindSet then begin
            AccountInterestAccrual2.DeleteAll;
        end;
        Commit;


        case LoanProduct."Interest Calculation Method" of
            LoanProduct."Interest Calculation Method"::"Reducing Balance":
                InterestAmount := ((LoanProduct."Interest Rate(%)" / 100) * GetLoanAccountPrincipalBalance("AccountNo.")) / 365;
        end;

        AccountInterestAccrual.Init;
        AccountInterestAccrual."Account No." := "AccountNo.";
        AccountInterestAccrual."Accrual Type" := AccountInterestAccrual."Accrual Type"::"Interest Accrual";
        AccountInterestAccrual."Accrual Date" := RunDate;
        AccountInterestAccrual.Amount := InterestAmount;
        AccountInterestAccrual.Insert;

        if InterestAmount <> 0 then begin
            //insert lines
            "LineNo." := 1000;
            "DocNo." := 'INT ' + Format(RunDate, 0, MonthFormatStr);

            GenJnlLine.Init;
            GenJnlLine."Journal Template Name" := HumanResourcesSetup."Interest Journal Template";
            GenJnlLine.Validate("Journal Template Name");
            GenJnlLine."Journal Batch Name" := HumanResourcesSetup."Interest Journal Batch";
            GenJnlLine.Validate("Journal Batch Name");
            GenJnlLine."Line No." := "LineNo.";
            GenJnlLine."Source Code" := '';
            GenJnlLine."Posting Date" := RunDate;
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice;
            GenJnlLine."Document No." := "DocNo.";
            GenJnlLine."External Document No." := '';
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."Account No." := LoanProduct."Interest Accrual Account";
            GenJnlLine.Validate("Account No.");
            GenJnlLine."Currency Code" := '';
            GenJnlLine.Amount := InterestAmount;  //Debit Amount
            GenJnlLine.Validate(Amount);
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
            GenJnlLine."Bal. Account No." := '';
            GenJnlLine.Validate("Bal. Account No.");
            //Due Date
            if LoanProduct."Repayment Frequency" = LoanProduct."Repayment Frequency"::Monthly then begin
                GenJnlLine."Due Date" := CalcDate('CM', RunDate);
            end;
            if LoanProduct."Repayment Frequency" = LoanProduct."Repayment Frequency"::Quarterly then begin
                GenJnlLine."Due Date" := CalcDate('CQ', RunDate);
            end;
            //End Due Date
            GenJnlLine."Shortcut Dimension 1 Code" := EmployeeLoanAccounts."Global Dimension 1 Code";
            GenJnlLine.Validate("Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code" := EmployeeLoanAccounts."Global Dimension 2 Code";
            GenJnlLine.Validate("Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3, EmployeeLoanAccounts."Shortcut Dimension 3 Code");
            GenJnlLine.ValidateShortcutDimCode(4, EmployeeLoanAccounts."Shortcut Dimension 4 Code");
            GenJnlLine.ValidateShortcutDimCode(5, EmployeeLoanAccounts."Shortcut Dimension 5 Code");
            GenJnlLine.ValidateShortcutDimCode(6, EmployeeLoanAccounts."Shortcut Dimension 6 Code");
            GenJnlLine.ValidateShortcutDimCode(7, EmployeeLoanAccounts."Shortcut Dimension 7 Code");
            GenJnlLine.ValidateShortcutDimCode(8, EmployeeLoanAccounts."Shortcut Dimension 8 Code");
            GenJnlLine.Description := 'Interest Receivable - Account no.' + EmployeeLoanAccounts."No.";
            GenJnlLine.Description2 := 'Interest Receivable for loan account no.' + EmployeeLoanAccounts."No.";
            GenJnlLine.Validate(Description);
            GenJnlLine."Customer No." := EmployeeLoanAccounts."Employee No.";
            GenJnlLine."Investment Account No." := EmployeeLoanAccounts."No.";
            GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Interest Receivable";
            if GenJnlLine.Amount <> 0 then
                GenJnlLine.Insert;

            // Credit Entry (Income)
            GenJnlLine.Init;
            GenJnlLine."Journal Template Name" := HumanResourcesSetup."Interest Journal Template";
            GenJnlLine.Validate("Journal Template Name");
            GenJnlLine."Journal Batch Name" := HumanResourcesSetup."Interest Journal Batch";
            GenJnlLine.Validate("Journal Batch Name");
            GenJnlLine."Line No." := "LineNo." + 1;
            GenJnlLine."Source Code" := '';
            GenJnlLine."Posting Date" := RunDate;
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice;
            GenJnlLine."Document No." := "DocNo.";
            GenJnlLine."External Document No." := '';
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."Account No." := LoanProduct."Interest Income Account";
            GenJnlLine.Validate("Account No.");
            GenJnlLine."Currency Code" := '';
            GenJnlLine.Amount := -InterestAmount;  //Credit Amount
            GenJnlLine.Validate(Amount);
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
            GenJnlLine."Bal. Account No." := '';
            GenJnlLine.Validate("Bal. Account No.");
            //Due Date
            if LoanProduct."Repayment Frequency" = LoanProduct."Repayment Frequency"::Monthly then begin
                GenJnlLine."Due Date" := CalcDate('CM', RunDate);
            end;
            if LoanProduct."Repayment Frequency" = LoanProduct."Repayment Frequency"::Quarterly then begin
                GenJnlLine."Due Date" := CalcDate('CQ', RunDate);
            end;
            //End Due Date
            GenJnlLine."Shortcut Dimension 1 Code" := EmployeeLoanAccounts."Global Dimension 1 Code";
            GenJnlLine.Validate("Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code" := EmployeeLoanAccounts."Global Dimension 2 Code";
            GenJnlLine.Validate("Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3, EmployeeLoanAccounts."Shortcut Dimension 3 Code");
            GenJnlLine.ValidateShortcutDimCode(4, EmployeeLoanAccounts."Shortcut Dimension 4 Code");
            GenJnlLine.ValidateShortcutDimCode(5, EmployeeLoanAccounts."Shortcut Dimension 5 Code");
            GenJnlLine.ValidateShortcutDimCode(6, EmployeeLoanAccounts."Shortcut Dimension 6 Code");
            GenJnlLine.ValidateShortcutDimCode(7, EmployeeLoanAccounts."Shortcut Dimension 7 Code");
            GenJnlLine.ValidateShortcutDimCode(8, EmployeeLoanAccounts."Shortcut Dimension 8 Code");
            GenJnlLine.Description := 'Interest Income - Account no.' + EmployeeLoanAccounts."No.";
            GenJnlLine.Description2 := 'Interest Receivable for loan account no.' + EmployeeLoanAccounts."No.";
            GenJnlLine.Validate(Description);
            GenJnlLine."Customer No." := EmployeeLoanAccounts."Employee No.";
            GenJnlLine."Investment Account No." := EmployeeLoanAccounts."No.";
            GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Interest Receivable";
            if GenJnlLine.Amount <> 0 then
                GenJnlLine.Insert;


            Commit;
            //Post the Journal Lines

            GenJnlLine.Reset;
            GenJnlLine.SetRange("Journal Template Name", HumanResourcesSetup."Interest Journal Template");
            GenJnlLine.SetRange("Journal Batch Name", HumanResourcesSetup."Interest Journal Batch");
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnlLine);
            Commit;

        end;
    end;

    procedure GetLoanAccountPrincipalBalance("AccountNo.": Code[20]) PrincipalBalance: Decimal
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        PrincipalBalance := 0;
        EmployeeLoanAccounts.Get("AccountNo.");

        EmployeeLoanProducts.Get(EmployeeLoanAccounts."Loan Product Code");

        CustLedgerEntry.Reset;
        CustLedgerEntry.SetRange("Investment Account No.", "AccountNo.");
        CustLedgerEntry.SetRange("Investment Transaction Type", CustLedgerEntry."Investment Transaction Type"::"Loan Disbursement");
        if CustLedgerEntry.FindSet then begin
            repeat
                CustLedgerEntry.CalcFields(Amount);
                PrincipalBalance := PrincipalBalance + CustLedgerEntry.Amount;
            until CustLedgerEntry.Next = 0;
        end;

        exit(PrincipalBalance);
    end;

    procedure PostEmployeeLoanAccountInterest("AccountNo.": Code[20]; StartDate: Date; EndDate: Date)
    var
        AccountInterestAccrual: Record "Employee Interest Accrual";
        InterestAmount: Decimal;
        "LineNo.": Integer;
        MonthFormatStr: Label '<Month Text> <Year>';
        "DocNo.": Code[20];
        TotalInterestAmount: Decimal;
    begin
        HumanResourcesSetup.Reset;
        HumanResourcesSetup.Get;
        HumanResourcesSetup.TestField(HumanResourcesSetup."Interest Journal Template");
        HumanResourcesSetup.TestField(HumanResourcesSetup."Interest Journal Batch");

        EmployeeLoanAccounts.Reset;
        EmployeeLoanAccounts.Get("AccountNo.");

        LoanProduct.Reset;
        LoanProduct.Get(EmployeeLoanAccounts."Loan Product Code");

        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", HumanResourcesSetup."Interest Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", HumanResourcesSetup."Interest Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        Commit;

        //get total interest amount
        TotalInterestAmount := 0;
        AccountInterestAccrual.Reset;
        AccountInterestAccrual.SetRange(AccountInterestAccrual."Account No.", EmployeeLoanAccounts."No.");
        AccountInterestAccrual.SetRange(AccountInterestAccrual."Accrual Type", AccountInterestAccrual."Accrual Type"::"Interest Accrual");
        AccountInterestAccrual.SetRange(AccountInterestAccrual."Accrual Date", StartDate, EndDate);
        AccountInterestAccrual.SetRange(AccountInterestAccrual."Posted to Customer Account", false);
        if AccountInterestAccrual.FindSet then begin
            repeat
                TotalInterestAmount := TotalInterestAmount + AccountInterestAccrual.Amount;
            until AccountInterestAccrual.Next = 0;
        end;

        //insert lines
        // InterestAmount:=AccountInterestAccrual.Amount;
        "LineNo." := 1000;
        "DocNo." := 'INT ' + Format(StartDate, 0, MonthFormatStr);

        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := HumanResourcesSetup."Interest Journal Template";
        GenJnlLine.Validate("Journal Template Name");
        GenJnlLine."Journal Batch Name" := HumanResourcesSetup."Interest Journal Batch";
        GenJnlLine.Validate("Journal Batch Name");
        GenJnlLine."Line No." := "LineNo.";
        GenJnlLine."Source Code" := '';
        GenJnlLine."Posting Date" := EndDate;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice;
        GenJnlLine."Document No." := "DocNo.";
        GenJnlLine."External Document No." := '';
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := EmployeeLoanAccounts."Employee No.";
        GenJnlLine.Validate("Account No.");
        GenJnlLine."Currency Code" := '';
        GenJnlLine.Amount := TotalInterestAmount;  //Debit Amount
        GenJnlLine.Validate(Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := LoanProduct."Interest Accrual Account";
        GenJnlLine.Validate("Bal. Account No.");
        //Due Date
        if LoanProduct."Repayment Frequency" = LoanProduct."Repayment Frequency"::Monthly then begin
            GenJnlLine."Due Date" := CalcDate('CM', StartDate);
        end;
        if LoanProduct."Repayment Frequency" = LoanProduct."Repayment Frequency"::Quarterly then begin
            GenJnlLine."Due Date" := CalcDate('CQ', StartDate);
        end;
        //End Due Date
        GenJnlLine."Posting Group" := LoanProduct."Interest Receivable PG";
        GenJnlLine.Validate(GenJnlLine."Posting Group");
        GenJnlLine."Shortcut Dimension 1 Code" := EmployeeLoanAccounts."Global Dimension 1 Code";
        GenJnlLine.Validate("Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := EmployeeLoanAccounts."Global Dimension 2 Code";
        GenJnlLine.Validate("Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, EmployeeLoanAccounts."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, EmployeeLoanAccounts."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, EmployeeLoanAccounts."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, EmployeeLoanAccounts."Shortcut Dimension 6 Code");
        GenJnlLine.ValidateShortcutDimCode(7, EmployeeLoanAccounts."Shortcut Dimension 7 Code");
        GenJnlLine.ValidateShortcutDimCode(8, EmployeeLoanAccounts."Shortcut Dimension 8 Code");
        GenJnlLine.Description := 'Interest Receivable - Account no.' + EmployeeLoanAccounts."No.";
        GenJnlLine.Description2 := 'Interest Receivable for loan account no.' + EmployeeLoanAccounts."No.";
        GenJnlLine.Validate(Description);
        GenJnlLine."Customer No." := EmployeeLoanAccounts."Employee No.";
        GenJnlLine."Investment Account No." := EmployeeLoanAccounts."No.";
        GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Interest Receivable";
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;


        Commit;
        //Post the Journal Lines
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", HumanResourcesSetup."Interest Journal Template");
        GenJnlLine.SetRange("Journal Batch Name", HumanResourcesSetup."Interest Journal Batch");
        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnlLine);
        Commit;

        CustLedgerEntry.Reset;
        CustLedgerEntry.SetRange(CustLedgerEntry."Document No.", "DocNo.");
        CustLedgerEntry.SetRange(CustLedgerEntry."Posting Date", EndDate);
        if CustLedgerEntry.FindFirst then begin
            AccountInterestAccrual.Reset;
            AccountInterestAccrual.SetRange(AccountInterestAccrual."Account No.", EmployeeLoanAccounts."No.");
            AccountInterestAccrual.SetRange(AccountInterestAccrual."Accrual Type", AccountInterestAccrual."Accrual Type"::"Interest Accrual");
            AccountInterestAccrual.SetRange(AccountInterestAccrual."Accrual Date", StartDate, EndDate);
            AccountInterestAccrual.SetRange(AccountInterestAccrual."Posted to Customer Account", false);
            if AccountInterestAccrual.FindSet then begin
                repeat
                    AccountInterestAccrual."Posted to Customer Account" := true;
                    AccountInterestAccrual.Modify;
                until AccountInterestAccrual.Next = 0;
            end;
        end;
    end;

    procedure GenerateEmployeeAccountInvoice("AccountNo.": Code[20]; RunDate: Date)
    var
        EmployeeAccountInvoice: Record "Employee Account Invoice2";
        "LineNo.": Integer;
        RepaymentSchedule: Record "Employee Repayment Schedule";
        ArrearsDate: Date;
    begin
        HumanResourcesSetup.Reset;
        HumanResourcesSetup.Get;
        HumanResourcesSetup.TestField(HumanResourcesSetup."Loan Invoice Nos");

        ArrearsDate := CalcDate('CM', CalcDate('-1M', RunDate));

        EmployeeLoanAccounts.Reset;
        EmployeeLoanAccounts.Get("AccountNo.");

        RepaymentSchedule.Reset;
        RepaymentSchedule.SetRange(RepaymentSchedule."Loan No.", EmployeeLoanAccounts."No.");
        RepaymentSchedule.SetRange(RepaymentSchedule."Repayment Date", CalcDate('CM', RunDate));
        if RepaymentSchedule.FindFirst then begin
            EmployeeAccountInvoice.Init;
            EmployeeAccountInvoice."No." := "NoSeriesMgt.".GetNextNo(HumanResourcesSetup."Loan Invoice Nos", 0D, true);
            EmployeeAccountInvoice."Document Date" := Today;
            EmployeeAccountInvoice."Posting Date" := CalcDate('CM', RunDate);
            EmployeeAccountInvoice."Customer No." := EmployeeLoanAccounts."Employee No.";
            EmployeeAccountInvoice."Customer Name" := EmployeeLoanAccounts."Employee Name";
            EmployeeAccountInvoice."Loan Account No." := EmployeeLoanAccounts."No.";
            EmployeeAccountInvoice."Principal Arrears" := EmployeeLoanAccounts."Principal Arrears";
            EmployeeAccountInvoice."Interest Arrears" := EmployeeLoanAccounts."Interest Arrears";
            EmployeeAccountInvoice."Penalty Interest Arrears" := EmployeeLoanAccounts."Penalty Interest Arrears";
            EmployeeAccountInvoice."Loan Fee Arrears" := EmployeeLoanAccounts."Loan Fee Arrears";
            EmployeeAccountInvoice."Principal Amount" := RepaymentSchedule."Principal Repayment";
            EmployeeAccountInvoice."Total Amount" := RepaymentSchedule."Principal Repayment" +
                                            EmployeeLoanAccounts."Principal Arrears" + EmployeeLoanAccounts."Interest Arrears" +
                                            EmployeeLoanAccounts."Penalty Interest Arrears" + EmployeeLoanAccounts."Loan Fee Arrears";

            EmployeeAccountInvoice."Global Dimension 1 Code" := EmployeeLoanAccounts."Global Dimension 1 Code";
            EmployeeAccountInvoice."Global Dimension 2 Code" := EmployeeLoanAccounts."Global Dimension 2 Code";
            EmployeeAccountInvoice."Shortcut Dimension 3 Code" := EmployeeLoanAccounts."Shortcut Dimension 3 Code";
            EmployeeAccountInvoice."Shortcut Dimension 4 Code" := EmployeeLoanAccounts."Shortcut Dimension 4 Code";
            EmployeeAccountInvoice."Shortcut Dimension 5 Code" := EmployeeLoanAccounts."Shortcut Dimension 5 Code";
            EmployeeAccountInvoice."Shortcut Dimension 6 Code" := EmployeeLoanAccounts."Shortcut Dimension 6 Code";
            EmployeeAccountInvoice."Shortcut Dimension 7 Code" := EmployeeLoanAccounts."Shortcut Dimension 7 Code";
            EmployeeAccountInvoice."Shortcut Dimension 8 Code" := EmployeeLoanAccounts."Shortcut Dimension 8 Code";
            EmployeeAccountInvoice.Description := 'Account Invoice for Account No.' + EmployeeLoanAccounts."No.";
            EmployeeAccountInvoice."Created By" := UserId;
            EmployeeAccountInvoice."Date Created" := Today;
            EmployeeAccountInvoice."Time Created" := Time;
            EmployeeAccountInvoice."User ID" := UserId;
            if EmployeeAccountInvoice."Total Amount" <> 0 then
                EmployeeAccountInvoice.Insert;
            Message('Account Invoice created successfully.');
        end;
    end;

    procedure PostEmployeeAccountInvoice("InvoiceNo.": Code[20])
    var
        EmployeeAccountInvoice: Record "Employee Account Invoice2";
        "LineNo.": Integer;
        RepaymentPeriod: DateFormula;
    begin
        HumanResourcesSetup.Reset;
        HumanResourcesSetup.Get;
        HumanResourcesSetup.TestField(HumanResourcesSetup."Principal Journal Template");
        HumanResourcesSetup.TestField(HumanResourcesSetup."Principal Journal Batch");

        EmployeeAccountInvoice.Reset;
        EmployeeAccountInvoice.Get("InvoiceNo.");

        EmployeeLoanAccounts.Reset;
        EmployeeLoanAccounts.Get(EmployeeAccountInvoice."Loan Account No.");

        LoanProduct.Reset;
        LoanProduct.Get(EmployeeLoanAccounts."Loan Product Code");

        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", HumanResourcesSetup."Principal Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", HumanResourcesSetup."Principal Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        Commit;

        "LineNo." := 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := HumanResourcesSetup."Principal Journal Template";
        GenJnlLine.Validate("Journal Template Name");
        GenJnlLine."Journal Batch Name" := HumanResourcesSetup."Principal Journal Batch";
        GenJnlLine.Validate("Journal Batch Name");
        GenJnlLine."Line No." := "LineNo.";
        GenJnlLine."Source Code" := '';
        GenJnlLine."Posting Date" := EmployeeAccountInvoice."Posting Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := EmployeeAccountInvoice."No.";
        GenJnlLine."External Document No." := '';
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := EmployeeLoanAccounts."Employee No.";
        GenJnlLine.Validate("Account No.");
        GenJnlLine."Currency Code" := EmployeeAccountInvoice."Currency Code";
        GenJnlLine.Amount := -EmployeeAccountInvoice."Principal Amount";  //Debit Amount
        GenJnlLine.Validate(Amount);
        //Due Date
        if LoanProduct."Repayment Frequency" = LoanProduct."Repayment Frequency"::Monthly then begin
            GenJnlLine."Due Date" := CalcDate('CM', EmployeeAccountInvoice."Posting Date");
        end;
        if LoanProduct."Repayment Frequency" = LoanProduct."Repayment Frequency"::Quarterly then begin
            GenJnlLine."Due Date" := CalcDate('CQ', EmployeeAccountInvoice."Posting Date");
        end;
        //End Due Date
        GenJnlLine."Posting Group" := LoanProduct."Disbursement Payment Code";
        GenJnlLine.Validate("Posting Group");
        //GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
        //GenJnlLine."Bal. Account No.":=LoanProduct."Disbursement Account No.";
        //GenJnlLine.VALIDATE("Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := EmployeeLoanAccounts."Global Dimension 1 Code";
        GenJnlLine.Validate("Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := EmployeeLoanAccounts."Global Dimension 2 Code";
        GenJnlLine.Validate("Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, EmployeeLoanAccounts."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, EmployeeLoanAccounts."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, EmployeeLoanAccounts."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, EmployeeLoanAccounts."Shortcut Dimension 6 Code");
        GenJnlLine.ValidateShortcutDimCode(7, EmployeeLoanAccounts."Shortcut Dimension 7 Code");
        GenJnlLine.ValidateShortcutDimCode(8, EmployeeLoanAccounts."Shortcut Dimension 8 Code");
        GenJnlLine.Description := 'Principal Receivable for account no.' + EmployeeLoanAccounts."No.";
        GenJnlLine.Description2 := 'Principal Receivable for account no.' + EmployeeLoanAccounts."No.";
        GenJnlLine.Validate(Description);
        GenJnlLine."Customer No." := EmployeeLoanAccounts."Employee No.";
        GenJnlLine."Investment Account No." := EmployeeLoanAccounts."No.";
        GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Loan Disbursement";
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;

        //enter balancing account
        "LineNo." := "LineNo." + 1;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := HumanResourcesSetup."Principal Journal Template";
        GenJnlLine.Validate("Journal Template Name");
        GenJnlLine."Journal Batch Name" := HumanResourcesSetup."Principal Journal Batch";
        GenJnlLine.Validate("Journal Batch Name");
        GenJnlLine."Line No." := "LineNo.";
        GenJnlLine."Source Code" := '';
        GenJnlLine."Posting Date" := EmployeeAccountInvoice."Posting Date";
        //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Invoice;
        GenJnlLine."Document No." := EmployeeAccountInvoice."No.";
        GenJnlLine."External Document No." := '';
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := EmployeeLoanAccounts."Employee No.";
        GenJnlLine.Validate("Account No.");
        GenJnlLine."Currency Code" := EmployeeAccountInvoice."Currency Code";
        GenJnlLine.Amount := EmployeeAccountInvoice."Principal Amount";  //Debit Amount
        GenJnlLine.Validate(Amount);
        //Due Date
        if LoanProduct."Repayment Frequency" = LoanProduct."Repayment Frequency"::Monthly then begin
            GenJnlLine."Due Date" := CalcDate('CM', EmployeeAccountInvoice."Posting Date");
        end;
        if LoanProduct."Repayment Frequency" = LoanProduct."Repayment Frequency"::Quarterly then begin
            GenJnlLine."Due Date" := CalcDate('CQ', EmployeeAccountInvoice."Posting Date");
        end;
        //End Due Date
        GenJnlLine."Posting Group" := LoanProduct."Principal Receivable PG";
        GenJnlLine.Validate("Posting Group");
        //GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
        //GenJnlLine."Bal. Account No.":=LoanProduct."Disbursement Account No.";
        //GenJnlLine.VALIDATE("Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := EmployeeLoanAccounts."Global Dimension 1 Code";
        GenJnlLine.Validate("Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := EmployeeLoanAccounts."Global Dimension 2 Code";
        GenJnlLine.Validate("Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, EmployeeLoanAccounts."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, EmployeeLoanAccounts."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, EmployeeLoanAccounts."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, EmployeeLoanAccounts."Shortcut Dimension 6 Code");
        GenJnlLine.ValidateShortcutDimCode(7, EmployeeLoanAccounts."Shortcut Dimension 7 Code");
        GenJnlLine.ValidateShortcutDimCode(8, EmployeeLoanAccounts."Shortcut Dimension 8 Code");
        GenJnlLine.Description := 'Principal Receivable for account no.' + EmployeeLoanAccounts."No.";
        GenJnlLine.Description2 := 'Principal Receivable for account no.' + EmployeeLoanAccounts."No.";
        GenJnlLine.Validate(Description);
        GenJnlLine."Customer No." := EmployeeLoanAccounts."Employee No.";
        GenJnlLine."Investment Account No." := EmployeeLoanAccounts."No.";
        GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Principal Receivable";
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
        Commit;
        //Post the Journal Lines
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", HumanResourcesSetup."Principal Journal Template");
        GenJnlLine.SetRange("Journal Batch Name", HumanResourcesSetup."Principal Journal Batch");
        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnlLine);
        Commit;

        CustLedgerEntry.Reset;
        CustLedgerEntry.SetRange(CustLedgerEntry."Document No.", EmployeeAccountInvoice."No.");
        if CustLedgerEntry.FindFirst then begin
            EmployeeAccountInvoice.Status := EmployeeAccountInvoice.Status::Posted;
            EmployeeAccountInvoice.Posted := true;
            EmployeeAccountInvoice."Posted By" := UserId;
            EmployeeAccountInvoice."Date Posted" := Today;
            EmployeeAccountInvoice."Time Posted" := Time;
            EmployeeAccountInvoice.Modify;
        end;
    end;
}

