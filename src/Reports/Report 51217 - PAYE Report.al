report 51217 "PAYE Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/PAYE Report.rdl';

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Start Date") WHERE(Status = FILTER(Open | Posted));
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
                    column(NationalID_Employee; Employee."National ID")
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
                    column(ArrearsAmount; ArrearsAmount)
                    {
                    }
                    column(BasicAmount; BasicAmount)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        lvPeriodYear: Text[5];
                    begin

                        if PrevEmpID = Employee."No." then CurrReport.Skip;//SNG 270511 To stop employee details from being fetched more than once

                        Name := Employee.FullName;
                        BasicAmount := 0;
                        AmountPeriod := 0;

                        Employee.SetRange("Period Filter", Periods."Period ID");
                        Employee.SetRange("ED Code Filter", PayrollSetup."PAYE ED Code");
                        Employee.CalcFields(Amount);
                        AmountPeriod := Employee.Amount;

                        //Basic+arrears
                        EmployeeRec.Reset;
                        EmployeeRec.SetRange("No.", Employee."No.");
                        EmployeeRec.SetRange("Period Filter", Periods."Period ID");
                        EmployeeRec.SetRange("ED Code Filter", PayrollSetup."Basic Pay E/D Code");
                        if EmployeeRec.FindFirst then begin
                            EmployeeRec.CalcFields(EmployeeRec.Amount);
                            BasicAmount := EmployeeRec.Amount;
                        end;
                        //Arrears
                        ArrearsAmount := 0;
                        EmployeeRec.Reset;
                        EmployeeRec.SetRange("No.", Employee."No.");
                        EmployeeRec.SetRange("Period Filter", Periods."Period ID");
                        EmployeeRec.SetRange("ED Code Filter", PayrollSetup."Salary Arrears Code");
                        if EmployeeRec.FindFirst then begin
                            EmployeeRec.CalcFields(EmployeeRec.Amount);
                            ArrearsAmount := EmployeeRec.Amount;
                        end;

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
                    i := i + 1;
                    if i = 1 then begin
                        ShowPreparedBy := true;
                        PreparedDate := "Approval Entry"."Date-Time Sent for Approval";
                        EmployeeRecI.Reset;
                        EmployeeRecI.SetRange("User ID", "Approval Entry"."Sender ID");
                        if EmployeeRecI.FindFirst then begin
                            PreparedByCaption := 'Prepared By: Payroll Accountant: ' + ' ' + EmployeeRecI."First Name" + ' ' + EmployeeRecI."Last Name";

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
                        ApprovedByCaption := 'Confirmed By: HOD Finance';
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
        AmountThisYearCaptionLbl: Label 'Amount';
        AmountToDateCaptionLbl: Label 'To Date';
        TotalsCaptionLbl: Label 'Totals';
        CompanyInfo: Record "Company Information";
        EmployeeRec: Record Employee;
        BasicAmount: Decimal;
        ArrearsAmount: Decimal;
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

