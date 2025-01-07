report 51166 P10
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/P10.rdl';

    dataset
    {
        dataitem(Year; Year)
        {
            RequestFilterFields = Year;
            column(PayrollSetupEmployerPINNo; PayrollSetup."Employer PIN No.")
            {
            }
            column(YEARFORMATYear; 'YEAR ' + Format(Year))
            {
            }
            column(Year_Year; Year)
            {
            }
            dataitem(Periods; Periods)
            {
                DataItemLink = "Period Year" = FIELD(Year);
                DataItemTableView = SORTING("Start Date");
                column(KENYAREVENUEAUTHORITY; 'KENYA REVENUE AUTHORITY')
                {
                }
                column(NAMEOFEMPLOYERPayrollSetupEmployerName; 'NAME OF EMPLOYER   ' + PayrollSetup."Employer Name")
                {
                }
                column(ADDRESSPayrollSetupEmployersAddress; 'ADDRESS    ' + PayrollSetup."Employers Address")
                {
                }
                column(SIGNATURE; 'SIGNATURE ............................................................')
                {
                }
                column(DATE; 'DATE           ............................................................')
                {
                }
                column(PAYE; PAYE)
                {
                }
                column(WeIforwardherewithTaxDeductionCardsP9AP9BshowingthetotaltaxdeductedaslistedonP10AamountingtoKshsFORMATTotalPAYE; 'We/I forward herewith ..... Tax Deduction Cards (P9A/P9B) showing the total tax deducted (as listed on P.10A) amounting to Kshs ' + Format(TotalPAYE))
                {
                }
                column(Periods_Period_ID; "Period ID")
                {
                }
                column(PeriodStarDate; Periods."Start Date")
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
                column(EmployerName; PayrollSetup."Employer Name")
                {
                }
                column(EmployerAddress; PayrollSetup."Employers Address")
                {
                }
                dataitem("Payroll Header"; "Payroll Header")
                {
                    DataItemLink = "Payroll ID" = FIELD("Period ID");
                    column(PAYE1; PAYE)
                    {
                    }
                    column(PeriodsDescription; Periods.Description)
                    {
                    }
                    column(Payroll_Header_Payroll_ID; "Payroll ID")
                    {
                    }
                    column(Payroll_Header_Employee_no_; "Employee no.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if "M (LCY)" > 0 then PAYE := PAYE + "M (LCY)"; //SKM130208 OC-ES037 added if to exclude negative PAYE
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    PAYE := 0;
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    CurrReport.CreateTotals(PAYE);
                end;
            }
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
        PayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
    end;

    var
        PAYE: Decimal;
        PayrollSetup: Record "Payroll Setups";
        TotalPAYE: Decimal;
        gvAllowedPayrolls: Record "Allowed Payrolls";

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

