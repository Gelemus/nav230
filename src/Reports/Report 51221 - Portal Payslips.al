report 51221 "Portal Payslips"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Portal Payslips.rdl';

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Start Date") ORDER(Ascending) WHERE(Status = FILTER(Open | Posted));
            RequestFilterFields = "Period ID";
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(Periods_Period_ID; "Period ID")
            {
            }
            column(Periods_Period_Month; "Period Month")
            {
            }
            column(Periods_Period_Year; "Period Year")
            {
            }
            column(Periods_Payroll_Code; "Payroll Code")
            {
            }
            column(Status_Periods; Periods.Status)
            {
            }
            dataitem(Employee; Employee)
            {
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "No.";
                column(Branch_Code_from_multiple_dim__; 'Branch Code from multiple dim?')
                {
                }
                column(Employee__Job_Title_; Employee."Job Title")
                {
                }
                column(National_ID; Employee."National ID")
                {
                }
                column(Employee__No__; "No.")
                {
                }
                column(MonthText; MonthText)
                {
                }
                column(EmploNameText; EmploNameText)
                {
                }
                column(CompanyNameText; CompanyNameText)
                {
                }
                column(Employee_Employee__Global_Dimension_1_Code_; Employee."Global Dimension 1 Code")
                {
                }
                column(gvPinNo; gvPinNo)
                {
                }
                column(gvNhifNo; gvNhifNo)
                {
                }
                column(gvNssfNo; gvNssfNo)
                {
                }
                column(EmpBank; EmpBank)
                {
                }
                column(AccountNo; AccountNo)
                {
                }
                column(ServiceYears; Employee."Active Service Years")
                {
                }
                column(Salary_Scale; Employee."Salary Scale")
                {
                }
                column(YearsOfService; YearsOfService)
                {
                }
                column(Age; Age)
                {
                }
                column(EmpBank1; EmpBank)
                {
                }
                column(EmpBankBranch; EmpBankBranch)
                {
                }
                column(Date_of_Retirement; Employee."Date of Retirement")
                {
                }
                column(gvPayrollCode; gvPayrollCode)
                {
                }
                column(Employee_Employee__Global_Dimension_2_Code_; Employee."Global Dimension 2 Code")
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
                column(Rate__RepaymentCaption; Rate__RepaymentCaptionLbl)
                {
                }
                column(Quantity__InterestCaption; Quantity__InterestCaptionLbl)
                {
                }
                column(Branch_Caption; Branch_CaptionLbl)
                {
                }
                column(Employee__Job_Title_Caption; Employee__Job_Title_CaptionLbl)
                {
                }
                column(Employee__No__Caption; Employee__No__CaptionLbl)
                {
                }
                column(Payslip_for_Caption; Payslip_for_CaptionLbl)
                {
                }
                column(EmploNameTextCaption; EmploNameTextCaptionLbl)
                {
                }
                column(Employee_Employee__Global_Dimension_1_Code_Caption; FieldCaption("Global Dimension 1 Code"))
                {
                }
                column(Cumulative_Contribution___Total_Principal__To_DateCaption; Cumulative_Contribution___Total_Principal__To_DateCaptionLbl)
                {
                }
                column(Outstanding_Principal_to_DateCaption; Outstanding_Principal_to_DateCaptionLbl)
                {
                }
                column(gvPinNoCaption; gvPinNoCaptionLbl)
                {
                }
                column(gvNhifNoCaption; gvNhifNoCaptionLbl)
                {
                }
                column(gvNssfNoCaption; gvNssfNoCaptionLbl)
                {
                }
                column(Bank_Caption; Bank_CaptionLbl)
                {
                }
                column(Account_No_Caption; Account_No_CaptionLbl)
                {
                }
                column(Branch_Caption_Control1000000002; Branch_Caption_Control1000000002Lbl)
                {
                }
                column(Payroll_CodeCaption; Payroll_CodeCaptionLbl)
                {
                }
                column(Dept_CodeCaption; Dept_CodeCaptionLbl)
                {
                }
                dataitem("Payslip Group"; "Payslip Group")
                {
                    DataItemTableView = SORTING(Code);
                    column(Payslip_Group__Heading_Text_; "Heading Text")
                    {
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(TotalAmountDec; TotalAmountDec)
                    {
                    }
                    column(Payslip_Group_Code; Code)
                    {
                    }
                    column(PaySlipGroupIncludeTotal; "Payslip Group"."Include Total For Group")
                    {
                    }
                    dataitem("Payslip Lines"; "Payslip Lines")
                    {
                        DataItemLink = "Payslip Group" = FIELD(Code);
                        DataItemTableView = SORTING("Line No.", "Payslip Group");
                        column(IsPayslipLineP9; IsPayslipLineP9)
                        {
                        }
                        column(Payslip_Lines__P9_Text_; "P9 Text")
                        {
                        }
                        column(Payslip_Lines_Amount; Amount)
                        {
                        }
                        column(Payslip_Lines_Line_No_; "Line No.")
                        {
                        }
                        column(Payslip_Lines_Payslip_Group; "Payslip Group")
                        {
                        }
                        column(Payslip_Lines_Payroll_Code; "Payroll Code")
                        {
                        }
                        column(Payslip_Lines_E_D_Code; "E/D Code")
                        {
                        }
                        dataitem("Payroll Lines"; "Payroll Lines")
                        {
                            DataItemLink = "ED Code" = FIELD("E/D Code");
                            DataItemTableView = SORTING("Entry No.");
                            column(PayrollLineLoanEntry; "Payroll Lines"."Loan Entry")
                            {
                            }
                            column(Payroll_Lines_Text; Text)
                            {
                            }
                            column(Payroll_Lines__Amount__LCY__; "Amount (LCY)")
                            {
                            }
                            column(Payroll_Lines__Rate__LCY__; "Rate (LCY)")
                            {
                            }
                            column(Payroll_Lines_Quantity; Quantity)
                            {
                            }
                            column(CumilativeDec; Abs(CumilativeDec))
                            {
                            }
                            column(Payroll_Lines_Text_Control13; Text)
                            {
                            }
                            column(Payroll_Lines__Amount__LCY___Control14; "Amount (LCY)")
                            {
                            }
                            column(Payroll_Lines__Interest__LCY__; "Interest (LCY)")
                            {
                            }
                            column(Payroll_Lines__Repayment__LCY__; "Repayment (LCY)")
                            {
                            }
                            column(Payroll_Lines__Remaining_Debt__LCY__; "Remaining Debt (LCY)")
                            {
                            }
                            column(Payroll_Lines__Paid__LCY__; "Paid (LCY)")
                            {
                            }
                            column(Payroll_Lines_Entry_No_; "Entry No.")
                            {
                            }
                            column(Payroll_Lines_ED_Code; "ED Code")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                EDDefRec.Get("Payroll Lines"."ED Code");

                                if EDDefRec.Cumulative then begin
                                    EmployeeRec.Get(Employee."No.");
                                    EmployeeRec.SetRange("ED Code Filter", EDDefRec."ED Code");
                                    EndDate := Periods."End Date";
                                    EmployeeRec.SetFilter("Date Filter", Format(DMY2Date(1, 1, 1900)) + '..' + Format(EndDate));

                                    EmployeeRec.CalcFields("Amount To Date (LCY)", "Non Payroll Receipts");
                                    CumilativeDec := EmployeeRec."Amount To Date (LCY)" + EmployeeRec."Non Payroll Receipts";

                                end else
                                    CumilativeDec := 0;

                                case EDDefRec."Calculation Group" of
                                    //skm300507EDDefRec."Calculation Group"::None:
                                    //  "Payroll Lines"."Amount (LCY)" := 0;
                                    EDDefRec."Calculation Group"::Deduction:
                                        begin
                                            if "Payslip Lines".Negative then
                                                "Payroll Lines"."Amount (LCY)" := -"Payroll Lines"."Amount (LCY)"
                                            else
                                                "Payroll Lines"."Amount (LCY)" := "Payroll Lines"."Amount (LCY)";
                                        end;
                                    EDDefRec."Calculation Group"::None:
                                        begin
                                            if "Payslip Lines".Negative then
                                                "Payroll Lines"."Amount (LCY)" := -"Payroll Lines"."Amount (LCY)"
                                            else
                                                "Payroll Lines"."Amount (LCY)" := "Payroll Lines"."Amount (LCY)";
                                        end;
                                end;

                                TotalAmountDec := TotalAmountDec + "Payroll Lines"."Amount (LCY)";
                            end;

                            trigger OnPreDataItem()
                            begin
                                SetRange("Employee No.", Employee."No.");
                                SetRange("Payroll ID", Periods."Period ID");
                                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if "Payslip Lines"."Line Type" = 1 then begin
                                case "Payslip Lines".P9 of
                                    "Payslip Lines".P9::A:
                                        "Payslip Lines".Amount := HeaderRec."A (LCY)";
                                    "Payslip Lines".P9::B:
                                        "Payslip Lines".Amount := HeaderRec."B (LCY)";
                                    "Payslip Lines".P9::C:
                                        "Payslip Lines".Amount := HeaderRec."C (LCY)";
                                    "Payslip Lines".P9::D:
                                        "Payslip Lines".Amount := HeaderRec."D (LCY)";
                                    "Payslip Lines".P9::E1:
                                        "Payslip Lines".Amount := HeaderRec."E1 (LCY)";
                                    "Payslip Lines".P9::E2:
                                        "Payslip Lines".Amount := HeaderRec."E2 (LCY)";
                                    "Payslip Lines".P9::E3:
                                        "Payslip Lines".Amount := HeaderRec."E3 (LCY)";
                                    "Payslip Lines".P9::F:
                                        "Payslip Lines".Amount := HeaderRec."F (LCY)";
                                    "Payslip Lines".P9::G:
                                        "Payslip Lines".Amount := HeaderRec."G (LCY)";
                                    "Payslip Lines".P9::H:
                                        "Payslip Lines".Amount := HeaderRec."H (LCY)";
                                    "Payslip Lines".P9::J:
                                        "Payslip Lines".Amount := HeaderRec."J (LCY)";
                                    "Payslip Lines".P9::K:
                                        "Payslip Lines".Amount := HeaderRec."K (LCY)";
                                    "Payslip Lines".P9::L:
                                        "Payslip Lines".Amount := HeaderRec."L (LCY)";
                                    "Payslip Lines".P9::M:
                                        "Payslip Lines".Amount := HeaderRec."M (LCY)";
                                end;
                            end;

                            if "Payslip Lines"."Line Type" = "Payslip Lines"."Line Type"::P9 then
                                IsPayslipLineP9 := true
                            else
                                IsPayslipLineP9 := false;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //PayrollSetupRec.GET;

                        //TotalText := PayrollSetupRec."Employer HELB No."+' ' + "Payslip Group"."Heading Text";
                        TotalAmountDec := 0;
                        if (Employee."Calculation Scheme" = 'INTERN') and ("Payslip Group"."Heading Text 2" <> '') then
                            "Payslip Group"."Heading Text" := "Payslip Group"."Heading Text 2";
                        TotalText := 'TOTAL ' + "Payslip Group"."Heading Text";
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    end;
                }
                dataitem("Integer"; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;
                    column(NetPayText; NetPayText)
                    {
                    }
                    column(NetPaydec; NetPaydec)
                    {
                    }
                    column(Integer_Number; Number)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    EmpBank := '';

                    if HeaderRec.Get(Periods."Period ID", Employee."No.") then begin
                        HeaderRec.CalcFields("Total Payable (LCY)", "Total Deduction (LCY)", "Total Rounding Pmts (LCY)", "Total Rounding Ded (LCY)");
                        NetPaydec := HeaderRec."Total Payable (LCY)" + HeaderRec."Total Rounding Pmts (LCY)" - (HeaderRec."Total Deduction (LCY)" +
                                     HeaderRec."Total Rounding Ded (LCY)");
                    end else
                        CurrReport.Skip;
                    Employee.Validate("Birth Date");
                    EmploNameText := Employee.FullName;

                    Employee.TestField("Mode of Payment");
                    gvModeofPayment.Get("Mode of Payment");
                    if gvModeofPayment.Description <> '' then
                        NetPayText := 'Net Pay - ' + gvModeofPayment.Description
                    else
                        NetPayText := 'Net Pay - By ' + gvModeofPayment.Code;

                    if Employee."Bank Code" <> '' then
                        if EmplankAccount.Get(Employee."Bank Code") then begin
                            EmpBank := EmplankAccount.Name;
                            AccountNo := Employee."Bank Account No";
                            EmpBankBranch := EmplankAccount.Branch;
                        end;

                    //check Age in years of payslip period
                    if Today > Employee."Birth Date" then
                        if (Employee."Birth Date" <> 0D) then
                            Age := Dates.DetermineAge(Employee."Birth Date", Today);
                    if Periods."Start Date" <> 0D then
                        Age := Dates.DetermineAge(Employee."Birth Date", Periods."Start Date");

                    //check years of service of payslip period
                    if Today > Employee."Birth Date" then
                        if (Employee."Birth Date" <> 0D) then
                            YearsOfService := Dates.DetermineAgeService3(Employee."Birth Date", Today);
                    if Periods."Start Date" <> 0D then
                        YearsOfService := Dates.DetermineAgeService3(Employee."Birth Date", Periods."Start Date");
                    if Employee."Physically Challenged" = Employee."Physically Challenged"::Yes then
                        YearsOfService := Dates.pwdDetermineAgeService2(Employee."Birth Date", Periods."Start Date");
                    SetFilter("ED Code Filter", PayrollSetupRec."NSSF ED Code");
                    CalcFields("Membership No.");
                    gvNssfNo := "NSSF No.";
                    SetFilter("ED Code Filter", PayrollSetupRec."PAYE ED Code");
                    CalcFields("Membership No.");
                    gvPinNo := PIN;
                    SetFilter("ED Code Filter", PayrollSetupRec."NHIF ED Code");
                    CalcFields("Membership No.");
                    gvNhifNo := "NHIF No.";

                    //AMI 140907 OC023 show Payroll code in the Payslip
                    if Employee."Calculation Scheme" <> '' then begin
                        CalculationHeader.Get(Employee."Calculation Scheme");
                        gvPayrollCode := CalculationHeader."Payroll Code";
                    end;
                    Employee.Modify;
                end;

                trigger OnPostDataItem()
                begin
                    //AMI 140907 OC023 show Payroll code in the Payslip
                    gvPayrollCode := '';
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

                    //skm070307 payslip e-mailing
                    if gvEmployeeNoFilter <> '' then SetRange("No.", gvEmployeeNoFilter);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                MonthText := Periods.Description;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

                //skm070307 payslip e-mailing
                if gvPeriodIDFilter <> '' then SetRange("Period ID", gvPeriodIDFilter);
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
    begin
        gsSegmentPayrollData;
        PayrollSetupRec.Get(gvAllowedPayrolls."Payroll Code");
        CompanyNameText := PayrollSetupRec."Employer Name";
        PeriodRec.SetCurrentKey("Start Date");
        PeriodRec.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
        PeriodRec.Find('-');
        if gvPeriodIDFilter = '' then
            gvPeriodIDFilter := Employee.GetFilter("Period Filter");//ICS APR2018
        if gvEmployeeNoFilter = '' then
            gvEmployeeNoFilter := Employee.GetFilter("No.");//ICS APR2018
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        PeriodRec: Record Periods;
        EmployeeRec: Record Employee;
        PayrollSetupRec: Record "Payroll Setups";
        HeaderRec: Record "Payroll Header";
        EDDefRec: Record "ED Definitions";
        TotalText: Text[60];
        NetPayText: Text[60];
        MonthText: Text[60];
        EmploNameText: Text[100];
        CompanyNameText: Text[100];
        TotalAmountDec: Decimal;
        NetPaydec: Decimal;
        CumilativeDec: Decimal;
        EmplankAccount: Record "Employee Bank Account";
        EmpBank: Text[30];
        AccountNo: Text[30];
        EmpBankBranch: Text[30];
        gvNhifNo: Code[20];
        gvNssfNo: Code[20];
        gvPinNo: Code[20];
        EndDate: Date;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        gvModeofPayment: Record "Mode of Payment";
        gvPeriodIDFilter: Code[100];
        gvEmployeeNoFilter: Code[100];
        CalculationHeader: Record "Calculation Header";
        gvPayrollCode: Text[30];
        AmountCaptionLbl: Label 'Amount';
        Rate__RepaymentCaptionLbl: Label 'Rate/\Repayment';
        Quantity__InterestCaptionLbl: Label 'Quantity/\Interest';
        Branch_CaptionLbl: Label 'Branch:';
        Employee__Job_Title_CaptionLbl: Label 'Job Title :';
        Employee__No__CaptionLbl: Label 'Personnel No. :';
        Payslip_for_CaptionLbl: Label 'Payslip for:';
        EmploNameTextCaptionLbl: Label 'Employee Name :';
        Cumulative_Contribution___Total_Principal__To_DateCaptionLbl: Label 'Cumulative\Contribution /\Total Principal\ To Date';
        Outstanding_Principal_to_DateCaptionLbl: Label 'Outstanding\Principal to\Date';
        gvPinNoCaptionLbl: Label 'PIN Code';
        gvNhifNoCaptionLbl: Label 'NHIF No';
        gvNssfNoCaptionLbl: Label 'NSSF No';
        Bank_CaptionLbl: Label 'Bank:';
        Account_No_CaptionLbl: Label 'Account No.';
        Branch_Caption_Control1000000002Lbl: Label 'Branch:';
        Payroll_CodeCaptionLbl: Label 'Payroll Code';
        Dept_CodeCaptionLbl: Label 'Dept Code';
        IsPayslipLineP9: Boolean;
        payrollSetup: Record "Payroll Setups";
        YearsOfService: Text;
        Dates: Codeunit Dates;
        Age: Text;
        payrollCode: Code[20];

    procedure sSetParameters(pPeriodIDFilter: Code[10]; pEmployeeNoFilter: Code[10])
    begin
        //skm080307 this function sets global parameters for filtering the payslip when e-mailing
        gvPeriodIDFilter := pPeriodIDFilter;
        gvEmployeeNoFilter := pEmployeeNoFilter;
    end;

    procedure gsSegmentPayrollData()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        UsrID: Code[10];
        UsrID2: Code[10];
        StringLen: Integer;
        lvActiveSession: Record "Active Session";
    begin

        //ERROR(FORMAT(USERID));

        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID", ServiceInstanceId);
        //lvActiveSession.SETRANGE("Session ID",SESSIONID);
        lvActiveSession.SetRange("User ID", UserId);
        lvActiveSession.FindFirst;

        if gvEmployeeNoFilter <> '' then begin
            EmployeeRec.Reset;
            EmployeeRec.SetRange("No.", gvEmployeeNoFilter);
            if EmployeeRec.FindFirst then begin
                payrollCode := EmployeeRec."Payroll Code";
            end;
        end;

        gvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        //gvAllowedPayrolls.SETRANGE("Last Active Payroll", TRUE);
        gvAllowedPayrolls.SetRange("Payroll Code", payrollCode);
        if not gvAllowedPayrolls.FindFirst then
            Error('You are not allowed access to this payroll dataset.');
    end;
}

