report 51174 "Company Payslip Dept"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Company Payslip Dept.rdl';

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Start Date") ORDER(Ascending) WHERE(Status = FILTER(Open | Posted));
            RequestFilterFields = "Period ID";
            column(COMPANYNAME; CompanyName)
            {
            }
            column(TotalPayrollbyDepartment; 'Total Payroll by Department')
            {
            }
            column(PeriodID_Periods; "Period ID")
            {
            }
            column(PeriodMonth_Periods; "Period Month")
            {
            }
            column(Periods_Period_Year; "Period Year")
            {
            }
            column(Periods_Payroll_Code; "Payroll Code")
            {
            }
            dataitem("Dimension Value"; "Dimension Value")
            {
                DataItemTableView = SORTING("Dimension Code", Code) ORDER(Ascending) WHERE("Global Dimension No." = CONST(2));
                column(NamePayslip; Name + ' Payslip')
                {
                }
                column(Code_DimensionValue; Code)
                {
                }
                column(Dimension_Value_Dimension_Code; "Dimension Code")
                {
                }
                dataitem("Payslip Group"; "Payslip Group")
                {
                    DataItemTableView = SORTING(Code);
                    column(HeadingText_PayslipGroup; "Heading Text")
                    {
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(ABSTotalAmountDec; Abs(TotalAmountDec))
                    {
                    }
                    column(NetPay; NetPay)
                    {
                    }
                    column(Payslip_Group_Code; Code)
                    {
                    }
                    dataitem("Payslip Lines"; "Payslip Lines")
                    {
                        DataItemLink = "Payslip Group" = FIELD(Code);
                        DataItemTableView = SORTING("Line No.", "Payslip Group");
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
                            column(ABSAmount; Abs(Amount))
                            {
                            }
                            column(DisplayText; DisplayText)
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
                                EDDefRec.Get("ED Code");

                                if EDDefRec.Cumulative then begin
                                    EmployeeRec.SetRange("ED Code Filter", EDDefRec."ED Code");
                                    EmployeeRec.SetRange("Date Filter", PeriodRec."Start Date", Periods."End Date");
                                    EmployeeRec.CalcFields("Amount To Date");
                                    CumilativeDec := EmployeeRec."Amount To Date";
                                end else
                                    CumilativeDec := 0;

                                case EDDefRec."Calculation Group" of
                                    EDDefRec."Calculation Group"::None:
                                        Amount := 0;
                                    EDDefRec."Calculation Group"::Deduction:
                                        Amount := -Amount;
                                end;

                                TotalAmountDec := TotalAmountDec + Amount;
                                NetPay := NetPay + Amount;
                                DisplayText := EDDefRec.Description;
                            end;

                            trigger OnPreDataItem()
                            begin
                                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                                SetRange("Global Dimension 2 Code", "Dimension Value".Code);
                                SetRange("Payroll ID", Periods."Period ID");

                                CurrReport.CreateTotals(Amount);
                                RPtHeader := "Dimension Value".Name + ' Payslip';
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if "Line Type" = 1 then begin
                                case P9 of
                                    P9::A:
                                        Amount := HeaderRec."A (LCY)";
                                    P9::B:
                                        Amount := HeaderRec."B (LCY)";
                                    P9::C:
                                        Amount := HeaderRec."C (LCY)";
                                    P9::D:
                                        Amount := HeaderRec."D (LCY)";
                                    P9::E1:
                                        Amount := HeaderRec."E1 (LCY)";
                                    P9::E2:
                                        Amount := HeaderRec."E2 (LCY)";
                                    P9::E3:
                                        Amount := HeaderRec."E3 (LCY)";
                                    P9::F:
                                        Amount := HeaderRec."F (LCY)";
                                    P9::G:
                                        Amount := HeaderRec."G (LCY)";
                                    P9::H:
                                        Amount := HeaderRec."H (LCY)";
                                    P9::J:
                                        Amount := HeaderRec."J (LCY)";
                                    P9::K:
                                        Amount := HeaderRec."K (LCY)";
                                    P9::L:
                                        Amount := HeaderRec."L (LCY)";
                                    P9::M:
                                        Amount := HeaderRec."M (LCY)";
                                end;
                            end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                            CurrReport.CreateTotals(Amount);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        TotalText := 'Total ' + "Payslip Group"."Heading Text";
                        TotalAmountDec := 0;
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
                }

                trigger OnAfterGetRecord()
                begin
                    TotalAmountDec := 0;
                    NetPay := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                MonthText := Periods.Description;
                if DeptCode <> '' then begin
                    DeptRec.SetFilter("Global Dimension No.", '2');
                    DeptRec.Get(DeptCode);
                    RPtHeader := DeptRec.Name + ' Payslip';
                end else
                    RPtHeader := CompanyName + ' Payslip';
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
        PayrollSetupRec.Get(gvAllowedPayrolls."Payroll Code");
        CompanyNameText := PayrollSetupRec."Employer Name";

        PeriodRec.SetCurrentKey("Start Date");
        PeriodRec.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
        PeriodRec.Find('-');
    end;

    var
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
        EmpBank: Text[100];
        DisplayText: Text[100];
        DeptCode: Code[10];
        RPtHeader: Text[100];
        DeptRec: Record "Dimension Value";
        NetPay: Decimal;
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

