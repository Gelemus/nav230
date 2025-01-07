report 51171 "Loans / Advances"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Loans  Advances.rdl';

    dataset
    {
        dataitem("Loans/Advances"; "Loans/Advances")
        {
            DataItemTableView = SORTING(ID) WHERE("Paid to Employee" = CONST(true));
            RequestFilterFields = ID, Employee, Type, "Loan Types";
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
            column(Loans_Advances__First_Name_; "First Name")
            {
            }
            column(Loans_Advances__Last_Name_; "Last Name")
            {
            }
            column(Loans_Advances__Interest_Rate_; "Interest Rate")
            {
            }
            column(Loans_Advances_Principal; Principal)
            {
            }
            column(Loans_Advances__Remaining_Debt_; "Remaining Debt")
            {
            }
            column(Loans_Advances_Repaid; Repaid)
            {
            }
            column(Loans_Advances__Interest_Paid_; "Interest Paid")
            {
            }
            column(Loans_Advances_Installments; Installments)
            {
            }
            column(Loans_Advances__Installment_Amount_; "Installment Amount")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loans_Advances__First_Name_Caption; FieldCaption("First Name"))
            {
            }
            column(Loans_Advances__Last_Name_Caption; FieldCaption("Last Name"))
            {
            }
            column(Loans_Advances__Interest_Rate_Caption; FieldCaption("Interest Rate"))
            {
            }
            column(Loans_Advances_PrincipalCaption; FieldCaption(Principal))
            {
            }
            column(Loans_Advances__Remaining_Debt_Caption; FieldCaption("Remaining Debt"))
            {
            }
            column(Loans_Advances_RepaidCaption; FieldCaption(Repaid))
            {
            }
            column(Loans_Advances__Interest_Paid_Caption; FieldCaption("Interest Paid"))
            {
            }
            column(Loans_Advances_InstallmentsCaption; FieldCaption(Installments))
            {
            }
            column(Loans_Advances__Installment_Amount_Caption; FieldCaption("Installment Amount"))
            {
            }
            column(Loans_Advances_ID; ID)
            {
            }

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                if not gvShowWrittenOff then   //SNG 080611 allow user to view Written off and Cleared loans
                    SetRange("Loans/Advances".Cleared, false);
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

        PeriodRec.SetCurrentKey("Start Date");
        PeriodRec.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
        PeriodRec.Find('-');

        TitleText := 'Summary of Loans';
    end;

    var
        PayrollSetup: Record "Payroll Setups";
        PeriodRec: Record Periods;
        EmployeeRec: Record Employee;
        Name: Text[100];
        TitleText: Text[60];
        EmployerName: Text[50];
        PeriodAmount: Decimal;
        TotalAmountArray: array[4] of Decimal;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        gvShowWrittenOff: Boolean;
        CurrReport_PAGENOCaptionLbl: Label 'Page';

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

