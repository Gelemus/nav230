report 51148 "Payroll Allowance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Payroll Allowance Report.rdl';

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
            dataitem("ED Definitions"; "ED Definitions")
            {
                DataItemTableView = WHERE("ED Code" = FILTER('BASIC'));
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
                        column(AnnualAmount; AmountPeriod * 12)
                        {
                        }
                        column(LeaveAmount; AmountPeriod * 12 * 0.05)
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
                            end;
                            //PayrollHeader."Pay Leave":=FALSE;
                            PayrollHeader.SetRange("Employee no.", Employee."No.");
                            if PayrollHeader.FindSet then begin
                                if PayrollHeader."Pay Leave" = false then
                                    CurrReport.Skip;
                            end;
                            //MESSAGE('Emp %1 Pay Leave%2',PayrollHeader."Employee no.",PayrollHeader."Pay Leave");
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
                    TitleText := "Leave AllowanceCaptionLbl" + ' Schedule for ' + Periods.Description;
                end;

                trigger OnPreDataItem()
                begin
                    //"ED Definitions"."ED Code":='Basic';
                end;
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No");
                DataItemTableView = WHERE(Status = FILTER(Approved));
                column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
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
                dataitem(Employee1; Employee)
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(EmployeeSignature_Employee; Employee1."Employee Signature")
                    {
                    }
                    column(FirstName_Employee; Employee1."First Name")
                    {
                    }
                    column(MiddleName_Employee; Employee1."Middle Name")
                    {
                    }
                    column(LastName_Employee; Employee1."Last Name")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    i := i + 1;
                    if i = 1 then begin
                        ShowPreparedBy := true;

                        EmployeeRecI.Reset;
                        EmployeeRecI.SetRange("User ID", "Approval Entry"."Sender ID");
                        if EmployeeRecI.FindFirst then begin
                            PreparedByCaption := 'Prepared By: Payroll Accountant ' + ' ' + EmployeeRecI."First Name" + ' ' + EmployeeRecI."Last Name";

                        end;
                        UserSetupRec.Reset;

                        UserSetupRecI.SetRange("User ID", "Approval Entry"."Sender ID");
                        if UserSetupRecI.FindFirst then
                            UserSetupRecI.CalcFields(Signature);

                        ApprovedByCaption := 'Checked By: HRO ';

                        UserSetupRec.Reset;

                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);

                    end
                    else
                        ShowPreparedBy := false;
                    if i = 2 then begin
                        ApprovedByCaption := 'Verified By: FM ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end
                    else if i = 3 then begin
                        ApprovedByCaption := 'Approved By: MD ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    i := 0;
                end;
            }
            dataitem(CreationApprovalEntry; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(SequenceNo_CreationApprovalEntry; CreationApprovalEntry."Sequence No.")
                {
                }
                column(SenderID_CreationApprovalEntry; CreationApprovalEntry."Sender ID")
                {
                }
                column(ApproverID_CreationApprovalEntry; CreationApprovalEntry."Approver ID")
                {
                }
                column(DateTimeSentforApproval_CreationApprovalEntry; CreationApprovalEntry."Date-Time Sent for Approval")
                {
                }
                column(LastDateTimeModified_CreationApprovalEntry; CreationApprovalEntry."Last Date-Time Modified")
                {
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


                //Approval
                ApprovalEntryRec.Reset;
                ApprovalEntryRec.SetRange("Document No.", Periods."Document No");
                ApprovalEntryRec.SetRange(Status, ApprovalEntryRec.Status::Approved);
                if ApprovalEntryRec.FindFirst then
                    repeat
                        if i = 0 then begin
                            Approval1 := ApprovalEntryRec."Sender ID";
                            PreparedDate := ApprovalEntryRec."Date-Time Sent for Approval";
                        end
                        else if i = 1 then
                            Approval2 := ApprovalEntryRec."Approver ID"
                        else if i = 2 then
                            Approval3 := ApprovalEntryRec."Approver ID"
                        else if i = 3 then
                            Approval4 := ApprovalEntryRec."Approver ID";

                        i += 1;

                    until ApprovalEntryRec.Next = 0;
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
        AnnualAmount: Decimal;
        LeaveAmount: Decimal;
        PayrollHeader: Record "Payroll Header";
        "Leave AllowanceCaptionLbl": Label 'Leave Allowances';
        ApprovalEntryRec: Record "Approval Entry";
        Approval1: Code[50];
        ApprovedByCaption: Text;
        Approval1Date: Date;
        Approval2: Code[50];
        Approval2Date: Date;
        Approval3: Code[50];
        Approval3Date: Date;
        Approval4: Code[50];
        Approval4Date: Date;
        Approval5: Code[50];
        Approval5Date: Date;
        i: Integer;
        ShowPreparedBy: Boolean;
        PreparedBy: Text;
        PreparedByCaption: Text;
        EmployeeRecI: Record Employee;
        EmployeeRecII: Record Employee;
        EmployeeRecIII: Record Employee;
        EmployeeRecIV: Record Employee;
        UserSetupRec: Record "User Setup";
        UserSetupRecI: Record "User Setup";
        PreparedDate: DateTime;

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

