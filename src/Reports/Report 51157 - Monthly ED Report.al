report 51157 "Monthly ED Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Monthly ED Report.rdl';

    dataset
    {
        dataitem("Payroll Lines"; "Payroll Lines")
        {
            DataItemTableView = SORTING("Payroll ID", "Global Dimension 1 Code", "Global Dimension 2 Code") ORDER(Ascending);
            column(USERID; UserId)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(TitleText; TitleText)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(Employee_No__; 'Employee No.')
            {
            }
            column(Employee_Name_; 'Employee Name')
            {
            }
            column(Payroll_Lines__Amount__LCY__; "Amount (LCY)")
            {
            }
            column(gvBranch; gvBranch)
            {
            }
            column(gvDepartment; gvDepartment)
            {
            }
            column(Payroll_Lines__Employee_No__; "Employee No.")
            {
            }
            column(Payroll_Lines__Amount__LCY___Control11; "Amount (LCY)")
            {
            }
            column(Name; Name)
            {
            }
            column(Payroll_Lines_Quantity; Quantity)
            {
            }
            column(Payroll_Lines_Rate; Rate)
            {
            }
            column(NationalID; NationalID)
            {
            }
            column(Payroll_Lines__Amount__LCY___Control1000000007; "Amount (LCY)")
            {
            }
            column(Payroll_Lines__Amount__LCY___Control31; "Amount (LCY)")
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(Totalhours; Totalhours)
            {
            }
            column(EmpCount; EmpCount)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(QtyCaption; QtyCaptionLbl)
            {
            }
            column(RateCaption; RateCaptionLbl)
            {
            }
            column(Amount__LCY_Caption; Amount__LCY_CaptionLbl)
            {
            }
            column(ID_No_Caption; ID_No_CaptionLbl)
            {
            }
            column(Payroll_Lines__Amount__LCY__Caption; Payroll_Lines__Amount__LCY__CaptionLbl)
            {
            }
            column(Payroll_Lines__Amount__LCY___Control31Caption; Payroll_Lines__Amount__LCY___Control31CaptionLbl)
            {
            }
            column(TotalAmountCaption; TotalAmountCaptionLbl)
            {
            }
            column(EmpCountCaption; EmpCountCaptionLbl)
            {
            }
            column(Payroll_Lines_Entry_No_; "Entry No.")
            {
            }
            column(Payroll_Lines_Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            column(Payroll_Lines_Global_Dimension_2_Code; "Global Dimension 2 Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if PrevEmpID = "Employee No." then CurrReport.Skip;//SNG 080611 To stop employee details from being fetched more than once

                TotalAmount += "Amount (LCY)";
                Totalhours += Quantity;
                EmpCount += 1;

                Employee.Get("Employee No.");
                NationalID := Employee."National ID";
                Name := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";

                PrevEmpID := "Employee No.";
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll ID", PeriodCode);
                SetRange("ED Code", EDCode);
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                CurrReport.CreateTotals(Quantity, "Amount (LCY)");
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

    trigger OnInitReport()
    begin

        if not IsServiceTier then begin
            if ACTION::LookupOK = PAGE.RunModal(PAGE::"Period Look Up", Period) then
                PeriodCode := Period."Period ID"
            else
                Error('No period was selected');

            if ACTION::LookupOK = PAGE.RunModal(PAGE::"ED Definitions", EDDef) then
                EDCode := EDDef."ED Code"
            else
                Error('No E/D was selected');
        end;

        if IsServiceTier then begin
            if ACTION::LookupOK = PAGE.RunModal(PAGE::"Period Look Up", Period) then
                PeriodCode := Period."Period ID"
            else
                Error('No period was selected');

            if ACTION::LookupOK = PAGE.RunModal(PAGE::"ED Definitions", EDDef) then
                EDCode := EDDef."ED Code"
            else
                Error('No E/D was selected');
        end;

        TitleText := EDDef.Description + ' List for ' + Period.Description;
    end;

    trigger OnPreReport()
    begin
        gsSegmentPayrollData;
        EmpCount := 0;
    end;

    var
        Employee: Record Employee;
        Period: Record Periods;
        EDDef: Record "ED Definitions";
        TestCalc: Codeunit "Payroll Posting";
        Name: Text[250];
        TitleText: Text[100];
        EDCode: Code[20];
        PeriodCode: Code[10];
        TotalAmount: Decimal;
        Totalhours: Decimal;
        EmpCount: Integer;
        NationalID: Code[10];
        gvAllowedPayrolls: Record "Allowed Payrolls";
        gvBranch: Text[30];
        gvDepartment: Text[30];
        gvDimValues: Record "Dimension Value";
        PrevEmpID: Code[20];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        QtyCaptionLbl: Label 'Qty';
        RateCaptionLbl: Label 'Rate';
        Amount__LCY_CaptionLbl: Label 'Amount (LCY)';
        ID_No_CaptionLbl: Label 'ID No.';
        Payroll_Lines__Amount__LCY__CaptionLbl: Label 'Continued...';
        Payroll_Lines__Amount__LCY___Control31CaptionLbl: Label 'Continued...';
        TotalAmountCaptionLbl: Label 'Total Amount LCY';
        EmpCountCaptionLbl: Label 'No. of Employees';
        EmployeeName: Text[250];

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

