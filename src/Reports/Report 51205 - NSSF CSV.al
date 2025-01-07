report 51205 "NSSF CSV"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payroll Header";"Payroll Header")
        {
            DataItemTableView = SORTING("Payroll ID","Employee no.");
            RequestFilterFields = "Payroll ID","Payroll Code";

            trigger OnAfterGetRecord()
            var
                lvEmployee: Record Employee;
                lvPayrollLines: Record "Payroll Lines";
                lvInsuranceAmt: Decimal;
                lvRentRecoveryAmt: Decimal;
                EmployeeHousing: Integer;
            begin
                lvEmployee.Get("Payroll Header"."Employee no.");
                lvRentRecoveryAmt:=0;
                lvInsuranceAmt:=0;
                PayrollSetup.Get(lvEmployee."Payroll Code");
                //PayrollSetup.TESTFIELD("Insurance Relief ED");
                
                EmployeeHousing:=lvEmployee."Housing For Employee";
                gvTempExcelBuffer.NewRow;
                gvTempExcelBuffer.AddColumn(lvEmployee."No.",false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);//A
                gvTempExcelBuffer.AddColumn(UpperCase(lvEmployee."Last Name"),false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);//B
                gvTempExcelBuffer.AddColumn(UpperCase(lvEmployee.FullName),false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);//B
                gvTempExcelBuffer.AddColumn(lvEmployee."National ID",false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);//C
                gvTempExcelBuffer.AddColumn(lvEmployee.PIN,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);//C
                gvTempExcelBuffer.AddColumn(lvEmployee."NSSF No.",false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);//C
                gvTempExcelBuffer.AddColumn(199,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);//G
                gvTempExcelBuffer.AddColumn(3334,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);//H
                gvTempExcelBuffer.AddColumn(1,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);//G
                gvTempExcelBuffer.AddColumn(200,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);//H
                gvTempExcelBuffer.AddColumn(200,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);//G
                gvTempExcelBuffer.AddColumn(400,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);//H
                /*
                gvTempExcelBuffer.AddColumn('Primary Employee',FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Text);//D
                //bascic
                lvPayrollLines.RESET;
                lvPayrollLines.SETCURRENTKEY("Payroll ID","Employee No.","ED Code","Posting Date");
                lvPayrollLines.SETRANGE("Payroll ID","Payroll Header"."Payroll ID");
                lvPayrollLines.SETRANGE("Employee No.","Payroll Header"."Employee no.");
                lvPayrollLines.SETFILTER("ED Code",PayrollSetup."Basic Pay E/D Code");
                lvPayrollLines.CALCSUMS("Amount (LCY)");
                gvTempExcelBuffer.AddColumn(ABS(lvPayrollLines."Amount (LCY)"),FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//E
                //housing
                lvPayrollLines.RESET;
                lvPayrollLines.SETCURRENTKEY("Payroll ID","Employee No.","ED Code","Posting Date");
                lvPayrollLines.SETRANGE("Payroll ID","Payroll Header"."Payroll ID");
                lvPayrollLines.SETRANGE("Employee No.","Payroll Header"."Employee no.");
                lvPayrollLines.SETFILTER("ED Code",PayrollSetup."House Allowances ED");
                lvPayrollLines.CALCSUMS("Amount (LCY)");
                gvTempExcelBuffer.AddColumn(ABS(lvPayrollLines."Amount (LCY)"),FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//F
                //travelling
                lvPayrollLines.RESET;
                lvPayrollLines.SETCURRENTKEY("Payroll ID","Employee No.","ED Code","Posting Date");
                lvPayrollLines.SETRANGE("Payroll ID","Payroll Header"."Payroll ID");
                lvPayrollLines.SETRANGE("Employee No.","Payroll Header"."Employee no.");
                lvPayrollLines.SETFILTER("ED Code",PayrollSetup."Commuter Allowance ED");
                lvPayrollLines.CALCSUMS("Amount (LCY)");
                
                gvTempExcelBuffer.AddColumn(0,FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//G
                gvTempExcelBuffer.AddColumn(0,FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//H
                //Overtime
                lvPayrollLines.RESET;
                lvPayrollLines.SETCURRENTKEY("Payroll ID","Employee No.","ED Code","Posting Date");
                lvPayrollLines.SETRANGE("Payroll ID","Payroll Header"."Payroll ID");
                lvPayrollLines.SETRANGE("Employee No.","Payroll Header"."Employee no.");
                lvPayrollLines.SETFILTER("ED Code",'=%1|=%2',PayrollSetup."Normal OT ED",PayrollSetup."Weekend OT ED");
                lvPayrollLines.CALCSUMS("Amount (LCY)");
                
                gvTempExcelBuffer.AddColumn(ABS(lvPayrollLines."Amount (LCY)"),FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//I
                
                gvTempExcelBuffer.AddColumn(0,FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//J
                
                gvTempExcelBuffer.AddColumn(0,FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//K
                //Otherallowa
                lvPayrollLines.RESET;
                lvPayrollLines.SETCURRENTKEY("Payroll ID","Employee No.","ED Code","Posting Date");
                lvPayrollLines.SETRANGE("Payroll ID","Payroll Header"."Payroll ID");
                lvPayrollLines.SETRANGE("Employee No.","Payroll Header"."Employee no.");
                lvPayrollLines.SETRANGE("Calculation Group",lvPayrollLines."Calculation Group"::Payments);
                lvPayrollLines.SETFILTER("ED Code",'<>%1&<>%2&<>%3&<>%4',PayrollSetup."Normal OT ED",PayrollSetup."Weekend OT ED",PayrollSetup."House Allowances ED",PayrollSetup."Basic Pay E/D Code");
                lvPayrollLines.CALCSUMS("Amount (LCY)");
                gvTempExcelBuffer.AddColumn(ABS(lvPayrollLines."Amount (LCY)"),FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//L
                
                gvTempExcelBuffer.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Text);//M
                gvTempExcelBuffer.AddColumn(0,FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//N
                gvTempExcelBuffer.AddColumn(0,FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//O
                gvTempExcelBuffer.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Text);//P
                
                
                gvTempExcelBuffer.AddColumn(0,FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//Q
                gvTempExcelBuffer.AddColumn('Benefit not given',FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Text);//R
                gvTempExcelBuffer.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Text);//S
                gvTempExcelBuffer.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Text);//T
                gvTempExcelBuffer.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Text);//U
                gvTempExcelBuffer.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Text);//V
                gvTempExcelBuffer.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Text);//W
                gvTempExcelBuffer.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Text);//X
                //Pension
                lvPayrollLines.RESET;
                lvPayrollLines.SETCURRENTKEY("Payroll ID","Employee No.","ED Code","Posting Date");
                lvPayrollLines.SETRANGE("Payroll ID","Payroll Header"."Payroll ID");
                lvPayrollLines.SETRANGE("Employee No.","Payroll Header"."Employee no.");
                lvPayrollLines.SETFILTER("ED Code",'=%1|=%2|=%3',PayrollSetup."NSSF ED Code",PayrollSetup."Pension ED Code",PayrollSetup."Pension 2 ED Code");
                lvPayrollLines.CALCSUMS("Amount (LCY)");
                gvTempExcelBuffer.AddColumn(ABS(lvPayrollLines."Amount (LCY)"),FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//Y
                gvTempExcelBuffer.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Text);//Z
                gvTempExcelBuffer.AddColumn(0,FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//AA
                gvTempExcelBuffer.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//AB
                gvTempExcelBuffer.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Text);//AC
                gvTempExcelBuffer.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Text);//AD
                gvTempExcelBuffer.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Text);//AE
                
                //PERSONAL RELIEF
                lvPayrollLines.RESET;
                lvPayrollLines.SETCURRENTKEY("Payroll ID","Employee No.","ED Code","Posting Date");
                lvPayrollLines.SETRANGE("Payroll ID","Payroll Header"."Payroll ID");
                lvPayrollLines.SETRANGE("Employee No.","Payroll Header"."Employee no.");
                lvPayrollLines.SETFILTER("ED Code",'=%1',PayrollSetup."Tax Relief Code");
                lvPayrollLines.CALCSUMS("Amount (LCY)");
                gvTempExcelBuffer.AddColumn(ABS(lvPayrollLines."Amount (LCY)"),FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//AF
                
                //Tax Relief
                lvPayrollLines.RESET;
                lvPayrollLines.SETCURRENTKEY("Payroll ID","Employee No.","ED Code","Posting Date");
                lvPayrollLines.SETRANGE("Payroll ID","Payroll Header"."Payroll ID");
                lvPayrollLines.SETRANGE("Employee No.","Payroll Header"."Employee no.");
                lvPayrollLines.SETFILTER("ED Code",'=%1',PayrollSetup."Insurance Relief ED");//,PayrollSetup."NHIF Relief Code");
                lvPayrollLines.CALCSUMS("Amount (LCY)");
                gvTempExcelBuffer.AddColumn(ABS(lvPayrollLines."Amount (LCY)"),FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//AG
                
                //gvTempExcelBuffer.AddColumn(0,FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//AG
                
                gvTempExcelBuffer.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Text);//AH
                
                lvPayrollLines.RESET;
                lvPayrollLines.SETCURRENTKEY("Payroll ID","Employee No.","ED Code","Posting Date");
                lvPayrollLines.SETRANGE("Payroll ID","Payroll Header"."Payroll ID");
                lvPayrollLines.SETRANGE("Employee No.","Payroll Header"."Employee no.");
                lvPayrollLines.SETFILTER("ED Code",'=%1',PayrollSetup."PAYE ED Code");
                lvPayrollLines.CALCSUMS("Amount (LCY)");
                gvTempExcelBuffer.AddColumn(ABS(lvPayrollLines."Amount (LCY)"),FALSE,'',FALSE,FALSE,FALSE,'',gvTempExcelBuffer."Cell Type"::Number);//AI
                */

            end;

            trigger OnPostDataItem()
            begin
                /*gvTempExcelBuffer.CreateBook(STRSUBSTNO('PAYE- %1',"Payroll Header"."Payroll ID"),"Payroll Header"."Payroll ID");
                gvTempExcelBuffer.WriteSheet("Payroll Header"."Payroll Code",COMPANYNAME,USERID);
                gvTempExcelBuffer.CloseBook;
                gvTempExcelBuffer.OpenExcel;
                //gvTempExcelBuffer.UpdateBookStream;*/
                //Filename:=TemporaryPath+'\P10.xlsx';
                SheetName:="Payroll Header"."Payroll ID";
                ReportHeader:='';
                Company:='';
                user:='';
                //gvTempExcelBuffer.CreateBookAndOpenExcel(Filename,SheetName,'','','');

            end;

            trigger OnPreDataItem()
            begin
                if "Payroll Header".GetFilter("Payroll Header"."Payroll ID") = '' then
                   Error('You must specify Payroll ID filter');
                
                
                /*gsSegmentPayrollData;
                PayrollSetup.GET(gvAllowedPayrolls."Payroll Code");
                "Payroll Header".SETFILTER("Payroll Header"."Payroll Code",gvAllowedPayrolls."Payroll Code");
                
                */

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
        lvActiveSession.SetRange("Server Instance ID",ServiceInstanceId);
        lvActiveSession.SetRange("Session ID",SessionId);
        lvActiveSession.FindFirst;


        gvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        gvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if not gvAllowedPayrolls.FindFirst then
          Error('You are not allowed access to this payroll dataset.');
    end;
}

