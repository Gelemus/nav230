report 57027 "AThird Rule Report1"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/AThird Rule Report1.rdl';

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
            column(BasicPay; "Payroll Header"."Basic Pay")
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
            column(PermanentEarnings; PermanentEarnings)
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(CommutorAllownce; CommutorAllowance)
            {
            }
            column(AthirdOfEarning; AthirdOfEarning)
            {
            }
            column(AthirdRuleAmount; AthirdRuleAmount)
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
                /*IF PayrollSetup.FINDFIRST THEN BEGIN
                  PayrollSetup.TESTFIELD("Commuter Allowance ED");
                  PayrollLines.SETRANGE("Payroll ID","Payroll Header"."Payroll ID");
                  PayrollLines.SETRANGE("Employee No.","Payroll Header"."Employee no.");
                 IF "Payroll Header"."Payroll Code" = 'CMT' THEN BEGIN
                  IF PayrollLines.FINDSET THEN BEGIN
                    REPEAT
                      IF (PayrollLines."ED Code"='FUEL ALL') OR (PayrollLines."ED Code"='ENTERTAINMENT ALLOWA')
                        OR (PayrollLines."ED Code"='NON-PRACTICING ALLOW') THEN
                        OtherFixEarning := OtherFixEarning+PayrollLines.Amount;
                
                    UNTIL PayrollLines.NEXT=0;
                  END;
                 END ELSE BEGIN
                  PayrollLines.SETRANGE("ED Code",PayrollSetup."Commuter Allowance ED");
                  IF PayrollLines.FINDFIRST THEN
                    OtherFixEarning := PayrollLines.Amount;
                  END;
                END;*/
                /*"Payroll Header".CALCFIELDS("Payroll Header"."Total Deduction (LCY)");
                "Payroll Header".CALCFIELDS("Payroll Header"."Middle Name");
                "Payroll Header".CALCFIELDS("Payroll Header".PAYE);
                "Payroll Header".CALCFIELDS("Payroll Header"."Permanent Earning");
                PAYE := "Payroll Header".PAYE;
                PPaye := "Payroll Header"."Middle Name";
                TotalDeductions := "Payroll Header"."Total Deduction (LCY)";
                
                IF PAYE > 0 THEN
                  TotalDeductions := TotalDeductions+PPaye-PAYE;
                //NHif Relief
                NhifReliefAmt:=0;
                PayrollLines.RESET;
                PayrollLines.SETRANGE("Employee No.","Payroll Header"."Employee no.");
                PayrollLines.SETRANGE("ED Code",'NHIF RELIEF');
                PayrollLines.SETRANGE("Payroll ID","Payroll Header"."Payroll ID");
                IF PayrollLines.FINDFIRST THEN
                 NhifReliefAmt:=PayrollLines.Amount;
                
                //MESSAGE('%1 %2 %3',TotalDeductions,PAYE,PPaye);
                PermanentEarnings := "Payroll Header"."Permanent Earning";//"Payroll Header"."Basic Pay (LCY)"+"Payroll Header"."House Allowance"+OtherFixEarning;
                AthirdOfEarning :=  PermanentEarnings * 0.33;
                //NetPay := "Payroll Header"."Total Payable (LCY)" - "Payroll Header"."Total Deduction (LCY)";
                NetPay := (PermanentEarnings - TotalDeductions)+NhifReliefAmt;
                AthirdRuleAmount :=NetPay - AthirdOfEarning;*/

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

