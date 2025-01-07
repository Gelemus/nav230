report 51176 "Credit Transfer List"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Credit Transfer List.rdl';

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Period ID", "Period Month", "Period Year") ORDER(Ascending);
            RequestFilterFields = "Period ID";
            column(FORMATTODAY04; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReportPAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Description_Periods; Description)
            {
            }
            column(gvPeriodTotalAmount; gvPeriodTotalAmount)
            {
            }
            column(PeriodID_Periods; "Period ID")
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
            dataitem("Employee Bank Account"; "Employee Bank Account")
            {
                DataItemTableView = SORTING("No.") ORDER(Ascending);
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.";
                column(Name_EmployeeBankAccount; Name)
                {
                }
                column(Branch_EmployeeBankAccount; Branch)
                {
                }
                column(Address_EmployeeBankAccount; Address)
                {
                }
                column(City_EmployeeBankAccount; City)
                {
                }
                column(gvBankTotalAmount; gvBankTotalAmount)
                {
                }
                column(Name_EmployeeBankAccount1; Name)
                {
                }
                column(Branch_EmployeeBankAccount1; Branch)
                {
                }
                column(Employee_Bank_Account_No_; "No.")
                {
                }
                dataitem(Employee; Employee)
                {
                    //DataItemLink = Field52021889=FIELD("No.");
                    PrintOnlyIfDetail = false;
                    RequestFilterFields = "No.";
                    column(No_Employee; "No.")
                    {
                    }
                    column(FullName; FullName)
                    {
                    }
                    column(BankAccountNo_Employee; "Bank Account No")
                    {
                    }
                    column(gvAmount; gvAmount)
                    {
                    }
                    column(Employee_Bank_Code; "Bank Code")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        gvAmount := 0;
                        if Header.Get(Periods."Period ID", "No.") then begin
                            Header.CalcFields("Total Payable (LCY)", "Total Deduction (LCY)", "Total Rounding Pmts (LCY)", "Total Rounding Ded (LCY)");
                            gvAmount := Header."Total Payable (LCY)" + Header."Total Rounding Pmts (LCY)" - (Header."Total Deduction (LCY)" +
                              Header."Total Rounding Ded (LCY)");
                            if gvAmount < 0 then
                                CurrReport.Skip
                            else
                                gvBankTotalAmount := gvBankTotalAmount + gvAmount;
                            gvPeriodTotalAmount := gvPeriodTotalAmount + gvAmount;
                        end else
                            CurrReport.Skip;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    gvBankTotalAmount := 0;
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("No.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                gvPeriodTotalAmount := 0;
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
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Header: Record "Payroll Header";
        gvBankTotalAmount: Decimal;
        gvAmount: Decimal;
        gvPeriodTotalAmount: Decimal;
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

