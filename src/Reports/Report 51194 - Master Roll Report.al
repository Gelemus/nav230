report 51194 "Master Roll Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Master Roll Report.rdl';

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Start Date");
            RequestFilterFields = "Period ID";
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
            column(Description_Periods; Periods.Description)
            {
            }
            dataitem(Employee; Employee)
            {
                DataItemTableView = SORTING("No.");
                PrintOnlyIfDetail = true;
                //RequestFilterFields = Status,"No.","Statistics Group Code","Global Dimension 1 Code","Shortcut Dimension 3 Code",Status,"Payroll Code","Shortcut Dimension 5 Code","Shortcut Dimension 4 Code","Shortcut Dimension 6 Code","Shortcut Dimension 7 Code";
                column(Employee_Name; Name)
                {
                }
                column(Employee__No__; "No.")
                {
                }
                column(SalaryScale_Employee; Employee."Salary Scale")
                {
                }
                column(GlobalDimension2Code_Employee; Employee."Global Dimension 2 Code")
                {
                }
                dataitem("Calculation Scheme Master Roll"; "Calculation Scheme Master Roll")
                {
                    DataItemTableView = SORTING("Payroll Code", Number);
                    column(Number_CalculationScheme1; "Calculation Scheme Master Roll".Number)
                    {
                    }
                    column(EDCode_CalculationScheme1; "Calculation Scheme Master Roll"."ED Code")
                    {
                    }
                    column(Description_CalculationScheme1; "Calculation Scheme Master Roll".Description)
                    {
                    }
                    column(ValueSource_CalculationScheme1; "Calculation Scheme Master Roll"."Value Source")
                    {
                    }
                    column(Amount; Amount)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Amount := 0;
                        if "Calculation Scheme Master Roll"."Value Source" = "Calculation Scheme Master Roll"."Value Source"::"ED Definition" then begin
                            PayrollLines.Reset;
                            PayrollLines.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                            PayrollLines.SetRange("Employee No.", Employee."No.");
                            PayrollLines.SetRange("Payroll ID", Periods."Period ID");
                            PayrollLines.SetRange("ED Code", "Calculation Scheme Master Roll"."ED Code");
                            if PayrollLines.FindFirst then begin
                                repeat
                                    Amount := Amount + PayrollLines.Amount;
                                until PayrollLines.Next = 0;
                                if PayrollLines."Calculation Group" = PayrollLines."Calculation Group"::Payments then
                                    TotalIncome := TotalIncome + Amount
                                else if PayrollLines."Calculation Group" = PayrollLines."Calculation Group"::Deduction then
                                    TotalDeduction := TotalDeduction + Amount;
                            end
                        end
                        else if "Calculation Scheme Master Roll"."Value Source" = "Calculation Scheme Master Roll"."Value Source"::"Total Deduction" then begin
                            Amount := TotalDeduction;
                        end
                        else if "Calculation Scheme Master Roll"."Value Source" = "Calculation Scheme Master Roll"."Value Source"::"Total Gross" then begin
                            Amount := TotalIncome;
                        end
                        else if "Calculation Scheme Master Roll"."Value Source" = "Calculation Scheme Master Roll"."Value Source"::"Net Pay" then begin
                            Amount := TotalIncome - TotalDeduction;
                            if Amount < 0 then
                                Amount := 0;
                        end;
                        //MESSAGE(FORMAT(Amount));
                        if (Amount = 0) and ("SkipZero'sED") then CurrReport.Skip;
                    end;

                    trigger OnPreDataItem()
                    begin
                        "Calculation Scheme Master Roll".SetRange("Calculation Scheme Master Roll"."Payroll Code", gvAllowedPayrolls."Payroll Code");
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    lvBank: Record "Employee Bank Account";
                begin
                    Name := FullName;
                    TotalDeduction := 0;
                    TotalIncome := 0;
                    Netpay := 0;
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                end;
            }
            dataitem("Approval Comment Line"; "Approval Comment Line")
            {
                DataItemLink = "Document No." = FIELD("Document No");
                DataItemTableView = SORTING("Entry No.") ORDER(Ascending);
                column(ApprovedDays_ApprovalCommentLine; "Approval Comment Line"."Approved Days")
                {
                    IncludeCaption = true;
                }
                column(ApprovedStartDate_ApprovalCommentLine; "Approval Comment Line"."Approved Start Date")
                {
                    IncludeCaption = true;
                }
                column(ApprovedReturnDate_ApprovalCommentLine; "Approval Comment Line"."Approved Return Date")
                {
                    IncludeCaption = true;
                }
                column(Reason_ApprovalCommentLine; "Approval Comment Line".Reason)
                {
                    IncludeCaption = true;
                }
                column(LeaveAllowanceGranted_ApprovalCommentLine; "Approval Comment Line"."Leave allowance Granted")
                {
                    IncludeCaption = true;
                }
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
                    /*i:=i+1;
                    IF i=1 THEN BEGIN
                      ShowPreparedBy:=TRUE;
                     PreparedDate:="Approval Entry"."Date-Time Sent for Approval";
                     EmployeeRecI.RESET;
                     EmployeeRecI.SETRANGE("User ID","Approval Entry"."Sender ID");
                     IF  EmployeeRecI.FINDFIRST THEN
                     BEGIN
                      PreparedByCaption:='Prepared By: Payroll Administrator: '+' '+EmployeeRecI."First Name"+' '+EmployeeRecI."Last Name";
                    
                        END;
                    UserSetupRecI.RESET;
                    UserSetupRecI.SETRANGE("User ID","Approval Entry"."Sender ID");
                    IF UserSetupRecI.FINDFIRST THEN
                      UserSetupRecI.CALCFIELDS(Signature);
                    
                    ApprovedByCaption:='Checked By: GM HR :' ;
                    UserSetupRec.RESET;
                    UserSetupRec.SETRANGE("User ID","Approval Entry"."Approver ID");
                    IF UserSetupRec.FINDFIRST THEN
                      UserSetupRec.CALCFIELDS(Signature);
                      END
                      ELSE
                      ShowPreparedBy:=FALSE;
                    {IF i=2 THEN
                      BEGIN
                      ApprovedByCaption:='Confirmed By: ACCOUNTANT:';
                      UserSetupRec.RESET;
                      UserSetupRec.SETRANGE("User ID","Approval Entry"."Approver ID");
                      IF UserSetupRec.FINDFIRST THEN
                        UserSetupRec.CALCFIELDS(Signature);
                        END
                    ELSE IF i=3 THEN
                      BEGIN
                      ApprovedByCaption:='Verified By: CM: ';
                      UserSetupRec.RESET;
                      UserSetupRec.SETRANGE("User ID","Approval Entry"."Approver ID");
                      IF UserSetupRec.FINDFIRST THEN
                        UserSetupRec.CALCFIELDS(Signature);
                        END
                    ELSE} IF i=2 THEN
                      BEGIN
                      ApprovedByCaption:='Approved By: GM FINANCE: ';
                      UserSetupRec.RESET;
                      UserSetupRec.SETRANGE("User ID","Approval Entry"."Approver ID");
                      IF UserSetupRec.FINDFIRST THEN
                        UserSetupRec.CALCFIELDS(Signature);
                        END;*/
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

                        ApprovedByCaption := 'Checked By: GM HR';

                        UserSetupRec.Reset;

                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);

                    end
                    else
                        ShowPreparedBy := false;
                    if i = 2 then begin
                        ApprovedByCaption := 'Confirmed By: HOD FINANCE';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end
                    else if i = 3 then begin
                        ApprovedByCaption := 'Authorised By: MD ';
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
            area(content)
            {
                field("Skip Zero ED"; "SkipZero'sED")
                {
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
        //EDFilters := "ED Definitions".GETFILTERS + ' ' + Employee.GETFILTERS;
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
        TotalIncome: Decimal;
        TotalDeduction: Decimal;
        Netpay: Decimal;
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
        PayrollLines: Record "Payroll Lines";
        Amount: Decimal;
        CompanyInfo: Record "Company Information";
        "SkipZero'sED": Boolean;
        Approver1: Code[20];
        i: Integer;
        ShowPreparedBy: Boolean;
        PreparedByCaption: Text;
        ApprovedByCaption: Text;
        UserSetupRec: Record "User Setup";
        UserSetupRecI: Record "User Setup";
        PreparedDate: DateTime;
        "Salary Scale": Text[250];
        EmployeeRecI: Record Employee;
        "Job Title": Text[250];
        TenantMedia: Record "Tenant Media";
        TenantMedia1: Record "Tenant Media";

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

