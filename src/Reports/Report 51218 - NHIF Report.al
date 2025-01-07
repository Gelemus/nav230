report 51218 "NHIF Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/NHIF Report.rdl';

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
            column(Registration_Pin; CompanyInfo."Registration No.")
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
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(NHIF_No_Caption; NHIF_No_CaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(This_YearCaption; This_YearCaptionLbl)
            {
            }
            column(To_DateCaption; To_DateCaptionLbl)
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
                    //The property 'DataItemTableView' shouldn't have an empty value.
                    //DataItemTableView = '';
                    RequestFilterFields = "No.", "Statistics Group Code", "Global Dimension 1 Code", "Global Dimension 2 Code", Status;
                    column(Employee_Name; Name)
                    {
                    }
                    column(Other_Names; "Other Names")
                    {
                    }
                    column(Employee__No__; "No.")
                    {
                    }
                    column(NationalID_Employee; Employee."National ID")
                    {
                    }
                    column(Employee__Membership_No__; "NHIF No.")
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
                        if PrevEmpID = Employee."No." then CurrReport.Skip;//SNG 300511 To stop employee details from being fetched more than once

                        Name := Employee."Last Name";//FullName;
                        "Other Names" := Employee."First Name" + ' ' + Employee."Middle Name";
                        Employee.SetRange("Period Filter", Periods."Period ID");
                        Employee.SetRange("ED Code Filter", PayrollSetup."NHIF ED Code");

                        Employee.CalcFields(Amount);
                        AmountPeriod := Employee.Amount;
                        TotalAmount := TotalAmount + Employee.Amount;

                        AmountThisYear := 0;
                        //calculate the NHIF amount for the employee in the year
                        PayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
                        gvPeriods.Reset;
                        gvPeriods.SetRange("Period ID", Periods."Period ID");
                        if gvPeriods.Find('-') then
                            lvPeriodYear := StrSubstNo('*%1', Format(gvPeriods."Period Year"));
                        gvPayrollLines.Reset;
                        gvPayrollLines.SetCurrentKey("ED Code", "Employee No.", "Payroll Code", "Payroll ID");
                        gvPayrollLines.SetRange("ED Code", PayrollSetup."NHIF ED Code");
                        gvPayrollLines.SetRange("Employee No.", Employee."No.");
                        gvPayrollLines.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                        gvPayrollLines.SetFilter("Payroll ID", '%1', lvPeriodYear);
                        if gvPayrollLines.FindSet then begin
                            repeat
                                AmountThisYear += gvPayrollLines.Amount;
                            until gvPayrollLines.Next = 0;
                        end;



                        Employee.SetRange("Period Filter", PeriodRec."Period ID", Periods."Period ID");
                        Employee.SetRange("ED Code Filter", PayrollSetup."NHIF ED Code");
                        Employee.CalcFields(Amount, "Amount To Date");
                        //AmountThisYear := Employee.Amount;
                        //TotalAmountThisYear := TotalAmountThisYear + Employee.Amount;
                        TotalAmountThisYear := TotalAmountThisYear + AmountThisYear;

                        AmountToDate := Employee."Amount To Date";
                        TotalAmountToDate := TotalAmountToDate + Employee."Amount To Date";
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
                    SetRange("ED Code", PayrollSetup."NHIF ED Code");
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
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

                        ApprovedByCaption := 'Checked By: GM HR:';

                        UserSetupRec.Reset;

                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);

                    end
                    else
                        ShowPreparedBy := false;
                    if i = 2 then begin
                        ApprovedByCaption := 'Confirmed By: HOD Finance:';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end
                    else if i = 3 then begin
                        ApprovedByCaption := 'Authorised By: MD:';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end;
                    /*
                ELSE IF i=4 THEN
                  BEGIN
                  ApprovedByCaption:='Approved By: MD: ';
                  UserSetupRec.RESET;
                  UserSetupRec.SETRANGE("User ID","Approval Entry"."Approver ID");
                  IF UserSetupRec.FINDFIRST THEN
                    UserSetupRec.CALCFIELDS(Signature);
                    END;
                */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                TitleText := /*'NHIF Deduction Schedule for ' + */Periods."Period ID";
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
        PrevEmpID: Code[20];
        gvPayrollLines: Record "Payroll Lines";
        gvPeriods: Record Periods;
        AmountCaptionLbl: Label 'Amount';
        NameCaptionLbl: Label 'Name';
        NHIF_No_CaptionLbl: Label 'NHIF No.';
        No_CaptionLbl: Label 'No.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        This_YearCaptionLbl: Label 'Amount';
        To_DateCaptionLbl: Label 'To Date';
        TotalsCaptionLbl: Label 'Totals';
        CompanyInfo: Record "Company Information";
        Approver1: Code[20];
        i: Integer;
        ShowPreparedBy: Boolean;
        PreparedByCaption: Text;
        ApprovedByCaption: Text;
        UserSetupRec: Record "User Setup";
        UserSetupRecI: Record "User Setup";
        PreparedDate: DateTime;
        EmployeeRecI: Record Employee;
        "Other Names": Text[100];

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

