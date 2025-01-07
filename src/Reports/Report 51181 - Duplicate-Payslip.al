report 51181 "Duplicate-Payslip"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Duplicate-Payslip.rdl';

    dataset
    {
        dataitem("Duplicate-Payslip"; "Duplicate-Payslip")
        {
            DataItemTableView = SORTING("Payslip Set", "Line No") ORDER(Ascending);
            RequestFilterFields = Period;
            column(EmployerName; EmployerName)
            {
            }
            column(Duplicate_Payslip_Employee1; Employee1)
            {
            }
            column(EmpFullNameArray_1_; EmpFullNameArray[1])
            {
            }
            column(Payslip_for____Period_Name1_; 'Payslip for ' + "Period Name1")
            {
            }
            column(Duplicate_Payslip_Employee2; Employee2)
            {
            }
            column(EmpFullNameArray_2_; EmpFullNameArray[2])
            {
            }
            column(gvPayrollCode; gvPayrollCode)
            {
            }
            column(gvPayrollCode2; gvPayrollCode2)
            {
            }
            column(Dept1; Dept1)
            {
            }
            column(Dept2; Dept2)
            {
            }
            column(Payslip_for____Period_Name1__Control1102754001; 'Payslip for ' + "Period Name1")
            {
            }
            column(EmployerName_Control1102754002; EmployerName)
            {
            }
            column(gvbirthdate_1_; gvbirthdate[1])
            {
            }
            column(gvAgeText_1_; gvAgeText[1])
            {
            }
            column(gvbirthdate_2_; gvbirthdate[2])
            {
            }
            column(gvAgeText_2_; gvAgeText[2])
            {
            }
            column(gvNSSF_1_; gvNSSF[1])
            {
            }
            column(gvNHIF_1_; gvNHIF[1])
            {
            }
            column(GVPin; gvpin[1])
            {
            }
            column(GDID; gvID[1])
            {
            }
            column(GVPin2; gvpin[2])
            {
            }
            column(GDID2; gvID[2])
            {
            }
            column(gvNHIF_2_; gvNHIF[2])
            {
            }
            column(gvNSSF_2_; gvNSSF[2])
            {
            }
            column(gvSalaryScale_1_; gvSalaryScale[1])
            {
            }
            column(gvSalaryScale_2_; gvSalaryScale[2])
            {
            }
            column(Duplicate_Payslip_Description1; Description1)
            {
            }
            column(Duplicate_Payslip_Amount1; Amount1)
            {
            }
            column(Duplicate_Payslip_Amount2; Amount2)
            {
            }
            column(Duplicate_Payslip_Description2; Description2)
            {
            }
            column(Duplicate_Payslip_Cumm1; Cumm1)
            {
            }
            column(Duplicate_Payslip_Cumm2; Cumm2)
            {
            }
            column(Duplicate_Payslip_Bank1; Bank1)
            {
            }
            column(Duplicate_Payslip_Branch1; Branch1)
            {
            }
            column(Duplicate_Payslip_Account1; Account1)
            {
            }
            column(Duplicate_Payslip_Account2; Account2)
            {
            }
            column(Duplicate_Payslip_Branch2; Branch2)
            {
            }
            column(Duplicate_Payslip_Bank2; Bank2)
            {
            }
            column(gvModeOfPayment_1_; gvModeOfPayment[1])
            {
            }
            column(gvModeOfPayment_2_; gvModeOfPayment[2])
            {
            }
            column(Duplicate_Payslip_Employee1Caption; Duplicate_Payslip_Employee1CaptionLbl)
            {
            }
            column(AMOUNTCaption; AMOUNTCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(BalanceCaption_Control1000000023; BalanceCaption_Control1000000023Lbl)
            {
            }
            column(AMOUNTCaption_Control1000000024; AMOUNTCaption_Control1000000024Lbl)
            {
            }
            column(Payroll_CodeCaption; Payroll_CodeCaptionLbl)
            {
            }
            column(NSSFCaption; NSSFCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102754025; EmptyStringCaption_Control1102754025Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754027; EmptyStringCaption_Control1102754027Lbl)
            {
            }
            column(AgeCaption; AgeCaptionLbl)
            {
            }
            column(Dept_CodeCaption; Dept_CodeCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102754042; EmptyStringCaption_Control1102754042Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754043; EmptyStringCaption_Control1102754043Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754044; EmptyStringCaption_Control1102754044Lbl)
            {
            }
            column(NHIFCaption; NHIFCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102754046; EmptyStringCaption_Control1102754046Lbl)
            {
            }
            column(NHIFCaption_Control1102754047; NHIFCaption_Control1102754047Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754048; EmptyStringCaption_Control1102754048Lbl)
            {
            }
            column(NSSFCaption_Control1102754049; NSSFCaption_Control1102754049Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754050; EmptyStringCaption_Control1102754050Lbl)
            {
            }
            column(Payroll_CodeCaption_Control1102754051; Payroll_CodeCaption_Control1102754051Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754052; EmptyStringCaption_Control1102754052Lbl)
            {
            }
            column(Dept_CodeCaption_Control1102754053; Dept_CodeCaption_Control1102754053Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754054; EmptyStringCaption_Control1102754054Lbl)
            {
            }
            column(AgeCaption_Control1102754055; AgeCaption_Control1102754055Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754056; EmptyStringCaption_Control1102754056Lbl)
            {
            }
            column(NameCaption_Control1102754057; NameCaption_Control1102754057Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754058; EmptyStringCaption_Control1102754058Lbl)
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102754060; EmptyStringCaption_Control1102754060Lbl)
            {
            }
            column(Job_Title_Job_GroupCaption; Job_Title_Job_GroupCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102754063; EmptyStringCaption_Control1102754063Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754067; EmptyStringCaption_Control1102754067Lbl)
            {
            }
            column(Job_Title_Job_GroupCaption_Control1102754065; Job_Title_Job_GroupCaption_Control1102754065Lbl)
            {
            }
            column(Mode_Of_PaymentCaption; Mode_Of_PaymentCaptionLbl)
            {
            }
            column(BranchCaption; BranchCaptionLbl)
            {
            }
            column(BankCaption; BankCaptionLbl)
            {
            }
            column(Bank_A_C__Caption; Bank_A_C__CaptionLbl)
            {
            }
            column(Bank_A_C__Caption_Control1102754009; Bank_A_C__Caption_Control1102754009Lbl)
            {
            }
            column(BranchCaption_Control1102754019; BranchCaption_Control1102754019Lbl)
            {
            }
            column(BankCaption_Control1102754020; BankCaption_Control1102754020Lbl)
            {
            }
            column(Mode_Of_PaymentCaption_Control1102754023; Mode_Of_PaymentCaption_Control1102754023Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754032; EmptyStringCaption_Control1102754032Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754033; EmptyStringCaption_Control1102754033Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754034; EmptyStringCaption_Control1102754034Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754035; EmptyStringCaption_Control1102754035Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754036; EmptyStringCaption_Control1102754036Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754037; EmptyStringCaption_Control1102754037Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754038; EmptyStringCaption_Control1102754038Lbl)
            {
            }
            column(EmptyStringCaption_Control1102754039; EmptyStringCaption_Control1102754039Lbl)
            {
            }
            column(Duplicate_Payslip_Payslip_Set; "Payslip Set")
            {
            }
            column(Duplicate_Payslip_Line_No; "Line No")
            {
            }
            column(CompInfoPic; CompInfo.Picture)
            {
            }

            trigger OnAfterGetRecord()
            var
                LoopCounter: Integer;
                lvPayrollSetup: Record "Payroll Setups";
            begin
                CompInfo.Get;
                CompInfo.CalcFields(Picture);
                lvPayrollSetup.FindLast;
                EmployerName := lvPayrollSetup."Employer Name";

                for LoopCounter := 1 to 5 do begin
                    EmployeeRec[LoopCounter].Init;
                    EmployeeRec[LoopCounter]."No." := '';
                end;

                if "Duplicate-Payslip".Employee1 <> '' then begin
                    EmployeeRec[1].Get("Duplicate-Payslip".Employee1);
                    EmpFullNameArray[1] := EmployeeRec[1].FullName();
                    //
                    gvbirthdate[1] := EmployeeRec[1]."Birth Date";
                    gvNSSF[1] := EmployeeRec[1]."NSSF No.";
                    gvNHIF[1] := EmployeeRec[1]."NHIF No.";
                    gvID[1] := EmployeeRec[1]."National ID";
                    gvpin[1] := EmployeeRec[1].PIN;
                    gvModeOfPayment[1] := EmployeeRec[1]."Mode of Payment";
                    if gvbirthdate[1] <> 0D then
                        gvAgeText[1] := CalculateAge(gvbirthdate[1], "Duplicate-Payslip".Period);
                    if EmployeeRec[1]."Basic Pay" = EmployeeRec[1]."Basic Pay"::Fixed then begin
                        gvSalaryScale[1] := EmployeeRec[1]."Job Title" + ' ' + EmployeeRec[1]."Salary Scale";
                    end else begin
                        gvSalaryScale[1] := EmployeeRec[1]."Job Title";
                    end;
                end;

                if "Duplicate-Payslip".Employee2 <> '' then begin
                    EmployeeRec[2].Get("Duplicate-Payslip".Employee2);
                    EmpFullNameArray[2] := EmployeeRec[2].FullName();
                    //
                    gvbirthdate[2] := EmployeeRec[2]."Birth Date";
                    gvNSSF[2] := EmployeeRec[2]."NSSF No.";
                    gvNHIF[2] := EmployeeRec[2]."NHIF No.";
                    gvID[2] := EmployeeRec[2]."National ID";
                    gvpin[2] := EmployeeRec[2].PIN;
                    gvModeOfPayment[2] := EmployeeRec[2]."Mode of Payment";
                    if gvbirthdate[2] <> 0D then
                        gvAgeText[2] := CalculateAge(gvbirthdate[2], "Duplicate-Payslip".Period);
                    if EmployeeRec[2]."Basic Pay" = EmployeeRec[2]."Basic Pay"::Fixed then begin
                        gvSalaryScale[2] := EmployeeRec[2]."Job Title" + ' ' + EmployeeRec[2]."Salary Scale";
                    end else begin
                        gvSalaryScale[2] := EmployeeRec[2]."Job Title";
                    end;

                end;

                if "Duplicate-Payslip".Employee3 <> '' then begin
                    EmployeeRec[3].Get("Duplicate-Payslip".Employee3);
                    EmpFullNameArray[3] := EmployeeRec[3].FullName();
                    //
                    gvbirthdate[3] := EmployeeRec[3]."Birth Date";
                    gvNSSF[3] := EmployeeRec[3]."NSSF No.";
                    gvNHIF[3] := EmployeeRec[3]."NHIF No.";
                    gvID[3] := EmployeeRec[3]."National ID";
                    gvpin[3] := EmployeeRec[3].PIN;
                    gvModeOfPayment[3] := EmployeeRec[3]."Mode of Payment";
                    if gvbirthdate[3] <> 0D then
                        gvAgeText[3] := CalculateAge(gvbirthdate[3], "Duplicate-Payslip".Period);
                    if EmployeeRec[3]."Basic Pay" = EmployeeRec[3]."Basic Pay"::Fixed then begin
                        gvSalaryScale[3] := EmployeeRec[3]."Job Title" + ' ' + EmployeeRec[3]."Salary Scale";
                    end else begin
                        gvSalaryScale[3] := EmployeeRec[3]."Job Title";
                    end;

                end;

                if "Duplicate-Payslip".Employee4 <> '' then begin
                    EmployeeRec[4].Get("Duplicate-Payslip".Employee4);
                    EmpFullNameArray[4] := EmployeeRec[4].FullName();
                    //
                    gvbirthdate[4] := EmployeeRec[4]."Birth Date";
                    gvNSSF[4] := EmployeeRec[4]."NSSF No.";
                    gvNHIF[4] := EmployeeRec[4]."NHIF No.";
                    gvID[4] := EmployeeRec[4]."National ID";
                    gvpin[4] := EmployeeRec[4].PIN;
                    gvModeOfPayment[4] := EmployeeRec[4]."Mode of Payment";
                    if gvbirthdate[2] <> 0D then
                        gvAgeText[4] := CalculateAge(gvbirthdate[4], "Duplicate-Payslip".Period);
                    if EmployeeRec[4]."Basic Pay" = EmployeeRec[4]."Basic Pay"::Fixed then begin
                        gvSalaryScale[4] := EmployeeRec[4]."Job Title" + ' ' + EmployeeRec[4]."Salary Scale";
                    end else begin
                        gvSalaryScale[4] := EmployeeRec[4]."Job Title";
                    end;

                end;

                //IGS 140907 OC023 show Payroll code in the Duplicate Payslip

                //Payroll  and Dept Code for Employee 1
                if Employee.Get("Duplicate-Payslip".Employee1) then begin
                    Dept1 := Employee."Global Dimension 2 Code";
                    CalculationHeader.Get(Employee."Calculation Scheme");
                    gvPayrollCode := CalculationHeader."Payroll Code";
                end;
                //Payroll and Dept Code for Employee 2
                if Employee.Get("Duplicate-Payslip".Employee2) then begin
                    Dept2 := Employee."Global Dimension 2 Code";
                    CalculationHeader.Get(Employee."Calculation Scheme");
                    gvPayrollCode2 := CalculationHeader."Payroll Code";
                end;

                //END IGS
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        lvPayrollSetup: Record "Payroll Setups";
    begin
        gsSegmentPayrollData;
        lvPayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
        PayslipsetFilter := "Duplicate-Payslip".GetFilters;

        //lvPayrollSetup.GET;
        EmployerName := lvPayrollSetup."Employer Name";
    end;

    var
        EmployeeRec: array[5] of Record Employee;
        EmpFullNameArray: array[5] of Text[60];
        DepartmentNameArray: array[5] of Text[60];
        PayslipsetFilter: Text[100];
        EmployerName: Text[50];
        gvAllowedPayrolls: Record "Allowed Payrolls";
        CalculationHeader: Record "Calculation Header";
        gvPayrollCode: Text[30];
        gvPayrollCode2: Text[30];
        Employee: Record Employee;
        Dept1: Text[30];
        Dept2: Text[30];
        gvAgeText: array[5] of Text[50];
        Periods: Record Periods;
        gvbirthdate: array[5] of Date;
        gvNSSF: array[5] of Code[20];
        gvNHIF: array[5] of Code[20];
        gvBank: array[5] of Text[50];
        gvModeOfPayment: array[5] of Text[50];
        gvBranch: array[5] of Text[50];
        gvBankAccountNo: array[5] of Text[50];
        gvEmpBankAccount: Record "Employee Bank Account";
        Year: array[5] of Integer;
        Month: array[5] of Integer;
        gvSalaryScale: array[5] of Text[100];
        Duplicate_Payslip_Employee1CaptionLbl: Label 'Employee No. :';
        AMOUNTCaptionLbl: Label 'AMOUNT';
        BalanceCaptionLbl: Label 'Balance';
        BalanceCaption_Control1000000023Lbl: Label 'Balance';
        AMOUNTCaption_Control1000000024Lbl: Label 'AMOUNT';
        Payroll_CodeCaptionLbl: Label 'Payroll Code';
        NSSFCaptionLbl: Label 'NSSF';
        NameCaptionLbl: Label 'Name';
        EmptyStringCaptionLbl: Label ':';
        EmptyStringCaption_Control1102754025Lbl: Label ':';
        EmptyStringCaption_Control1102754027Lbl: Label ':';
        AgeCaptionLbl: Label 'Age';
        Dept_CodeCaptionLbl: Label 'Dept Code';
        EmptyStringCaption_Control1102754042Lbl: Label ':';
        EmptyStringCaption_Control1102754043Lbl: Label ':';
        EmptyStringCaption_Control1102754044Lbl: Label ':';
        NHIFCaptionLbl: Label 'NHIF';
        EmptyStringCaption_Control1102754046Lbl: Label ':';
        NHIFCaption_Control1102754047Lbl: Label 'NHIF';
        EmptyStringCaption_Control1102754048Lbl: Label ':';
        NSSFCaption_Control1102754049Lbl: Label 'NSSF';
        EmptyStringCaption_Control1102754050Lbl: Label ':';
        Payroll_CodeCaption_Control1102754051Lbl: Label 'Payroll Code';
        EmptyStringCaption_Control1102754052Lbl: Label ':';
        Dept_CodeCaption_Control1102754053Lbl: Label 'Dept Code';
        EmptyStringCaption_Control1102754054Lbl: Label ':';
        AgeCaption_Control1102754055Lbl: Label 'Age';
        EmptyStringCaption_Control1102754056Lbl: Label ':';
        NameCaption_Control1102754057Lbl: Label 'Name';
        EmptyStringCaption_Control1102754058Lbl: Label ':';
        EmployeeCaptionLbl: Label 'Employee';
        EmptyStringCaption_Control1102754060Lbl: Label ':';
        Job_Title_Job_GroupCaptionLbl: Label 'Job Title-Job Group';
        EmptyStringCaption_Control1102754063Lbl: Label ':';
        EmptyStringCaption_Control1102754067Lbl: Label ':';
        Job_Title_Job_GroupCaption_Control1102754065Lbl: Label 'Job Title-Job Group';
        Mode_Of_PaymentCaptionLbl: Label 'Mode Of Payment';
        BranchCaptionLbl: Label 'Branch';
        BankCaptionLbl: Label 'Bank';
        Bank_A_C__CaptionLbl: Label 'Bank A/C :';
        Bank_A_C__Caption_Control1102754009Lbl: Label 'Bank A/C :';
        BranchCaption_Control1102754019Lbl: Label 'Branch';
        BankCaption_Control1102754020Lbl: Label 'Bank';
        Mode_Of_PaymentCaption_Control1102754023Lbl: Label 'Mode Of Payment';
        EmptyStringCaption_Control1102754032Lbl: Label ':';
        EmptyStringCaption_Control1102754033Lbl: Label ':';
        EmptyStringCaption_Control1102754034Lbl: Label ':';
        EmptyStringCaption_Control1102754035Lbl: Label ':';
        EmptyStringCaption_Control1102754036Lbl: Label ':';
        EmptyStringCaption_Control1102754037Lbl: Label ':';
        EmptyStringCaption_Control1102754038Lbl: Label ':';
        EmptyStringCaption_Control1102754039Lbl: Label ':';
        gvpin: array[5] of Code[20];
        gvID: array[5] of Code[20];
        CompInfo: Record "Company Information";

    procedure CalculateAge(lvDOB: Date; lvPeriod: Code[10]) AgeText: Text[30]
    var
        lvDay: Integer;
        lvMonth: Integer;
        lvYear: Integer;
        CurrPeriod: Code[10];
        CurrMonth: Integer;
        CurrYear: Integer;
        NoOfYears: Integer;
        NoOfMonths: Integer;
        periodFactor: Integer;
        birthFactor: Integer;
        Text000: Label '%1 years %2 months';
        Text001: Label '%1 years';
    begin
        lvDay := Date2DMY(lvDOB, 1);
        lvMonth := Date2DMY(lvDOB, 2);
        lvYear := Date2DMY(lvDOB, 3);

        if StrLen(lvPeriod) > 6 then begin
            Evaluate(CurrMonth, (CopyStr(lvPeriod, 1, 2)));
            Evaluate(CurrYear, (CopyStr(lvPeriod, 4, 4)));
        end else begin
            Evaluate(CurrMonth, (CopyStr(lvPeriod, 1, 1)));
            Evaluate(CurrYear, (CopyStr(lvPeriod, 3, 4)));
        end;
        NoOfYears := CurrYear - lvYear;
        //calc months
        //Period factor
        periodFactor := 12 - CurrMonth;
        //Birthdate factor
        birthFactor := 12 - lvMonth;

        if periodFactor > birthFactor then begin
            NoOfYears := NoOfYears - 1;
            NoOfMonths := 12 - (periodFactor - birthFactor);
            AgeText := '(' + Format(NoOfYears, 0, 0) + ' ' + 'years' + ', ' + Format(NoOfMonths, 0, 0) + ' ' + 'months)';
        end;

        if periodFactor = birthFactor then begin
            AgeText := '(' + Format(NoOfYears, 0, 0) + ' ' + 'years)';
        end;

        if periodFactor < birthFactor then begin
            NoOfMonths := birthFactor - periodFactor;
            AgeText := '(' + Format(NoOfYears, 0, 0) + ' ' + 'years' + ', ' + Format(NoOfMonths, 0, 0) + ' ' + 'months)';
        end;

        exit(AgeText);
        //Whose your daddy!
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

