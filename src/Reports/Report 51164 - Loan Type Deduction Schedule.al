report 51164 "Loan Type Deduction Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Loan Type Deduction Schedule.rdl';

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Start Date") WHERE(Status = FILTER(Open | Posted));
            RequestFilterFields = "Period ID";
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
            dataitem("Loan Types"; "Loan Types")
            {
                column(Loan_Types_Description; Description)
                {
                }
                column(Loan_Types_Code; Code)
                {
                }
                column(USERID; UserId)
                {
                }
                column(CurrReport_PAGENO; CurrReport.PageNo)
                {
                }
                column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
                {
                }
                column(EmployerName; EmployerName)
                {
                }
                column(TitleText; TitleText)
                {
                }
                column(No_Caption; No_CaptionLbl)
                {
                }
                column(NameCaption; NameCaptionLbl)
                {
                }
                column(Principle_RepaidCaption; Principle_RepaidCaptionLbl)
                {
                }
                column(InterestCaption; InterestCaptionLbl)
                {
                }
                column(Remaining_DebtCaption; Remaining_DebtCaptionLbl)
                {
                }
                column(MonthlyCaption; MonthlyCaptionLbl)
                {
                }
                column(Loan_Types_CodeCaption; Loan_Types_CodeCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                dataitem("Loans/Advances"; "Loans/Advances")
                {
                    DataItemLink = "Loan Types" = FIELD(Code);
                    RequestFilterFields = "Loan Types";
                    column(Loans_Advances_ID; ID)
                    {
                    }
                    column(Loans_Advances_Loan_Types; "Loan Types")
                    {
                    }
                    column(Loans_Advances_Employee; Employee)
                    {
                    }
                    dataitem("Loan Entry"; "Loan Entry")
                    {
                        DataItemLink = "Loan ID" = FIELD(ID), Employee = FIELD(Employee);
                        DataItemTableView = SORTING("Loan ID", Employee, Period, "Transfered To Payroll", Posted) ORDER(Ascending);
                        column(Name; Name)
                        {
                        }
                        column(Loan_Entry_Employee; Employee)
                        {
                        }
                        column(Loan_Entry_Repayment; Repayment)
                        {
                        }
                        column(Loan_Entry_Interest; Interest)
                        {
                        }
                        column(Loan_Entry__Remaining_Debt_; "Remaining Debt")
                        {
                        }
                        column(PeriodAmount; PeriodAmount)
                        {
                        }
                        column(Loan_Entry_No_; "No.")
                        {
                        }
                        column(Loan_Entry_Loan_ID; "Loan ID")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            EmployeeRec.Get(Employee);
                            Name := EmployeeRec.FullName;

                            PeriodAmount := Interest + Repayment;
                            TotalAmountArray[1] := TotalAmountArray[1] + Repayment;
                            TotalAmountArray[2] := TotalAmountArray[2] + Interest;
                            TotalAmountArray[3] := TotalAmountArray[3] + PeriodAmount;
                            TotalAmountArray[4] := TotalAmountArray[4] + "Remaining Debt";
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                            SetRange(Period, PERIODFILTER);

                            if not gvShowWrittenOff then  //SNG 080611 allow user to view Written off and Cleared loans
                                SetRange("Loan Entry".Posted, false);
                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

                        if not gvShowWrittenOff then   //SNG 080611 allow user to view Written off and Cleared loans
                            SetRange("Loans/Advances".Cleared, false);
                    end;
                }
                dataitem("Integer"; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;
                    column(TotalAmountArray_2_; TotalAmountArray[2])
                    {
                    }
                    column(TotalAmountArray_1_; TotalAmountArray[1])
                    {
                    }
                    column(TotalAmountArray_3_; TotalAmountArray[3])
                    {
                    }
                    column(TotalAmountArray_4_; TotalAmountArray[4])
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
                    Clear(TotalAmountArray);
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TitleText := 'Loan Deduction Schedule for ' + Periods.Description;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                // IF Periods.GETFILTER(Periods."Period ID")=''THEN ERROR('Specify the Period ID');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1102754001)
                {
                    ShowCaption = false;
                    field(gvShowWrittenOff; gvShowWrittenOff)
                    {
                        Caption = 'Show Written Off Loans / Cleared Loans';
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
        gsSegmentPayrollData;
        PayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
        EmployerName := PayrollSetup."Employer Name";
        PERIODFILTER := Periods.GetFilter("Period ID");
    end;

    var
        PayrollSetup: Record "Payroll Setups";
        EmployeeRec: Record Employee;
        Name: Text[100];
        TitleText: Text[60];
        EmployerName: Text[50];
        PeriodAmount: Decimal;
        TotalAmountArray: array[4] of Decimal;
        PERIODFILTER: Text[30];
        gvAllowedPayrolls: Record "Allowed Payrolls";
        gvShowWrittenOff: Boolean;
        No_CaptionLbl: Label 'No.';
        NameCaptionLbl: Label 'Name';
        Principle_RepaidCaptionLbl: Label 'Principle Repaid';
        InterestCaptionLbl: Label 'Interest';
        Remaining_DebtCaptionLbl: Label 'Remaining Debt';
        MonthlyCaptionLbl: Label 'Monthly';
        Loan_Types_CodeCaptionLbl: Label 'Loan Type';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
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

