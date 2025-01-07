report 51234 "Institution Based ED Report In"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Institution Based ED Report In.rdl';
    Caption = 'Institution Based ED Report Insurance';

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Start Date");
            RequestFilterFields = "Period ID";
            column(Periods_Period_ID; "Period ID")
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
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
            dataitem(Institution; Institution)
            {
                RequestFilterFields = "Code";
                column(Code_Institution; Institution.Code)
                {
                }
                column(InstitutionName_Institution; Institution."Institution Name")
                {
                }
                dataitem("ED Definitions"; "ED Definitions")
                {
                    DataItemLink = "Institution Code" = FIELD(Code);
                    RequestFilterFields = "ED Code";
                    column(USERID; UserId)
                    {
                    }
                    column(CurrReport_PAGENO; CurrReport.PageNo)
                    {
                    }
                    column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
                    {
                    }
                    column(ED_Definitions__ED_Code_; "ED Code")
                    {
                    }
                    column(ED_Definitions_Description; Description)
                    {
                    }
                    column(EmployerName; EmployerName)
                    {
                    }
                    column(TitleText; TitleText)
                    {
                    }
                    column(EDFilters; EDFilters)
                    {
                    }
                    column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                    {
                    }
                    column(Employee_NameCaption; Employee_NameCaptionLbl)
                    {
                    }
                    column(Employee__No__Caption; Employee__No__CaptionLbl)
                    {
                    }
                    column(Employee__Membership_No__Caption; Employee__Membership_No__CaptionLbl)
                    {
                    }
                    column(AmountPeriodCaption; AmountPeriodCaptionLbl)
                    {
                    }
                    column(AmountThisYearCaption; AmountThisYearCaptionLbl)
                    {
                    }
                    column(AmountToDateCaption; AmountToDateCaptionLbl)
                    {
                    }
                    column(Employee__Bank_Account_No__Caption; Employee.FieldCaption("Bank Account No"))
                    {
                    }
                    column(BankCaption; BankCaptionLbl)
                    {
                    }
                    column(BranchCaption; BranchCaptionLbl)
                    {
                    }
                    dataitem("Payroll Lines"; "Payroll Lines")
                    {
                        DataItemLink = "ED Code" = FIELD("ED Code");
                        DataItemTableView = SORTING("Payroll ID", "Employee No.", "ED Code");
                        column(Payroll_Lines_Entry_No_; "Entry No.")
                        {
                        }
                        column(Payroll_Lines_ED_Code; "ED Code")
                        {
                        }
                        column(Payroll_Lines_Employee_No_; "Employee No.")
                        {
                        }
                        column(RemainingDebt_PayrollLines; "Payroll Lines"."Remaining Debt")
                        {
                        }
                        dataitem(Employee; Employee)
                        {
                            DataItemLink = "No." = FIELD("Employee No.");
                            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE(Status = CONST(Active));
                            RequestFilterFields = "No.", "Statistics Group Code", "Global Dimension 1 Code", "Global Dimension 2 Code", Status;
                            column(Employee_Name; Name)
                            {
                            }
                            column(Employee__No__; "No.")
                            {
                            }
                            column(Employee__Membership_No__; "Membership No.")
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
                            column(Employee__Bank_Account_No__; "Bank Account No")
                            {
                            }
                            column(NationalID_Employee; Employee."National ID")
                            {
                            }
                            column(GlobalDimension1Code_Employee; Employee."Global Dimension 1 Code")
                            {
                            }
                            column(BankName; BankName)
                            {
                            }
                            column(BranchName; BranchName)
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                lvBank: Record "Employee Bank Account";
                            begin
                                Name := FullName;
                                Employee.SetFilter("Employee Type", '%1', "Payroll Lines"."Loan ID");
                                SetFilter("ED Code Filter", "ED Definitions"."ED Code");
                                CalcFields("Membership No.");

                                SetFilter("Date Filter", '%1..%2', Periods."Start Date", Periods."End Date");
                                CalcFields("Amount (LCY)");
                                AmountPeriod := "Amount (LCY)";
                                TotalAmount := TotalAmount + "Amount (LCY)";

                                SetFilter("Date Filter", '%1', Periods."End Date");
                                CalcFields("Amount To Date (LCY)");

                                PeriodRec.SetRange("Period Year", Periods."Period Year");
                                PeriodRec.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                                PeriodRec.Find('-');
                                SetFilter("Date Filter", '%1..%2', PeriodRec."Start Date", Periods."End Date");
                                CalcFields("Amount (LCY)");
                                AmountThisYear := "Amount (LCY)";
                                TotalAmountThisYear := TotalAmountThisYear + "Amount (LCY)";

                                AmountToDate := "Amount To Date (LCY)";
                                TotalAmountToDate := TotalAmountToDate + "Amount To Date";
                                Empcount := Empcount + 1;

                                if lvBank.Get(Employee."Bank Code") then begin
                                    BankName := lvBank.Name;
                                    BranchName := lvBank.Branch;
                                end
                            end;

                            trigger OnPreDataItem()
                            begin
                                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                                CurrReport.CreateTotals(AmountToDate, TotalAmountToDate);
                            end;
                        }

                        trigger OnPreDataItem()
                        begin
                            SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                            SetRange("Payroll ID", Periods."Period ID");
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        TotalAmountThisYear := 0;
                        TotalAmountToDate := 0;
                        TotalAmount := 0;
                        TitleText := Institution."Institution Name" + ' Schedule for ' + Periods.Description;
                    end;
                }
                dataitem("Integer"; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;
                    column(Number_of_Employees_____FORMAT_Empcount_; 'Number of Employees ' + Format(Empcount))
                    {
                    }
                    column(TotalAmount; TotalAmount)
                    {
                    }
                    column(TotalAmountThisYear; TotalAmountThisYear)
                    {
                    }
                    column(TotalAmountToDate; TotalAmountToDate)
                    {
                    }
                    column(TotalAmount_Control1000000011; TotalAmount)
                    {
                    }
                    column(Periods_Description; Periods.Description)
                    {
                    }
                    column(TotalsCaption; TotalsCaptionLbl)
                    {
                    }
                    column(Please_Recieve_Cheque_Number__________________________________Caption; Please_Recieve_Cheque_Number__________________________________CaptionLbl)
                    {
                    }
                    column(For_Ksh_Caption; For_Ksh_CaptionLbl)
                    {
                    }
                    column(Covering_payment_of_advance_to_the_above_listed_StaffCaption; Covering_payment_of_advance_to_the_above_listed_StaffCaptionLbl)
                    {
                    }
                    column(Please_credit_their_accounts_accordinglyCaption; Please_credit_their_accounts_accordinglyCaptionLbl)
                    {
                    }
                    column(Approved_by_Chief_Executive_OfficerCaption; Approved_by_Chief_Executive_OfficerCaptionLbl)
                    {
                    }
                    column(Approved_by_AccountantCaption; Approved_by_AccountantCaptionLbl)
                    {
                    }
                    column(Approved_by_HR_Admin_ManagerCaption; Approved_by_HR_Admin_ManagerCaptionLbl)
                    {
                    }
                    column(Integer_Number; Number)
                    {
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin
                PeriodRec.SetRange("Period Year", Periods."Period Year");
                PeriodRec.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                PeriodRec.Find('-');

                TotalAmountThisYear := 0;
                TotalAmountToDate := 0;
                TotalAmount := 0;
                Empcount := 0;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

                if Periods.GetFilter(Periods."Period ID") = '' then Error('Specify the Period ID');
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
        EDFilters := "ED Definitions".GetFilters + ' ' + Employee.GetFilters;
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
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
        EDFilters: Text[150];
        Empcount: Integer;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        BankName: Text[200];
        BranchName: Text[50];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Employee_NameCaptionLbl: Label 'Name';
        Employee__No__CaptionLbl: Label 'No.';
        Employee__Membership_No__CaptionLbl: Label 'Membership No.';
        AmountPeriodCaptionLbl: Label 'Amount';
        AmountThisYearCaptionLbl: Label 'This Year';
        AmountToDateCaptionLbl: Label 'To Date';
        BankCaptionLbl: Label 'Bank';
        BranchCaptionLbl: Label 'Branch';
        TotalsCaptionLbl: Label 'Totals';
        Please_Recieve_Cheque_Number__________________________________CaptionLbl: Label 'Please Recieve Cheque Number__________________________________';
        For_Ksh_CaptionLbl: Label 'For Ksh.';
        Covering_payment_of_advance_to_the_above_listed_StaffCaptionLbl: Label 'Covering payment of advance to the above listed Staff';
        Please_credit_their_accounts_accordinglyCaptionLbl: Label 'Please credit their accounts accordingly';
        Approved_by_Chief_Executive_OfficerCaptionLbl: Label 'Approved by Finance Director';
        Approved_by_AccountantCaptionLbl: Label 'Approved by FinanceAccountant';
        Approved_by_HR_Admin_ManagerCaptionLbl: Label 'Approved by HR/Admin Manager';
        CompanyInfo: Record "Company Information";

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

