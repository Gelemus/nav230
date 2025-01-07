report 51160 "Bank Payment List"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Bank Payment List.rdl';

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Start Date") WHERE(Status = FILTER(Open | Posted));
            RequestFilterFields = "Period ID";
            column(CompName; CompName)
            {
            }
            column(CompanyInformation_Name; CompanyInfo.Name)
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
            column(Periods_Description; Description)
            {
            }
            column(Periods_Status; Status)
            {
            }
            column(CompNameCaption; CompNameCaptionLbl)
            {
            }
            column(Periods_DescriptionCaption; Periods_DescriptionCaptionLbl)
            {
            }
            column(Period_StatusCaption; Period_StatusCaptionLbl)
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
            dataitem(Employee; Employee)
            {
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "No.", "Bank Code", "Statistics Group Code", "Global Dimension 1 Code", "Global Dimension 2 Code", Status, "Mode of Payment";
                column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
                {
                }
                column(Employee__No__; "No.")
                {
                }
                column(Employee_Name; Name)
                {
                }
                column(Employee_Amount; Amount)
                {
                }
                column(Mobile_No; Employee."Mobile Phone No.")
                {
                }
                column(BankName; BankName)
                {
                }
                column(BranchName; BranchName)
                {
                }
                column(Employee__Bank_Account_No__; "Bank Account No")
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(TotalAmount_Control23; TotalAmount)
                {
                }
                column(Periods_Description_Control25; Periods.Description)
                {
                }
                column(FORMAT_TODAY_0_4__Control28; Format(Today, 0, 4))
                {
                }
                column(Number_of_Employees____FORMAT_EmpCount_; 'Number of Employees ' + Format(EmpCount))
                {
                }
                column(Employee_AmountCaption; Employee_AmountCaptionLbl)
                {
                }
                column(Employee_NameCaption; Employee_NameCaptionLbl)
                {
                }
                column(Employee__No__Caption; FieldCaption("No."))
                {
                }
                column(BranchNameCaption; BranchNameCaptionLbl)
                {
                }
                column(BankNameCaption; BankNameCaptionLbl)
                {
                }
                column(Employee__Bank_Account_No__Caption; FieldCaption("Bank Account No"))
                {
                }
                column(TotalAmountCaption; TotalAmountCaptionLbl)
                {
                }
                column(Please_recieve_cheque_number___________________________________________Caption; Please_recieve_cheque_number___________________________________________CaptionLbl)
                {
                }
                column(for_ShsCaption; for_ShsCaptionLbl)
                {
                }
                column(covering_payments_of_salaries_to_the_above_listed_staff_forCaption; covering_payments_of_salaries_to_the_above_listed_staff_forCaptionLbl)
                {
                }
                column(Please_credit_their_accounts_accordingly_Caption; Please_credit_their_accounts_accordingly_CaptionLbl)
                {
                }
                column(Approved_By__Chief_Executive_OfficerCaption; Approved_By__Chief_Executive_OfficerCaptionLbl)
                {
                }
                column(Approved_By__AccountantCaption; Approved_By__AccountantCaptionLbl)
                {
                }
                column(Approved_By__HR___Admin_ManagerCaption; Approved_By__HR___Admin_ManagerCaptionLbl)
                {
                }
                column(NationalID_Employee; Employee."National ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if BankTable.Get(Employee."Bank Code") then begin //SNG 080611 Make sure employee has bank code setup

                        BankName := BankTable.Name;
                        BranchName := BankTable.Branch;

                        Name := Employee.FullName;

                        if Header.Get(Periods."Period ID", Employee."No.") then begin
                            //filter by header mode of payment
                            if Header."Mode of Payment" <> '' then begin
                                if Header."Mode of Payment" <> ModeOfPayment then
                                    CurrReport.Skip;
                            end else begin
                                if Employee."Mode of Payment" <> ModeOfPayment then
                                    CurrReport.Skip;
                            end;
                            //----

                            Header.CalcFields("Total Payable (LCY)", "Total Deduction (LCY)", "Total Rounding Pmts (LCY)", "Total Rounding Ded (LCY)");
                            Amount := Header."Total Payable (LCY)" + Header."Total Rounding Pmts (LCY)" - (Header."Total Deduction (LCY)" +
                              Header."Total Rounding Ded (LCY)");
                            if Amount < 0 then
                                CurrReport.Skip
                            else
                                TotalAmount := TotalAmount + Amount;
                        end else
                            CurrReport.Skip;

                        EmpCount := EmpCount + 1;
                    end
                    else
                        Error(Employee."First Name" + ' ' + Employee."Middle Name" +
                        '\Employee No. ' + Employee."No." + '\Does not seem to have a bank Code setup');

                end;

                trigger OnPreDataItem()
                begin
                    EmpCount := 0;
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    //SETRANGE(Employee."Mode of Payment", ModeOfPayment);
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
                        ApprovedByCaption := 'Approved By: GM FINANCE: ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end;

                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalAmount := 0;
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
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        //SNG 080611 Enable user to dynamicaly select the Mode of Payment
        Message('Select The Bank Payment Option ');
        if ACTION::LookupOK = PAGE.RunModal(PAGE::"Mode of Payment", gvPayment) then
            ModeOfPayment := gvPayment.Code
        else
            Error('Please Select a mode of payment');
    end;

    trigger OnPreReport()
    begin
        gsSegmentPayrollData;
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        Header: Record "Payroll Header";
        BankTable: Record "Employee Bank Account";
        Name: Text[60];
        Amount: Decimal;
        TotalAmount: Decimal;
        Emplo: Record Employee;
        BankName: Text[50];
        BranchName: Text[50];
        PeriodName: Text[50];
        CompName: Text[50];
        EmpCount: Integer;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        gvPayment: Record "Mode of Payment";
        ModeOfPayment: Code[20];
        CompNameCaptionLbl: Label 'Bank Schedule for: ';
        Periods_DescriptionCaptionLbl: Label 'Bank Credit Transfer List For';
        Period_StatusCaptionLbl: Label 'Period Status';
        Employee_AmountCaptionLbl: Label 'Amount';
        Employee_NameCaptionLbl: Label 'Name';
        BranchNameCaptionLbl: Label 'Branch';
        BankNameCaptionLbl: Label 'Bank';
        TotalAmountCaptionLbl: Label 'Total Amount';
        Please_recieve_cheque_number___________________________________________CaptionLbl: Label 'Please recieve cheque number __________________________________________';
        for_ShsCaptionLbl: Label 'for Shs';
        covering_payments_of_salaries_to_the_above_listed_staff_forCaptionLbl: Label ', covering payments of salaries to the above listed staff for';
        Please_credit_their_accounts_accordingly_CaptionLbl: Label 'Please credit their accounts accordingly.';
        Approved_By__Chief_Executive_OfficerCaptionLbl: Label 'Approved By: Chief Executive Officer';
        Approved_By__AccountantCaptionLbl: Label 'Approved By: Accountant';
        Approved_By__HR___Admin_ManagerCaptionLbl: Label 'Approved By: HR / Admin Manager';
        CompanyInfo: Record "Company Information";
        nssf: Decimal;
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

