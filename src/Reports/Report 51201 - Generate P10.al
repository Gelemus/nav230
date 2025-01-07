report 51201 "Generate P10"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payroll Header"; "Payroll Header")
        {
            DataItemTableView = SORTING("Payroll ID", "Employee no.");
            RequestFilterFields = "Payroll ID", "Payroll Code";

            trigger OnAfterGetRecord()
            var
                lvEmployee: Record Employee;
                lvPayrollLines: Record "Payroll Lines";
                lvInsuranceAmt: Decimal;
                lvRentRecoveryAmt: Decimal;
                EmployeeHousing: Integer;
            begin
                lvEmployee.Get("Payroll Header"."Employee no.");
                lvRentRecoveryAmt := 0;
                lvInsuranceAmt := 0;
                PayrollSetup.Get(lvEmployee."Payroll Code");
                //PayrollSetup.TESTFIELD("Insurance Relief ED");

                EmployeeHousing := lvEmployee."Housing For Employee";
                gvTempExcelBuffer.NewRow;
                gvTempExcelBuffer.AddColumn(lvEmployee.PIN, false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//A
                gvTempExcelBuffer.AddColumn(UpperCase(lvEmployee.FullName), false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//B
                gvTempExcelBuffer.AddColumn('Resident', false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//C
                gvTempExcelBuffer.AddColumn('Primary Employee', false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//D
                //bascic
                lvPayrollLines.Reset;
                lvPayrollLines.SetCurrentKey("Payroll ID", "Employee No.", "ED Code", "Posting Date");
                lvPayrollLines.SetRange("Payroll ID", "Payroll Header"."Payroll ID");
                lvPayrollLines.SetRange("Employee No.", "Payroll Header"."Employee no.");
                lvPayrollLines.SetFilter("ED Code", PayrollSetup."Basic Pay E/D Code");
                lvPayrollLines.CalcSums("Amount (LCY)");
                gvTempExcelBuffer.AddColumn(Abs(lvPayrollLines."Amount (LCY)"), false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//E
                //housing
                lvPayrollLines.Reset;
                lvPayrollLines.SetCurrentKey("Payroll ID", "Employee No.", "ED Code", "Posting Date");
                lvPayrollLines.SetRange("Payroll ID", "Payroll Header"."Payroll ID");
                lvPayrollLines.SetRange("Employee No.", "Payroll Header"."Employee no.");
                lvPayrollLines.SetFilter("ED Code", PayrollSetup."House Allowances ED");
                lvPayrollLines.CalcSums("Amount (LCY)");
                gvTempExcelBuffer.AddColumn(Abs(lvPayrollLines."Amount (LCY)"), false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//F
                //travelling
                lvPayrollLines.Reset;
                lvPayrollLines.SetCurrentKey("Payroll ID", "Employee No.", "ED Code", "Posting Date");
                lvPayrollLines.SetRange("Payroll ID", "Payroll Header"."Payroll ID");
                lvPayrollLines.SetRange("Employee No.", "Payroll Header"."Employee no.");
                lvPayrollLines.SetFilter("ED Code", PayrollSetup."Commuter Allowance ED");
                lvPayrollLines.CalcSums("Amount (LCY)");
                //Commuter
                lvPayrollLines.Reset;
                lvPayrollLines.SetCurrentKey("Payroll ID", "Employee No.", "ED Code", "Posting Date");
                lvPayrollLines.SetRange("Payroll ID", "Payroll Header"."Payroll ID");
                lvPayrollLines.SetRange("Employee No.", "Payroll Header"."Employee no.");
                lvPayrollLines.SetFilter("ED Code", PayrollSetup."Commuter Allowance ED");
                lvPayrollLines.CalcSums("Amount (LCY)");
                gvTempExcelBuffer.AddColumn(Abs(lvPayrollLines."Amount (LCY)"), false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//G
                //gvTempExcelBuffer.AddColumn(0,FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//G
                //gvTempExcelBuffer.AddColumn(0, false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//H
                //LEAVE ALLOWANCE
                lvPayrollLines.Reset;
                lvPayrollLines.SetCurrentKey("Payroll ID", "Employee No.", "ED Code", "Posting Date");
                lvPayrollLines.SetRange("Payroll ID", "Payroll Header"."Payroll ID");
                lvPayrollLines.SetRange("Employee No.", "Payroll Header"."Employee no.");
                lvPayrollLines.SetFilter("ED Code", '=%1', PayrollSetup."Leave Travel Allowance ED");
                lvPayrollLines.CalcSums("Amount (LCY)");
                gvTempExcelBuffer.AddColumn(Abs(lvPayrollLines."Amount (LCY)"), false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//H                
                //Overtime
                lvPayrollLines.Reset;
                lvPayrollLines.SetCurrentKey("Payroll ID", "Employee No.", "ED Code", "Posting Date");
                lvPayrollLines.SetRange("Payroll ID", "Payroll Header"."Payroll ID");
                lvPayrollLines.SetRange("Employee No.", "Payroll Header"."Employee no.");
                lvPayrollLines.SetFilter("ED Code", '=%1|=%2', PayrollSetup."Normal OT ED", PayrollSetup."Weekend OT ED");
                lvPayrollLines.CalcSums("Amount (LCY)");

                gvTempExcelBuffer.AddColumn(Abs(lvPayrollLines."Amount (LCY)"), false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//I

                gvTempExcelBuffer.AddColumn(0, false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//J

                gvTempExcelBuffer.AddColumn(0, false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//K
                //Otherallowance(Hazard,Special Duty)
                lvPayrollLines.Reset;
                lvPayrollLines.SetCurrentKey("Payroll ID", "Employee No.", "ED Code", "Posting Date");
                lvPayrollLines.SetRange("Payroll ID", "Payroll Header"."Payroll ID");
                lvPayrollLines.SetRange("Employee No.", "Payroll Header"."Employee no.");
                lvPayrollLines.SetRange("Calculation Group", lvPayrollLines."Calculation Group"::Payments);
                lvPayrollLines.SetFilter("ED Code", '=%1|=%2|=%3', PayrollSetup."Leave Advance Loan", PayrollSetup."Personal Account Recoveries ED", PayrollSetup."Overdrawn ED");
                lvPayrollLines.CalcSums("Amount (LCY)");
                gvTempExcelBuffer.AddColumn(Abs(lvPayrollLines."Amount (LCY)"), false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//L

                gvTempExcelBuffer.AddColumn('', false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//M
                gvTempExcelBuffer.AddColumn(0, false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//N
                gvTempExcelBuffer.AddColumn(0, false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//O
                gvTempExcelBuffer.AddColumn('', false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//P


                gvTempExcelBuffer.AddColumn(0, false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//Q
                gvTempExcelBuffer.AddColumn('Benefit not given', false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//R
                gvTempExcelBuffer.AddColumn('', false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//S
                gvTempExcelBuffer.AddColumn('', false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//T
                gvTempExcelBuffer.AddColumn('', false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//U
                gvTempExcelBuffer.AddColumn('', false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//V
                gvTempExcelBuffer.AddColumn('', false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//W
                gvTempExcelBuffer.AddColumn('', false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//X
                //Pension
                lvPayrollLines.RESET;
                lvPayrollLines.SETCURRENTKEY("Payroll ID", "Employee No.", "ED Code", "Posting Date");
                lvPayrollLines.SETRANGE("Payroll ID", "Payroll Header"."Payroll ID");
                lvPayrollLines.SETRANGE("Employee No.", "Payroll Header"."Employee no.");
                lvPayrollLines.SETFILTER("ED Code", '=%1|=%2|=%3|=%4|=%5', PayrollSetup."Nssf Tier 1 Employee", PayrollSetup."Nssf Tier 2 Employee", PayrollSetup."Pension ED Code", PayrollSetup."Pension 2 ED Code", PayrollSetup."Pension 3 ED Code");
                lvPayrollLines.CALCSUMS("Amount (LCY)");

                lvPayrollLines.RESET;
                lvPayrollLines.SETCURRENTKEY("Payroll ID", "Employee No.", "ED Code", "Posting Date");
                lvPayrollLines.SETRANGE("Payroll ID", "Payroll Header"."Payroll ID");
                lvPayrollLines.SETRANGE("Employee No.", "Payroll Header"."Employee no.");
                lvPayrollLines.SETFILTER("ED Code", '=%1|=%2|=%3|=%4|=%5', PayrollSetup."Nssf Tier 1 Employee", PayrollSetup."Nssf Tier 2 Employee", PayrollSetup."Pension ED Code", PayrollSetup."Pension 2 ED Code", PayrollSetup."Pension 3 ED Code");
                lvPayrollLines.CALCSUMS("Amount (LCY)");

                gvTempExcelBuffer.AddColumn(0, false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//Y

                //gvTempExcelBuffer.AddColumn(Abs(lvPayrollLines."Amount (LCY)"), false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//Y

                gvTempExcelBuffer.AddColumn(Abs(lvPayrollLines."Amount (LCY)"), false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//Y
                gvTempExcelBuffer.AddColumn('', false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//Z
                gvTempExcelBuffer.AddColumn(0, false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//AA

                //AHL RELIEF
                lvPayrollLines.Reset;
                lvPayrollLines.SetCurrentKey("Payroll ID", "Employee No.", "ED Code", "Posting Date");
                lvPayrollLines.SetRange("Payroll ID", "Payroll Header"."Payroll ID");
                lvPayrollLines.SetRange("Employee No.", "Payroll Header"."Employee no.");
                lvPayrollLines.SetFilter("ED Code", '=%1', PayrollSetup."Interest Benefit");
                lvPayrollLines.CalcSums("Amount (LCY)");
                gvTempExcelBuffer.AddColumn(Abs(lvPayrollLines."Amount (LCY)"), false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//AB

                //gvTempExcelBuffer.AddColumn('', false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//AB
                gvTempExcelBuffer.AddColumn('', false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//AC
                gvTempExcelBuffer.AddColumn('', false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//AD
                gvTempExcelBuffer.AddColumn('', false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//AE

                //PERSONAL RELIEF
                lvPayrollLines.Reset;
                lvPayrollLines.SetCurrentKey("Payroll ID", "Employee No.", "ED Code", "Posting Date");
                lvPayrollLines.SetRange("Payroll ID", "Payroll Header"."Payroll ID");
                lvPayrollLines.SetRange("Employee No.", "Payroll Header"."Employee no.");
                lvPayrollLines.SetFilter("ED Code", '=%1', PayrollSetup."Tax Relief Code");
                lvPayrollLines.CalcSums("Amount (LCY)");
                gvTempExcelBuffer.AddColumn(Abs(lvPayrollLines."Amount (LCY)"), false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//AF

                //Tax Relief
                lvPayrollLines.Reset;
                lvPayrollLines.SetCurrentKey("Payroll ID", "Employee No.", "ED Code", "Posting Date");
                lvPayrollLines.SetRange("Payroll ID", "Payroll Header"."Payroll ID");
                lvPayrollLines.SetRange("Employee No.", "Payroll Header"."Employee no.");
                lvPayrollLines.SetFilter("ED Code", '=%1', PayrollSetup."Insurance Relief ED");//,PayrollSetup."NHIF Relief Code");
                lvPayrollLines.CalcSums("Amount (LCY)");
                gvTempExcelBuffer.AddColumn(Abs(lvPayrollLines."Amount (LCY)"), false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//AG

                //gvTempExcelBuffer.AddColumn(0,FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//AG

                gvTempExcelBuffer.AddColumn('', false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Text);//AH

                lvPayrollLines.Reset;
                lvPayrollLines.SetCurrentKey("Payroll ID", "Employee No.", "ED Code", "Posting Date");
                lvPayrollLines.SetRange("Payroll ID", "Payroll Header"."Payroll ID");
                lvPayrollLines.SetRange("Employee No.", "Payroll Header"."Employee no.");
                lvPayrollLines.SetFilter("ED Code", '=%1', PayrollSetup."PAYE ED Code");
                lvPayrollLines.CalcSums("Amount (LCY)");
                gvTempExcelBuffer.AddColumn(Abs(lvPayrollLines."Amount (LCY)"), false, '', false, false, false, '', gvTempExcelBuffer."Cell Type"::Number);//AI

            end;

            trigger OnPostDataItem()
            begin
                /*gvTempExcelBuffer.CreateBook(STRSUBSTNO('PAYE- %1',"Payroll Header"."Payroll ID"),"Payroll Header"."Payroll ID");
                gvTempExcelBuffer.WriteSheet("Payroll Header"."Payroll Code",COMPANYNAME,USERID);
                gvTempExcelBuffer.CloseBook;
                gvTempExcelBuffer.OpenExcel;
                //gvTempExcelBuffer.UpdateBookStream;*/
                Filename := TemporaryPath + '\P10.xlsx';
                SheetName := "Payroll Header"."Payroll ID";
                ReportHeader := '';
                Company := '';
                user := '';
                gvTempExcelBuffer.CreateBookAndOpenExcel(Filename, SheetName, '', '', '');

            end;

            trigger OnPreDataItem()
            begin
                if "Payroll Header".GetFilter("Payroll Header"."Payroll ID") = '' then
                    Error('You must specify Payroll ID filter');


                /*gsSegmentPayrollData;
                PayrollSetup.GET(gvAllowedPayrolls."Payroll Code");
                "Payroll Header".SETFILTER("Payroll Header"."Payroll Code", gvAllowedPayrolls."Payroll Code");*/



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

    var
        Text0001: Label 'Housing 0-Not housed 1-Employer owned house 2-Employer rented house or 3-Agricultural farm';
        gvTempExcelBuffer: Record "Excel Buffer" temporary;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        PayrollSetup: Record "Payroll Setups";
        Filename: Text;
        SheetName: Text;
        ReportHeader: Text;
        Company: Text;
        user: Text;
        Window: Dialog;

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

