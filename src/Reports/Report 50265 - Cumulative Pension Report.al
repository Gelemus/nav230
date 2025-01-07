report 50265 "Cumulative Pension Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Cumulative Pension Report.rdl';

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Start Date");
            RequestFilterFields = "Period ID", "Period Year", "Period Month";
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
            dataitem("ED Definitions"; "ED Definitions")
            {
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
                    column(RemainingDebt_PayrollLines; CumilativeDec)
                    {
                    }
                    dataitem(Employee; Employee)
                    {
                        DataItemLink = "No." = FIELD("Employee No.");
                        DataItemTableView = SORTING("Global Dimension 1 Code");
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

                    trigger OnAfterGetRecord()
                    var
                        EDDefRec: Record "ED Definitions";
                        EmployeeRec: Record Employee;
                        Enddate: Date;
                    begin
                        EDDefRec.Get("Payroll Lines"."ED Code");
                        if EDDefRec."Pension ED" = true then begin
                            if EDDefRec.Cumulative then begin
                                EmployeeRec.Get("Payroll Lines"."Employee No.");
                                // EmployeeRec.SETRANGE("ED Code Filter",EDDefRec."ED Code");
                                Enddate := Periods."End Date";
                                EmployeeRec.SetFilter("Date Filter", Format(DMY2Date(1, 1, 1900)) + '..' + Format(Enddate));
                                EmployeeRec.CalcFields("Amount To Date (LCY)", "Non Payroll Receipts");
                                CumilativeDec := EmployeeRec."Amount To Date (LCY)" + EmployeeRec."Non Payroll Receipts";
                            end else
                                CumilativeDec := 0;

                            if "Payroll Lines"."Loan Entry" then
                                CumilativeDec := "Payroll Lines"."Remaining Debt";
                        end;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                        SetRange("Payroll ID", Periods."Period ID");
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

                trigger OnAfterGetRecord()
                begin
                    TotalAmountThisYear := 0;
                    TotalAmountToDate := 0;
                    TotalAmount := 0;
                end;
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No");
                DataItemTableView = WHERE(Status = FILTER(Approved));
                column(SequenceNo; "Approval Entry"."Sequence No.")
                {
                }
                column(LastDateTimeModified; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(ApproverID; "Approval Entry"."Approver ID")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(SenderID; "Approval Entry"."Sender ID")
                {
                }
                column(ShowPreparedBy_; ShowPreparedBy)
                {
                }
                column(ApprovedByCaption_; ApprovedByCaption)
                {
                }
                column(PreparedByCaption_; PreparedByCaption)
                {
                }
                column(PreparedDate; PreparedDate)
                {
                }
                column(UserSetupRec_SignatureI_; UserSetupRecI.Signature)
                {
                }
                column(UserSetupRec_Signature_; UserSetupRec.Signature)
                {
                }
                dataitem(Employee2; Employee)
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(FirstName_Employee; Employee2."First Name")
                    {
                    }
                    column(MiddleName_Employee; Employee2."Middle Name")
                    {
                    }
                    column(LastName_Employee; Employee2."Last Name")
                    {
                    }
                    column(EmployeeSignature; Employee2."Employee Signature")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    i := i + 1;
                    if i = 1 then begin
                        ShowPreparedBy := true;
                        PreparedDate := "Approval Entry"."Date-Time Sent for Approval";
                        EmployeeRecI.Reset;
                        EmployeeRecI.SetRange("User ID", "Approval Entry"."Sender ID");
                        if EmployeeRecI.FindFirst then begin
                            PreparedByCaption := 'Prepared By: Payroll Administrator: ' + ' ' + EmployeeRecI."First Name" + ' ' + EmployeeRecI."Last Name";

                        end;
                        UserSetupRec.Reset;

                        UserSetupRecI.SetRange("User ID", "Approval Entry"."Sender ID");
                        if UserSetupRecI.FindFirst then
                            UserSetupRecI.CalcFields(Signature);

                        ApprovedByCaption := 'Checked By: GM HR:';

                        UserSetupRec.Reset;

                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);

                    end
                    else
                        ShowPreparedBy := false;
                    /*IF i=2 THEN
                      BEGIN
                      ApprovedByCaption:='Confirmed By: ACCOUNTANT:';
                      UserSetupRec.RESET;
                      UserSetupRec.SETRANGE("User ID","Approval Entry"."Approver ID");
                      IF UserSetupRec.FINDFIRST THEN
                        UserSetupRec.CALCFIELDS(Signature);
                        END
                    ELSE IF i=3 THEN
                      BEGIN
                      ApprovedByCaption:='Verified By: CM:';
                      UserSetupRec.RESET;
                      UserSetupRec.SETRANGE("User ID","Approval Entry"."Approver ID");
                      IF UserSetupRec.FINDFIRST THEN
                        UserSetupRec.CALCFIELDS(Signature);
                        END
                    ELSE*/
                    if i = 2 then begin
                        ApprovedByCaption := 'Approved By: GM FINANCE:';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end;

                end;
            }

            trigger OnAfterGetRecord()
            begin
                TitleText := 'Earning/Deduction Schedule for ' + Periods.Description;
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

                if Periods.GetFilter(Periods."Period ID") = '' then
                    if (Periods.GetFilter("Period Month") = '') and (Periods.GetFilter("Period Year") = '') then
                        Error('Specify the Period ID');
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
        CumilativeDec: Decimal;
        CompanyInfo: Record "Company Information";
        PrintDate: Date;
        PrintTime: Time;
        Approver1: Code[20];
        i: Integer;
        ShowPreparedBy: Boolean;
        PreparedByCaption: Text;
        ApprovedByCaption: Text;
        UserSetupRec: Record "User Setup";
        UserSetupRecI: Record "User Setup";
        PreparedDate: DateTime;
        EmployeeRecI: Record Employee;

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

