report 51172 "Loan Amortisation"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Loan Amortisation.rdl';

    dataset
    {
        dataitem("Loans/Advances"; "Loans/Advances")
        {
            DataItemTableView = SORTING(ID) ORDER(Ascending);
            RequestFilterFields = ID, Employee, "Loan Types";
            column(EmployerName; EmployerName)
            {
            }
            column(USERID; UserId)
            {
            }
            column(TitleText; TitleText)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(Name; Name)
            {
            }
            column(Loans_Advances__Interest_Rate_; "Interest Rate")
            {
            }
            column(Loans_Advances_Principal; Principal)
            {
            }
            column(TotalAmountArray_2_; TotalAmountArray[2])
            {
            }
            column(TotalAmountArray_1_; TotalAmountArray[1])
            {
            }
            column(TotalAmountArray_3_; TotalAmountArray[3])
            {
            }
            column(Remaining_DebtCaption; Remaining_DebtCaptionLbl)
            {
            }
            column(MonthlyCaption; MonthlyCaptionLbl)
            {
            }
            column(InterestCaption; InterestCaptionLbl)
            {
            }
            column(RepaymentCaption; RepaymentCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(Loans_Advances__Interest_Rate_Caption; Loans_Advances__Interest_Rate_CaptionLbl)
            {
            }
            column(Loans_Advances_PrincipalCaption; Loans_Advances_PrincipalCaptionLbl)
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }
            column(Cheque_No_____________________________________________________________________________________________Caption; Cheque_No_____________________________________________________________________________________________CaptionLbl)
            {
            }
            column(Approved_by____________________________________________________________________________________________Caption; Approved_by____________________________________________________________________________________________CaptionLbl)
            {
            }
            column(Terms_Accepted____________________________________________________________________________________________Caption; Terms_Accepted____________________________________________________________________________________________CaptionLbl)
            {
            }
            column(Loans_Advances_ID; ID)
            {
            }
            dataitem("Loan Entry"; "Loan Entry")
            {
                DataItemLink = "Loan ID" = FIELD(ID);
                DataItemTableView = SORTING("No.", "Loan ID");
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
                column(Loan_Entry__No__; "No.")
                {
                }
                column(Loan_Entry_Period; Period)
                {
                }
                column(Loan_Entry_Loan_ID; "Loan ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PeriodAmount := Interest + Repayment;
                    TotalAmountArray[1] := TotalAmountArray[1] + Repayment;
                    TotalAmountArray[2] := TotalAmountArray[2] + Interest;
                    TotalAmountArray[3] := TotalAmountArray[3] + PeriodAmount;
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
                TitleText := 'Loan Amortisation';
                Clear(TotalAmountArray);

                EmployeeRec.Get(Employee);
                Name := EmployeeRec.FullName;
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
    end;

    var
        EmployeeRec: Record Employee;
        PayrollSetup: Record "Payroll Setups";
        Name: Text[100];
        TitleText: Text[60];
        EmployerName: Text[50];
        PeriodAmount: Decimal;
        TotalAmountArray: array[3] of Decimal;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        Remaining_DebtCaptionLbl: Label 'Remaining Debt';
        MonthlyCaptionLbl: Label 'Monthly';
        InterestCaptionLbl: Label 'Interest';
        RepaymentCaptionLbl: Label 'Repayment';
        NameCaptionLbl: Label 'Name';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        No_CaptionLbl: Label 'No.';
        PeriodCaptionLbl: Label 'Period';
        Loans_Advances__Interest_Rate_CaptionLbl: Label 'Interest Rate';
        Loans_Advances_PrincipalCaptionLbl: Label 'Principal';
        TotalsCaptionLbl: Label 'Totals';
        Cheque_No_____________________________________________________________________________________________CaptionLbl: Label 'Cheque No. :..........................................................................................';
        Approved_by____________________________________________________________________________________________CaptionLbl: Label 'Approved by :..........................................................................................';
        Terms_Accepted____________________________________________________________________________________________CaptionLbl: Label 'Terms Accepted :..........................................................................................';

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

