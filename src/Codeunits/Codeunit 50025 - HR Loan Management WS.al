codeunit 50025 "HR Loan Management WS"
{

    trigger OnRun()
    begin
        Message(SendLoanApprovalRequest('SADVN00128'));
        //CreateEmployeeLoanApplication('NWC/061','SADVNCE',23450,3,'10-2020','test');
    end;

    var
        Employee: Record Employee;
        EmployeeLoanApplications: Record "Employee Loan Applications";
        EmployeeLoanProducts: Record "Employee Loan Products";
        HumanResourcesSetup: Record "Human Resources Setup";
        SERVERDIRECTORYPATH: Label 'C:\inetpub\wwwroot\ICDC\TenantData';
        TxtCharsToKeep: Label 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.@';
        Text_0001: Label 'A payment  %1  voucher will be generated for this disbursement. Continue?';
        Text_0002: Label 'Payment voucher no.'' %1 successfully created for disbursement no. %2';
        Text_0003: Label 'You cannot apply an amount higher than %1  for loan product: %1';
        Text_0004: Label 'The loan limit amounts have not been setup for loan product: %1  job grade: %2';
        Text_0005: Label 'Your salary cannot support the repayment of %1, the net salary will be less than 1/3 of your basic salary %2';
        Text_0006: Label 'The amount applied cannot be higher than %1  times you monthly salary.';
        Text_0007: Label '%1 has not been attached., this is a required document.';
        Text_0008: Label 'The following document has not been attached. %1, this is a required document.';
        Text_0009: Label 'Applied Amount must be greater than 0';
        Text_0030: Label 'Kindly recommend to the Executive Director and attach a valuation report where applicable.<br> Loan Application details:<br>';
        Text_0031: Label 'Loan Application No. <br> Product Code:';
        ApprovalEntry: Record "Approval Entry";
        Dates: Codeunit Dates;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
        ApprovalsMgmtMain: Codeunit "Approvals Mgmt.";

        Text_0010: Label 'Retirement date cannot be earlier than loan repayment end date';
        PayrollPeriods: Record "Payroll Period";
        LoansAdvances: Record "Salary Advance";
        LoanEntry: Record "Loan Entry";
        PayrollPeriodsII: Record Periods;

    [Scope('Personalization')]
    procedure GetLoanAdvancesList(var Loans: XMLport Loans; EmployeeNo: Code[20])
    begin
        if EmployeeNo <> '' then begin
            LoansAdvances.Reset;
            LoansAdvances.SetFilter(Employee, EmployeeNo);
            if LoansAdvances.FindFirst then;
            Loans.SetTableView(LoansAdvances);
        end
    end;

    [Scope('Personalization')]
    procedure GetLoanAdvancesListStatus(var Loans: XMLport Loans; EmployeeNo: Code[20]; LoanStatus: Option Open,"Pending Approval",Approved,Rejected)
    begin
        LoansAdvances.Reset;
        LoansAdvances.SetRange(Status, LoanStatus);
        if EmployeeNo <> '' then begin

            LoansAdvances.SetFilter(Employee, EmployeeNo);
            if LoansAdvances.FindFirst then;
            Loans.SetTableView(LoansAdvances);
        end
    end;

    [Scope('Personalization')]
    procedure GetLoantypesList(var LoanTypes: XMLport "Loan Types")
    begin
    end;

    [Scope('Personalization')]
    procedure GetLoanEntryList(var LoanEntryxml: XMLport "Loan Entry"; LoanID: Code[20])
    begin
        if LoanID <> '' then begin
            LoanEntry.Reset;
            LoanEntry.SetFilter("Loan ID", LoanID);
            if LoanEntry.FindFirst then;
            LoanEntryxml.SetTableView(LoanEntry);
        end
    end;

    [Scope('Personalization')]
    procedure GetLoanStartPeriods(var PayrollPeriodsXml: XMLport PayrollPeriods)
    begin
    end;

    [Scope('Personalization')]
    procedure CheckOpenLoanApplicationExists("EmployeeNo.": Code[20]) OpenLoanApplicationExist: Boolean
    begin
        OpenLoanApplicationExist := false;
        LoansAdvances.Reset;
        LoansAdvances.SetRange(LoansAdvances.Employee, "EmployeeNo.");
        /*IF LoansAdvances.FINDFIRST THEN BEGIN
          IF (LoansAdvances.Status=LoansAdvances.Status::Open) OR (LoansAdvances.Status=LoansAdvances.Status::"Pending Approval") OR (LoansAdvances.Status=LoansAdvances.Status::Submitted)
        THEN
          OpenLoanApplicationExist:=TRUE;
        END;
        */

    end;

    [Scope('Personalization')]
    procedure CheckLoanApplicationExists("LoanApplicationNo.": Code[20]; "EmployeeNo.": Code[20]) LoanApplicationExist: Boolean
    begin
        LoanApplicationExist := false;
        LoansAdvances.Reset;
        LoansAdvances.SetRange(LoansAdvances.Employee, "EmployeeNo.");
        LoansAdvances.SetRange(LoansAdvances.ID, "LoanApplicationNo.");
        if LoansAdvances.FindFirst then begin
            LoanApplicationExist := true;
        end;
    end;

    [Scope('Personalization')]
    procedure CreateEmployeeLoanApplication("EmployeeNo.": Code[20]; LoanType: Code[20]; PrincipalAmount: Decimal; NoofInstallments: Integer; StartPeriod: Code[20]; Purpose: Text; FileName: Text; AdvanceType: Option " ","Laptop Advance","Phone Advance","Other Advance") ReturnValue: Text
    var
        LoansGeneralSetup: Record "Employee Loans General Setup";
        Employee: Record Employee;
    begin
        ReturnValue := '';
        Employee.Get("EmployeeNo.");
        PayrollPeriodsII.Reset;
        PayrollPeriodsII.SetRange("Payroll Code", Employee."Payroll Code");
        PayrollPeriodsII.SetRange(Status, PayrollPeriodsII.Status::Open);
        PayrollPeriodsII.FindLast;
        LoansAdvances.Init;
        //LoansAdvances.=TODAY;
        LoansAdvances.Type := LoansAdvances.Type::Advance;
        LoansAdvances.Employee := "EmployeeNo.";
        LoansAdvances."Payroll Code" := Employee."Payroll Code";
        LoansAdvances.Validate(LoansAdvances.Employee);
        //LoansAdvances.VALIDATE("Loan Types",LoanType);
        //LoansAdvances."Loan Types":='ADVANCE CMT';
        LoansAdvances.Validate(Principal, PrincipalAmount);
        LoansAdvances.Validate(Installments, NoofInstallments);
        //LoansAdvances.VALIDATE("Start Period",StartPeriod);
        LoansAdvances."File Name" := FileName;
        LoansAdvances."Purpose of Salary Advance" := Purpose;
        LoansAdvances.Validate("Advance Type", AdvanceType);
        LoansAdvances.Validate("Start Period", PayrollPeriodsII."Period ID");
        if LoansAdvances.Insert(true) then begin
            ReturnValue := '200: Loan No ' + Format(LoansAdvances.ID) + ' Successfully Created';
        end
        else
            ReturnValue := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure GetEmployeeLoanApplicationStatus("LoanApplicationNo.": BigInteger) LoanApplicationStatus: Text
    begin
        /*LoanApplicationStatus:='';
        LoansAdvances.RESET;
        LoansAdvances.SETRANGE(LoansAdvances.ID,"LoanApplicationNo.");
        IF LoansAdvances.FINDFIRST THEN BEGIN
          LoanApplicationStatus:=FORMAT(LoansAdvances.Status);
        END;
        */

    end;

    [Scope('Personalization')]
    procedure GetOpenEmployeeLoanApplicationNo("EmployeeNo.": Code[20]) "ApplicationNo.": Code[20]
    begin
        "ApplicationNo." := '';
        /*LoansAdvances.RESET;
        LoansAdvances.SETRANGE(LoansAdvances.Employee,"EmployeeNo.");
        LoansAdvances.SETRANGE(LoansAdvances.Status,LoansAdvances.Status::Open);
        IF LoansAdvances.FINDFIRST THEN BEGIN
          "ApplicationNo.":=LoansAdvances."No.";
        END;
        */

    end;

    [Scope('Personalization')]
    procedure GetEmployeeLoanApplicationNo("EmployeeNo.": Code[20]) "ApplicationNo.": Code[20]
    begin
        /*"ApplicationNo.":='';
        LoansAdvances.RESET;
        LoansAdvances.SETRANGE(LoansAdvances."No.","ApplicationNo.");
        LoansAdvances.SETRANGE(LoansAdvances.Status,LoansAdvances.Status::Open);
        IF LoansAdvances.FINDFIRST THEN BEGIN
          "ApplicationNo.":=LoansAdvances."No.";
        END;*/

    end;

    [Scope('Personalization')]
    procedure GetEmployeeLoanAccountNo("EmployeeNo.": Code[20]) "LoanAccountNo.": Code[20]
    var
        EmployeeLoanAccounts: Record "Employee Loan Accounts";
    begin
        "LoanAccountNo." := '';
        EmployeeLoanAccounts.Reset;
        EmployeeLoanAccounts.SetRange(EmployeeLoanAccounts."No.", "LoanAccountNo.");
        if EmployeeLoanAccounts.FindFirst then begin
            "LoanAccountNo." := EmployeeLoanAccounts."No.";
        end;
    end;

    [Scope('Personalization')]
    procedure ModifyEmployeeLoanApplication(LoanID: BigInteger; "EmployeeNo.": Code[20]; LoanType: Code[20]; PrincipalAmount: Decimal; NoofInstallments: Integer; StartPeriod: Code[20]; FileName: Text; AdvanceType: Option " ","Laptop Advance","Phone Advance","Other Advance") ReturnValue: Text
    var
        LoansGeneralSetup: Record "Employee Loans General Setup";
    begin
        ReturnValue := '';

        if LoansAdvances.Get("EmployeeNo.") then begin
            //LoansAdvances.Status:=TODAY;
            //LoansAdvances.Employee:="EmployeeNo.";
            //LoansAdvances.VALIDATE(LoansAdvances.Employee);
            //LoansAdvances.VALIDATE("Loan Types",LoanType);
            LoansAdvances.Validate(Principal, PrincipalAmount);
            LoansAdvances.Validate(Installments, NoofInstallments);
            LoansAdvances.Validate("Start Period", StartPeriod);
            LoansAdvances.Validate("Advance Type", AdvanceType);
            LoansAdvances."File Name" := FileName;
            if LoansAdvances.Modify then
                ReturnValue := '200: Loan No ' + Format(LoansAdvances.ID) + ' Successfully modified'
            else
                ReturnValue := '400: modify error' + GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400 no id:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure SendLoanApprovalRequest("LoansAdvancesNo.": Code[20]) LoansAdvancesApprovalRequestSent: Text
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        LoansAdvancesApprovalRequestSent := '';

        LoansAdvances.Reset;
        if LoansAdvances.Get("LoansAdvancesNo.") then begin

            LoansAdvances.TestField("Installment Amount");
            LoansAdvances.TestField(Principal);
            LoansAdvances.TestField(Employee);
            LoansAdvances.TestField("Start Period");
            LoansAdvances.TestField(Status, LoansAdvances.Status::Open);

            if (LoansAdvances."Advance Type" = LoansAdvances."Advance Type"::"Salary Advance") and (LoansAdvances."Net Pay after Advance" < LoansAdvances."1/3 Basic Pay") then begin
                // IF LoansAdvances.Employee <> '0481' THEN
                Error('This will violate a third rule,Kindly talk to HR Manager or Reduce the amount you are Requesting');
            end else if (LoansAdvances."Advance Type" = LoansAdvances."Advance Type"::"Salary in Advance") and (LoansAdvances."Net Pay after Advance" <> 0) then begin
                //IF LoansAdvances.Employee <> '0481' THEN
                Error('This will violate a third rule,Kindly talk to HR Manager');
            end else begin

                ApprovalsMgmt.OnSendSalaryAdvanceForApproval(LoansAdvances);
                Commit;
                ApprovalEntry.Reset;
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", LoansAdvances.ID);
                ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
                if ApprovalEntry.FindFirst then
                    LoansAdvancesApprovalRequestSent := '200: Approval Request sent Successfully'
                else
                    LoansAdvancesApprovalRequestSent := '400:' + GetLastErrorCode + '-' + GetLastErrorText;

            end;

        end;
    end;

    procedure CancelLoanApprovalRequest("LoansAdvancesNo.": Code[20]) LoansAdvancesApprovalRequestCanceled: Text
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        LoansAdvancesApprovalRequestCanceled := '';

        LoansAdvances.Reset;
        if LoansAdvances.Get("LoansAdvancesNo.") then begin
            ApprovalsMgmt.OnCancelSalaryAdvanceApprovalRequest(LoansAdvances);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", LoansAdvances.ID);
            if ApprovalEntry.FindLast then begin
                if ApprovalEntry.Status = ApprovalEntry.Status::Canceled then
                    LoansAdvancesApprovalRequestCanceled := '200: Approval Request Cancelled Successfully'
                else
                    LoansAdvancesApprovalRequestCanceled := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
            end;
        end;
    end;

    [Scope('Personalization')]
    procedure ApproveLoanApplication("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]) Approved: Text
    var
        "EntryNo.": Integer;
    begin
        Approved := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.ApproveApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
        if ApprovalEntry.FindFirst then
            Approved := '200: Salary Advance Approved Successfully '
        else
            Approved := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure RejectLoanApplication("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]; Rejectioncomments: Text) Rejected: Text
    var
        "EntryNo.": Integer;
    begin
        Rejected := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry."Rejection Comments" := Rejectioncomments;
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.RejectApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Rejected);
        if ApprovalEntry.FindFirst then
            Rejected := '200: Salary Advance Rejected Successfully '
        else
            Rejected := '400:' + GetLastErrorCode + '-' + GetLastErrorText;

        //**************************************** HR Leave Reimbursement ********************************************************************************************************************************************************
    end;

    [Scope('Personalization')]
    procedure GetEmployeeLoanApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; EmployeeNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::"Salary Advance");
        if EmployeeNo <> '' then begin
            Employee.Get(EmployeeNo);
            Employee.TestField("User ID");
            ApprovalEntry.SetRange("Approver ID", Employee."User ID");

        end;
        //ApprovalEntry.SETRANGE("Approver ID",'77tyty');
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetLoanpprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; LeaveNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::"Salary Advance");
        if LeaveNo <> '' then begin
            ApprovalEntry.SetRange("Document No.", LeaveNo);
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetLoanAdvancesDocument(var Loans: XMLport Loans; HeaderNo: Code[20])
    begin

        LoansAdvances.Reset;
        if HeaderNo <> '' then begin
            LoansAdvances.SetFilter(ID, HeaderNo);
        end;
        if LoansAdvances.FindFirst then;
        Loans.SetTableView(LoansAdvances);
    end;
}

