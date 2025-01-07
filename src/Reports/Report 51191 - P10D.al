report 51191 P10D
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/P10D.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            column(EmployeeNo; Employee."No.")
            {
            }
            column(EmployeePIN; Employee.PIN)
            {
            }
            column(EmployeeName; Employee.FullName)
            {
            }
            column(EmployerPIN; PayrollSetup."Employer PIN No.")
            {
            }
            column(EmployerName; PayrollSetup."Employer Name")
            {
            }
            column(TotalWCPS; TotalWCPS)
            {
            }
            column(FringeTax; FringeTax)
            {
            }
            column(TotalOthers; TotalOthers)
            {
            }
            column(TaxLogo; PayrollSetup."KRA Tax Logo")
            {
            }
            column(QtrEndingDate; QtrEndingDate)
            {
            }
            column(Year; Year)
            {
            }
            dataitem("Payroll Header"; "Payroll Header")
            {
                DataItemLink = "Employee no." = FIELD("No.");
                DataItemTableView = SORTING("Payroll ID", "Employee no.");
                column(TotalGrossPay; "Payroll Header"."D (LCY)")
                {
                }
                column(TotalPAYE; "Payroll Header"."M (LCY)")
                {
                }
                column(PayrollHeaderEmpNo; "Payroll Header"."Employee no.")
                {
                }

                trigger OnPreDataItem()
                begin
                    "Payroll Header".SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    "Payroll Header".SetFilter("Payroll ID", PeriodFilter);
                    "Payroll Header".SetRange("Employee no.", Employee."No.");
                end;
            }

            trigger OnPreDataItem()
            begin
                gsSegmentPayrollData;
                Employee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                PayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
                PayrollSetup.CalcFields("KRA Tax Logo");


                Period.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                Period.SetRange("Period Year", Year);
                if Quarter2 = Quarter2::"1" then begin
                    QtrEndingDate := '31/03';
                    Period.SetFilter("Period Month", '%1|%2|%3', 1, 2, 3)
                end else if Quarter2 = Quarter2::"2" then begin
                    QtrEndingDate := '30/06';
                    Period.SetFilter("Period Month", '%1|%2|%3', 4, 5, 6)
                end else if Quarter2 = Quarter2::"3" then begin
                    QtrEndingDate := '30/09';
                    Period.SetFilter("Period Month", '%1|%2|%3', 7, 8, 9)
                end else begin
                    QtrEndingDate := '31/12';
                    Period.SetFilter("Period Month", '%1|%2|%3', 10, 11, 12);
                end;

                Period.FindFirst;
                repeat
                    if PeriodFilter <> '' then
                        PeriodFilter := PeriodFilter + '|' + Period."Period ID"
                    else
                        PeriodFilter := Period."Period ID";
                until Period.Next = 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(TotalWCPS; TotalWCPS)
                    {
                        BlankZero = true;
                        Caption = 'Total WCPS';
                    }
                    field(FringeTax; FringeTax)
                    {
                        BlankZero = true;
                        Caption = 'Fringe Benefit Tax';
                    }
                    field(TotalOthers; TotalOthers)
                    {
                        BlankZero = true;
                        Caption = 'Tax Lumpsum/Audit/Penalty/Int';
                    }
                    field(Quarter2; Quarter2)
                    {
                        Caption = 'Quarter';
                    }
                    field(Year; Year)
                    {
                        BlankZero = true;
                        Caption = 'Year';
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
        if Quarter2 = 0 then Error('Quarter must be specified');
        if Year = 0 then Error('Year must be specified');
    end;

    var
        EmployeeGrossPay: Decimal;
        EmployeeTax: Decimal;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        DateFilter: Date;
        TotalWCPS: Decimal;
        FringeTax: Decimal;
        TotalOthers: Decimal;
        PayrollSetup: Record "Payroll Setups";
        Quarter2: Option "0","1","2","3","4";
        Year: Integer;
        Period: Record Periods;
        PeriodFilter: Text[30];
        QtrEndingDate: Text[5];

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

