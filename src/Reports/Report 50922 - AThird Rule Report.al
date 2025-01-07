report 50922 "AThird Rule Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/AThird Rule Report.rdl';

    dataset
    {
        dataitem("Payroll Header"; "Payroll Header")
        {
            RequestFilterFields = "Payroll ID", "Employee no.";
            column(PayrollID; "Payroll Header"."Payroll ID")
            {
            }
            column(EmployeeNo; "Payroll Header"."Employee no.")
            {
            }
            column(BasicPay1; "Payroll Header"."Basic Pay")
            {
            }
            column(TotalDeduction; "Payroll Header"."Total Deduction (LCY)")
            {
            }
            column(GrossAmount; "Payroll Header"."Total Payable (LCY)")
            {
            }
            column(HouseAllowance; "Payroll Header"."House Allowance")
            {
            }
            column(CommutorAllownce; CommutorAllowance)
            {
            }
            column(PermanentEarnings; PermanentEarnings)
            {
            }
            column(AthirdOfEarning; AthirdOfEarning)
            {
            }
            column(AthirdRuleAmount; AthirdRuleAmount)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(Name; Name)
            {
            }
            column(Title; TitleText)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(NhifReliefAmt_; NhifReliefAmt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                OtherFixEarning := 0;


                Periods.SetRange(Periods."Period ID", "Payroll Header"."Payroll ID");
                Periods.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

                if Periods.Find('-') then
                    TitleText := 'A Third Report For ' + Periods.Description;

                Emp.SetRange(Emp."No.", "Payroll Header"."Employee no.");
                if Emp.Find('-') then
                    Name := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";

                PayrollSetup.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                "Payroll Header".CalcFields("Payroll Header"."Total Deduction (LCY)");
                "Payroll Header".CalcFields("Payroll Header"."Middle Name");
                "Payroll Header".CalcFields("Payroll Header"."Basic Pay");
                "Payroll Header".CalcFields("Payroll Header"."Total Deduction (LCY)");
                TotalDeductions := "Payroll Header"."Total Deduction (LCY)";
                PermanentEarnings := "Payroll Header"."Total Payable (LCY)";
                BasicPay := Round(("Payroll Header"."Basic Pay"), 1, '>');
                AthirdOfEarning := Round((BasicPay * 1 / 3), 1, '>');
                NetPay := Round((PermanentEarnings - TotalDeductions), 1, '>');
                AthirdRuleAmount := NetPay - AthirdOfEarning;
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
    begin
        gsSegmentPayrollData;
        CompanyInfo.Get;
    end;

    var
        Name: Text[100];
        Emp: Record Employee;
        CommutorAllowance: Decimal;
        AthirdOfEarning: Decimal;
        AthirdRuleAmount: Decimal;
        Periods: Record Periods;
        TitleText: Text[60];
        PayrollSetup: Record "Payroll Setups";
        CompanyInfo: Record "Company Information";
        PayrollLines: Record "Payroll Lines";
        gvAllowedPayrolls: Record "Allowed Payrolls";
        NetPay: Decimal;
        PermanentEarnings: Decimal;
        OtherFixEarning: Integer;
        TotalDeductions: Decimal;
        Paye: Decimal;
        PPaye: Decimal;
        NhifReliefAmt: Decimal;
        BasicPay: Decimal;

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

