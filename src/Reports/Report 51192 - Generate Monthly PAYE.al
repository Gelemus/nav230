report 51192 "Generate Monthly PAYE"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payroll Header";"Payroll Header")
        {
            DataItemTableView = SORTING("Payroll ID","Employee no.");
            RequestFilterFields = "Payroll ID";

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
                //PayrollSetup.TESTFIELD("Insurance Relief ED");
                //cmm 120813 Calculate insurance and rent recovery amt
                lvPayrollLines.Reset;
                lvPayrollLines.SetCurrentKey("Payroll ID","Employee No.","ED Code","Posting Date");
                lvPayrollLines.SetRange("Payroll ID","Payroll Header"."Payroll ID");
                lvPayrollLines.SetRange("Employee No.","Payroll Header"."Employee no.");
                lvPayrollLines.SetFilter("ED Code",PayrollSetup."Insurance Relief ED");
                lvPayrollLines.CalcSums("Amount (LCY)");
                lvInsuranceAmt:=Abs(lvPayrollLines."Amount (LCY)");

                if PayrollSetup."Rent Recovery ED" <> '' then begin
                  lvPayrollLines.Reset;
                  lvPayrollLines.SetCurrentKey("Payroll ID","Employee No.","ED Code","Posting Date");
                  lvPayrollLines.SetRange("Payroll ID","Payroll Header"."Payroll ID");
                  lvPayrollLines.SetRange("Employee No.","Payroll Header"."Employee no.");
                  lvPayrollLines.SetFilter("ED Code",PayrollSetup."Rent Recovery ED");
                  lvPayrollLines.CalcSums("Amount (LCY)");
                  lvRentRecoveryAmt:=Abs(lvPayrollLines."Amount (LCY)");
                end;
                //end cmm
                EmployeeHousing:=lvEmployee."Housing For Employee";
                gvTempExcelBuffer.NewRow;
                gvTempExcelBuffer.AddColumn(lvEmployee.PIN,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn(UpperCase(lvEmployee.FullName),false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn("Payroll Header"."A (LCY)",false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
                gvTempExcelBuffer.AddColumn("Payroll Header"."B (LCY)",false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
                gvTempExcelBuffer.AddColumn(EmployeeHousing,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
                gvTempExcelBuffer.AddColumn(lvEmployee."Value of Quarters",false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
                gvTempExcelBuffer.AddColumn(0,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
                gvTempExcelBuffer.AddColumn(lvRentRecoveryAmt,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
                gvTempExcelBuffer.AddColumn(0,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
                gvTempExcelBuffer.AddColumn(0,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
                gvTempExcelBuffer.AddColumn(0,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
                gvTempExcelBuffer.AddColumn("Payroll Header"."E2 (LCY)",false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
                gvTempExcelBuffer.AddColumn(0,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
                gvTempExcelBuffer.AddColumn("Payroll Header"."F (LCY)",false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
                gvTempExcelBuffer.AddColumn(0,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
                gvTempExcelBuffer.AddColumn(0,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
                gvTempExcelBuffer.AddColumn(0,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
                gvTempExcelBuffer.AddColumn("Payroll Header"."K (LCY)",false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
                gvTempExcelBuffer.AddColumn(lvInsuranceAmt,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
                gvTempExcelBuffer.AddColumn(0,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Number);
            end;

            trigger OnPostDataItem()
            begin
                //gvTempExcelBuffer.CreateBook(StrSubstNo('PAYE- %1',"Payroll Header"."Payroll ID"),"Payroll Header"."Payroll ID");
                gvTempExcelBuffer.WriteSheet("Payroll Header"."Payroll Code",CompanyName,UserId);
                gvTempExcelBuffer.CloseBook;
                gvTempExcelBuffer.OpenExcel;
                //gvTempExcelBuffer.UpdateBookStream;
            end;

            trigger OnPreDataItem()
            begin
                if "Payroll Header".GetFilter("Payroll Header"."Payroll ID") = '' then
                   Error('You must specify Payroll ID filter');
                gsSegmentPayrollData;
                PayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
                "Payroll Header".SetRange("Payroll Header"."Payroll Code",gvAllowedPayrolls."Payroll Code");
                gvTempExcelBuffer.AddColumn('Employee''s PIN',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('Employee''s NAME',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('Cash pay Kshs',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('Benefits Non cash Kshs',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn(Text0001,false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('Value of Quarters Kshs',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('Computed value of Quarters',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('Rent Recovered from Employee',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('Net Value Of Housing',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('Total Gross pay C+D+E Kshs',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('Defined Contribution Benefit Calculation Kshs 30%OF C',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('Defined Contribution Benefit Calculation Kshs Actual Cont',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('Defined Contribution Benefit Calculation Kshs Legal Limit',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('Owner Occupied Interest or HOSP Kshs',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('Defined Contribution & owner occupier Interest or HOSP Kshs',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('Chargeable pay (F-H) Kshs',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('Tax Charged Kshs',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('Monthly Relief + Insurance Relief Kshs',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('Insurance Relief',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
                gvTempExcelBuffer.AddColumn('P.A.Y.E TAX Kshs',false,'',false,false,false,'',gvTempExcelBuffer."Cell Type"::Text);
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

