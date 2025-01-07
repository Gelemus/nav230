report 51152 "PAYE Report1"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/PAYE Report1.rdl';

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Start Date") WHERE(Status = FILTER(Open | Posted));
            RequestFilterFields = "Period ID";
            column(EmployerName; EmployerName)
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
            column(USERID; UserId)
            {
            }
            column(Amount_This_PeriodCaption; Amount_This_PeriodCaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(gvPinNoCaption; gvPinNoCaptionLbl)
            {
            }
            column(Employee__No__Caption; Employee__No__CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(AmountThisYearCaption; AmountThisYearCaptionLbl)
            {
            }
            column(AmountToDateCaption; AmountToDateCaptionLbl)
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
            dataitem("Payroll Lines"; "Payroll Lines")
            {
                DataItemLink = "Payroll ID" = FIELD("Period ID");
                DataItemTableView = SORTING("Payroll ID", "Employee No.", "ED Code");
                column(Payroll_Lines_Entry_No_; "Entry No.")
                {
                }
                column(Payroll_Lines_Payroll_ID; "Payroll ID")
                {
                }
                column(Payroll_Lines_Employee_No_; "Employee No.")
                {
                }
                column(Payroll_Lines_ED_Code; "ED Code")
                {
                }
                dataitem(Employee; Employee)
                {
                    DataItemLink = "No." = FIELD("Employee No.");
                    DataItemTableView = SORTING("No.") ORDER(Ascending);
                    RequestFilterFields = "No.", "Statistics Group Code", "Global Dimension 1 Code", "Global Dimension 2 Code", Status;
                    column(Employee_Name; Name)
                    {
                    }
                    column(Employee__No__; "No.")
                    {
                    }
                    column(gvPinNo; gvPinNo)
                    {
                    }
                    column(AmountPeriod; AmountPeriod)
                    {
                    }
                    column(AmountThisYear; AmountThisYear)
                    {
                    }
                    column(AmountToDate; AmountToDate)
                    {
                    }
                    column(Employee_ED_Code_Filter; "ED Code Filter")
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        lvPeriodYear: Text[5];
                    begin

                        if PrevEmpID = Employee."No." then CurrReport.Skip;//SNG 270511 To stop employee details from being fetched more than once

                        Name := Employee.FullName;

                        Employee.SetRange("Period Filter", Periods."Period ID");
                        Employee.CalcFields(Amount);
                        AmountPeriod := Employee.Amount;
                        TotalAmount := TotalAmount + Employee.Amount;

                        AmountThisYear := 0;

                        //calculate the PAYE amount for the employee in the year
                        PayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
                        gvPeriods.Reset;
                        gvPeriods.SetRange("Period ID", Periods."Period ID");
                        if gvPeriods.Find('-') then
                            lvPeriodYear := StrSubstNo('*%1', Format(gvPeriods."Period Year"));
                        gvPayrollLines.Reset;
                        gvPayrollLines.SetCurrentKey("ED Code", "Employee No.", "Payroll Code", "Payroll ID");
                        gvPayrollLines.SetRange("ED Code", PayrollSetup."PAYE ED Code");
                        gvPayrollLines.SetRange("Employee No.", Employee."No.");
                        gvPayrollLines.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                        gvPayrollLines.SetFilter("Payroll ID", '%1', lvPeriodYear);
                        if gvPayrollLines.FindSet then begin
                            repeat
                                AmountThisYear += gvPayrollLines.Amount;
                            until gvPayrollLines.Next = 0;
                        end;


                        Employee.SetRange("Period Filter", PeriodRec."Period ID", Periods."Period ID");
                        Employee.CalcFields(Amount, "Amount To Date");
                        //AmountThisYear := Employee.Amount;
                        //TotalAmountThisYear := TotalAmountThisYear + Employee.Amount;
                        TotalAmountThisYear := TotalAmountThisYear + AmountThisYear;

                        AmountToDate := Employee."Amount To Date";
                        TotalAmountToDate := TotalAmountToDate + Employee."Amount To Date";


                        //AKK START
                        SetFilter("ED Code Filter", PayrollSetup."PAYE ED Code");
                        CalcFields("Membership No.");
                        gvPinNo := Employee.PIN;
                        //AKK STOP
                    end;

                    trigger OnPostDataItem()
                    begin
                        PrevEmpID := Employee."No.";
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    end;
                }

                trigger OnPreDataItem()
                begin
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    SetRange("ED Code", PayrollSetup."PAYE ED Code");
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number);
                MaxIteration = 1;
                column(TotalAmount; TotalAmount)
                {
                }
                column(TotalAmountThisYear; TotalAmountThisYear)
                {
                }
                column(TotalAmountToDate; TotalAmountToDate)
                {
                }
                column(TotalsCaption; TotalsCaptionLbl)
                {
                }
                column(Integer_Number; Number)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                TitleText := 'PAYE Deduction Schedule for ' + Periods.Description;

                PeriodRec.SetRange("Period Year", Periods."Period Year");
                PeriodRec.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                PeriodRec.Find('-');

                TotalAmountThisYear := 0;
                TotalAmountToDate := 0;
                TotalAmount := 0;
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
        PayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
        EmployerName := PayrollSetup."Employer Name";

        PeriodRec.SetCurrentKey("Start Date");
    end;

    var
        PayrollSetup: Record "Payroll Setups";
        PeriodRec: Record Periods;
        Name: Text[100];
        TitleText: Text[60];
        EmployerName: Text[50];
        AmountPeriod: Decimal;
        AmountThisYear: Decimal;
        AmountToDate: Decimal;
        TotalAmountThisYear: Decimal;
        TotalAmountToDate: Decimal;
        TotalAmount: Decimal;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        MembershipNumbers: Record "Membership Numbers";
        gvPinNo: Code[20];
        PrevEmpID: Code[20];
        gvPayrollLines: Record "Payroll Lines";
        gvPeriods: Record Periods;
        Amount_This_PeriodCaptionLbl: Label 'Amount This Period';
        Employee_NameCaptionLbl: Label 'Name';
        gvPinNoCaptionLbl: Label 'PIN No.';
        Employee__No__CaptionLbl: Label 'No.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        AmountThisYearCaptionLbl: Label 'This Year';
        AmountToDateCaptionLbl: Label 'To Date';
        TotalsCaptionLbl: Label 'Totals';

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

