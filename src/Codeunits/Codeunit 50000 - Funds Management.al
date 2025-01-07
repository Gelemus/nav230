codeunit 50000 "Funds Management"
{

    trigger OnRun()
    begin
    end;

    var
        TaxCodes: Record "Funds Tax Code";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        DocPrint: Codeunit "Document-Print";
        ReversalEntry: Record "Reversal Entry";
        GLEntry: Record "G/L Entry";
        FundsSetup: Record "Funds General Setup";
        CustEntry: Record "Cust. Ledger Entry";
        CustEntry2: Record "Cust. Ledger Entry";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        Text0006: Label 'There is no budgeted amount for the Gl %1,%2 kindly request the accounts for assistance';
        Text0010: Label 'There is no budgeted amount for the Gl %1,%2 kindly request the accounts for assistance';
        Text0011: Label 'The Amount On imprest line No %1  %2 %3  Exceeds The Budget By %4';
        PAYMENTJNL: Label 'PAYMENTJNL';
        RECEIPTJNL: Label 'RECEIPTJNL';
        TRANJNL: Label 'TRANJNL';
        IMPJNL: Label 'IMPJNL';
        IMPSURRJNL: Label 'IMPSURRJNL';
        ImprestHeader: Record "Imprest Header";
        //SMTPMail: Codeunit "SMTP Mail";
        //SMTP: Record "SMTP Mail Setup";
        ChequeRegisterLines: Record "Cheque Register Lines";
        "HRLoanMgt.": Codeunit "HR Loan Management";
        EmployeeLoanDisbursement: Record "Employee Loan Disbursement";
        HRLoanProducts: Record "Employee Loan Products";
        FundsGeneralSetup: Record "Funds General Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        Text_0001: Label 'Loan %1 Repayment';
        FundsTransactionCode: Record "Funds Transaction Code";
        Text_0002: Label 'Loan  %1  repayment';
        TransactionNo: Integer;
        DocNo: Code[20];
        InvNo: Code[20];
        TotalDisbursedAmount: Decimal;
        Amount1: Decimal;
        LoansAdvancesRec: Record "Loans/Advances";
        SalaryAdvanceRec: Record "Salary Advance";
        LoanTypesRec: Record "Loan Types";
        LoansAdvancesCopy: Record "Loans/Advances";
        gvPayrollUtilities: Codeunit "Payroll Posting";
        BCSetup: Record "Budget Control Setup";
        BudgetGL: Code[30];
        Text0004: Label 'The  Date From %1 and Date To %2 In The Imprest Does Not Fall Within Budget Dating %3 - %4';
        FundsTransactionCodei: Record "Funds Transaction Code";
        PurchaseRequisition: Record "Purchase Requisitions";
        Text0005: Label 'The Imprest  %1 was Already Voted Using Purchase Requisition %2';

    procedure PostPayment("Payment Header": Record "Payment Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        PaymentLine: Record "Payment Line";
        PaymentHeader: Record "Payment Header";
        SourceCode: Code[20];
        BankLedgerEntries: Record "Bank Account Ledger Entry";
        PaymentLine2: Record "Payment Line";
        PaymentHeader2: Record "Payment Header";
        DocumentExist: Label 'Payment Document is already posted, Document No.:%1 already exists in Bank No:%2';
        EmployeeLoanAccounts: Record "Employee Loan Accounts";
        LoanRepayment: Record "Employee Repayment Schedule";
        PaymentCodes: Record "Funds Transaction Code";
        EmployeeRec: Record Employee;
        LoansAdvancesRecCopy: Record "Loans/Advances";
    begin
        PaymentHeader.TransferFields("Payment Header", true);
        SourceCode := PAYMENTJNL;

        BankLedgerEntries.Reset;
        BankLedgerEntries.SetRange(BankLedgerEntries."Document No.", PaymentHeader."No.");
        BankLedgerEntries.SetRange(BankLedgerEntries.Reversed, false);
        if BankLedgerEntries.FindFirst then begin
            Error(DocumentExist, PaymentHeader."No.", PaymentHeader."Bank Account No.");
        end;

        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", "Journal Template");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        LineNo := 1000;
        //*********************************************Add Payment Header***************************************************************//
        PaymentHeader.CalcFields("Net Amount", "WithHolding Tax Amount", "Withholding VAT Amount");
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate("Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate("Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := PaymentHeader."No.";
        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
        GenJnlLine."Cheque No." := PaymentHeader."Cheque No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := PaymentHeader."Bank Account No.";
        GenJnlLine.Validate("Account No.");
        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
        GenJnlLine.Validate("Currency Code");
        GenJnlLine.Amount := -(PaymentHeader."Net Amount");  //Credit Amount
        GenJnlLine.Validate(Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate("Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
        GenJnlLine.Validate("Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
        GenJnlLine.Validate("Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := UpperCase(CopyStr(PaymentHeader.Description, 1, 249));
        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
        GenJnlLine.Payee := PaymentHeader."Payee Name";
        GenJnlLine.Validate(Description);
        if PaymentHeader."Loan No." <> '' then begin
            GenJnlLine."Investment Account No." := PaymentHeader."Loan No.";
            GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Loan Disbursement";
        end;
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;

        //wvat
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate("Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate("Journal Batch Name");
        GenJnlLine."Line No." := 100002;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := PaymentHeader."No.";
        GenJnlLine."External Document No." := PaymentHeader."Cheque No. - WHVAT";
        GenJnlLine."Cheque No." := PaymentHeader."Cheque No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := PaymentHeader."Bank Account No.";
        GenJnlLine.Validate("Account No.");
        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
        GenJnlLine.Validate("Currency Code");
        GenJnlLine.Amount := -(PaymentHeader."Withholding VAT Amount");  //Credit Amount
        GenJnlLine.Validate(Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate("Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
        GenJnlLine.Validate("Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
        GenJnlLine.Validate("Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := UpperCase(CopyStr('W/VAT:' + Format(PaymentHeader."No.") + '::' + Format(PaymentHeader."Payee Name"), 1, 249));
        //GenJnlLine.Description:=UPPERCASE(COPYSTR(PaymentHeader.Description,1,249));
        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
        GenJnlLine.Payee := PaymentHeader."Payee Name";
        GenJnlLine.Validate(Description);
        if PaymentHeader."Loan No." <> '' then begin
            GenJnlLine."Investment Account No." := PaymentHeader."Loan No.";
            GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Loan Disbursement";
        end;
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;

        //wtax
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate("Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate("Journal Batch Name");
        GenJnlLine."Line No." := 100006;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := PaymentHeader."No.";
        GenJnlLine."External Document No." := PaymentHeader."Cheque No. - WHTAX";
        GenJnlLine."Cheque No." := PaymentHeader."Cheque No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := PaymentHeader."Bank Account No.";
        GenJnlLine.Validate("Account No.");
        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
        GenJnlLine.Validate("Currency Code");
        GenJnlLine.Amount := -(PaymentHeader."WithHolding Tax Amount");  //Credit Amount
        GenJnlLine.Validate(Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate("Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
        GenJnlLine.Validate("Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
        GenJnlLine.Validate("Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := UpperCase(CopyStr('W/TAX:' + Format(PaymentHeader."No.") + '::' + Format(PaymentHeader."Payee Name"), 1, 249));
        //GenJnlLine.Description:=UPPERCASE(COPYSTR('W/TAX:' + FORMAT(PaymentHeader."No.") + '::' + FORMAT(PaymentHeader."Payee Name"));
        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
        GenJnlLine.Payee := PaymentHeader."Payee Name";
        GenJnlLine.Validate(Description);
        if PaymentHeader."Loan No." <> '' then begin
            GenJnlLine."Investment Account No." := PaymentHeader."Loan No.";
            GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Loan Disbursement";
        end;
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
        //************************************************End Add to Bank***************************************************************//

        //***********************************************Add Payment Lines**************************************************************//
        PaymentLine.Reset;
        PaymentLine.SetRange("Document No.", PaymentHeader."No.");
        PaymentLine.SetFilter("Total Amount", '<>%1', 0);
        if PaymentLine.FindSet then begin
            repeat
                //****************************************Add Line Amounts***********************************************************//
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate("Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate("Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                GenJnlLine."Document No." := PaymentLine."Document No.";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Account Type" := PaymentLine."Account Type";
                GenJnlLine."Account No." := PaymentLine."Account No.";
                GenJnlLine.Validate("Account No.");
                GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine.Amount := PaymentLine."Net Amount";  //Debit Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                if PaymentHeader."Loan No." <> '' then begin
                    GenJnlLine."Investment Account No." := PaymentHeader."Loan No.";
                    GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Loan Disbursement";
                end;
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                GenJnlLine.Validate("Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PaymentLine."Global Dimension 2 Code";
                GenJnlLine.Validate("Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PaymentLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PaymentLine."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, PaymentLine."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, PaymentLine."Shortcut Dimension 6 Code");
                GenJnlLine.ValidateShortcutDimCode(7, PaymentLine."Shortcut Dimension 7 Code");
                GenJnlLine.ValidateShortcutDimCode(8, PaymentLine."Shortcut Dimension 8 Code");
                GenJnlLine.Description := UpperCase(CopyStr(PaymentLine.Description, 1, 249));
                GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
                GenJnlLine.Validate(Description);
                GenJnlLine.Payee := PaymentHeader."Payee Name";
                GenJnlLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                GenJnlLine.Validate("Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                GenJnlLine."Employee Transaction Type" := PaymentLine."Employee Transaction Type";
                if PaymentHeader."Loan No." <> '' then begin
                    GenJnlLine."Investment Account No." := PaymentHeader."Loan No.";
                    GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Loan Disbursement";
                end;
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;
                //*************************************End Add Line Amounts**********************************************************//

                //**************************************Add W/TAX Amounts************************************************************//
                if PaymentLine."Withholding Tax Code" <> '' then begin
                    TaxCodes.Reset;
                    TaxCodes.SetRange("Tax Code", PaymentLine."Withholding Tax Code");
                    if TaxCodes.FindFirst then begin
                        TaxCodes.TestField("Account No.");
                        /*LineNo:=LineNo+1;
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name":="Journal Template";
                        GenJnlLine.VALIDATE("Journal Template Name");
                        GenJnlLine."Journal Batch Name":="Journal Batch";
                        GenJnlLine.VALIDATE("Journal Batch Name");
                        GenJnlLine."Line No.":=LineNo;
                        GenJnlLine."Source Code":=SourceCode;
                        GenJnlLine."Posting Date":=PaymentHeader."Posting Date";
                        GenJnlLine."Document Type":=GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No.":=PaymentLine."Document No.";
                        GenJnlLine."External Document No.":=PaymentHeader."Cheque No. - WHTAX";
                        GenJnlLine."Account Type":=GenJnlLine."Account Type"::"Bank Account";
                        GenJnlLine."Account No.":=PaymentHeader."Bank Account No.";
                        GenJnlLine.VALIDATE("Account No.");
                        GenJnlLine."Currency Code":=PaymentHeader."Currency Code";
                        GenJnlLine.VALIDATE("Currency Code");
                        GenJnlLine.Amount:=-(PaymentLine."Withholding Tax Amount");   //Credit Amount
                        GenJnlLine.VALIDATE(Amount);
                        GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No.":='';
                        GenJnlLine.VALIDATE("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code":=PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code":=PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3,PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4,PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5,PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6,PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description:=UPPERCASE(COPYSTR('W/TAX:' + FORMAT(PaymentLine."Document No.") + '::' + FORMAT(PaymentLine."Account Name"),1,249));
                        GenJnlLine.Description2:=UPPERCASE(COPYSTR(PaymentHeader."Payee Name",1,249));
                        GenJnlLine.Payee:=PaymentHeader."Payee Name";
                        IF GenJnlLine.Amount<>0 THEN
                          GenJnlLine.INSERT;*/

                        //W/TAX Balancing
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Cheque No. - WHTAX";
                        GenJnlLine."Account Type" := PaymentLine."Account Type";
                        GenJnlLine."Account No." := PaymentLine."Account No.";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Posting Group" := PaymentLine."Posting Group";
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine.Amount := PaymentLine."Withholding Tax Amount";   //Debit Amount
                        GenJnlLine.Validate(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UpperCase(CopyStr('W/TAX:' + Format(PaymentLine."Document No.") + '::' + Format(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));

                        GenJnlLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                        GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                        GenJnlLine.Validate("Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                        GenJnlLine."Employee Transaction Type" := PaymentLine."Employee Transaction Type";
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;
                    end;
                end;
                //****************************************End Add W/TAX Amounts************************************************************//

                //****************************************Add W/VAT Amounts***************************************************************//
                if PaymentLine."Withholding VAT Code" <> '' then begin
                    TaxCodes.Reset;
                    TaxCodes.SetRange("Tax Code", PaymentLine."Withholding VAT Code");
                    if TaxCodes.FindFirst then begin
                        TaxCodes.TestField("Account No.");
                        /*LineNo:=LineNo+1;
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name":="Journal Template";
                        GenJnlLine.VALIDATE("Journal Template Name");
                        GenJnlLine."Journal Batch Name":="Journal Batch";
                        GenJnlLine.VALIDATE("Journal Batch Name");
                        GenJnlLine."Line No.":=LineNo;
                        GenJnlLine."Source Code":=SourceCode;
                        GenJnlLine."Posting Date":=PaymentHeader."Posting Date";
                        GenJnlLine."Document Type":=GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No.":=PaymentLine."Document No.";
                        GenJnlLine."External Document No.":=PaymentHeader."Cheque No. - WHVAT";
                        GenJnlLine."Account Type":=GenJnlLine."Account Type"::"Bank Account";
                        GenJnlLine."Account No.":=PaymentHeader."Bank Account No.";
                        GenJnlLine.VALIDATE("Account No.");
                        GenJnlLine."Currency Code":=PaymentHeader."Currency Code";
                        GenJnlLine.VALIDATE("Currency Code");
                        GenJnlLine.Amount:=-(PaymentLine."Withholding VAT Amount");   //Credit Amount
                        GenJnlLine.VALIDATE(Amount);
                        GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No.":='';
                        GenJnlLine.VALIDATE("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code":=PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code":=PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3,PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4,PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5,PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6,PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description:=UPPERCASE(COPYSTR('W/VAT:' + FORMAT(PaymentLine."Document No.") + '::' + FORMAT(PaymentLine."Account Name"),1,249));
                        GenJnlLine.Description2:=UPPERCASE(COPYSTR(PaymentHeader."Payee Name",1,249));
                        GenJnlLine.Payee:=PaymentHeader."Payee Name";
                        IF GenJnlLine.Amount<>0 THEN
                          GenJnlLine.INSERT;
                          */
                        //W/VAT Balancing
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Cheque No. - WHVAT";
                        GenJnlLine."Account Type" := PaymentLine."Account Type";
                        GenJnlLine."Account No." := PaymentLine."Account No.";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Posting Group" := PaymentLine."Posting Group";
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine.Amount := PaymentLine."Withholding VAT Amount";   //Debit Amount
                        GenJnlLine.Validate(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UpperCase(CopyStr('W/VAT:' + Format(PaymentLine."Document No.") + '::' + Format(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
                        GenJnlLine.Payee := PaymentHeader."Payee Name";
                        GenJnlLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                        GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                        GenJnlLine.Validate("Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                        GenJnlLine."Employee Transaction Type" := PaymentLine."Employee Transaction Type";
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;
                    end;
                end;
                //***********************************End Add W/VAT Amounts*************************************************************//
                //salary Advance** create loan and pay
                if not Preview then begin
                    if PaymentLine."Payee Type" = PaymentLine."Payee Type"::"Salary Advance" then begin
                        SalaryAdvanceRec.Reset;
                        SalaryAdvanceRec.SetRange(ID, PaymentLine."Payee No.");
                        if SalaryAdvanceRec.FindFirst then begin
                            LoansAdvancesRec.Init;
                            LoansAdvancesRec.Type := LoansAdvancesRec.Type::Advance;
                            //Get Payroll code from employee
                            if EmployeeRec.Get(SalaryAdvanceRec.Employee) then
                                LoansAdvancesRec."Payroll Code" := EmployeeRec."Payroll Code"; //SNG 130611 payroll data segregation

                            LoansAdvancesRec.Employee := SalaryAdvanceRec.Employee;
                            LoansAdvancesRecCopy.Reset;
                            if LoansAdvancesCopy.FindLast then
                                LoansAdvancesRec.ID := LoansAdvancesCopy.ID + 1;
                            LoanTypesRec.Reset;
                            LoanTypesRec.SetRange(Type, LoanTypesRec.Type::Advance);
                            if LoanTypesRec.FindLast then
                                //updated on 30/06/2022 - loan type to select the one from the salary advance type
                                //LoansAdvancesRec."Loan Types":=LoanTypesRec.Code;
                                LoansAdvancesRec."Loan Types" := SalaryAdvanceRec."Loan Types";
                            LoansAdvancesRec.Validate(Principal, SalaryAdvanceRec.Principal);
                            LoansAdvancesRec."Principal (LCY)" := SalaryAdvanceRec."Principal (LCY)";
                            LoansAdvancesRec.Validate("Installment Amount", SalaryAdvanceRec."Installment Amount");
                            LoansAdvancesRec.Validate("Installment Amount (LCY)", SalaryAdvanceRec."Installment Amount (LCY)");
                            LoansAdvancesRec."Interest Rate" := SalaryAdvanceRec."Interest Rate";
                            LoansAdvancesRec.Validate(Installments, SalaryAdvanceRec.Installments);
                            LoansAdvancesRec.Validate("Start Period", SalaryAdvanceRec."Start Period");
                            LoansAdvancesRec.Validate("Currency Code", SalaryAdvanceRec."Currency Code");
                            LoansAdvancesRec.Employee := SalaryAdvanceRec.Employee;//PaymentLine."Account No.";
                            LoansAdvancesRec."Payments Method" := SalaryAdvanceRec."Payments Method";

                            LoansAdvancesRec."Salary Advance Request No" := SalaryAdvanceRec.ID;
                            LoansAdvancesRec.Insert(true);
                            //create and pay loan
                            LoansAdvancesCopy.Reset;
                            LoansAdvancesCopy.SetRange("Salary Advance Request No", SalaryAdvanceRec.ID);
                            if LoansAdvancesCopy.FindLast then begin
                                LoansAdvancesCopy.CreateLoan;
                                LoansAdvancesCopy.PayLoan;

                                //modify pay to employee
                                SalaryAdvanceRec."Paid to Employee" := true;
                                SalaryAdvanceRec.Modify;


                            end
                            else
                                Error('Loan not created');

                        end;
                    end;
                end;
            until PaymentLine.Next = 0;
        end;

        //*********************************************End Add Payment Lines************************************************************//
        Commit;
        //********************************************Post the Journal Lines************************************************************//
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", "Journal Template");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances

        if not Preview then begin
            //Post the Journal Lines
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            BankLedgerEntries.Reset;
            BankLedgerEntries.SetRange("Document No.", PaymentHeader."No.");
            if BankLedgerEntries.FindFirst then begin
                PaymentHeader2.Reset;
                PaymentHeader2.SetRange("No.", PaymentHeader."No.");
                if PaymentHeader2.FindFirst then begin
                    PaymentHeader2.Status := PaymentHeader2.Status::Posted;
                    PaymentHeader2.Validate(PaymentHeader2.Status);
                    PaymentHeader2.Posted := true;
                    PaymentHeader2."Posted By" := UserId;
                    PaymentHeader2."Date Posted" := Today;
                    PaymentHeader2."Time Posted" := Time;
                    if PaymentHeader2.Modify then
                        MarkImprestAsPosted(PaymentHeader."No.");
                end;
            end;
            Commit;
            //***********************************************End Update Document************************************************************//
        end else begin
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange("Journal Template Name", "Journal Template");
            GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
            if GenJnlLine.FindSet then begin
                GenJnlPost.Preview(GenJnlLine);
            end;
            //**********************************************End Preview Posting*************************************************************//
        end;

        BankLedgerEntries.Reset;
        BankLedgerEntries.SetRange("Document No.", PaymentHeader."No.");
        if BankLedgerEntries.FindFirst then begin
            ChequeRegisterLines.Reset;
            ChequeRegisterLines.SetRange(ChequeRegisterLines."Cheque No.", PaymentHeader."Cheque No.");
            if ChequeRegisterLines.FindFirst then begin
                ChequeRegisterLines."Assigned to PV" := true;
                ChequeRegisterLines."PV Posted with Cheque" := true;
                ChequeRegisterLines."Payee No" := PaymentHeader."Payee No.";
                ChequeRegisterLines.Payee := PaymentHeader."Payee Name";
                ChequeRegisterLines."PV No" := PaymentHeader."No.";
                ChequeRegisterLines."PV Description" := PaymentHeader.Description;
                ChequeRegisterLines."PV Prepared By" := PaymentHeader."User ID";
                ChequeRegisterLines.Modify;
            end;
        end;

    end;

    procedure PostHRLoanPayment("Payment Header": Record "Payment Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        PaymentLine: Record "Payment Line";
        PaymentHeader: Record "Payment Header";
        SourceCode: Code[20];
        BankLedgerEntries: Record "Bank Account Ledger Entry";
        PaymentLine2: Record "Payment Line";
        PaymentHeader2: Record "Payment Header";
        DocumentExist: Label 'Payment Document is already posted, Document No.:%1 already exists in Bank No:%2';
        EmployeeLoanAccounts: Record "Employee Loan Accounts";
        LoanRepayment: Record "Employee Repayment Schedule";
        PaymentCodes: Record "Funds Transaction Code";
        EmployeeLoanProducts: Record "Employee Loan Products";
    begin
        PaymentHeader.TransferFields("Payment Header", true);
        SourceCode := PAYMENTJNL;

        EmployeeLoanAccounts.Get(PaymentHeader."Loan No.");

        EmployeeLoanProducts.Get(EmployeeLoanAccounts."Loan Product Code");

        BankLedgerEntries.Reset;
        BankLedgerEntries.SetRange(BankLedgerEntries."Document No.", PaymentHeader."No.");
        BankLedgerEntries.SetRange(BankLedgerEntries.Reversed, false);
        if BankLedgerEntries.FindFirst then begin
            Error(DocumentExist, PaymentHeader."No.", PaymentHeader."Bank Account No.");
        end;

        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", "Journal Template");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        LineNo := 1000;
        //*********************************************Add Payment Header***************************************************************//
        PaymentHeader.CalcFields("Net Amount");
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate("Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate("Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := PaymentHeader."No.";
        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
        GenJnlLine."Cheque No." := PaymentHeader."Cheque No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := PaymentHeader."Bank Account No.";
        GenJnlLine.Validate("Account No.");
        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
        GenJnlLine.Validate("Currency Code");
        GenJnlLine.Amount := -(PaymentHeader."Net Amount");  //Credit Amount
        GenJnlLine.Validate(Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate("Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
        GenJnlLine.Validate("Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
        GenJnlLine.Validate("Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
        //GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
        //GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := UpperCase(CopyStr(PaymentHeader.Description, 1, 249));
        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
        GenJnlLine.Validate(Description);
        if PaymentHeader."Loan No." <> '' then begin
            GenJnlLine."Investment Account No." := PaymentHeader."Loan No.";
            GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Loan Disbursement";
        end;
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
        //************************************************End Add to Bank***************************************************************//

        //***********************************************Add Payment Lines**************************************************************//
        PaymentLine.Reset;
        PaymentLine.SetRange("Document No.", PaymentHeader."No.");
        PaymentLine.SetFilter("Total Amount", '<>%1', 0);
        if PaymentLine.FindSet then begin
            repeat
                //****************************************Add Line Amounts***********************************************************//
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate("Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate("Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                GenJnlLine."Document No." := PaymentLine."Document No.";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                GenJnlLine."Account No." := EmployeeLoanAccounts."Employee No.";
                GenJnlLine."Investment Account No." := PaymentHeader."Loan No.";
                GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Loan Disbursement";
                GenJnlLine.Validate("Account No.");
                GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine.Amount := PaymentLine."Total Amount";  //Debit Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Posting Group" := EmployeeLoanProducts."Disbursement Payment Code";
                GenJnlLine.Validate(GenJnlLine."Posting Group");
                GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                GenJnlLine.Validate("Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PaymentLine."Global Dimension 2 Code";
                GenJnlLine.Validate("Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PaymentLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PaymentLine."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, PaymentLine."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, PaymentLine."Shortcut Dimension 6 Code");
                GenJnlLine.ValidateShortcutDimCode(7, PaymentLine."Shortcut Dimension 7 Code");
                GenJnlLine.ValidateShortcutDimCode(8, PaymentLine."Shortcut Dimension 8 Code");
                GenJnlLine.Description := UpperCase(CopyStr(PaymentHeader.Description, 1, 249));
                GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
                GenJnlLine.Validate(Description);
                GenJnlLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                GenJnlLine.Validate("Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                GenJnlLine."Employee Transaction Type" := PaymentLine."Employee Transaction Type";
                GenJnlLine."Investment Account No." := PaymentHeader."Loan No.";
                GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Loan Disbursement";
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;
            //*************************************End Add Line Amounts**********************************************************//
            until PaymentLine.Next = 0;
        end;
        //*********************************************End Add Payment Lines************************************************************//
        Commit;
        //********************************************Post the Journal Lines************************************************************//
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", "Journal Template");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        if not Preview then begin
            //Post the Journal Lines
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            BankLedgerEntries.Reset;
            BankLedgerEntries.SetRange("Document No.", PaymentHeader."No.");
            if BankLedgerEntries.FindFirst then begin
                PaymentHeader2.Reset;
                PaymentHeader2.SetRange("No.", PaymentHeader."No.");
                if PaymentHeader2.FindFirst then begin
                    PaymentHeader2.Status := PaymentHeader2.Status::Posted;
                    PaymentHeader2.Validate(PaymentHeader2.Status);
                    PaymentHeader2.Posted := true;
                    PaymentHeader2."Posted By" := UserId;
                    PaymentHeader2."Date Posted" := Today;
                    PaymentHeader2."Time Posted" := Time;
                    PaymentHeader2.Modify;

                    //create payroll deduction
                    "HRLoanMgt.".CreateLoanPayrollDeduction(PaymentHeader2."No.", PaymentHeader."Loan No.", TotalDisbursedAmount);
                    //update disbursement voucher
                    "HRLoanMgt.".UpdateDisbursementVoucher(PaymentHeader2."No.");

                    PaymentHeader2.CalcFields("Net Amount");
                    EmployeeLoanAccounts.Reset;
                    EmployeeLoanAccounts.Get(PaymentHeader2."Loan No.");

                    if EmployeeLoanAccounts."Repayment Start Date" = 0D then
                        EmployeeLoanAccounts."Repayment Start Date" := PaymentHeader2."Posting Date";
                    EmployeeLoanAccounts.Modify;
                end;
            end;
            Commit;
            //***********************************************End Update Document************************************************************//
        end else begin
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange("Journal Template Name", "Journal Template");
            GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
            if GenJnlLine.FindSet then begin
                GenJnlPost.Preview(GenJnlLine);
            end;
            //**********************************************End Preview Posting*************************************************************//
        end;

        BankLedgerEntries.Reset;
        BankLedgerEntries.SetRange("Document No.", PaymentHeader."No.");
        if BankLedgerEntries.FindFirst then begin
            ChequeRegisterLines.Reset;
            ChequeRegisterLines.SetRange(ChequeRegisterLines."Cheque No.", PaymentHeader."Cheque No.");
            if ChequeRegisterLines.FindFirst then begin
                ChequeRegisterLines."Assigned to PV" := true;
                ChequeRegisterLines."PV Posted with Cheque" := true;
                ChequeRegisterLines."Payee No" := PaymentHeader."Payee No.";
                ChequeRegisterLines.Payee := PaymentHeader."Payee Name";
                ChequeRegisterLines."PV No" := PaymentHeader."No.";
                ChequeRegisterLines."PV Description" := PaymentHeader.Description;
                ChequeRegisterLines."PV Prepared By" := PaymentHeader."User ID";
                ChequeRegisterLines.Modify;
            end;
        end;



        /*//Send email to supplier
        PaymentLine2.RESET;
        PaymentLine2.SETRANGE(PaymentLine2."Document No.",PaymentHeader."No.");
        PaymentLine2.SETRANGE(PaymentLine2."Account Type",PaymentLine2."Account Type"::Vendor);
        IF PaymentLine2.FINDFIRST THEN BEGIN
         //IF CONFIRM(Txt070)=FALSE THEN EXIT
         SendVendorEmail(PaymentLine2."Document No.",PaymentLine2."Account No.",PaymentLine2."Net Amount");
        END;
        */

    end;

    procedure PostPaymentLineByLine("Payment Header": Record "Payment Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        PaymentLine: Record "Payment Line";
        PaymentHeader: Record "Payment Header";
        SourceCode: Code[20];
        BankLedgerEntries: Record "Bank Account Ledger Entry";
        PaymentLine2: Record "Payment Line";
        PaymentHeader2: Record "Payment Header";
        DocumentExist: Label 'Payment Document is already posted, Document No.:%1 already exists in Bank No:%2';
    begin
        PaymentHeader.TransferFields("Payment Header", true);
        SourceCode := PAYMENTJNL;

        BankLedgerEntries.Reset;
        BankLedgerEntries.SetRange(BankLedgerEntries."Document Type", BankLedgerEntries."Document Type"::Payment);
        BankLedgerEntries.SetRange(BankLedgerEntries."Document No.", PaymentHeader."No.");
        if BankLedgerEntries.FindFirst then begin
            Error(DocumentExist, PaymentHeader."No.", PaymentHeader."Bank Account No.");
        end;

        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", "Journal Template");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        LineNo := 1000;

        //***********************************************Add Payment Lines**************************************************************//
        PaymentLine.Reset;
        PaymentLine.SetRange("Document No.", PaymentHeader."No.");
        PaymentLine.SetFilter("Total Amount", '<>%1', 0);
        if PaymentLine.FindSet then begin
            repeat
                //****************************************Add Line Amounts***********************************************************//
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate("Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate("Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                GenJnlLine."Document No." := PaymentLine."Document No.";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Account Type" := PaymentLine."Account Type";
                GenJnlLine."Account No." := PaymentLine."Account No.";
                GenJnlLine.Validate("Account No.");
                GenJnlLine."Posting Group" := PaymentLine."Posting Group";
                GenJnlLine."External Document No." := PaymentLine."Reference No.";
                GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine.Amount := PaymentLine."Total Amount";  //Debit Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
                GenJnlLine."Bal. Account No." := PaymentHeader."Bank Account No.";
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                GenJnlLine.Validate("Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PaymentLine."Global Dimension 2 Code";
                GenJnlLine.Validate("Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PaymentLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PaymentLine."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, PaymentLine."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, PaymentLine."Shortcut Dimension 6 Code");
                //GenJnlLine.ValidateShortcutDimCode(7,PaymentLine."Shortcut Dimension 7 Code");
                // GenJnlLine.ValidateShortcutDimCode(8,PaymentLine."Shortcut Dimension 8 Code");
                GenJnlLine.Description := UpperCase(CopyStr(PaymentHeader.Description, 1, 249));
                GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
                GenJnlLine.Validate(Description);
                GenJnlLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                GenJnlLine.Validate("Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                GenJnlLine."Employee Transaction Type" := PaymentLine."Employee Transaction Type";
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;
                //*************************************End Add Line Amounts**********************************************************//

                //**************************************Add W/TAX Amounts************************************************************//
                if PaymentLine."Withholding Tax Code" <> '' then begin
                    TaxCodes.Reset;
                    TaxCodes.SetRange("Tax Code", PaymentLine."Withholding Tax Code");
                    if TaxCodes.FindFirst then begin
                        TaxCodes.TestField("Account No.");
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No.";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine.Amount := -(PaymentLine."Withholding Tax Amount");   //Credit Amount
                        GenJnlLine.Validate(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        // GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                        // GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UpperCase(CopyStr('W/TAX:' + Format(PaymentLine."Document No.") + '::' + Format(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;

                        //W/TAX Balancing
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := PaymentLine."Account Type";
                        GenJnlLine."Account No." := PaymentLine."Account No.";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Posting Group" := PaymentLine."Posting Group";
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine.Amount := PaymentLine."Withholding Tax Amount";   //Debit Amount
                        GenJnlLine.Validate(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        // GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                        // GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UpperCase(CopyStr('W/TAX:' + Format(PaymentLine."Document No.") + '::' + Format(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
                        GenJnlLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                        GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                        GenJnlLine.Validate("Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                        GenJnlLine."Employee Transaction Type" := PaymentLine."Employee Transaction Type";
                        /*IF GenJnlLine.Amount<>0 THEN
                            GenJnlLine.INSERT;*/
                    end;
                end;
                //****************************************End Add W/TAX Amounts************************************************************//

                //****************************************Add W/VAT Amounts***************************************************************//
                if PaymentLine."Withholding VAT Code" <> '' then begin
                    TaxCodes.Reset;
                    TaxCodes.SetRange("Tax Code", PaymentLine."Withholding VAT Code");
                    if TaxCodes.FindFirst then begin
                        TaxCodes.TestField("Account No.");
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No.";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine.Amount := -(PaymentLine."Withholding VAT Amount");   //Credit Amount
                        GenJnlLine.Validate(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        // GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                        // GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UpperCase(CopyStr('W/VAT:' + Format(PaymentLine."Document No.") + '::' + Format(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;

                        //W/VAT Balancing
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := PaymentLine."Account Type";
                        GenJnlLine."Account No." := PaymentLine."Account No.";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Posting Group" := PaymentLine."Posting Group";
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine.Amount := PaymentLine."Withholding VAT Amount";   //Debit Amount
                        GenJnlLine.Validate(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        //  GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                        //  GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UpperCase(CopyStr('W/VAT:' + Format(PaymentLine."Document No.") + '::' + Format(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
                        GenJnlLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                        GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                        GenJnlLine.Validate("Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                        GenJnlLine."Employee Transaction Type" := PaymentLine."Employee Transaction Type";
                        /*IF GenJnlLine.Amount<>0 THEN
                            GenJnlLine.INSERT;*/
                    end;
                end;
            //***********************************End Add W/VAT Amounts*************************************************************//
            until PaymentLine.Next = 0;
        end;
        //*********************************************End Add Payment Lines************************************************************//
        Commit;
        //********************************************Post the Journal Lines************************************************************//
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", "Journal Template");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        if not Preview then begin
            //Post the Journal Lines
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            BankLedgerEntries.Reset;
            BankLedgerEntries.SetRange("Document No.", PaymentHeader."No.");
            if BankLedgerEntries.FindFirst then begin
                PaymentHeader2.Reset;
                PaymentHeader2.SetRange("No.", PaymentHeader."No.");
                if PaymentHeader2.FindFirst then begin
                    PaymentHeader2.Status := PaymentHeader2.Status::Posted;
                    PaymentHeader2.Validate(PaymentHeader2.Status);
                    PaymentHeader2.Posted := true;
                    PaymentHeader2."Posted By" := UserId;
                    PaymentHeader2."Date Posted" := Today;
                    PaymentHeader2."Time Posted" := Time;
                    PaymentHeader2.Modify;
                end;
            end;
            Commit;
            //***********************************************End Update Document************************************************************//
        end else begin
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange("Journal Template Name", "Journal Template");
            GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
            if GenJnlLine.FindSet then begin
                GenJnlPost.Preview(GenJnlLine);
            end;
            //**********************************************End Preview Posting*************************************************************//
        end;

    end;

    procedure CheckPaymentMandatoryFields("Payment Header": Record "Payment Header"; Posting: Boolean)
    var
        PaymentHeader: Record "Payment Header";
        PaymentLine: Record "Payment Line";
        EmptyPaymentLine: Label 'You cannot Post Payment with empty Line';
        "G/LAccount": Record "G/L Account";
    begin
        PaymentHeader.TransferFields("Payment Header", true);
        //PaymentHeader.TESTFIELD("Posting Date");
        if PaymentHeader."Payment Type" = PaymentHeader."Payment Type"::"Cheque Payment" then begin
            if PaymentHeader."Payment Mode" = "Payment Header"."Payment Mode"::EFT then begin
                //PaymentHeader.TESTFIELD("Reference No.");
            end;
            //PaymentHeader.TESTFIELD("Reference No.");PaymentHeader.TESTFIELD("Reference No.");
            //PaymentHeader.TESTFIELD("Cheque No.");
            PaymentHeader.TestField("Payee Name");
        end;
        PaymentHeader.TestField("Bank Account No.");
        PaymentHeader.TestField(Description);
        PaymentHeader.TestField("Global Dimension 1 Code");
        if Posting then
            PaymentHeader.TestField(Status, PaymentHeader.Status::Approved);

        //Check Payment Lines
        PaymentLine.Reset;
        PaymentLine.SetRange("Document No.", PaymentHeader."No.");
        if PaymentLine.FindSet then begin
            repeat
                PaymentLine.TestField("Account No.");
                PaymentLine.TestField("Total Amount");
                PaymentLine.TestField(Description);
                if PaymentLine."Account Type" = PaymentLine."Account Type"::"G/L Account" then begin
                    "G/LAccount".Reset;
                    "G/LAccount".Get(PaymentLine."Account No.");
                    if "G/LAccount"."Income/Balance" = "G/LAccount"."Income/Balance"::"Income Statement" then begin
                        PaymentLine.TestField("Global Dimension 2 Code");
                        /* PaymentLine.TESTFIELD("Shortcut Dimension 3 Code");
                         PaymentLine.TESTFIELD("Shortcut Dimension 4 Code");
                         PaymentLine.TESTFIELD("Shortcut Dimension 5 Code");
                         PaymentLine.TESTFIELD("Shortcut Dimension 6 Code");*/
                    end;
                end;
            until PaymentLine.Next = 0;
        end else begin
            Error(EmptyPaymentLine);
        end;

    end;

    procedure PostReceipt("Receipt Header": Record "Receipt Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        ReceiptLine: Record "Receipt Line";
        ReceiptHeader: Record "Receipt Header";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        ReceiptLine2: Record "Receipt Line";
        ReceiptHeader2: Record "Receipt Header";
        DocumentExist: Label 'Receipt is already posted, Document No.:%1 already exists in Bank No:%2';
        GLEntry: Record "G/L Entry";
    begin
        ReceiptHeader.TransferFields("Receipt Header", true);
        SourceCode := RECEIPTJNL;

        BankLedgers.Reset;
        BankLedgers.SetRange(BankLedgers."Document No.", ReceiptHeader."No.");
        if BankLedgers.FindFirst then begin
            Error(DocumentExist, ReceiptHeader."No.", ReceiptHeader."Account No.");
        end;

        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        //***************************************************Add to Bank***************************************************************//
        ReceiptHeader.CalcFields("Line Amount", "Line Amount(LCY)");
        LineNo := 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
        GenJnlLine."Document No." := ReceiptHeader."No.";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."External Document No." := ReceiptHeader."Reference No.";
        if ReceiptHeader."Receipt Types" = ReceiptHeader."Receipt Types"::Bank then begin
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
            GenJnlLine."Account No." := ReceiptHeader."Account No.";
        end else begin
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            if FundsTransactionCode.Get(ReceiptHeader."Account No.") then
                GenJnlLine."Account No." := FundsTransactionCode."Account No.";
        end;
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        GenJnlLine.Amount := ReceiptHeader."Line Amount";  //Debit Amount
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
        //GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
        //GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := CopyStr(ReceiptHeader.Description, 1, 249);
        GenJnlLine.Description2 := UpperCase(CopyStr("Receipt Header"."Received From", 1, 249));
        GenJnlLine.Validate(GenJnlLine.Description);
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
        //************************************************End Add to Bank***************************************************************//
        //***********************************************Add Receipt Lines**************************************************************//
        ReceiptLine.Reset;
        ReceiptLine.SetRange(ReceiptLine."Document No.", ReceiptHeader."No.");
        ReceiptLine.SetFilter(ReceiptLine.Amount, '<>%1', 0);
        if ReceiptLine.FindSet then begin
            repeat
                //****************************************Add Line NetAmounts***********************************************************//
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
                GenJnlLine."Document No." := ReceiptLine."Document No.";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Account Type" := ReceiptLine."Account Type";
                GenJnlLine."Account No." := ReceiptLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Posting Group" := ReceiptLine."Posting Group";
                GenJnlLine."External Document No." := ReceiptHeader."Reference No.";
                GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine.Amount := -(ReceiptLine.Amount);  //Credit Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                // IF ReceiptLine."Posting Group" <> '' THEN BEGIN
                GenJnlLine."Investment Transaction Type" := ReceiptLine."Loan Transaction Type";
                GenJnlLine."Investment Account No." := ReceiptLine."Loan Account No.";
                GenJnlLine."Customer No." := ReceiptLine."Account No.";
                //  END;
                GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
                GenJnlLine.ValidateShortcutDimCode(7, ReceiptHeader."Shortcut Dimension 7 Code");
                GenJnlLine.ValidateShortcutDimCode(8, ReceiptHeader."Shortcut Dimension 8 Code");
                GenJnlLine.Description := CopyStr(ReceiptHeader.Description, 1, 249);
                GenJnlLine.Description2 := UpperCase(CopyStr("Receipt Header"."Received From", 1, 249));
                GenJnlLine.Validate(GenJnlLine.Description);
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                if ReceiptLine."Loan Account No." <> '' then begin
                    GenJnlLine."Applies-to ID" := '';
                    GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                end else begin
                    GenJnlLine."Applies-to ID" := ReceiptLine."Applies-to ID";
                    GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                end;
                GenJnlLine."Employee Transaction Type" := ReceiptLine."Employee Transaction Type";
                GenJnlLine."Investment Application No." := ReceiptLine."Investment Application No.";
                // GenJnlLine."Loan Account No.":=ReceiptLine."Investment Account No.";
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;
                //*************************************End add Line NetAmounts**********************************************************//
                //****************************************Add VAT Amounts***************************************************************//
                if ReceiptLine."VAT Code" <> '' then begin
                    TaxCodes.Reset;
                    TaxCodes.SetRange(TaxCodes."Tax Code", ReceiptLine."VAT Code");
                    if TaxCodes.FindFirst then begin
                        TaxCodes.TestField(TaxCodes."Account No.");
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
                        GenJnlLine."Document No." := ReceiptLine."Document No.";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."External Document No." := ReceiptHeader."Reference No.";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No.";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                        GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                        GenJnlLine."Gen. Bus. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine.Amount := -(ReceiptLine."VAT Amount");   //Credit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
                        //  GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
                        //  GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := CopyStr('VAT:' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"), 1, 249);
                        GenJnlLine.Description2 := UpperCase(CopyStr("Receipt Header"."Received From", 1, 50));
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;

                        //VAT Balancing goes to Vendor
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
                        GenJnlLine."Document No." := ReceiptLine."Document No.";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."External Document No." := ReceiptHeader."Reference No.";
                        GenJnlLine."Account Type" := ReceiptLine."Account Type";
                        GenJnlLine."Account No." := ReceiptLine."Account No.";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine.Amount := ReceiptLine."VAT Amount";   //Debit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
                        //GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
                        // GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := CopyStr('VAT:' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"), 1, 249);
                        GenJnlLine.Description2 := UpperCase(CopyStr("Receipt Header"."Received From", 1, 50));
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;
                    end;
                end;
            //*************************************End Add VAT Amounts**************************************************************//
            until ReceiptLine.Next = 0;
        end;
        //*********************************************End Add Payment Lines************************************************************//
        Commit;
        //********************************************Post the Journal Lines************************************************************//
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        if not Preview then begin
            //Now Post the Journal Lines
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            GLEntry.Reset;
            GLEntry.SetRange("Document No.", ReceiptHeader."No.");
            if GLEntry.FindFirst then begin
                ReceiptHeader2.Reset;
                ReceiptHeader2.SetRange(ReceiptHeader2."No.", ReceiptHeader."No.");
                if ReceiptHeader2.FindFirst then begin

                    //Apply loan
                    if ReceiptHeader2."Receipt Type" = ReceiptHeader2."Receipt Type"::"Investment Loan" then begin
                        if ReceiptHeader2."Investment Account No." <> '' then begin
                            //InvstReceiptApplication.SuggestInvestmentLoanRepaymentsDefined(ReceiptHeader2."No.",ReceiptHeader2."Amount Received",ReceiptHeader2."Investment Account No.");
                        end else begin
                            // InvstReceiptApplication.SuggestInvestmentLoanRepaymentsUnDefined(ReceiptHeader2."No.",ReceiptHeader2."Amount Received");
                        end;
                    end;
                    //End Loan Application;
                    //Apply equity
                    if ReceiptHeader2."Receipt Type" = ReceiptHeader2."Receipt Type"::Equity then begin
                        if ReceiptHeader2."Investment Account No." <> '' then begin
                            // InvstReceiptApplication.SuggestInvestmentEquityRepaymentsDefined(ReceiptHeader2."No.",ReceiptHeader2."Amount Received",ReceiptHeader2."Investment Account No.");
                        end else begin
                            // InvstReceiptApplication.SuggestInvestmentEquityRepaymentsUnDefined(ReceiptHeader2."No.",ReceiptHeader2."Amount Received");
                        end;
                    end;
                    //End Equity Application;

                    ReceiptHeader2.Status := ReceiptHeader2.Status::Posted;
                    ReceiptHeader2.Posted := true;
                    ReceiptHeader2."Posted By" := UserId;
                    ReceiptHeader2."Date Posted" := Today;
                    ReceiptHeader2."Time Posted" := Time;
                    ReceiptHeader2.Modify;
                    ReceiptLine2.Reset;
                    ReceiptLine2.SetRange(ReceiptLine2."Document No.", ReceiptHeader2."No.");
                    if ReceiptLine2.FindSet then begin
                        repeat
                            ReceiptLine2.Status := ReceiptLine2.Status::Posted;
                            ReceiptLine2.Posted := true;
                            ReceiptLine2."Posted By" := UserId;
                            ReceiptLine2."Date Posted" := Today;
                            ReceiptLine2."Time Posted" := Time;
                            ReceiptLine2.Modify;

                        /*TenantApplication.RESET;
                        TenantApplication.SETRANGE(TenantApplication."Tenant Account No.",ReceiptLine2."Account No.");
                        TenantApplication.SETRANGE(TenantApplication.Receipted,FALSE);
                        IF TenantApplication.FINDFIRST THEN BEGIN
                          TenantApplication.Receipted:=TRUE;
                          TenantApplication."Receipt Date":=TODAY;
                          TenantApplication."Receipt No.":=ReceiptLine2."Document No.";
                        END;*/
                        until ReceiptLine2.Next = 0;
                    end;
                end;
            end;
            Commit;
            //***********************************************End Update Document************************************************************//
        end else begin
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
            if GenJnlLine.FindSet then begin
                GenJnlPost.Preview(GenJnlLine);
            end;
            //**********************************************End Preview Posting*************************************************************//
        end;

    end;

    procedure PostChequeReceipt("ReceiptNo.": Code[20]; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        ReceiptLine: Record "Receipt Line";
        ReceiptHeader: Record "Receipt Header";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        ReceiptLine2: Record "Receipt Line";
        ReceiptHeader2: Record "Receipt Header";
        DocumentExist: Label 'Receipt is already posted, Document No.:%1 already exists in Bank No:%2';
        GLEntry: Record "G/L Entry";
    begin
        ReceiptHeader.Get("ReceiptNo.");
        SourceCode := RECEIPTJNL;

        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        //***************************************************Add to Bank***************************************************************//
        ReceiptHeader.CalcFields("Line Amount", "Line Amount(LCY)");
        LineNo := 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
        GenJnlLine."Document No." := ReceiptHeader."No.";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."External Document No." := ReceiptHeader."Reference No.";
        if ReceiptHeader."Receipt Types" = ReceiptHeader."Receipt Types"::Bank then begin
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
            GenJnlLine."Account No." := ReceiptHeader."Account No.";
        end else begin
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            if FundsTransactionCode.Get(ReceiptHeader."Account No.") then
                GenJnlLine."Account No." := FundsTransactionCode."Account No.";
        end;
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        GenJnlLine.Amount := ReceiptHeader."Line Amount";  //Debit Amount
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
        //GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
        //GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := CopyStr(ReceiptHeader.Description, 1, 249);
        GenJnlLine.Description2 := UpperCase(CopyStr(ReceiptHeader."Received From", 1, 249));
        GenJnlLine.Validate(GenJnlLine.Description);
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
        //************************************************End Add to Bank***************************************************************//
        //***********************************************Add Receipt Lines**************************************************************//
        ReceiptLine.Reset;
        ReceiptLine.SetRange(ReceiptLine."Document No.", ReceiptHeader."No.");
        ReceiptLine.SetFilter(ReceiptLine.Amount, '<>%1', 0);
        if ReceiptLine.FindSet then begin
            repeat
                //****************************************Add Line NetAmounts***********************************************************//
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
                GenJnlLine."Document No." := ReceiptLine."Document No.";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Account Type" := ReceiptLine."Account Type";
                GenJnlLine."Account No." := ReceiptLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Posting Group" := ReceiptLine."Posting Group";
                GenJnlLine."External Document No." := ReceiptHeader."Reference No.";
                GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine.Amount := -(ReceiptLine.Amount);  //Credit Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Investment Transaction Type" := ReceiptLine."Loan Transaction Type";
                GenJnlLine."Investment Account No." := ReceiptLine."Loan Account No.";
                GenJnlLine."Customer No." := ReceiptLine."Account No.";
                GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
                GenJnlLine.ValidateShortcutDimCode(7, ReceiptHeader."Shortcut Dimension 7 Code");
                GenJnlLine.ValidateShortcutDimCode(8, ReceiptHeader."Shortcut Dimension 8 Code");
                GenJnlLine.Description := CopyStr(ReceiptHeader.Description, 1, 249);
                GenJnlLine.Description2 := UpperCase(CopyStr(ReceiptHeader."Received From", 1, 249));
                GenJnlLine.Validate(GenJnlLine.Description);
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                if ReceiptLine."Loan Account No." <> '' then begin
                    GenJnlLine."Applies-to ID" := '';
                    GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                end else begin
                    GenJnlLine."Applies-to ID" := ReceiptLine."Applies-to ID";
                    GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                end;
                GenJnlLine."Employee Transaction Type" := ReceiptLine."Employee Transaction Type";
                GenJnlLine."Investment Application No." := ReceiptLine."Investment Application No.";
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;
            //*************************************End add Line NetAmounts**********************************************************//

            until ReceiptLine.Next = 0;
        end;
        //*********************************************End Add Payment Lines************************************************************//
        Commit;
        //********************************************Post the Journal Lines************************************************************//
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        if not Preview then begin
            //Now Post the Journal Lines
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            GLEntry.Reset;
            GLEntry.SetRange("Document No.", ReceiptHeader."No.");
            if GLEntry.FindFirst then begin
                ReceiptHeader2.Reset;
                ReceiptHeader2.SetRange(ReceiptHeader2."No.", ReceiptHeader."No.");
                if ReceiptHeader2.FindFirst then begin
                    //Apply loan
                    if ReceiptHeader2."Receipt Type" = ReceiptHeader2."Receipt Type"::"Investment Loan" then begin
                        if ReceiptHeader2."Investment Account No." <> '' then begin
                            //InvstReceiptApplication.SuggestInvestmentLoanRepaymentsDefined(ReceiptHeader2."No.",ReceiptHeader2."Amount Received",ReceiptHeader2."Investment Account No.");
                        end else begin
                            //InvstReceiptApplication.SuggestInvestmentLoanRepaymentsUnDefined(ReceiptHeader2."No.",ReceiptHeader2."Amount Received");
                        end;
                    end;
                    //End Loan Application;

                    ReceiptHeader2.Status := ReceiptHeader2.Status::Posted;
                    ReceiptHeader2.Posted := true;
                    ReceiptHeader2."Posted By" := UserId;
                    ReceiptHeader2."Date Posted" := Today;
                    ReceiptHeader2."Time Posted" := Time;
                    ReceiptHeader2.Modify;
                    ReceiptLine2.Reset;
                    ReceiptLine2.SetRange(ReceiptLine2."Document No.", ReceiptHeader2."No.");
                    if ReceiptLine2.FindSet then begin
                        repeat
                            ReceiptLine2.Status := ReceiptLine2.Status::Posted;
                            ReceiptLine2.Posted := true;
                            ReceiptLine2."Posted By" := UserId;
                            ReceiptLine2."Date Posted" := Today;
                            ReceiptLine2."Time Posted" := Time;
                            ReceiptLine2.Modify;

                        /*TenantApplication.RESET;
                        TenantApplication.SETRANGE(TenantApplication."Tenant Account No.",ReceiptLine2."Account No.");
                        TenantApplication.SETRANGE(TenantApplication.Receipted,FALSE);
                        IF TenantApplication.FINDFIRST THEN BEGIN
                          TenantApplication.Receipted:=TRUE;
                          TenantApplication."Receipt Date":=TODAY;
                          TenantApplication."Receipt No.":=ReceiptLine2."Document No.";
                        END;*/
                        until ReceiptLine2.Next = 0;
                    end;
                end;
            end;
            Commit;
            //***********************************************End Update Document************************************************************//
        end else begin
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
            if GenJnlLine.FindSet then begin
                GenJnlPost.Preview(GenJnlLine);
            end;
            //**********************************************End Preview Posting*************************************************************//
        end;

    end;

    procedure CheckReceiptMandatoryFields("Receipt Header": Record "Receipt Header"; Posting: Boolean)
    var
        EmptyReceiptLine: Label 'You cannot Post Receipt with empty Line';
        ReceiptHeader: Record "Receipt Header";
        ReceiptLine: Record "Receipt Line";
        AmountsNotEqual: Label 'The Amount Received:%1 is not equal to the Total Line Amount:%2';
        ReceiptLine2: Record "Receipt Line";
    begin
        ReceiptHeader.TransferFields("Receipt Header", true);
        ReceiptHeader.TestField("Posting Date");
        ReceiptHeader.TestField("Account No.");
        ReceiptHeader.TestField("Received From");
        ReceiptHeader.TestField(Description);
        ReceiptHeader.TestField("Receipt Type");

        //ReceiptHeader.TESTFIELD("Global Dimension 1 Code");
        //Check Receipt Lines
        ReceiptLine.Reset;
        ReceiptLine.SetRange("Document No.", ReceiptHeader."No.");
        if ReceiptLine.FindSet then begin
            repeat
                ReceiptLine.TestField("Account No.");
                ReceiptLine.TestField(Amount);
                ReceiptLine.TestField(Description);
            until ReceiptLine.Next = 0;
        end else begin
            Error(EmptyReceiptLine);
        end;

        //Check Investment Mandatory fields
        CheckInvestmentReceiptCode(ReceiptHeader."No.");

        ReceiptHeader.CalcFields("Line Amount", "Line Amount(LCY)");
        if ReceiptHeader."Amount Received" <> ReceiptHeader."Line Amount" then
            Error(AmountsNotEqual, ReceiptHeader."Amount Received", ReceiptHeader."Line Amount");


        if ReceiptHeader."Receipt Type" = ReceiptHeader."Receipt Type"::"Investment Loan" then begin
            ReceiptHeader.TestField("Client No.");
        end;
    end;

    procedure PostFundsTransfer("Funds Transfer Header": Record "Funds Transfer Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        FundsTransferLine: Record "Funds Transfer Line";
        FundsTransferHeader: Record "Funds Transfer Header";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        FundsTransferLine2: Record "Funds Transfer Line";
        FundsTransferHeader2: Record "Funds Transfer Header";
        DocumentExist: Label 'Funds Transfer document is already posted, Document No.:%1 already exists in Bank No.:%2';
    begin
        FundsTransferHeader.TransferFields("Funds Transfer Header", true);
        SourceCode := TRANJNL;
        BankLedgers.Reset;
        //BankLedgers.SETRANGE("Document Type",BankLedgers."Document Type"::);
        BankLedgers.SetRange("Document No.", FundsTransferHeader."No.");
        if BankLedgers.FindFirst then begin
            Error(DocumentExist, FundsTransferHeader."No.", FundsTransferHeader."Bank Account No.");
        end;

        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", "Journal Template");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        LineNo := 1000;
        //********************************************Add to Paying Bank***************************************************************//
        FundsTransferHeader.CalcFields("Line Amount");
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate("Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate("Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := FundsTransferHeader."Posting Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := FundsTransferHeader."No.";
        GenJnlLine."External Document No." := FundsTransferHeader."Reference No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := FundsTransferHeader."Bank Account No.";
        GenJnlLine.Validate("Account No.");
        GenJnlLine."Currency Code" := FundsTransferHeader."Currency Code";
        GenJnlLine.Validate("Currency Code");
        GenJnlLine.Amount := -(FundsTransferHeader."Amount To Transfer");  //Credit Amount
        GenJnlLine.Validate(Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate("Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := FundsTransferHeader."Global Dimension 1 Code";
        GenJnlLine.Validate("Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := FundsTransferHeader."Global Dimension 2 Code";
        GenJnlLine.Validate("Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, FundsTransferHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, FundsTransferHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, FundsTransferHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, FundsTransferHeader."Shortcut Dimension 6 Code");
        //GenJnlLine.ValidateShortcutDimCode(7,FundsTransferHeader."Shortcut Dimension 7 Code");
        //GenJnlLine.ValidateShortcutDimCode(8,FundsTransferHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := UpperCase(CopyStr(FundsTransferHeader.Description, 1, 249));
        GenJnlLine.Description2 := UpperCase(CopyStr(FundsTransferHeader."Transfer To", 1, 249));
        GenJnlLine.Validate(Description);
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
        //************************************************End Add to Paying Bank***********************************************************//

        //***********************************************Add Receiving Bank Lines**********************************************************//
        FundsTransferLine.Reset;
        FundsTransferLine.SetRange("Document No.", FundsTransferHeader."No.");
        FundsTransferLine.SetFilter(Amount, '<>%1', 0);
        if FundsTransferLine.FindSet then begin
            repeat
                //****************************************Add Line NetAmounts***********************************************************//
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate("Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate("Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := FundsTransferHeader."Posting Date";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Document No." := FundsTransferLine."Document No.";
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
                GenJnlLine."Account No." := FundsTransferLine."Account No.";
                GenJnlLine.Validate("Account No.");
                GenJnlLine."External Document No." := FundsTransferHeader."Reference No.";
                GenJnlLine."Currency Code" := FundsTransferHeader."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine.Amount := FundsTransferLine.Amount;
                GenJnlLine.Validate(Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Validate("Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := FundsTransferHeader."Global Dimension 1 Code";
                GenJnlLine.Validate("Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := FundsTransferHeader."Global Dimension 2 Code";
                GenJnlLine.Validate("Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, FundsTransferHeader."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, FundsTransferHeader."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, FundsTransferHeader."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, FundsTransferHeader."Shortcut Dimension 6 Code");
                // GenJnlLine.ValidateShortcutDimCode(7,FundsTransferHeader."Shortcut Dimension 7 Code");
                // GenJnlLine.ValidateShortcutDimCode(8,FundsTransferHeader."Shortcut Dimension 8 Code");
                GenJnlLine.Description := UpperCase(CopyStr(FundsTransferHeader.Description, 1, 249));
                GenJnlLine.Description2 := UpperCase(CopyStr(FundsTransferHeader."Transfer To", 1, 50));
                GenJnlLine.Validate(GenJnlLine.Description);
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;
            //***************************************End Add Line Amounts************************************************************//
            until FundsTransferLine.Next = 0;
        end;
        Commit;
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        if not Preview then begin
            //Now Post the Journal Lines
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            BankLedgers.Reset;
            BankLedgers.SetRange("Document Type", BankLedgers."Document Type"::" ");
            BankLedgers.SetRange("Document No.", FundsTransferHeader."No.");
            if BankLedgers.FindFirst then begin
                FundsTransferHeader2.Reset;
                FundsTransferHeader2.SetRange("No.", FundsTransferHeader."No.");
                if FundsTransferHeader2.FindFirst then begin
                    FundsTransferHeader2.Status := FundsTransferHeader2.Status::Posted;
                    FundsTransferHeader2.Posted := true;
                    FundsTransferHeader2."Posted By" := UserId;
                    FundsTransferHeader2."Date Posted" := Today;
                    FundsTransferHeader2."Time Posted" := Time;
                    FundsTransferHeader2.Modify;
                    FundsTransferLine2.Reset;
                    FundsTransferLine2.SetRange("Document No.", FundsTransferHeader2."No.");
                    if FundsTransferLine2.FindSet then begin
                        repeat
                            FundsTransferLine2.Status := FundsTransferLine2.Status::Posted;
                            FundsTransferLine2.Posted := true;
                            FundsTransferLine2."Posted By" := UserId;
                            FundsTransferLine2."Date Posted" := Today;
                            FundsTransferLine2."Time Posted" := Time;
                            FundsTransferLine2.Modify;
                        until FundsTransferLine2.Next = 0;
                    end;
                end;
            end;
            Commit;
            //************************************************End Update Document**********************************************************//
        end else begin
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange("Journal Template Name", "Journal Template");
            GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
            if GenJnlLine.FindSet then begin
                GenJnlPost.Preview(GenJnlLine);
            end;
            //**********************************************End Preview Posting*************************************************************//
        end;
    end;

    procedure CheckFundsTransferMandatoryFields("Money Transfer Header": Record "Funds Transfer Header"; Posting: Boolean)
    var
        EmptyFundsTransferLine: Label 'You cannot Post Funds Transfer with empty Line';
        AmountsNotEqual: Label 'The Amount to Transfer:%1 is not equal to the Total Line Amount:%2';
        MoneyTransferHeader: Record "Funds Transfer Header";
        MoneyTransferLine: Record "Funds Transfer Line";
    begin
        MoneyTransferHeader.TransferFields("Money Transfer Header", true);
        MoneyTransferHeader.TestField("Posting Date");
        MoneyTransferHeader.TestField("Bank Account No.");
        MoneyTransferHeader.TestField(Description);
        //MoneyTransferHeader.TESTFIELD("Global Dimension 1 Code");
        //MoneyTransferHeader.TESTFIELD(Status,MoneyTransferHeader.Status::Released);
        //Check Funds Transfer Lines
        MoneyTransferLine.Reset;
        MoneyTransferLine.SetRange("Document No.", MoneyTransferHeader."No.");
        if MoneyTransferLine.FindSet then begin
            repeat
                MoneyTransferLine.TestField("Account No.");
                MoneyTransferLine.TestField(Amount);
            //MoneyTransferLine.TESTFIELD(Description);
            until MoneyTransferLine.Next = 0;
        end else begin
            Error(EmptyFundsTransferLine);
        end;
        MoneyTransferHeader.CalcFields("Line Amount", "Line Amount(LCY)");
        if MoneyTransferHeader."Amount To Transfer" <> MoneyTransferHeader."Line Amount" then
            Error(AmountsNotEqual, MoneyTransferHeader."Amount To Transfer", MoneyTransferHeader."Line Amount");
    end;

    procedure PostImprest("Imprest Header": Record "Imprest Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        ImprestLine: Record "Imprest Line";
        ImprestHeader: Record "Imprest Header";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        ImprestLine2: Record "Imprest Line";
        ImprestHeader2: Record "Imprest Header";
        DocumentExist: Label 'Imprest document is already posted. Document No.:%1  already exists in Bank No:%2';
    begin
        ImprestHeader.TransferFields("Imprest Header", true);
        SourceCode := IMPJNL;
        BankLedgers.Reset;
        BankLedgers.SetRange("Document No.", ImprestHeader."No.");
        BankLedgers.SetRange(Reversed, false);
        if BankLedgers.FindFirst then begin
            Error(DocumentExist, ImprestHeader."No.", ImprestHeader."Bank Account No.");
        end;

        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        LineNo := 1000;
        //********************************************Add Imprest Header*******************************************************//
        ImprestHeader.CalcFields(ImprestHeader.Amount, ImprestHeader."Amount(LCY)");
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := Today;//ImprestHeader."Posting Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := ImprestHeader."No.";
        GenJnlLine."External Document No." := ImprestHeader."Reference No.";
        //added on 12/10/2024 to accomodate branch imprest
        IF ImprestHeader."Imprest Type" = ImprestHeader."Imprest Type"::Pettycash THEN BEGIN
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
            ImprestLine.RESET;
            ImprestLine.SETRANGE(ImprestLine."Document No.", ImprestHeader."No.");
            IF ImprestLine.FINDSET THEN BEGIN
                GenJnlLine."Account No." := ImprestLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
            END;

            // GenJnlLine."Posting Group" := ImprestHeader."Employee Posting Group";
            // GenJnlLine.Validate("Posting Group");               

        END ELSE BEGIN
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::Employee;
            GenJnlLine."Account No." := ImprestHeader."Employee No.";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine."Posting Group" := ImprestHeader."Employee Posting Group";
            GenJnlLine.Validate("Posting Group");
        END;
        GenJnlLine."Currency Code" := ImprestHeader."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        GenJnlLine.Amount := (ImprestHeader.Amount);  //Debit Amount
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, ImprestHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, ImprestHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, ImprestHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, ImprestHeader."Shortcut Dimension 6 Code");
        //GenJnlLine.ValidateShortcutDimCode(7,ImprestHeader."Shortcut Dimension 7 Code");
        //GenJnlLine.ValidateShortcutDimCode(8,ImprestHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Validate(GenJnlLine.Description);
        GenJnlLine.Description := UpperCase(CopyStr(ImprestHeader.Description, 1, 249));
        GenJnlLine.Description2 := UpperCase(CopyStr(ImprestHeader."Employee Name", 1, 249));
        GenJnlLine.Payee := ImprestHeader."Employee Name";

        GenJnlLine."Employee Transaction Type" := GenJnlLine."Employee Transaction Type"::Imprest;
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;

        LineNo := LineNo + 1;
        //Credit Bank
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := Today;//ImprestHeader."Posting Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := ImprestHeader."No.";
        GenJnlLine."External Document No." := ImprestHeader."Reference No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := ImprestHeader."Bank Account No.";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine."Currency Code" := ImprestHeader."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        GenJnlLine.Amount := -(ImprestHeader.Amount);  //Credit Amount
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, ImprestHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, ImprestHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, ImprestHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, ImprestHeader."Shortcut Dimension 6 Code");
        //GenJnlLine.ValidateShortcutDimCode(7,ImprestHeader."Shortcut Dimension 7 Code");
        //GenJnlLine.ValidateShortcutDimCode(8,ImprestHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Validate(GenJnlLine.Description);
        GenJnlLine.Description := UpperCase(CopyStr(ImprestHeader.Description, 1, 249));
        GenJnlLine.Description2 := UpperCase(CopyStr(ImprestHeader."Employee Name", 1, 249));
        GenJnlLine.Payee := ImprestHeader."Employee Name";

        GenJnlLine."Employee Transaction Type" := GenJnlLine."Employee Transaction Type"::Imprest;
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
        Commit;
        //********************************************Post the Journal Lines************************************************************//
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        if not Preview then begin
            //Now Post the Journal Lines
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            BankLedgers.Reset;
            BankLedgers.SetRange(BankLedgers."Document No.", ImprestHeader."No.");
            if BankLedgers.FindFirst then begin
                ImprestHeader2.Reset;
                ImprestHeader2.SetRange(ImprestHeader2."No.", ImprestHeader."No.");
                if ImprestHeader2.FindFirst then begin
                    ImprestHeader2.Status := ImprestHeader2.Status::Posted;
                    ImprestHeader2.Posted := true;
                    ImprestHeader2."Posted By" := UserId;
                    ImprestHeader2."Date Posted" := Today;
                    ImprestHeader2."Time Posted" := Time;
                    //Updated 12/10/2024 for surrendered
                    IF ImprestHeader2."Imprest Type" = ImprestHeader2."Imprest Type"::Pettycash THEN BEGIN
                        ImprestHeader2."Surrender status" := ImprestHeader2."Surrender status"::"Fully surrendered";
                        ImprestHeader2.Surrendered := true;
                    END;
                    //
                    ImprestHeader2.Modify;
                end;
            end;
            //**********************************************End Update Document***************************************************************//
        end else begin
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange("Journal Template Name", "Journal Template");
            GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
            if GenJnlLine.FindSet then begin
                GenJnlPost.Preview(GenJnlLine);
            end;
            //**********************************************End Preview Posting*************************************************************//
        end;
    end;

    procedure CheckImprestMandatoryFields("Imprest Header": Record "Imprest Header"; Posting: Boolean)
    var
        ImprestHeader: Record "Imprest Header";
        ImprestLine: Record "Imprest Line";
        EmptyImprestLine: Label 'You cannot Post Imprest with empty Line';
    begin
        ImprestHeader.TransferFields("Imprest Header", true);
        ImprestHeader.TestField("Posting Date");
        //ImprestHeader.TESTFIELD("Imprest Type");
        //ImprestHeader.TESTFIELD("Bank Account No.");
        ImprestHeader.TestField("Employee No.");
        ImprestHeader.TestField(Description);
        //ImprestHeader.TestField("Employee Posting Group");
        ImprestHeader.TestField("Global Dimension 1 Code");
        ImprestHeader.TestField(Type);
        ImprestHeader.TestField("Date From");
        ImprestHeader.TestField("Date To");
        if Posting then
            // ImprestHeader.TESTFIELD(Status,ImprestHeader.Status::Released);
            //Check Imprest Lines
            ImprestLine.Reset;
        ImprestLine.SetRange("Document No.", ImprestHeader."No.");
        if ImprestLine.FindSet then begin
            repeat
                //ImprestLine.TESTFIELD("Account No.");
                //ImprestLine.TESTFIELD("Gross Amount");
                if ImprestLine."Account Type" = ImprestLine."Account Type"::"G/L Account" then begin
                    //  ImprestLine.TESTFIELD("Global Dimension 1 Code");
                    // ImprestLine.TESTFIELD("Global Dimension 2 Code");
                    // ImprestLine.TESTFIELD("Shortcut Dimension 4 Code");
                    // ImprestLine.TESTFIELD("Shortcut Dimension 5 Code");
                    //ImprestLine.TESTFIELD("Shortcut Dimension 6 Code");
                end;
            until ImprestLine.Next = 0;
        end else begin
            Error(EmptyImprestLine);
        end;
    end;

    procedure PostImprestSurrender("Imprest Surrender Header": Record "Imprest Surrender Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        SourceCode: Code[20];
        ImprestSurrenderLine: Record "Imprest Surrender Line";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        ImprestSurrenderLine2: Record "Imprest Surrender Line";
        ImprestSurrenderHeader2: Record "Imprest Surrender Header";
        DocumentExist: Label 'Imprest Surrender document is already posted. Document No.:%1  already exists in Employee No:%2';
        ImprestHeader: Record "Imprest Header";
        EmployeeLedgers: Record "Employee Ledger Entry";
        FundsTransactionCodes: Record "Funds Transaction Code";
        FundsTaxCode: Record "Funds Tax Code";
        PaymentLine: Record "Payment Line";
        EmployeeLedgerEntry: Record "Employee Ledger Entry";
    begin
        ImprestSurrenderHeader.TransferFields("Imprest Surrender Header", true);
        SourceCode := IMPSURRJNL;
        /*
        EmployeeLedgers.RESET;
        EmployeeLedgers.SETRANGE(EmployeeLedgers."Document No.",ImprestSurrenderHeader."No.");
        IF EmployeeLedgers.FINDFIRST THEN BEGIN
          ERROR(DocumentExist,ImprestSurrenderHeader."No.",ImprestSurrenderHeader."Employee No.");
        END;
        */
        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        LineNo := 1000;
        //********************************************Add Surrender Header*******************************************************//
        ImprestSurrenderHeader.CalcFields(ImprestSurrenderHeader."Actual Spent");
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := ImprestSurrenderHeader."Posting Date";
        //GenJnlLine."Document Type":=GenJnlLine."Document Type"::"Imprest Surrender";
        GenJnlLine."Document No." := ImprestSurrenderHeader."No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Employee;
        GenJnlLine."Account No." := ImprestSurrenderHeader."Employee No.";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        ImprestHeader.Get(ImprestSurrenderHeader."Imprest No.");
        GenJnlLine."Posting Group" := ImprestHeader."Employee Posting Group";
        GenJnlLine.Validate("Posting Group");
        GenJnlLine."Currency Code" := ImprestSurrenderHeader."Currency Code";
        GenJnlLine.Validate("Currency Factor");
        GenJnlLine.Amount := -(ImprestSurrenderHeader."Actual Spent");  //Credit Amount
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := ImprestSurrenderHeader."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := ImprestSurrenderHeader."Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, ImprestSurrenderHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, ImprestSurrenderHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, ImprestSurrenderHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, ImprestSurrenderHeader."Shortcut Dimension 6 Code");
        //GenJnlLine.ValidateShortcutDimCode(7,ImprestSurrenderHeader."Shortcut Dimension 7 Code");
        //GenJnlLine.ValidateShortcutDimCode(8,ImprestSurrenderHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := CopyStr(ImprestSurrenderHeader.Description, 1, 249);
        GenJnlLine.Description2 := CopyStr(ImprestSurrenderHeader."Employee Name", 1, 249);
        GenJnlLine.Validate(GenJnlLine.Description);
        //GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Payment;
        //GenJnlLine."Applies-to Doc. No.":=ImprestHeader."No.";
        //GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
        PaymentLine.Reset;
        PaymentLine.SetRange("Payee No.", ImprestHeader."No.");
        PaymentLine.SetRange(Reversed, false);
        if PaymentLine.FindFirst then begin
            EmployeeLedgerEntry.Reset;
            EmployeeLedgerEntry.SetRange("Employee No.", ImprestSurrenderHeader."Employee No.");
            EmployeeLedgerEntry.SetRange("Document No.", PaymentLine."Document No.");
            if EmployeeLedgerEntry.FindFirst then begin
                GenJnlLine."Applies-to Doc. Type" := EmployeeLedgerEntry."Document Type";
                GenJnlLine."Applies-to Doc. No." := EmployeeLedgerEntry."Document No.";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
            end;
        end;
        GenJnlLine."Employee Transaction Type" := GenJnlLine."Employee Transaction Type"::Imprest;
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
        //********************************End Add Surrender Header********************************************************************//
        //**********************************Add Surrender Lines***********************************************************************//
        ImprestSurrenderLine.Reset;
        ImprestSurrenderLine.SetRange(ImprestSurrenderLine."Document No.", ImprestSurrenderHeader."No.");
        ImprestSurrenderLine.SetFilter(ImprestSurrenderLine."Actual Spent", '<>%1', 0);
        if ImprestSurrenderLine.FindSet then begin
            repeat
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := ImprestSurrenderHeader."Posting Date";
                //GenJnlLine."Document Type":=GenJnlLine."Document Type"::"Imprest Surrender";
                GenJnlLine."Document No." := ImprestSurrenderLine."Document No.";
                GenJnlLine."Account Type" := ImprestSurrenderLine."Account Type";
                GenJnlLine."Account No." := ImprestSurrenderLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                if ImprestSurrenderLine."Account Type" <> ImprestSurrenderLine."Account Type"::"G/L Account" then begin
                    GenJnlLine."Posting Group" := ImprestSurrenderLine."Posting Group";
                    GenJnlLine.Validate("Posting Group");
                end;
                GenJnlLine."Currency Code" := ImprestSurrenderHeader."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine.Amount := ImprestSurrenderLine."Actual Spent";  //Debit Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := ImprestSurrenderLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := ImprestSurrenderLine."Global Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, ImprestSurrenderLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, ImprestSurrenderLine."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, ImprestSurrenderLine."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, ImprestSurrenderLine."Shortcut Dimension 6 Code");
                //GenJnlLine.ValidateShortcutDimCode(7,ImprestSurrenderLine."Shortcut Dimension 7 Code");
                // GenJnlLine.ValidateShortcutDimCode(8,ImprestSurrenderLine."Shortcut Dimension 8 Code");
                GenJnlLine.Description := CopyStr(ImprestSurrenderLine.Description, 1, 249);
                GenJnlLine.Description2 := CopyStr(ImprestSurrenderHeader."Employee Name", 1, 249);
                GenJnlLine.Validate(GenJnlLine.Description);
                if ImprestSurrenderLine."Account Type" = ImprestSurrenderLine."Account Type"::"Fixed Asset" then begin
                    GenJnlLine."FA Posting Type" := GenJnlLine."FA Posting Type"::"Acquisition Cost";
                    GenJnlLine."FA Posting Date" := ImprestSurrenderHeader."Posting Date";
                    GenJnlLine."Depreciation Book Code" := ImprestSurrenderLine."FA Depreciation Book";
                    GenJnlLine.Validate(GenJnlLine."Depreciation Book Code");
                    GenJnlLine."FA Add.-Currency Factor" := 0;
                    GenJnlLine."Gen. Bus. Posting Group" := '';
                end;
                GenJnlLine."Employee Transaction Type" := GenJnlLine."Employee Transaction Type"::Imprest;
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;

                //TAX
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := ImprestSurrenderHeader."Posting Date";
                //GenJnlLine."Document Type":=GenJnlLine."Document Type"::"Imprest Surrender";
                GenJnlLine."Document No." := ImprestSurrenderLine."Document No.";
                GenJnlLine."Account Type" := ImprestSurrenderLine."Account Type";
                GenJnlLine."Account No." := ImprestSurrenderLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                if ImprestSurrenderLine."Account Type" <> ImprestSurrenderLine."Account Type"::"G/L Account" then begin
                    GenJnlLine."Posting Group" := ImprestSurrenderLine."Posting Group";
                    GenJnlLine.Validate("Posting Group");
                end;
                GenJnlLine."Currency Code" := ImprestSurrenderHeader."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine.Amount := ImprestSurrenderLine."Tax Amount";  //Debit Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                FundsTransactionCodes.Reset;
                //FundsTransactionCodes.SETRANGE(FundsTransactionCodes."Transaction Code",ImprestSurrenderLine."Imprest Code");
                FundsTransactionCodes.FindFirst;
                if FundsTransactionCodes."Include Withholding Tax" then begin
                    FundsTransactionCodes.TestField("Withholding Tax Code");
                    FundsTaxCode.Get(FundsTransactionCodes."Withholding Tax Code");

                    FundsTaxCode.TestField("Account No.");

                end;


                GenJnlLine."Bal. Account No." := FundsTaxCode."Account No.";
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := ImprestSurrenderLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := ImprestSurrenderLine."Global Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, ImprestSurrenderLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, ImprestSurrenderLine."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, ImprestSurrenderLine."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, ImprestSurrenderLine."Shortcut Dimension 6 Code");
                //GenJnlLine.ValidateShortcutDimCode(7,ImprestSurrenderLine."Shortcut Dimension 7 Code");
                // GenJnlLine.ValidateShortcutDimCode(8,ImprestSurrenderLine."Shortcut Dimension 8 Code");
                GenJnlLine.Description := CopyStr(ImprestSurrenderLine.Description + '-Imprest Tax', 1, 249);
                GenJnlLine.Description2 := CopyStr(ImprestSurrenderHeader."Employee Name" + '-Imprest Tax', 1, 249);
                GenJnlLine.Validate(GenJnlLine.Description);
                if ImprestSurrenderLine."Account Type" = ImprestSurrenderLine."Account Type"::"Fixed Asset" then begin
                    GenJnlLine."FA Posting Type" := GenJnlLine."FA Posting Type"::"Acquisition Cost";
                    GenJnlLine."FA Posting Date" := ImprestSurrenderHeader."Posting Date";
                    GenJnlLine."Depreciation Book Code" := ImprestSurrenderLine."FA Depreciation Book";
                    GenJnlLine.Validate(GenJnlLine."Depreciation Book Code");
                    GenJnlLine."FA Add.-Currency Factor" := 0;
                    GenJnlLine."Gen. Bus. Posting Group" := '';
                end;
                GenJnlLine."Employee Transaction Type" := GenJnlLine."Employee Transaction Type"::Imprest;
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;




            until ImprestSurrenderLine.Next = 0;
        end;
        //**********************************End Add Surrender Lines*********************************************************************//
        Commit;
        //********************************************Post the Journal Lines************************************************************//
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        if not Preview then begin
            //Now Post the Journal Lines
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            EmployeeLedgers.Reset;
            EmployeeLedgers.SetRange(EmployeeLedgers."Document No.", ImprestSurrenderHeader."No.");
            if EmployeeLedgers.FindFirst then begin
                ImprestSurrenderHeader2.Reset;
                ImprestSurrenderHeader2.SetRange(ImprestSurrenderHeader2."No.", ImprestSurrenderHeader."No.");
                if ImprestSurrenderHeader2.FindFirst then begin
                    ImprestSurrenderHeader2.Status := ImprestSurrenderHeader2.Status::Posted;
                    ImprestSurrenderHeader2.Posted := true;
                    ImprestSurrenderHeader2."Posted By" := UserId;
                    ImprestSurrenderHeader2."Date Posted" := Today;
                    ImprestSurrenderHeader2."Time Posted" := Time;
                    if ImprestSurrenderHeader2.Modify then begin
                        ImprestSurrenderLine2.Reset;
                        ImprestSurrenderLine2.SetRange(ImprestSurrenderLine2."Document No.", ImprestSurrenderHeader2."No.");
                        if ImprestSurrenderLine2.FindSet then begin
                            repeat
                                ImprestSurrenderLine2."Posting Date" := ImprestSurrenderHeader2."Posting Date";
                                ImprestSurrenderLine2.Posted := ImprestSurrenderHeader2.Posted;
                                ImprestSurrenderLine2."Posted By" := UserId;
                                ImprestSurrenderLine2."Date Posted" := Today;
                                ImprestSurrenderLine2."Time Posted" := Time;
                                ImprestSurrenderLine2.Modify;
                            until ImprestSurrenderLine2.Next = 0;
                        end;
                        //Update imprest surrender status
                        ImprestHeader.Reset;
                        ImprestHeader.SetRange(ImprestHeader."No.", ImprestSurrenderHeader2."Imprest No.");
                        if ImprestHeader.FindFirst then begin
                            ImprestHeader.CalcFields(Amount);
                            ImprestSurrenderHeader.CalcFields(Amount);
                            if (ImprestHeader.Amount = ImprestSurrenderHeader.Amount) or (ImprestSurrenderHeader.Amount > ImprestHeader.Amount) then begin
                                ImprestHeader.Surrendered := true;
                                ImprestHeader."Surrender status" := ImprestHeader."Surrender status"::"Fully surrendered";
                                //DecommitGLBudget(ImprestHeader); justo
                                ImprestHeader.Modify;
                            end else begin
                                ImprestHeader.Surrendered := true;
                                ImprestHeader."Surrender status" := ImprestHeader."Surrender status"::"Partially Surrendered";
                                //DecommitGLBudget(ImprestHeader);justo

                                ImprestHeader.Modify;
                            end;
                        end;
                    end;
                end;
            end;
            //**********************************************End Update Document*************************************************************//
        end else begin
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange("Journal Template Name", "Journal Template");
            GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
            if GenJnlLine.FindSet then begin
                GenJnlPost.Preview(GenJnlLine);
            end;
            //**********************************************End Preview Posting***********************************************************//
        end;

    end;

    procedure CheckImprestSurrenderMandatoryFields("Imprest Surrender Header": Record "Imprest Surrender Header"; Posting: Boolean)
    var
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        ImprestSurrenderLine: Record "Imprest Surrender Line";
        EmptyImprestSurrenderLine: Label 'You cannot Post Imprest Surrender with empty Line';
    begin
        ImprestSurrenderHeader.TransferFields("Imprest Surrender Header", true);
        ImprestSurrenderHeader.TestField("Posting Date");
        ImprestSurrenderHeader.TestField("Employee No.");
        ImprestSurrenderHeader.TestField("Imprest No.");
        ImprestSurrenderHeader.TestField(Description);
        //ImprestSurrenderHeader.TESTFIELD("Global Dimension 1 Code");
        //ImprestSurrenderHeader.TESTFIELD("Shortcut Dimension 4 Code");
        //ImprestSurrenderHeader.TESTFIELD("Shortcut Dimension 6 Code");
        if Posting then
            ImprestSurrenderHeader.TestField(Status, ImprestSurrenderHeader.Status::Released);
        //Check Imprest Lines
        ImprestSurrenderLine.Reset;
        ImprestSurrenderLine.SetRange("Document No.", ImprestSurrenderHeader."No.");
        if ImprestSurrenderLine.FindSet then begin
            repeat
                ImprestSurrenderLine.TestField("Account No.");
                ImprestSurrenderLine.TestField(Description);
                if ImprestSurrenderLine."Account Type" = ImprestSurrenderLine."Account Type"::"G/L Account" then begin
                    //ImprestSurrenderLine.TESTFIELD("Global Dimension 1 Code");

                end;
            until ImprestSurrenderLine.Next = 0;
        end else begin
            Error(EmptyImprestSurrenderLine);
        end;
    end;

    procedure PostFundsClaim("Funds Claim Header": Record "Funds Claim Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        FundsClaimLine: Record "Funds Claim Line";
        FundsClaimHeader: Record "Funds Claim Header";
        SourceCode: Code[20];
        BankLedgerEntries: Record "Bank Account Ledger Entry";
        FundsClaimLine2: Record "Funds Claim Line";
        FundsClaimHeader2: Record "Funds Claim Header";
        DocumentExist: Label 'Payment Document is already posted, Document No.:%1 already exists in Bank No:%2';
    begin
        FundsClaimHeader.TransferFields("Funds Claim Header", true);
        SourceCode := PAYMENTJNL;

        BankLedgerEntries.Reset;
        BankLedgerEntries.SetRange(BankLedgerEntries."Document Type", BankLedgerEntries."Document Type"::Payment);
        BankLedgerEntries.SetRange(BankLedgerEntries."Document No.", FundsClaimHeader."No.");
        if BankLedgerEntries.FindFirst then begin
            Error(DocumentExist, FundsClaimHeader."No.", FundsClaimHeader."Bank Account No.");
        end;

        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", "Journal Template");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        LineNo := 1000;
        //*********************************************Add Payment Header***************************************************************//
        FundsClaimHeader.CalcFields("Net Amount");
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate("Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate("Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := FundsClaimHeader."Posting Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Document No." := FundsClaimHeader."No.";
        GenJnlLine."External Document No." := FundsClaimHeader."Reference No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := FundsClaimHeader."Bank Account No.";
        GenJnlLine.Validate("Account No.");
        GenJnlLine."Currency Code" := FundsClaimHeader."Currency Code";
        GenJnlLine.Validate("Currency Code");
        GenJnlLine.Amount := -(FundsClaimHeader."Net Amount");  //Credit Amount
        GenJnlLine.Validate(Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate("Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := FundsClaimHeader."Global Dimension 1 Code";
        GenJnlLine.Validate("Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := FundsClaimHeader."Global Dimension 2 Code";
        GenJnlLine.Validate("Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, FundsClaimHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, FundsClaimHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, FundsClaimHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, FundsClaimHeader."Shortcut Dimension 6 Code");
        //GenJnlLine.ValidateShortcutDimCode(7,FundsClaimHeader."Shortcut Dimension 7 Code");
        //GenJnlLine.ValidateShortcutDimCode(8,FundsClaimHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := UpperCase(CopyStr(FundsClaimHeader.Description, 1, 249));
        GenJnlLine.Description2 := UpperCase(CopyStr(FundsClaimHeader."Payee Name", 1, 249));
        GenJnlLine.Validate(Description);
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
        //************************************************End Add to Bank***************************************************************//

        //*********************************************Add Funds Claim Lines************************************************************//
        FundsClaimLine.Reset;
        FundsClaimLine.SetRange(FundsClaimLine."Document No.", FundsClaimHeader."No.");
        FundsClaimLine.SetFilter(FundsClaimLine.Amount, '<>%1', 0);
        if FundsClaimLine.FindSet then begin
            repeat
                //****************************************Add Line Amounts***********************************************************//
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate("Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate("Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := FundsClaimHeader."Posting Date";
                GenJnlLine."Document No." := FundsClaimLine."Document No.";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Account Type" := FundsClaimLine."Account Type";
                GenJnlLine."Account No." := FundsClaimLine."Account No.";
                GenJnlLine.Validate("Account No.");
                GenJnlLine."Posting Group" := FundsClaimLine."Posting Group";
                GenJnlLine."External Document No." := FundsClaimHeader."Reference No.";
                GenJnlLine."Currency Code" := FundsClaimHeader."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine.Amount := FundsClaimLine.Amount;  //Debit Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := FundsClaimHeader."Global Dimension 1 Code";
                GenJnlLine.Validate("Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := FundsClaimLine."Global Dimension 2 Code";
                GenJnlLine.Validate("Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, FundsClaimLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, FundsClaimLine."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, FundsClaimLine."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, FundsClaimLine."Shortcut Dimension 6 Code");
                // GenJnlLine.ValidateShortcutDimCode(7,FundsClaimLine."Shortcut Dimension 7 Code");
                // GenJnlLine.ValidateShortcutDimCode(8,FundsClaimLine."Shortcut Dimension 8 Code");
                GenJnlLine.Description := UpperCase(CopyStr(FundsClaimHeader.Description, 1, 249));
                GenJnlLine.Description2 := UpperCase(CopyStr(FundsClaimHeader."Payee Name", 1, 249));
                GenJnlLine.Validate(Description);
                GenJnlLine."Employee Transaction Type" := FundsClaimLine."Employee Transaction Type";
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;
            //*************************************End Add Line Amounts**********************************************************//
            until FundsClaimLine.Next = 0;
        end;
        //*********************************************End Add Funds Claim Lines************************************************************//
        Commit;
        //********************************************Post the Journal Lines************************************************************//
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", "Journal Template");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        if not Preview then begin
            //Post the Journal Lines
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            BankLedgerEntries.Reset;
            BankLedgerEntries.SetRange(BankLedgerEntries."Document No.", FundsClaimHeader."No.");
            if BankLedgerEntries.FindFirst then begin
                FundsClaimHeader2.Reset;
                FundsClaimHeader2.SetRange("No.", FundsClaimHeader."No.");
                if FundsClaimHeader2.FindFirst then begin
                    FundsClaimHeader2.Status := FundsClaimHeader2.Status::Posted;
                    FundsClaimHeader2.Posted := true;
                    FundsClaimHeader2."Posted By" := UserId;
                    FundsClaimHeader2."Date Posted" := Today;
                    FundsClaimHeader2."Time Posted" := Time;
                    FundsClaimHeader2.Modify;
                    FundsClaimLine2.Reset;
                    FundsClaimLine2.SetRange("Document No.", FundsClaimHeader2."No.");
                    if FundsClaimLine2.FindSet then begin
                        repeat
                            FundsClaimLine2.Status := FundsClaimLine2.Status::Posted;
                            FundsClaimLine2.Posted := true;
                            FundsClaimLine2."Posted By" := UserId;
                            FundsClaimLine2."Date Posted" := Today;
                            FundsClaimLine2."Time Posted" := Time;
                            FundsClaimLine2.Modify;
                        until FundsClaimLine2.Next = 0;
                    end;
                end;
            end;
            Commit;
            //***********************************************End Update Document************************************************************//
        end else begin
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange("Journal Template Name", "Journal Template");
            GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
            if GenJnlLine.FindSet then begin
                GenJnlPost.Preview(GenJnlLine);
            end;
            //**********************************************End Preview Posting*************************************************************//
        end;
    end;

    procedure CheckFundsClaimMandatoryFields("Funds Claim Header": Record "Funds Claim Header"; Posting: Boolean)
    var
        EmptyFundsClaimLine: Label 'You cannot Post Funds Claim with empty Line';
        FundsClaimHeader: Record "Funds Claim Header";
        FundsClaimLine: Record "Funds Claim Line";
    begin
        FundsClaimHeader.TransferFields("Funds Claim Header", true);
        FundsClaimHeader.TestField("Posting Date");
        if FundsClaimHeader."Payment Mode" = FundsClaimHeader."Payment Mode"::Cheque then begin
            FundsClaimHeader.TestField("Reference No.");
        end;
        FundsClaimHeader.TestField("Payee No.");
        FundsClaimHeader.TestField(Description);
        FundsClaimHeader.TestField("Global Dimension 1 Code");
        if Posting then begin
            FundsClaimHeader.TestField("Bank Account No.");
            FundsClaimHeader.TestField(Status, FundsClaimHeader.Status::Released);
        end;

        //Check Funds Claim Lines
        FundsClaimLine.Reset;
        FundsClaimLine.SetRange("Document No.", FundsClaimHeader."No.");
        if FundsClaimLine.FindSet then begin
            repeat
                FundsClaimLine.TestField("Account No.");
                FundsClaimLine.TestField(Amount);
                FundsClaimLine.TestField(Description);
                FundsClaimLine.TestField("Global Dimension 1 Code");
                if FundsClaimLine."Account Type" = FundsClaimLine."Account Type"::"G/L Account" then begin
                    FundsClaimLine.TestField("Global Dimension 2 Code");
                    /*
                    FundsClaimLine.TESTFIELD("Shortcut Dimension 3 Code");
                    FundsClaimLine.TESTFIELD("Shortcut Dimension 4 Code");
                    FundsClaimLine.TESTFIELD("Shortcut Dimension 5 Code");
                    FundsClaimLine.TESTFIELD("Shortcut Dimension 6 Code");
                    */
                end;
            until FundsClaimLine.Next = 0;
        end else begin
            Error(EmptyFundsClaimLine);
        end;

    end;

    local procedure CustomerLinesExist("Payment Header": Record "Payment Header"): Boolean
    var
        "Payment Line": Record "Payment Line";
        "Payment Line2": Record "Payment Line";
    begin
        "Payment Line".Reset;
        "Payment Line".SetRange("Payment Line"."Document No.", "Payment Header"."No.");
        "Payment Line".SetRange("Payment Line"."Account Type", "Payment Line"."Account Type"::Customer);
        if "Payment Line".FindFirst then begin
            exit(true);
        end else begin
            exit(false)
        end;
    end;

    procedure SendVendorEmail(DocumentNo: Code[50]; AccountNo: Code[20]; Amount: Decimal)
    var
        Payment: Record "Payment Line";
        VendorAccount: Record Vendor;
    begin
        VendorAccount.Reset;
        VendorAccount.SetRange(VendorAccount."No.", AccountNo);
        VendorAccount.SetFilter(VendorAccount."E-Mail", '<>%1', '');
        if VendorAccount.FindFirst then begin
            //   SMTP.Get;
            //   SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",VendorAccount."E-Mail",'Payment No: ' +DocumentNo,'',true);
            //   SMTPMail.AppendBody('Dear'+' '+VendorAccount.Name+',');
            //   SMTPMail.AppendBody('<br><br>');
            //   SMTPMail.AppendBody('Payment voucher '+DocumentNo+' has been approved and funds will be available in your account within 5 working days');
            //   SMTPMail.AppendBody('<br><br>');
            //   SMTPMail.AppendBody('Thank you.');
            //   SMTPMail.AppendBody('<br><br>');
            //   SMTPMail.AppendBody(SMTP."Sender Name");
            //   SMTPMail.AppendBody('<br><br>');
            //   SMTPMail.AppendBody('This is a system generated mail. Please do not reply to this Email');
            //   SMTPMail.Send;
        end;
    end;

    procedure FnCreateGnlJournalLine(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        //GenJournalLine."Transaction Type":=TransactionType;
        //GenJournalLine."Loan No":=LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        //GenJournalLine."Shortcut Dimension 1 Code":=DimensionActivity;
        //GenJournalLine."Shortcut Dimension 2 Code":=FnGetUserBranch();
        //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    procedure PostDocumentReversal("Reversal Header": Record "Document Reversal Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        ReversalLine: Record "Document Reversal Line";
        ReversalHeader: Record "Document Reversal Header";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        ReversalLine2: Record "Document Reversal Line";
        ReversalHeader2: Record "Document Reversal Header";
        DocumentExist: Label 'Imprest document is already posted. Document No.:%1  already exists in Bank No:%2';
        PaymentHeader: Record "Payment Header";
        ReceiptHeader: Record "Receipt Header";
        FundsTransferHeader: Record "Funds Transfer Header";
        GLEntry: Record "G/L Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        EmployeeLedgerEntry: Record "Employee Ledger Entry";
        DetailedEmployeeLedgerEntry: Record "Detailed Employee Ledger Entry";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        ReversalHeader.TransferFields("Reversal Header", true);
        SourceCode := IMPJNL;

        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        LineNo := 1000;
        //********************************************Add Imprest Header*******************************************************//
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := Today;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := ReversalHeader."Document No.";
        GenJnlLine."Account Type" := ReversalHeader."Account Type";
        GenJnlLine."Account No." := ReversalHeader."Account No.";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        //GenJnlLine."Posting Group":=ReversalHeader."Employee Posting Group";
        //GenJnlLine.VALIDATE("Posting Group");
        //GenJnlLine."Currency Code":=ReversalHeader."Currency Code";
        //GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
        if (ReversalHeader."Document Type" = ReversalHeader."Document Type"::Payment) or (ReversalHeader."Document Type" = ReversalHeader."Document Type"::"Funds Transfer") then begin
            GenJnlLine.Amount := ReversalHeader.Amount;
        end else begin
            GenJnlLine.Amount := ReversalHeader.Amount * -1;
        end;
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := ReversalHeader."Shortcut Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := ReversalHeader."Shortcut Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, ReversalHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, ReversalHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, ReversalHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, ReversalHeader."Shortcut Dimension 6 Code");
        //GenJnlLine.ValidateShortcutDimCode(7,ReversalHeader."Shortcut Dimension 7 Code");
        //GenJnlLine.ValidateShortcutDimCode(8,ReversalHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := UpperCase(CopyStr(ReversalHeader.Description, 1, 249));
        GenJnlLine.Description2 := UpperCase(CopyStr(ReversalHeader.Description + ' Reversal', 1, 249));
        GenJnlLine.Validate(GenJnlLine.Description);
        GenJnlLine."Employee Transaction Type" := GenJnlLine."Employee Transaction Type"::Imprest;
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;

        ReversalLine.Reset;
        ReversalLine.SetRange(ReversalLine."No.", ReversalHeader."No.");
        ReversalLine.SetFilter(ReversalLine.Amount, '<>%1', 0);
        if ReversalLine.FindSet then begin
            repeat
                //****************************************Add Line NetAmounts***********************************************************//
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Today;
                GenJnlLine."Document No." := ReversalLine."Document No.";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Account Type" := ReversalLine."Account Type";
                GenJnlLine."Account No." := ReversalLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                /*GenJnlLine."External Document No.":=ReversalHeader."Reference No.";
                GenJnlLine."Currency Code":=ReversalHeader."Currency Code";
                GenJnlLine.VALIDATE("Currency Code");*/
                if (ReversalHeader."Document Type" = ReversalHeader."Document Type"::Payment) or (ReversalHeader."Document Type" = ReversalHeader."Document Type"::"Funds Transfer") then begin
                    GenJnlLine.Amount := ReversalLine.Amount * -1;
                end else begin
                    GenJnlLine.Amount := ReversalLine.Amount;
                end;
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := ReversalHeader."Shortcut Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := ReversalHeader."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, ReversalHeader."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, ReversalHeader."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, ReversalHeader."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, ReversalHeader."Shortcut Dimension 6 Code");
                GenJnlLine.ValidateShortcutDimCode(7, ReversalHeader."Shortcut Dimension 7 Code");
                GenJnlLine.ValidateShortcutDimCode(8, ReversalHeader."Shortcut Dimension 8 Code");
                GenJnlLine.Description := CopyStr(ReversalHeader.Description, 1, 249);
                GenJnlLine.Description2 := UpperCase(CopyStr("Reversal Header".Description + ' Reversal', 1, 249));
                GenJnlLine.Validate(GenJnlLine.Description);
                // GenJnlLine."Applies-to Doc. Type":=ReversalLine."Applies-to Doc. Type";
                // GenJnlLine."Applies-to ID":=ReversalLine."Applies-to ID";
                // GenJnlLine."Applies-to Doc. No.":=ReversalLine."Applies-to Doc. No.";
                /* GenJnlLine."Employee Transaction Type":=ReversalLine."Employee Transaction Type";
                 GenJnlLine."Loan Application No.":=ReversalLine."Investment Application No.";
                 GenJnlLine."Loan Account No.":=ReversalLine."Investment Account No.";*/
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;
            until ReversalLine.Next = 0;
        end;

        Commit;

        //********************************************Post the Journal Lines************************************************************//
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        if not Preview then begin
            //Now Post the Journal Lines
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            ReversalHeader2.Reset;
            ReversalHeader2.SetRange(ReversalHeader2."No.", ReversalHeader."No.");
            if ReversalHeader2.FindFirst then begin
                ReversalHeader2."Reversal Posted" := true;
                ReversalHeader2."Reversal Posted By" := UserId;
                ReversalHeader2."Reversal Posting Date" := Today;
                ReversalHeader2.Modify;
                if ReversalHeader2."Document Type" = ReversalHeader2."Document Type"::Payment then begin
                    PaymentHeader.Reset;
                    PaymentHeader.SetRange(PaymentHeader."No.", ReversalHeader2."Document No.");
                    if PaymentHeader.FindFirst then begin
                        PaymentHeader.Reversed := true;
                        PaymentHeader.Modify;
                    end;
                end else if ReversalHeader2."Document Type" = ReversalHeader2."Document Type"::Receipt then begin
                    ReceiptHeader.Reset;
                    ReceiptHeader.SetRange(ReceiptHeader."No.", ReversalHeader2."Document No.");
                    if ReceiptHeader.FindFirst then begin
                        ReceiptHeader.Reversed := true;
                        ReceiptHeader.Modify;
                    end;
                end else if ReversalHeader2."Document Type" = ReversalHeader2."Document Type"::"Funds Transfer" then begin
                    FundsTransferHeader.Reset;
                    FundsTransferHeader.SetRange(FundsTransferHeader."No.", ReversalHeader2."Document No.");
                    if FundsTransferHeader.FindFirst then begin
                        FundsTransferHeader.Reversed := true;
                        FundsTransferHeader.Modify;
                    end;
                end;
                GLEntry.Reset;
                GLEntry.SetRange(GLEntry."Document No.", "Reversal Header"."Document No.");
                GLEntry.SetRange(GLEntry.Reversed, false);
                if GLEntry.FindSet then begin
                    repeat
                        GLEntry.Reversed := true;
                        GLEntry.Modify;
                    until GLEntry.Next = 0;
                end;
                CustEntry.Reset;
                CustEntry.SetRange(CustEntry."Document No.", "Reversal Header"."Document No.");
                CustEntry.SetRange(CustEntry.Reversed, false);
                if CustEntry.FindSet then begin
                    repeat
                        CustEntry.Reversed := true;
                        CustEntry.Modify;
                    until CustEntry.Next = 0;
                end;
                BankAccountLedgerEntry.Reset;
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Document No.", "Reversal Header"."Document No.");
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry.Reversed, false);
                if BankAccountLedgerEntry.FindSet then begin
                    repeat
                        BankAccountLedgerEntry.Reversed := true;
                        BankAccountLedgerEntry.Modify;
                    until BankAccountLedgerEntry.Next = 0;
                end;
                VendorLedgerEntry.Reset;
                VendorLedgerEntry.SetRange(VendorLedgerEntry."Document No.", "Reversal Header"."Document No.");
                VendorLedgerEntry.SetRange(VendorLedgerEntry.Reversed, false);
                if VendorLedgerEntry.FindSet then begin
                    repeat
                        VendorLedgerEntry.Reversed := true;
                        VendorLedgerEntry.Modify;
                    until VendorLedgerEntry.Next = 0;
                end;
                /* DetailedVendorLedgEntry.RESET;
                  DetailedVendorLedgEntry.SETRANGE(DetailedVendorLedgEntry."Document No.","Reversal Header"."Document No.");
                  DetailedVendorLedgEntry.SETRANGE(DetailedVendorLedgEntry.Reversed,FALSE);
                  IF DetailedVendorLedgEntry.FINDSET THEN BEGIN
                  REPEAT
                    DetailedVendorLedgEntry.Reversed:=TRUE;
                    DetailedVendorLedgEntry.MODIFY;
                  UNTIL DetailedVendorLedgEntry.NEXT=0;
                 END; */
                EmployeeLedgerEntry.Reset;
                EmployeeLedgerEntry.SetRange(EmployeeLedgerEntry."Document No.", "Reversal Header"."Document No.");
                EmployeeLedgerEntry.SetRange(EmployeeLedgerEntry.Reversed, false);
                if EmployeeLedgerEntry.FindSet then begin
                    repeat
                        EmployeeLedgerEntry.Reversed := true;
                        EmployeeLedgerEntry.Modify;
                    until EmployeeLedgerEntry.Next = 0;
                end;
                /* DetailedEmployeeLedgerEntry.RESET;
                 DetailedEmployeeLedgerEntry.SETRANGE(DetailedEmployeeLedgerEntry."Document No.","Reversal Header"."Document No.");
                 DetailedEmployeeLedgerEntry.SETRANGE(DetailedEmployeeLedgerEntry.Reversed,FALSE);
                 IF DetailedEmployeeLedgerEntry.FINDSET THEN BEGIN
                 REPEAT
                   DetailedEmployeeLedgerEntry.Reversed:=TRUE;
                   DetailedEmployeeLedgerEntry.MODIFY;
                 UNTIL DetailedEmployeeLedgerEntry.NEXT=0;
                END;*/
            end;



            //**********************************************End Update Document***************************************************************//
        end else begin
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange("Journal Template Name", "Journal Template");
            GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
            if GenJnlLine.FindSet then begin
                GenJnlPost.Preview(GenJnlLine);
            end;
            //**********************************************End Preview Posting*************************************************************//
        end;

    end;

    procedure CreateEmployeeLoanReceipt(LineNo: Integer)
    var
        ReceiptHeader: Record "Receipt Header";
        ReceiptLine: Record "Receipt Line";
        Employee: Record Employee;
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        EmployeeLoanProducts: Record "Employee Loan Products";
        EmployeeLoanAccounts: Record "Employee Loan Accounts";
    begin
        /*insert receipt header
        FundsGeneralSetup.GET;
        
        ReceiptHeader.INIT;
        ReceiptHeader."No.":=NoSeriesManagement.GetNextNo(FundsGeneralSetup."Receipt Nos.",0D,TRUE);
        ReceiptHeader."Posting Date":=TODAY;
        ReceiptHeader."Payment Mode":=ReceiptHeader."Payment Mode"::" ";
        ReceiptHeader."Receipt Types":=ReceiptHeader."Receipt Types"::"G/L Account";
        ReceiptHeader."Receipt Type":=ReceiptHeader."Receipt Type"::"Staff Loan";
        FundsTransactionCode.RESET;
        FundsTransactionCode.SETRANGE("Loan Transaction Type",FundsTransactionCode."Loan Transaction Type"::"Staff Loan");
        IF FundsTransactionCode.FINDFIRST THEN
         ReceiptHeader."Account No.":=FundsTransactionCode."Transaction Code";
        ReceiptHeader.VALIDATE("Account No.");
        ReceiptHeader."Amount Received":=EmployeeDeduction.Amount;
        ReceiptHeader.VALIDATE("Amount Received");
        IF Employee.GET(EmployeeDeduction."Employee No.") THEN
         ReceiptHeader."Received From":=Employee."First Name"+' '+Employee."Middle Name"+' '+Employee."Last Name";
        ReceiptHeader.Description:='Loan'+ EmployeeDeduction."Loan No."+ ' repayment';
        ReceiptHeader.INSERT;
        
        //insert lines+1;
        CustomerLedgerEntry.RESET;
        CustomerLedgerEntry.SETRANGE("Customer No.",EmployeeDeduction."Employee No.");
        CustomerLedgerEntry.SETFILTER("Investment Transaction Type",'=%1|%2',2,4);
        CustomerLedgerEntry.SETFILTER(Amount,'>%1',0);
        IF CustomerLedgerEntry.FINDSET THEN BEGIN
          REPEAT
            CustomerLedgerEntry.CALCFIELDS("Remaining Amount");
            CustomerLedgerEntry.SETFILTER("Remaining Amount",'<>%1',0);
            LineNo:=LineNo+1;
            ReceiptLine.INIT;
            ReceiptLine."Line No.":=LineNo;
            ReceiptLine."Document No.":=ReceiptHeader."No.";
            ReceiptLine."Receipt Code":='EMPLOYEE';
            ReceiptLine."Account Type":=ReceiptLine."Account Type"::Customer;
            ReceiptLine."Account No.":=EmployeeDeduction."Employee No.";
            ReceiptLine.VALIDATE("Account No.");
            ReceiptLine.Description:='Loan '+ EmployeeDeduction."Loan No."+ ' repayment';
            ReceiptLine.Amount:=CustomerLedgerEntry."Remaining Amount";
            ReceiptLine.VALIDATE(Amount);
        
            ReceiptLine."Applies-to Doc. No.":=CustomerLedgerEntry."Document No.";
            ReceiptLine."Loan Account No.":=CustomerLedgerEntry."Investment Account No.";
            IF CustomerLedgerEntry."Investment Transaction Type" = CustomerLedgerEntry."Investment Transaction Type"::"Interest Receivable" THEN BEGIN
             ReceiptLine."Loan Transaction Type" := CustomerLedgerEntry."Investment Transaction Type"::"Interest Payment";
             IF EmployeeLoanAccounts.GET(ReceiptLine."Loan Account No.") THEN BEGIN
              IF EmployeeLoanProducts.GET(EmployeeLoanAccounts."Loan Product Code") THEN
               ReceiptLine."Posting Group":=EmployeeLoanProducts."Interest Receivable PG";
             END;
            END;
            IF CustomerLedgerEntry."Investment Transaction Type" = CustomerLedgerEntry."Investment Transaction Type"::"Principal Receivable" THEN BEGIN
              ReceiptLine."Loan Transaction Type" := CustomerLedgerEntry."Investment Transaction Type"::"Principal Payment";
             IF EmployeeLoanAccounts.GET(ReceiptLine."Loan Account No.") THEN BEGIN
              IF EmployeeLoanProducts.GET(EmployeeLoanAccounts."Loan Product Code") THEN
               ReceiptLine."Posting Group":=EmployeeLoanProducts."Principal Receivable PG";
             END;
            END;
            ReceiptLine.INSERT;
          UNTIL CustomerLedgerEntry.NEXT = 0;
        END;
        */

    end;

    procedure PostLoanReceipts(ReceiptHeader: Record "Receipt Header"; JournalTemplate: Code[20]; JournalBatch: Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        FundsTransactionCode: Record "Funds Transaction Code";
        ReceiptLine: Record "Receipt Line";
        EmployeeLedgerEntry: Record "Employee Ledger Entry";
        ReceiptHeader2: Record "Receipt Header";
    begin
        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JournalTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JournalBatch);
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        LineNo := 1000;

        //add header
        LineNo := LineNo + 1;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := JournalTemplate;
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Journal Batch Name" := JournalBatch;
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
        GenJnlLine."Document No." := ReceiptHeader."No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        if FundsTransactionCode.Get(ReceiptHeader."Account No.") then
            GenJnlLine."Account No." := FundsTransactionCode."Account No.";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine."Currency Code" := '';
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        GenJnlLine.Amount := ReceiptHeader."Amount Received";  //Credit Amount
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
        GenJnlLine.Description := ReceiptHeader.Description;
        GenJnlLine.Validate(GenJnlLine.Description);
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;

        ReceiptLine.Reset;
        ReceiptLine.SetRange("Document No.", ReceiptHeader."No.");
        if ReceiptLine.FindSet then begin
            repeat
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := JournalTemplate;
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JournalBatch;
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
                GenJnlLine."Document No." := ReceiptHeader."No.";
                GenJnlLine."Account Type" := ReceiptLine."Account Type";
                GenJnlLine."Account No." := ReceiptLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine.Amount := -ReceiptLine.Amount;  //credirt Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Global Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.Description := ReceiptLine.Description;
                GenJnlLine.Validate(GenJnlLine.Description);
                GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;

            until ReceiptLine.Next = 0;
        end;

        Commit;

        //post lines
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JournalTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JournalBatch);
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        AdjustGenJnl.Run(GenJnlLine);

        //Now Post the Journal Lines
        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Line", GenJnlLine);

        //end posting
        Commit;

        //update posted receipts
        EmployeeLedgerEntry.Reset;
        EmployeeLedgerEntry.SetRange("Document No.", ReceiptHeader."No.");
        if EmployeeLedgerEntry.FindFirst then begin
            ReceiptHeader2.Reset;
            ReceiptHeader2.SetRange("No.", ReceiptHeader."No.");
            if ReceiptHeader2.FindFirst then begin
                ReceiptHeader2.Status := ReceiptHeader2.Status::Posted;
                ReceiptHeader2.Posted := true;
                ReceiptHeader2."Posted By" := UserId;
                ReceiptHeader2."Date Posted" := Today;
                ReceiptHeader2."Time Posted" := Time;
                ReceiptHeader2.Modify;
            end;
        end;
    end;

    procedure CheckInvestmentReceiptCode(DocumentNumber: Code[30])
    var
        ReceiptLine: Record "Receipt Line";
    begin
        /*InvestmentGeneralSetup.GET;
        
        InvestmentGeneralSetup.TESTFIELD(InvestmentGeneralSetup."Appraisal Receipt Code");
        ReceiptLine.RESET;
        ReceiptLine.SETRANGE(ReceiptLine."Document No.",DocumentNumber);
        ReceiptLine.SETRANGE(ReceiptLine."Receipt Code",InvestmentGeneralSetup."Appraisal Receipt Code");
        IF ReceiptLine.FINDSET THEN BEGIN
          REPEAT
            ReceiptLine.TESTFIELD(ReceiptLine."Investment Application No.");
          UNTIL ReceiptLine.NEXT=0;
        END;
        */

    end;

    procedure SuggestInvestmentLoanRepayments("ReceiptNo.": Code[20])
    var
        ReceiptHeader: Record "Receipt Header";
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        LineNo: Integer;
        ReceiptLine: Record "Receipt Line";
    begin
        /*ReceiptHeader.GET("ReceiptNo.");
        //delete existing lines
        ReceiptLine.RESET;
        ReceiptLine.SETRANGE("Document No.","ReceiptNo.");
        ReceiptLine.DELETEALL;
        
        //insert lines;
        CustomerLedgerEntry.RESET;
        CustomerLedgerEntry.SETRANGE("Customer No.",ReceiptHeader."Client No.");
        CustomerLedgerEntry.SETRANGE("Investment Transaction Type",CustomerLedgerEntry."Investment Transaction Type"::"6");
        CustomerLedgerEntry.SETRANGE(Reversed,FALSE);
        IF CustomerLedgerEntry.FINDSET THEN BEGIN
          REPEAT
            CustomerLedgerEntry.CALCFIELDS("Remaining Amount");
            CustomerLedgerEntry.SETFILTER("Remaining Amount",'<>%1',0);
            ReceiptLine.INIT;
            ReceiptLine."Line No.":=0;
            ReceiptLine."Document No.":=ReceiptHeader."No.";
            ReceiptLine."Receipt Code":='CUSTOMER';
            ReceiptLine."Account Type":=ReceiptLine."Account Type"::Customer;
            ReceiptLine."Account No.":=ReceiptHeader."Client No.";
            ReceiptLine.VALIDATE("Account No.");
            ReceiptLine.Description:='Loan '+ CustomerLedgerEntry."Investment Account No."+ ' repayment';
            ReceiptLine.Amount:=CustomerLedgerEntry."Remaining Amount";
            ReceiptLine.VALIDATE(Amount);
        
            ReceiptLine."Applies-to Doc. No.":=CustomerLedgerEntry."Document No.";
            ReceiptLine."Loan Account No.":=CustomerLedgerEntry."Investment Account No.";
             ReceiptLine."Loan Transaction Type" := CustomerLedgerEntry."Investment Transaction Type"::"7";
             IF LoanAccounts.GET(ReceiptLine."Loan Account No.") THEN BEGIN
              IF InvestmentProducts.GET(LoanAccounts."Product Code") THEN
               ReceiptLine."Posting Group":=InvestmentProducts."Penalty Receivable PG";
             END;
            ReceiptLine.INSERT;
          UNTIL CustomerLedgerEntry.NEXT = 0;
         END;
          CustomerLedgerEntry.RESET;
          CustomerLedgerEntry.SETRANGE("Customer No.",ReceiptHeader."Client No.");
          CustomerLedgerEntry.SETRANGE("Investment Transaction Type",CustomerLedgerEntry."Investment Transaction Type"::"4");
          IF CustomerLedgerEntry.FINDSET THEN BEGIN
          REPEAT
            CustomerLedgerEntry.CALCFIELDS("Remaining Amount");
            CustomerLedgerEntry.SETFILTER("Remaining Amount",'<>%1',0);
            ReceiptLine.INIT;
            ReceiptLine."Line No.":=0;
            ReceiptLine."Document No.":=ReceiptHeader."No.";
            ReceiptLine."Receipt Code":='CUSTOMER';
            ReceiptLine."Account Type":=ReceiptLine."Account Type"::Customer;
            ReceiptLine."Account No.":=ReceiptHeader."Client No.";
            ReceiptLine.VALIDATE("Account No.");
            ReceiptLine.Description:='Loan '+ CustomerLedgerEntry."Investment Account No."+ ' repayment';
            ReceiptLine.Amount:=CustomerLedgerEntry."Remaining Amount";
            ReceiptLine.VALIDATE(Amount);
        
            ReceiptLine."Applies-to Doc. No.":=CustomerLedgerEntry."Document No.";
            ReceiptLine."Loan Account No.":=CustomerLedgerEntry."Investment Account No.";
             ReceiptLine."Loan Transaction Type" := CustomerLedgerEntry."Investment Transaction Type"::"5";
             IF LoanAccounts.GET(ReceiptLine."Loan Account No.") THEN BEGIN
              IF InvestmentProducts.GET(LoanAccounts."Product Code") THEN
               ReceiptLine."Posting Group":=InvestmentProducts."Interest Receivable PG";
             END;
            ReceiptLine.INSERT;
          UNTIL CustomerLedgerEntry.NEXT = 0;
        END;
        
        CustomerLedgerEntry.RESET;
        CustomerLedgerEntry.SETRANGE("Customer No.",ReceiptHeader."Client No.");
        CustomerLedgerEntry.SETRANGE("Investment Transaction Type",CustomerLedgerEntry."Investment Transaction Type"::"2");
        IF CustomerLedgerEntry.FINDSET THEN BEGIN
          REPEAT
            CustomerLedgerEntry.CALCFIELDS("Remaining Amount");
            CustomerLedgerEntry.SETFILTER("Remaining Amount",'<>%1',0);
            ReceiptLine.INIT;
            ReceiptLine."Line No.":=0;
            ReceiptLine."Document No.":=ReceiptHeader."No.";
            ReceiptLine."Receipt Code":='CUSTOMER';
            ReceiptLine."Account Type":=ReceiptLine."Account Type"::Customer;
            ReceiptLine."Account No.":=ReceiptHeader."Client No.";
            ReceiptLine.VALIDATE("Account No.");
            ReceiptLine.Description:='Loan '+ CustomerLedgerEntry."Investment Account No."+ ' repayment';
            ReceiptLine.Amount:=CustomerLedgerEntry."Remaining Amount";
            ReceiptLine.VALIDATE(Amount);
        
            ReceiptLine."Applies-to Doc. No.":=CustomerLedgerEntry."Document No.";
            ReceiptLine."Loan Account No.":=CustomerLedgerEntry."Investment Account No.";
             ReceiptLine."Loan Transaction Type" := CustomerLedgerEntry."Investment Transaction Type"::"3";
             IF LoanAccounts.GET(ReceiptLine."Loan Account No.") THEN BEGIN
              IF InvestmentProducts.GET(LoanAccounts."Product Code") THEN
               ReceiptLine."Posting Group":=InvestmentProducts."Principal Receivable PG";
             END;
            ReceiptLine.INSERT;
          UNTIL CustomerLedgerEntry.NEXT=0;
        END;
        */

    end;

    procedure MarkImprestAsPosted(PaymentNumber: Code[30])
    var
        ImprestHeader: Record "Imprest Header";
        PaymentLine: Record "Payment Line";
    begin
        PaymentLine.Reset;
        PaymentLine.SetRange(PaymentLine."Document No.", PaymentNumber);
        if PaymentLine.FindSet then begin
            repeat
                ImprestHeader.Reset;
                ImprestHeader.SetRange(ImprestHeader."No.", PaymentLine."Payee No.");
                if ImprestHeader.FindFirst then begin
                    //IF (ImprestHeader."Imprest Type"=ImprestHeader."Imprest Type"::"General Imprest") OR (ImprestHeader."Imprest Type"=ImprestHeader."Imprest Type"::Safari) THEN BEGIN
                    ImprestHeader.Status := ImprestHeader.Status::Posted;
                    ImprestHeader.Posted := true;
                    ImprestHeader."Posted By" := UserId;
                    ImprestHeader."Posting Date" := Today;
                    if ImprestHeader."Imprest Type" = ImprestHeader."Imprest Type"::Pettycash then begin
                        ImprestHeader.Surrendered := true;
                        ImprestHeader."Surrender status" := ImprestHeader."Surrender status"::"Fully surrendered";
                    end;
                    ImprestHeader.Modify;
                end;
            until PaymentLine.Next = 0;
        end;
    end;

    procedure CreateApplicationDocuments("ReceiptNo.": Code[20]; LoanAccountNo: Code[20]; CustomerNo: Code[20])
    var
        ReceiptHeader: Record "Receipt Header";
        ReceiptLine: Record "Receipt Line";
    begin
        /*LoanAccounts.RESET;
        LoanAccounts.SETRANGE("Customer No.",CustomerNo);
        LoanAccounts.SETRANGE("No.",LoanAccountNo);
        IF LoanAccounts.FINDSET THEN BEGIN
          REPEAT
            LoanAccounts.SETCURRENTKEY("Date Created");
            CreateLoanAccountApplication(LoanAccounts."No.","ReceiptNo.",CustomerNo);
          UNTIL LoanAccounts.NEXT =0;
        END;*/

    end;

    procedure CreateLoanAccountApplication("LoanAccountNo.": Code[20]; "ReceiptNo.": Code[20]; CustomerNo: Code[20])
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        ReceiptHeader: Record "Receipt Header";
        ReceiptLine: Record "Receipt Line";
        TotalDueAmounts: Decimal;
        AmountApplied: Decimal;
        RemainingAppliedAmount: Decimal;
        AmountApplied2: Decimal;
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        PenaltyReceivable: Decimal;
        InterestReceivable: Decimal;
        PrincipalReceivable: Decimal;
    begin
        /*//get total amount
        ReceiptHeader.GET("ReceiptNo.");
        //ReceiptLine.GET("ReceiptNo.");
        FundsGeneralSetup.GET;
        FundsGeneralSetup.TESTFIELD("Loan Receipt Nos.");
        
        TotalDueAmounts:=0;
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE("Customer No.",CustomerNo);
        CustLedgerEntry.SETRANGE("Investment Account No.","LoanAccountNo.");
        CustLedgerEntry.SETRANGE("Due Date",0D,ReceiptHeader."Posting Date");
        IF CustLedgerEntry.FINDSET THEN BEGIN
          REPEAT
            CustLedgerEntry.CALCFIELDS("Remaining Amount");
            TotalDueAmounts:=TotalDueAmounts+CustLedgerEntry."Remaining Amount";
          UNTIL CustLedgerEntry.NEXT =0;
        END;
        
        IF TotalDueAmounts < ReceiptHeader."Amount Received" THEN BEGIN
          //create document header
          AccountApplicationHeader.INIT;
          AccountApplicationHeader."No.":=NoSeriesManagement.GetNextNo(FundsGeneralSetup."Loan Receipt Nos.",0D,TRUE);
          AccountApplicationHeader."Document Date":=TODAY;
          AccountApplicationHeader."Posting Date":=ReceiptHeader."Posting Date";
          AccountApplicationHeader."Customer No.":=ReceiptLine."Account No.";
          AccountApplicationHeader."Customer Name":=ReceiptLine."Account Name";
          AccountApplicationHeader."Account Type":=AccountApplicationHeader."Account Type"::"1";
          AccountApplicationHeader."Account No.":="LoanAccountNo.";
          AccountApplicationHeader."Currency Code":=ReceiptHeader."Currency Code";
          AccountApplicationHeader."Created By":=USERID;
          AccountApplicationHeader."Date Created":=TODAY;
          AccountApplicationHeader."Time Created":=TIME;
          AccountApplicationHeader."User ID":=USERID;
          AccountApplicationHeader.INSERT;
        
          //create document lines
          CustLedgerEntry.RESET;
          CustLedgerEntry.SETRANGE("Customer No.",CustomerNo);
          CustLedgerEntry.SETRANGE("Investment Account No.","LoanAccountNo.");
          CustLedgerEntry.SETRANGE("Due Date",0D,ReceiptHeader."Posting Date");
          IF CustLedgerEntry.FINDSET THEN BEGIN
            REPEAT
              AccountApplicationLine.INIT;
              AccountApplicationLine."Line No.":=0;
              AccountApplicationLine."Document No.":=AccountApplicationHeader."No.";
              AccountApplicationLine."Posting Date":=ReceiptHeader."Posting Date";
              AccountApplicationLine."Account Type":=AccountApplicationLine."Account Type"::"2";
              AccountApplicationLine."Account No.":="LoanAccountNo.";
              AccountApplicationLine."Receipt No.":=ReceiptHeader."No.";
              AccountApplicationLine."Customer No.":=ReceiptLine."Account No.";
              AccountApplicationLine."Customer Name":=ReceiptLine."Account Name";
        
              //Interest
              IF CustLedgerEntry."Investment Transaction Type" = CustLedgerEntry."Investment Transaction Type"::"4" THEN BEGIN
               AccountApplicationLine."Transaction Type" := AccountApplicationLine."Transaction Type"::"2";
               IF LoanAccounts.GET(AccountApplicationLine."Account No.") THEN BEGIN
                IF InvestmentProducts.GET(LoanAccounts."Product Code") THEN
                 AccountApplicationLine."Posting Group":=InvestmentProducts."Interest Receivable PG";
                 AccountApplicationLine."Applied Amount":=CustLedgerEntry."Remaining Amount";
               END;
              END;
              //principal
              IF CustLedgerEntry."Investment Transaction Type" = CustLedgerEntry."Investment Transaction Type"::"2" THEN BEGIN
                AccountApplicationLine."Transaction Type" := AccountApplicationLine."Transaction Type"::"1";
               IF LoanAccounts.GET(AccountApplicationLine."Account No.") THEN BEGIN
                IF InvestmentProducts.GET(LoanAccounts."Product Code") THEN
                 AccountApplicationLine."Posting Group":=InvestmentProducts."Principal Receivable PG";
                 AccountApplicationLine."Applied Amount":=CustLedgerEntry."Remaining Amount";
               END;
              END;
              //penalty
              IF CustLedgerEntry."Investment Transaction Type" = CustLedgerEntry."Investment Transaction Type"::"6" THEN BEGIN
                AccountApplicationLine."Transaction Type" := AccountApplicationLine."Transaction Type"::"3";
               IF LoanAccounts.GET(AccountApplicationLine."Account No.") THEN BEGIN
                IF InvestmentProducts.GET(LoanAccounts."Product Code") THEN
                 AccountApplicationLine."Posting Group":=InvestmentProducts."Penalty Receivable PG";
                 AccountApplicationLine."Applied Amount":=CustLedgerEntry."Remaining Amount";
               END;
              END;
              AccountApplicationLine.INSERT;
            UNTIL CustLedgerEntry.NEXT =0;
          END;
        
        END ELSE BEGIN
         //create document header
          AccountApplicationHeader.INIT;
          AccountApplicationHeader."No.":=NoSeriesManagement.GetNextNo(FundsGeneralSetup."Loan Receipt Nos.",0D,TRUE);
          AccountApplicationHeader."Document Date":=TODAY;
          AccountApplicationHeader."Posting Date":=ReceiptHeader."Posting Date";
          AccountApplicationHeader."Customer No.":=ReceiptLine."Account No.";
          AccountApplicationHeader."Customer Name":=ReceiptLine."Account Name";
          AccountApplicationHeader."Account Type":=AccountApplicationHeader."Account Type"::"1";
          AccountApplicationHeader."Account No.":="LoanAccountNo.";
          AccountApplicationHeader."Currency Code":=ReceiptHeader."Currency Code";
          AccountApplicationHeader."Created By":=USERID;
          AccountApplicationHeader."Date Created":=TODAY;
          AccountApplicationHeader."Time Created":=TIME;
          AccountApplicationHeader."User ID":=USERID;
          AccountApplicationHeader.INSERT;
        
          AmountApplied:=0;
          RemainingAppliedAmount:=0;
          AmountApplied2:=0;
          //create document lines
          CustLedgerEntry.RESET;
          CustLedgerEntry.SETRANGE("Customer No.",CustomerNo);
          CustLedgerEntry.SETRANGE("Investment Account No.","LoanAccountNo.");
          CustLedgerEntry.SETRANGE("Due Date",0D,ReceiptHeader."Posting Date");
          IF CustLedgerEntry.FINDSET THEN BEGIN
            REPEAT
              AccountApplicationLine.INIT;
              AccountApplicationLine."Line No.":=0;
              AccountApplicationLine."Document No.":=AccountApplicationHeader."No.";
              AccountApplicationLine."Posting Date":=ReceiptHeader."Posting Date";
              AccountApplicationLine."Account Type":=AccountApplicationLine."Account Type"::"2";
              AccountApplicationLine."Account No.":="LoanAccountNo.";
              AccountApplicationLine."Receipt No.":=ReceiptHeader."No.";
              AccountApplicationLine."Customer No.":=ReceiptLine."Account No.";
              AccountApplicationLine."Customer Name":=ReceiptLine."Account Name";
        
              //penalty
              PenaltyReceivable:=0;
              CustLedgerEntry2.RESET;
              CustLedgerEntry2.SETRANGE("Customer No.",CustomerNo);
              CustLedgerEntry2.SETRANGE("Investment Account No.","LoanAccountNo.");
              CustLedgerEntry2.SETRANGE("Due Date",0D,ReceiptHeader."Posting Date");
              CustLedgerEntry2.SETRANGE("Investment Transaction Type",CustLedgerEntry2."Investment Transaction Type"::"6");
              IF CustLedgerEntry2.FINDSET THEN BEGIN
               REPEAT
                 CustLedgerEntry2.CALCFIELDS(CustLedgerEntry2."Remaining Amount");
                 PenaltyReceivable:=PenaltyReceivable+CustLedgerEntry2."Remaining Amount";
        
                 AccountApplicationLine."Transaction Type" := AccountApplicationLine."Transaction Type"::"3";
                 IF LoanAccounts.GET(AccountApplicationLine."Account No.") THEN BEGIN
                  IF InvestmentProducts.GET(LoanAccounts."Product Code") THEN
                   AccountApplicationLine."Posting Group":=InvestmentProducts."Penalty Receivable PG";
        
                  IF PenaltyReceivable < ReceiptHeader."Amount Received" THEN
                   AccountApplicationLine."Applied Amount":=PenaltyReceivable
                  ELSE
                   AccountApplicationLine."Applied Amount":=ReceiptHeader."Amount Received";
                 END;
                 AmountApplied:=AmountApplied+AccountApplicationLine."Applied Amount";
                 UNTIL CustLedgerEntry2.NEXT=0;
               END;
        
              //Interest
              IF AmountApplied < ReceiptHeader."Amount Received" THEN BEGIN
                InterestReceivable:=0;
                CustLedgerEntry2.RESET;
                CustLedgerEntry2.SETRANGE("Customer No.",CustomerNo);
                CustLedgerEntry2.SETRANGE("Investment Account No.","LoanAccountNo.");
                CustLedgerEntry2.SETRANGE("Due Date",0D,ReceiptHeader."Posting Date");
                CustLedgerEntry2.SETRANGE("Investment Transaction Type",CustLedgerEntry2."Investment Transaction Type"::"4");
                IF CustLedgerEntry2.FINDSET THEN BEGIN
                 REPEAT
                   CustLedgerEntry2.CALCFIELDS(CustLedgerEntry2."Remaining Amount");
                   InterestReceivable:=InterestReceivable+CustLedgerEntry2."Remaining Amount";
        
                   AccountApplicationLine."Transaction Type" := AccountApplicationLine."Transaction Type"::"2";
                   IF LoanAccounts.GET(AccountApplicationLine."Account No.") THEN BEGIN
                    IF InvestmentProducts.GET(LoanAccounts."Product Code") THEN
                     AccountApplicationLine."Posting Group":=InvestmentProducts."Interest Receivable PG";
        
                    IF InterestReceivable < ReceiptHeader."Amount Received" THEN
                     AccountApplicationLine."Applied Amount":=InterestReceivable
                    ELSE
                     AccountApplicationLine."Applied Amount":=ReceiptHeader."Amount Received";
                   END;
                   AmountApplied2:=AmountApplied2+AmountApplied+AccountApplicationLine."Applied Amount";
                   UNTIL CustLedgerEntry2.NEXT=0;
                 END;
                END;
        
              //principal
              IF AmountApplied2 < ReceiptHeader."Amount Received" THEN BEGIN
                PrincipalReceivable:=0;
                CustLedgerEntry2.RESET;
                CustLedgerEntry2.SETRANGE("Customer No.",CustomerNo);
                CustLedgerEntry2.SETRANGE("Investment Account No.","LoanAccountNo.");
                CustLedgerEntry2.SETRANGE("Due Date",0D,ReceiptHeader."Posting Date");
                CustLedgerEntry2.SETRANGE("Investment Transaction Type",CustLedgerEntry2."Investment Transaction Type"::"2");
                IF CustLedgerEntry2.FINDSET THEN BEGIN
                 REPEAT
                   CustLedgerEntry2.CALCFIELDS(CustLedgerEntry2."Remaining Amount");
                   InterestReceivable:=InterestReceivable+CustLedgerEntry2."Remaining Amount";
        
                   AccountApplicationLine."Transaction Type" := AccountApplicationLine."Transaction Type"::"1";
                   IF LoanAccounts.GET(AccountApplicationLine."Account No.") THEN BEGIN
                    IF InvestmentProducts.GET(LoanAccounts."Product Code") THEN
                     AccountApplicationLine."Posting Group":=InvestmentProducts."Principal Receivable PG";
        
                    IF PrincipalReceivable < ReceiptHeader."Amount Received" THEN
                     AccountApplicationLine."Applied Amount":=PrincipalReceivable
                    ELSE
                     AccountApplicationLine."Applied Amount":=ReceiptHeader."Amount Received";
                   END;
                   UNTIL CustLedgerEntry2.NEXT=0;
                 END;
                END;
              AccountApplicationLine.INSERT;
            UNTIL CustLedgerEntry.NEXT =0;
          END;
        END;
        */

    end;

    procedure PostJournalVoucher("Journal Voucher": Record "Journal Voucher Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        JournalVoucherLines: Record "Journal Voucher Lines";
        JournalVoucherHeader: Record "Journal Voucher Header";
        SourceCode: Code[20];
        JournalVoucherLines2: Record "Journal Voucher Lines";
        JournalVoucherHeader2: Record "Journal Voucher Header";
        GLEntry: Record "G/L Entry";
    begin
        JournalVoucherHeader.TransferFields("Journal Voucher", true);



        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete


        //***********************************************Add Receipt Lines**************************************************************//
        JournalVoucherLines.Reset;
        JournalVoucherLines.SetRange(JournalVoucherLines."JV No.", JournalVoucherHeader."JV No.");
        JournalVoucherLines.SetFilter(JournalVoucherLines.Amount, '<>%1', 0);
        if JournalVoucherLines.FindSet then begin
            repeat
                //****************************************Add Amounts***********************************************************//
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                //added on 25/07/2023 to use posting date on the lines
                if JournalVoucherLines."Posting Date" = 0D then begin
                    GenJnlLine."Posting Date" := JournalVoucherHeader."Posting Date";
                end else begin
                    GenJnlLine."Posting Date" := JournalVoucherLines."Posting Date";
                end;
                //end
                GenJnlLine."Document No." := JournalVoucherLines."JV No.";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Account Type" := JournalVoucherLines."Account Type";
                GenJnlLine."Account No." := JournalVoucherLines."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Posting Group" := JournalVoucherLines."Posting Group";
                GenJnlLine."External Document No." := JournalVoucherLines."External Document No.";
                //added on 23/05/2023
                GenJnlLine."Reference No" := JournalVoucherLines."Reference No";

                //end
                GenJnlLine."Currency Code" := JournalVoucherLines."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine.Amount := (JournalVoucherLines.Amount);  //Credit Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := JournalVoucherLines."Bal. Account Type";
                GenJnlLine."Bal. Account No." := JournalVoucherLines."Bal. Account No.";
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                if JournalVoucherLines."Account Type" = JournalVoucherLines."Account Type"::"Fixed Asset" then begin
                    GenJnlLine."FA Posting Date" := JournalVoucherLines."FA Posting Date";
                    GenJnlLine."FA Posting Type" := JournalVoucherLines."FA Posting Type";
                    GenJnlLine."Depreciation Book Code" := JournalVoucherLines."Depreciation Book Code";
                end;
                GenJnlLine."Shortcut Dimension 1 Code" := JournalVoucherLines."Shortcut Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := JournalVoucherLines."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, JournalVoucherLines."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, JournalVoucherLines."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, JournalVoucherLines."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, JournalVoucherLines."Shortcut Dimension 6 Code");
                GenJnlLine.ValidateShortcutDimCode(7, JournalVoucherLines."Shortcut Dimension 7 Code");
                GenJnlLine.ValidateShortcutDimCode(8, JournalVoucherLines."Shortcut Dimension 8 Code");
                GenJnlLine.Description := CopyStr(JournalVoucherLines.Description, 1, 249);
                GenJnlLine.Description2 := CopyStr(JournalVoucherHeader.Description, 1, 249);
                GenJnlLine.Validate(GenJnlLine.Description);
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;
            //*************************************End add Line NetAmounts**********************************************************//

            until JournalVoucherLines.Next = 0;
        end;

        Commit;

        //********************************************Post the Journal Lines************************************************************//
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        if not Preview then begin
            //Now Post the Journal Lines
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            GLEntry.Reset;
            GLEntry.SetRange("Document No.", JournalVoucherHeader."JV No.");
            if GLEntry.FindFirst then begin
                JournalVoucherHeader2.Reset;
                JournalVoucherHeader2.SetRange(JournalVoucherHeader2."JV No.", JournalVoucherHeader."JV No.");
                if JournalVoucherHeader2.FindFirst then begin
                    JournalVoucherHeader2.Posted := true;
                    JournalVoucherHeader2."Posted By" := UserId;
                    JournalVoucherHeader2."Time Posted" := Time;
                    JournalVoucherHeader2.Status := JournalVoucherHeader2.Status::Approved;
                    JournalVoucherHeader2.Modify;
                    JournalVoucherLines2.Reset;
                    JournalVoucherLines2.SetRange(JournalVoucherLines2."Document No.", JournalVoucherHeader2."JV No.");
                    if JournalVoucherLines2.FindSet then begin
                        repeat
                            JournalVoucherLines2.Posted := true;
                            JournalVoucherLines2."Posted By" := UserId;
                            JournalVoucherLines2."Date Posted" := Today;
                            JournalVoucherLines2."Time Posted" := Time;
                            JournalVoucherLines2.Modify;
                        until JournalVoucherLines2.Next = 0;
                    end;
                end;
            end;
            Commit;
            //***********************************************End Update Document************************************************************//
        end else begin
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
            if GenJnlLine.FindSet then begin
                GenJnlPost.Preview(GenJnlLine);
            end;
            //**********************************************End Preview Posting*************************************************************//
        end;
    end;

    procedure CheckJournalVoucherMandatoryFields("Journal Voucher": Record "Journal Voucher Header"; Posting: Boolean)
    var
        JournalVoucherHeader: Record "Journal Voucher Header";
        JournalVoucherLines: Record "Journal Voucher Lines";
        EmptyJournalVoucherLines: Label 'You cannot Post the journal with empty Line';
        "G/LAccount": Record "G/L Account";
    begin
        JournalVoucherHeader.TransferFields("Journal Voucher", true);
        JournalVoucherHeader.TestField("Posting Date");
        JournalVoucherHeader.TestField(Description);
        JournalVoucherHeader.TestField("Requires Voting");

        if Posting then
            JournalVoucherHeader.TestField(Status, JournalVoucherHeader.Status::Approved);

        //Check Lines
        JournalVoucherLines.Reset;
        JournalVoucherLines.SetRange("JV No.", JournalVoucherHeader."JV No.");
        if JournalVoucherLines.FindSet then begin
            repeat
                JournalVoucherLines.TestField("Account No.");
                JournalVoucherLines.TestField(Amount);
                JournalVoucherLines.TestField(Description);
            until JournalVoucherLines.Next = 0;
        end else begin
            Error(EmptyJournalVoucherLines);
        end;
    end;

    procedure GetEmployeeuserID(EmployeeNo: Code[30]) UserCode: Code[20]
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."Employee No", EmployeeNo);
        if UserSetup.FindFirst then
            exit(UserSetup."User ID")
        else
            Error('User has not been setup In Nav');
    end;

    procedure PostTransferAllowance(TransferAllowanceHeader: Record "Allowance Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        TransferAllowanceLine: Record "Allowance Line";
        TransferAllowanceHeaderRec: Record "Allowance Header";
        SourceCode: Code[20];
        EmployeeLedgerEntry: Record "Employee Ledger Entry";
        TransferAllowanceLine1: Record "Allowance Line";
        TransferAllowanceHeaderRec2: Record "Allowance Header";
    begin
        TransferAllowanceHeaderRec.TransferFields(TransferAllowanceHeader, true);
        SourceCode := IMPJNL;
        /*
        BankLedgers.RESET;
        BankLedgers.SETRANGE("Document No.",TransferAllowanceHeaderRec."No.");
        BankLedgers.SETRANGE(Reversed,FALSE);
        IF BankLedgers.FINDFIRST THEN BEGIN
          ERROR(DocumentExist,TransferAllowanceHeaderRec."No.",TransferAllowanceHeaderRec."Bank Account No.");
        END;
        */
        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        LineNo := 1000;
        //********************************************Add Imprest Header*******************************************************//
        TransferAllowanceHeaderRec.CalcFields(TransferAllowanceHeaderRec.Amount, TransferAllowanceHeaderRec."Amount(LCY)");
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := TransferAllowanceHeaderRec."Posting Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := TransferAllowanceHeaderRec."No.";
        GenJnlLine."External Document No." := TransferAllowanceHeaderRec."Reference No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Employee;
        GenJnlLine."Account No." := TransferAllowanceHeaderRec."Employee No.";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine."Posting Group" := TransferAllowanceHeaderRec."Employee Posting Group";
        GenJnlLine.Validate("Posting Group");
        GenJnlLine."Currency Code" := TransferAllowanceHeaderRec."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        GenJnlLine.Amount := -(TransferAllowanceHeaderRec.Amount);  //credit Amount
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := TransferAllowanceHeaderRec."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := TransferAllowanceHeaderRec."Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, TransferAllowanceHeaderRec."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, TransferAllowanceHeaderRec."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, TransferAllowanceHeaderRec."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, TransferAllowanceHeaderRec."Shortcut Dimension 6 Code");
        //GenJnlLine.ValidateShortcutDimCode(7,TransferAllowanceHeaderRec."Shortcut Dimension 7 Code");
        //GenJnlLine.ValidateShortcutDimCode(8,TransferAllowanceHeaderRec."Shortcut Dimension 8 Code");
        GenJnlLine.Description := UpperCase(CopyStr(TransferAllowanceHeaderRec.Description, 1, 249));
        GenJnlLine.Description2 := UpperCase(CopyStr(TransferAllowanceHeaderRec."Employee Name", 1, 249));
        GenJnlLine.Validate(GenJnlLine.Description);
        GenJnlLine."Employee Transaction Type" := GenJnlLine."Employee Transaction Type"::"Transfer Allowance";
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;

        LineNo := LineNo + 1;
        //debit Expense account
        TransferAllowanceLine1.Reset;
        TransferAllowanceLine1.SetRange("Document No.", TransferAllowanceHeaderRec."No.");
        if TransferAllowanceLine1.FindFirst then begin
            GenJnlLine.Init;
            GenJnlLine."Journal Template Name" := "Journal Template";
            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
            GenJnlLine."Journal Batch Name" := "Journal Batch";
            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
            GenJnlLine."Line No." := LineNo;
            GenJnlLine."Source Code" := SourceCode;
            GenJnlLine."Posting Date" := TransferAllowanceHeaderRec."Posting Date";
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
            GenJnlLine."Document No." := TransferAllowanceHeaderRec."No.";
            GenJnlLine."External Document No." := TransferAllowanceHeaderRec."Reference No.";
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."Account No." := TransferAllowanceLine1."Account No.";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine."Currency Code" := TransferAllowanceHeaderRec."Currency Code";
            GenJnlLine.Validate(GenJnlLine."Currency Code");
            GenJnlLine.Amount := (TransferAllowanceHeaderRec.Amount);  //debit Amount
            GenJnlLine.Validate(GenJnlLine.Amount);
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
            GenJnlLine."Bal. Account No." := '';
            GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
            GenJnlLine."Shortcut Dimension 1 Code" := TransferAllowanceHeaderRec."Global Dimension 1 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code" := TransferAllowanceHeaderRec."Global Dimension 2 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3, TransferAllowanceHeaderRec."Shortcut Dimension 3 Code");
            GenJnlLine.ValidateShortcutDimCode(4, TransferAllowanceHeaderRec."Shortcut Dimension 4 Code");
            GenJnlLine.ValidateShortcutDimCode(5, TransferAllowanceHeaderRec."Shortcut Dimension 5 Code");
            GenJnlLine.ValidateShortcutDimCode(6, TransferAllowanceHeaderRec."Shortcut Dimension 6 Code");
            //GenJnlLine.ValidateShortcutDimCode(7,TransferAllowanceHeaderRec."Shortcut Dimension 7 Code");
            //GenJnlLine.ValidateShortcutDimCode(8,TransferAllowanceHeaderRec."Shortcut Dimension 8 Code");
            GenJnlLine.Description := UpperCase(CopyStr(TransferAllowanceHeaderRec.Description, 1, 249));
            GenJnlLine.Description2 := UpperCase(CopyStr(TransferAllowanceHeaderRec."Employee Name", 1, 249));
            GenJnlLine.Validate(GenJnlLine.Description);
            GenJnlLine."Employee Transaction Type" := GenJnlLine."Employee Transaction Type"::"Transfer Allowance";
            if GenJnlLine.Amount <> 0 then
                GenJnlLine.Insert;
            Commit;
        end;
        //********************************************Post the Journal Lines************************************************************//
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        if not Preview then begin
            //Now Post the Journal Lines
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            EmployeeLedgerEntry.Reset;
            EmployeeLedgerEntry.SetRange(EmployeeLedgerEntry."Document No.", TransferAllowanceHeaderRec."No.");
            if EmployeeLedgerEntry.FindFirst then begin
                TransferAllowanceHeaderRec2.Reset;
                TransferAllowanceHeaderRec2.SetRange(TransferAllowanceHeaderRec2."No.", TransferAllowanceHeaderRec."No.");
                if TransferAllowanceHeaderRec2.FindFirst then begin
                    TransferAllowanceHeaderRec2.Status := TransferAllowanceHeaderRec2.Status::Posted;
                    TransferAllowanceHeaderRec2.Posted := true;
                    TransferAllowanceHeaderRec2."Posted By" := UserId;
                    TransferAllowanceHeaderRec2."Date Posted" := Today;
                    TransferAllowanceHeaderRec2."Time Posted" := Time;
                    TransferAllowanceHeaderRec2.Modify;
                end;
            end;
            //**********************************************End Update Document***************************************************************//
        end else begin
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange("Journal Template Name", "Journal Template");
            GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
            if GenJnlLine.FindSet then begin
                GenJnlPost.Preview(GenJnlLine);
            end;
            //**********************************************End Preview Posting*************************************************************//
        end;

    end;

    procedure CheckTransferAllowanceMandatoryFields(TransferAllowanceHeader: Record "Allowance Header"; Posting: Boolean)
    var
        TransferAllowanceHeaderRec: Record "Allowance Header";
        TransferAllowanceLine: Record "Allowance Line";
        EmptyImprestLine: Label 'You cannot Post Imprest with empty Line';
    begin
        TransferAllowanceHeaderRec.TransferFields(TransferAllowanceHeader, true);
        TransferAllowanceHeaderRec.TestField("Posting Date");
        //TransferAllowanceHeaderRec.TESTFIELD("Bank Account No.");
        TransferAllowanceHeaderRec.TestField("Employee No.");
        TransferAllowanceHeaderRec.TestField(Description);
        TransferAllowanceHeaderRec.TestField("Employee Posting Group");
        //TransferAllowanceHeaderRec.TESTFIELD("Global Dimension 1 Code");
        TransferAllowanceHeaderRec.TestField(Type);
        TransferAllowanceHeaderRec.TestField("Date From");
        TransferAllowanceHeaderRec.TestField("Date To");
        if Posting then
            // TransferAllowanceHeaderRec.TESTFIELD(Status,TransferAllowanceHeaderRec.Status::Released);
            //Check Imprest Lines
            TransferAllowanceLine.Reset;
        TransferAllowanceLine.SetRange("Document No.", TransferAllowanceHeaderRec."No.");
        if TransferAllowanceLine.FindSet then begin
            repeat
                TransferAllowanceLine.TestField("Account No.");
                TransferAllowanceLine.TestField("Gross Amount");
                if TransferAllowanceLine."Account Type" = TransferAllowanceLine."Account Type"::"G/L Account" then begin
                    //  TransferAllowanceLine.TESTFIELD("Global Dimension 1 Code");
                    // TransferAllowanceLine.TESTFIELD("Global Dimension 2 Code");
                    // TransferAllowanceLine.TESTFIELD("Shortcut Dimension 4 Code");
                    // TransferAllowanceLine.TESTFIELD("Shortcut Dimension 5 Code");
                    //TransferAllowanceLine.TESTFIELD("Shortcut Dimension 6 Code");
                end;
            until TransferAllowanceLine.Next = 0;
        end else begin
            Error(EmptyImprestLine);
        end;
    end;

    [Scope('Personalization')]
    procedure PrintImprest(ImprestNo: Code[20]) ServerPath: Text
    var
        ImprestVoucher: Report "Imprest Voucher";
        Filename: Text;
        PortalSetup: Record "Portal Setup";
        Filepath: Text;
        ImprestHeader: Record "Imprest Header";
    begin
        PortalSetup.Reset;
        PortalSetup.Get;
        PortalSetup.TestField("Server File Path");
        PortalSetup.TestField("Local File Path");
        Filename := ImprestNo + '_' + 'ImprestApplication.pdf';
        Filepath := PortalSetup."Local File Path" + Filename;
        // if FILE.Exists(Filepath) then
        //   FILE.Erase(Filepath);

        ImprestHeader.Reset;
        ImprestHeader.SetRange("No.", ImprestNo);
        ImprestVoucher.SetTableView(ImprestHeader);
        // ImprestVoucher.SaveAsPdf(Filepath);
        // if FILE.Exists(Filepath) then
        //   ServerPath:=PortalSetup."Server File Path"+Filename
        // else
        //Error('There was an Error. Please Try again');
    end;

    [Scope('Personalization')]
    procedure PrintPettyCash(ImprestNo: Code[20]) ServerPath: Text
    var
        ImprestVoucher: Report "Petty Cash Voucher 1";
        Filename: Text;
        PortalSetup: Record "Portal Setup";
        Filepath: Text;
        ImprestHeader: Record "Imprest Header";
    begin
        PortalSetup.Reset;
        PortalSetup.Get;
        PortalSetup.TestField("Server File Path");
        PortalSetup.TestField("Local File Path");
        Filename := ImprestNo + '_' + 'PettyCashApplication.pdf';
        Filepath := PortalSetup."Local File Path" + Filename;
        // if FILE.Exists(Filepath) then
        //   FILE.Erase(Filepath);

        ImprestHeader.Reset;
        ImprestHeader.SetRange("No.", ImprestNo);
        ImprestVoucher.SetTableView(ImprestHeader);
        // ImprestVoucher.SaveAsPdf(Filepath);
        // if FILE.Exists(Filepath) then
        //   ServerPath:=PortalSetup."Server File Path"+Filename
        // else
        //   Error('There was an Error. Please Try again');
    end;

    procedure PostBoardAllowance("Imprest Header": Record "Imprest Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        ImprestLine: Record "Imprest Line";
        ImprestHeader: Record "Imprest Header";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        ImprestLine2: Record "Imprest Line";
        ImprestHeader2: Record "Imprest Header";
        DocumentExist: Label 'Imprest document is already posted. Document No.:%1  already exists in Bank No:%2';
        FundsTransactionCodes: Record "Funds Transaction Code";
        FundsTaxCode: Record "Funds Tax Code";
    begin
        ImprestHeader.TransferFields("Imprest Header", true);
        SourceCode := IMPJNL;


        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        LineNo := 1000;
        //********************************************Add Imprest Header*******************************************************//
        ImprestHeader.CalcFields(ImprestHeader.Amount, ImprestHeader."Amount(LCY)");
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := ImprestHeader."Posting Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := ImprestHeader."No.";
        GenJnlLine."External Document No." := ImprestHeader."Reference No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Employee;
        GenJnlLine."Account No." := ImprestHeader."Employee No.";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine."Posting Group" := ImprestHeader."Employee Posting Group";
        GenJnlLine.Validate("Posting Group");
        GenJnlLine."Currency Code" := ImprestHeader."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        GenJnlLine.Amount := -(ImprestHeader.Amount);  //Debit Amount
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, ImprestHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, ImprestHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, ImprestHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, ImprestHeader."Shortcut Dimension 6 Code");
        //GenJnlLine.ValidateShortcutDimCode(7,ImprestHeader."Shortcut Dimension 7 Code");
        //GenJnlLine.ValidateShortcutDimCode(8,ImprestHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := UpperCase(CopyStr(ImprestHeader.Description, 1, 100));
        GenJnlLine.Description2 := UpperCase(CopyStr(ImprestHeader."Employee Name", 1, 100));
        GenJnlLine.Validate(GenJnlLine.Description);
        GenJnlLine."Employee Transaction Type" := GenJnlLine."Employee Transaction Type"::Imprest;
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;

        LineNo := LineNo + 1;
        //**********************************Add Surrender Lines***********************************************************************//
        ImprestLine.Reset;
        ImprestLine.SetRange(ImprestLine."Document No.", ImprestHeader."No.");

        if ImprestLine.FindSet then begin
            repeat
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := ImprestHeader."Posting Date";
                //GenJnlLine."Document Type":=GenJnlLine."Document Type"::"Imprest Surrender";
                GenJnlLine."Document No." := ImprestLine."Document No.";
                GenJnlLine."Account Type" := ImprestLine."Account Type";
                GenJnlLine."Account No." := ImprestLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                if ImprestLine."Account Type" <> ImprestLine."Account Type"::"G/L Account" then begin
                    GenJnlLine."Posting Group" := ImprestLine."Posting Group";
                    GenJnlLine.Validate("Posting Group");
                end;
                GenJnlLine."Currency Code" := ImprestHeader."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine.Amount := ImprestLine."Net Amount";  //Debit Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := ImprestLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := ImprestLine."Global Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, ImprestLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, ImprestLine."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, ImprestLine."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, ImprestLine."Shortcut Dimension 6 Code");
                //GenJnlLine.ValidateShortcutDimCode(7,ImprestLine."Shortcut Dimension 7 Code");
                // GenJnlLine.ValidateShortcutDimCode(8,ImprestLine."Shortcut Dimension 8 Code");
                GenJnlLine.Description := CopyStr(ImprestLine.Description, 1, 100);
                GenJnlLine.Description2 := CopyStr(ImprestHeader."Employee Name", 1, 100);
                GenJnlLine.Validate(GenJnlLine.Description);
                if ImprestLine."Account Type" = ImprestLine."Account Type"::"Fixed Asset" then begin
                    GenJnlLine."FA Posting Type" := GenJnlLine."FA Posting Type"::"Acquisition Cost";
                    GenJnlLine."FA Posting Date" := ImprestHeader."Posting Date";
                    GenJnlLine."Depreciation Book Code" := ImprestLine."FA Depreciation Book";
                    GenJnlLine.Validate(GenJnlLine."Depreciation Book Code");
                    GenJnlLine."FA Add.-Currency Factor" := 0;
                    GenJnlLine."Gen. Bus. Posting Group" := '';
                end;
                GenJnlLine."Employee Transaction Type" := GenJnlLine."Employee Transaction Type"::Imprest;
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;

                //TAX
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := ImprestHeader."Posting Date";
                //GenJnlLine."Document Type":=GenJnlLine."Document Type"::"Imprest Surrender";
                GenJnlLine."Document No." := ImprestLine."Document No.";
                GenJnlLine."Account Type" := ImprestLine."Account Type";
                GenJnlLine."Account No." := ImprestLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                if ImprestLine."Account Type" <> ImprestLine."Account Type"::"G/L Account" then begin
                    GenJnlLine."Posting Group" := ImprestLine."Posting Group";
                    GenJnlLine.Validate("Posting Group");
                end;
                GenJnlLine."Currency Code" := ImprestHeader."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine.Amount := ImprestLine."Tax Amount";  //Debit Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                FundsTransactionCodes.Reset;
                FundsTransactionCodes.SetRange(FundsTransactionCodes."Transaction Code", ImprestLine."Imprest Code");
                FundsTransactionCodes.FindFirst;
                if FundsTransactionCodes."Include Withholding Tax" then begin
                    FundsTransactionCodes.TestField("Withholding Tax Code");
                    FundsTaxCode.Get(FundsTransactionCodes."Withholding Tax Code");

                    FundsTaxCode.TestField("Account No.");

                end;


                GenJnlLine."Bal. Account No." := FundsTaxCode."Account No.";
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := ImprestLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := ImprestLine."Global Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, ImprestLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, ImprestLine."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, ImprestLine."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, ImprestLine."Shortcut Dimension 6 Code");
                //GenJnlLine.ValidateShortcutDimCode(7,ImprestLine."Shortcut Dimension 7 Code");
                // GenJnlLine.ValidateShortcutDimCode(8,ImprestLine."Shortcut Dimension 8 Code");
                GenJnlLine.Description := CopyStr(ImprestLine.Description + '-Board Tax', 1, 100);
                GenJnlLine.Description2 := CopyStr(ImprestHeader."Employee Name" + '-Board Tax', 1, 100);
                GenJnlLine.Validate(GenJnlLine.Description);
                if ImprestLine."Account Type" = ImprestLine."Account Type"::"Fixed Asset" then begin
                    GenJnlLine."FA Posting Type" := GenJnlLine."FA Posting Type"::"Acquisition Cost";
                    GenJnlLine."FA Posting Date" := ImprestHeader."Posting Date";
                    GenJnlLine."Depreciation Book Code" := ImprestLine."FA Depreciation Book";
                    GenJnlLine.Validate(GenJnlLine."Depreciation Book Code");
                    GenJnlLine."FA Add.-Currency Factor" := 0;
                    GenJnlLine."Gen. Bus. Posting Group" := '';
                end;
                GenJnlLine."Employee Transaction Type" := GenJnlLine."Employee Transaction Type"::Imprest;
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;




            until ImprestLine.Next = 0;
        end;
        //**********************************End Add Surrender Lines*********************************************************************//

        // END  LINES
        Commit;
        //********************************************Post the Journal Lines************************************************************//

        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        if not Preview then begin
            //Now Post the Journal Lines
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            ImprestHeader2.Reset;
            ImprestHeader2.SetRange(ImprestHeader2."No.", ImprestHeader."No.");
            if ImprestHeader2.FindFirst then begin
                ImprestHeader2.Status := ImprestHeader2.Status::Posted;
                ImprestHeader2.Surrendered := true;
                /*ImprestHeader2."Posted By":=USERID;
                ImprestHeader2."Date Posted":=TODAY;
                ImprestHeader2."Time Posted":=TIME;*/
                ImprestHeader2.Modify;

            end;
            //**********************************************End Update Document***************************************************************//
        end else begin
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange("Journal Template Name", "Journal Template");
            GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
            if GenJnlLine.FindSet then begin
                GenJnlPost.Preview(GenJnlLine);
            end;
            //**********************************************End Preview Posting*************************************************************//
        end;

    end;

    procedure ReverseReceipt("Receipt Header": Record "Receipt Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        ReceiptLine: Record "Receipt Line";
        ReceiptHeader: Record "Receipt Header";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        ReceiptLine2: Record "Receipt Line";
        ReceiptHeader2: Record "Receipt Header";
        DocumentExist: Label 'Receipt is already posted, Document No.:%1 already exists in Bank No:%2';
        GLEntry: Record "G/L Entry";
    begin
        ReceiptHeader.TransferFields("Receipt Header", true);
        SourceCode := RECEIPTJNL;
        /*
        BankLedgers.RESET;
        BankLedgers.SETRANGE(BankLedgers."Document No.",ReceiptHeader."No.");
        IF BankLedgers.FINDFIRST THEN BEGIN
          ERROR(DocumentExist,ReceiptHeader."No.",ReceiptHeader."Account No.");
        END;
        */
        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        //***************************************************Add to Bank***************************************************************//
        ReceiptHeader.CalcFields("Line Amount", "Line Amount(LCY)");
        LineNo := 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
        GenJnlLine."Document No." := ReceiptHeader."No.";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."External Document No." := ReceiptHeader."Reference No.";
        if ReceiptHeader."Receipt Types" = ReceiptHeader."Receipt Types"::Bank then begin
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
            GenJnlLine."Account No." := ReceiptHeader."Account No.";
        end else begin
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            if FundsTransactionCode.Get(ReceiptHeader."Account No.") then
                GenJnlLine."Account No." := FundsTransactionCode."Account No.";
        end;
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        GenJnlLine.Amount := -ReceiptHeader."Line Amount";  //Debit Amount
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
        //GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
        //GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := CopyStr(ReceiptHeader.Description + '-Reversal', 1, 249);
        GenJnlLine.Description2 := UpperCase(CopyStr("Receipt Header"."Received From", 1, 249));
        GenJnlLine.Validate(GenJnlLine.Description);
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
        //************************************************End Add to Bank***************************************************************//
        //***********************************************Add Receipt Lines**************************************************************//
        ReceiptLine.Reset;
        ReceiptLine.SetRange(ReceiptLine."Document No.", ReceiptHeader."No.");
        ReceiptLine.SetFilter(ReceiptLine.Amount, '<>%1', 0);
        if ReceiptLine.FindSet then begin
            repeat
                //****************************************Add Line NetAmounts***********************************************************//
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
                GenJnlLine."Document No." := ReceiptLine."Document No.";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Account Type" := ReceiptLine."Account Type";
                GenJnlLine."Account No." := ReceiptLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Posting Group" := ReceiptLine."Posting Group";
                GenJnlLine."External Document No." := ReceiptHeader."Reference No.";
                GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine.Amount := (ReceiptLine.Amount);  //Credit Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                // IF ReceiptLine."Posting Group" <> '' THEN BEGIN
                GenJnlLine."Investment Transaction Type" := ReceiptLine."Loan Transaction Type";
                GenJnlLine."Investment Account No." := ReceiptLine."Loan Account No.";
                GenJnlLine."Customer No." := ReceiptLine."Account No.";
                //  END;
                GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
                GenJnlLine.ValidateShortcutDimCode(7, ReceiptHeader."Shortcut Dimension 7 Code");
                GenJnlLine.ValidateShortcutDimCode(8, ReceiptHeader."Shortcut Dimension 8 Code");
                GenJnlLine.Description := CopyStr(ReceiptHeader.Description + '-Reversal', 1, 249);
                GenJnlLine.Description2 := UpperCase(CopyStr("Receipt Header"."Received From", 1, 249));
                GenJnlLine.Validate(GenJnlLine.Description);
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                if ReceiptLine."Loan Account No." <> '' then begin
                    GenJnlLine."Applies-to ID" := '';
                    GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                end else begin
                    GenJnlLine."Applies-to ID" := ReceiptLine."Applies-to ID";
                    GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                end;
                GenJnlLine."Employee Transaction Type" := ReceiptLine."Employee Transaction Type";
                GenJnlLine."Investment Application No." := ReceiptLine."Investment Application No.";
                // GenJnlLine."Loan Account No.":=ReceiptLine."Investment Account No.";
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;
                //*************************************End add Line NetAmounts**********************************************************//
                //****************************************Add VAT Amounts***************************************************************//
                if ReceiptLine."VAT Code" <> '' then begin
                    TaxCodes.Reset;
                    TaxCodes.SetRange(TaxCodes."Tax Code", ReceiptLine."VAT Code");
                    if TaxCodes.FindFirst then begin
                        TaxCodes.TestField(TaxCodes."Account No.");
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
                        GenJnlLine."Document No." := ReceiptLine."Document No.";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."External Document No." := ReceiptHeader."Reference No.";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No.";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                        GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                        GenJnlLine."Gen. Bus. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine.Amount := (ReceiptLine."VAT Amount");   //Credit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
                        //  GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
                        //  GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := CopyStr('VAT:-Reversal' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"), 1, 249);
                        GenJnlLine.Description2 := UpperCase(CopyStr("Receipt Header"."Received From", 1, 50));
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;

                        //VAT Balancing goes to Vendor
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
                        GenJnlLine."Document No." := ReceiptLine."Document No.";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."External Document No." := ReceiptHeader."Reference No.";
                        GenJnlLine."Account Type" := ReceiptLine."Account Type";
                        GenJnlLine."Account No." := ReceiptLine."Account No.";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine.Amount := -ReceiptLine."VAT Amount";   //Debit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
                        //GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
                        // GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := CopyStr('VAT:' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"), 1, 249);
                        GenJnlLine.Description2 := UpperCase(CopyStr("Receipt Header"."Received From", 1, 50));
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;
                    end;
                end;
            //*************************************End Add VAT Amounts**************************************************************//
            until ReceiptLine.Next = 0;
        end;
        //*********************************************End Add Payment Lines************************************************************//
        Commit;
        //********************************************Post the Journal Lines************************************************************//
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        if not Preview then begin
            //Now Post the Journal Lines
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            GLEntry.Reset;
            GLEntry.SetRange("Document No.", ReceiptHeader."No.");
            if GLEntry.FindFirst then begin
                ReceiptHeader2.Reset;
                ReceiptHeader2.SetRange(ReceiptHeader2."No.", ReceiptHeader."No.");
                if ReceiptHeader2.FindFirst then begin

                    ReceiptHeader2.Status := ReceiptHeader2.Status::Reversed;
                    ReceiptHeader2.Reversed := true;
                    ReceiptHeader2."Reversed By" := UserId;
                    ReceiptHeader2."Reversal Date" := Today;
                    ReceiptHeader2."Reversal Time" := Time;
                    ReceiptHeader2.Modify;
                    ReceiptLine2.Reset;
                    ReceiptLine2.SetRange(ReceiptLine2."Document No.", ReceiptHeader2."No.");
                    if ReceiptLine2.FindSet then begin
                        repeat
                            ReceiptLine2.Status := ReceiptLine2.Status::Reversed;
                            ReceiptLine2.Reversed := true;
                            ReceiptLine2."Reversed By" := UserId;
                            ReceiptLine2."Reversal Date" := Today;
                            ReceiptLine2."Reversal Time" := Time;
                            ReceiptLine2.Modify;


                        until ReceiptLine2.Next = 0;
                    end;
                end;
            end;
            Commit;
            //***********************************************End Update Document************************************************************//
        end else begin
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
            if GenJnlLine.FindSet then begin
                GenJnlPost.Preview(GenJnlLine);
            end;
            //**********************************************End Preview Posting*************************************************************//
        end;

    end;

    procedure PostImprest2("Imprest Header": Record "Imprest Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        ImprestLine: Record "Imprest Line";
        ImprestHeader: Record "Imprest Header";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        ImprestLine2: Record "Imprest Line";
        ImprestHeader2: Record "Imprest Header";
        DocumentExist: Label 'Imprest document is already posted. Document No.:%1  already exists in Bank No:%2';
        ImprestLines: Record "Imprest Line";
    begin
        ImprestHeader.TransferFields("Imprest Header", true);
        SourceCode := IMPJNL;
        BankLedgers.Reset;
        BankLedgers.SetRange("Document No.", ImprestHeader."No.");
        BankLedgers.SetRange(Reversed, false);
        if BankLedgers.FindFirst then begin
            Error(DocumentExist, ImprestHeader."No.", ImprestHeader."Bank Account No.");
        end;

        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        LineNo := 1000;
        ImprestLines.Reset;
        ImprestLines.SetRange("Document No.", ImprestHeader."No.");
        if ImprestLines.FindSet then begin
            repeat
                //********************************************Add Imprest Lines*******************************************************//
                ImprestHeader.CalcFields(ImprestHeader.Amount, ImprestHeader."Amount(LCY)");
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Posting Date" := ImprestHeader."Posting Date";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Document No." := ImprestHeader."No.";
                GenJnlLine."External Document No." := ImprestHeader."Reference No.";
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine."Account No." := ImprestLines."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                //GenJnlLine."Posting Group":=ImprestHeader."Employee Posting Group";
                GenJnlLine.Validate("Posting Group");
                GenJnlLine."Currency Code" := ImprestHeader."Currency Code";
                GenJnlLine.Validate(GenJnlLine."Currency Code");
                GenJnlLine.Amount := (ImprestLines."Net Amount");  //Debit Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := ImprestLines."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := ImprestLines."Global Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, ImprestLines."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, ImprestLines."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, ImprestLines."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, ImprestLines."Shortcut Dimension 6 Code");
                //GenJnlLine.ValidateShortcutDimCode(7,ImprestHeader."Shortcut Dimension 7 Code");
                //GenJnlLine.ValidateShortcutDimCode(8,ImprestHeader."Shortcut Dimension 8 Code");
                GenJnlLine.Validate(GenJnlLine.Description);
                GenJnlLine.Description := UpperCase(CopyStr(ImprestLines.Description, 1, 249));
                GenJnlLine.Description2 := UpperCase(CopyStr(ImprestHeader."Employee Name", 1, 249));
                GenJnlLine.Payee := ImprestHeader."Employee Name";

                GenJnlLine."Employee Transaction Type" := GenJnlLine."Employee Transaction Type"::Imprest;
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;
                LineNo := LineNo + 1;
            until ImprestLines.Next = 0;
        end;

        LineNo := LineNo + 1;
        //Credit Bank
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := ImprestHeader."Posting Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := ImprestHeader."No.";
        GenJnlLine."External Document No." := ImprestHeader."Reference No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := ImprestHeader."Bank Account No.";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine."Currency Code" := ImprestHeader."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        GenJnlLine.Amount := -(ImprestHeader.Amount);  //Credit Amount
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, ImprestHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, ImprestHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, ImprestHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, ImprestHeader."Shortcut Dimension 6 Code");
        //GenJnlLine.ValidateShortcutDimCode(7,ImprestHeader."Shortcut Dimension 7 Code");
        //GenJnlLine.ValidateShortcutDimCode(8,ImprestHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Validate(GenJnlLine.Description);
        GenJnlLine.Description := UpperCase(CopyStr(ImprestHeader.Description, 1, 249));
        GenJnlLine.Description2 := UpperCase(CopyStr(ImprestHeader."Employee Name", 1, 249));
        GenJnlLine.Payee := ImprestHeader."Employee Name";

        GenJnlLine."Employee Transaction Type" := GenJnlLine."Employee Transaction Type"::Imprest;
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
        Commit;
        //********************************************Post the Journal Lines************************************************************//
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        if not Preview then begin
            //Now Post the Journal Lines
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            BankLedgers.Reset;
            BankLedgers.SetRange(BankLedgers."Document No.", ImprestHeader."No.");
            if BankLedgers.FindFirst then begin
                ImprestHeader2.Reset;
                ImprestHeader2.SetRange(ImprestHeader2."No.", ImprestHeader."No.");
                if ImprestHeader2.FindFirst then begin
                    ImprestHeader2.Status := ImprestHeader2.Status::Posted;
                    ImprestHeader2.Posted := true;
                    ImprestHeader2."Posted By" := UserId;
                    ImprestHeader2."Date Posted" := Today;
                    ImprestHeader2."Time Posted" := Time;
                    ImprestHeader2."Surrender status" := ImprestHeader2."Surrender status"::"Fully surrendered";
                    ImprestHeader2.Surrendered := true;
                    ImprestHeader2.Modify;
                end;
            end;
            //**********************************************End Update Document***************************************************************//
        end else begin
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange("Journal Template Name", "Journal Template");
            GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
            if GenJnlLine.FindSet then begin
                GenJnlPost.Preview(GenJnlLine);
            end;
            //**********************************************End Preview Posting*************************************************************//
        end;
    end;

    procedure PostPaymentPortal("Payment Header": Record "Payment Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        PaymentLine: Record "Payment Line";
        PaymentHeader: Record "Payment Header";
        SourceCode: Code[20];
        BankLedgerEntries: Record "Bank Account Ledger Entry";
        PaymentLine2: Record "Payment Line";
        PaymentHeader2: Record "Payment Header";
        DocumentExist: Label 'Payment Document is already posted, Document No.:%1 already exists in Bank No:%2';
        EmployeeLoanAccounts: Record "Employee Loan Accounts";
        LoanRepayment: Record "Employee Repayment Schedule";
        PaymentCodes: Record "Funds Transaction Code";
        EmployeeRec: Record Employee;
        LoansAdvancesRecCopy: Record "Loans/Advances";
    begin
        PaymentHeader.TransferFields("Payment Header", true);
        SourceCode := PAYMENTJNL;

        BankLedgerEntries.Reset;
        BankLedgerEntries.SetRange(BankLedgerEntries."Document No.", PaymentHeader."No.");
        BankLedgerEntries.SetRange(BankLedgerEntries.Reversed, false);
        if BankLedgerEntries.FindFirst then begin
            Error(DocumentExist, PaymentHeader."No.", PaymentHeader."Bank Account No.");
        end;

        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", "Journal Template");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        LineNo := 1000;
        //*********************************************Add Payment Header***************************************************************//
        PaymentHeader.CalcFields("Net Amount");
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate("Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate("Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := PaymentHeader."No.";
        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
        GenJnlLine."Cheque No." := PaymentHeader."Cheque No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := PaymentHeader."Bank Account No.";
        GenJnlLine.Validate("Account No.");
        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
        GenJnlLine.Validate("Currency Code");
        GenJnlLine.Amount := -(PaymentHeader."Net Amount");  //Credit Amount
        GenJnlLine.Validate(Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate("Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
        GenJnlLine.Validate("Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
        GenJnlLine.Validate("Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := UpperCase(CopyStr(PaymentHeader.Description, 1, 249));
        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
        GenJnlLine.Payee := PaymentHeader."Payee Name";
        GenJnlLine.Validate(Description);
        GenJnlLine.HideDialog := true;
        if PaymentHeader."Loan No." <> '' then begin
            GenJnlLine."Investment Account No." := PaymentHeader."Loan No.";
            GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Loan Disbursement";
        end;
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
        //************************************************End Add to Bank***************************************************************//

        //***********************************************Add Payment Lines**************************************************************//
        PaymentLine.Reset;
        PaymentLine.SetRange("Document No.", PaymentHeader."No.");
        PaymentLine.SetFilter("Total Amount", '<>%1', 0);
        if PaymentLine.FindSet then begin
            repeat
                //****************************************Add Line Amounts***********************************************************//
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate("Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate("Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                GenJnlLine."Document No." := PaymentLine."Document No.";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Account Type" := PaymentLine."Account Type";
                GenJnlLine."Account No." := PaymentLine."Account No.";
                GenJnlLine.Validate("Account No.");
                GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine.Amount := PaymentLine."Net Amount";  //Debit Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                if PaymentHeader."Loan No." <> '' then begin
                    GenJnlLine."Investment Account No." := PaymentHeader."Loan No.";
                    GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Loan Disbursement";
                end;
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                GenJnlLine.Validate("Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PaymentLine."Global Dimension 2 Code";
                GenJnlLine.Validate("Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PaymentLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PaymentLine."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, PaymentLine."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, PaymentLine."Shortcut Dimension 6 Code");
                GenJnlLine.ValidateShortcutDimCode(7, PaymentLine."Shortcut Dimension 7 Code");
                GenJnlLine.ValidateShortcutDimCode(8, PaymentLine."Shortcut Dimension 8 Code");
                GenJnlLine.Description := UpperCase(CopyStr(PaymentLine.Description, 1, 249));
                GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
                GenJnlLine.Validate(Description);
                GenJnlLine.Payee := PaymentHeader."Payee Name";
                GenJnlLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                GenJnlLine.Validate("Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                GenJnlLine."Employee Transaction Type" := PaymentLine."Employee Transaction Type";
                GenJnlLine.HideDialog := true;
                if PaymentHeader."Loan No." <> '' then begin
                    GenJnlLine."Investment Account No." := PaymentHeader."Loan No.";
                    GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Loan Disbursement";
                end;
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;
                //*************************************End Add Line Amounts**********************************************************//

                //**************************************Add W/TAX Amounts************************************************************//
                if PaymentLine."Withholding Tax Code" <> '' then begin
                    TaxCodes.Reset;
                    TaxCodes.SetRange("Tax Code", PaymentLine."Withholding Tax Code");
                    if TaxCodes.FindFirst then begin
                        TaxCodes.TestField("Account No.");
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No.";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine.Amount := -(PaymentLine."Withholding Tax Amount");   //Credit Amount
                        GenJnlLine.Validate(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UpperCase(CopyStr('W/TAX:' + Format(PaymentLine."Document No.") + '::' + Format(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
                        GenJnlLine.Payee := PaymentHeader."Payee Name";
                        GenJnlLine.HideDialog := true;
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;

                        //W/TAX Balancing
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := PaymentLine."Account Type";
                        GenJnlLine."Account No." := PaymentLine."Account No.";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Posting Group" := PaymentLine."Posting Group";
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine.Amount := PaymentLine."Withholding Tax Amount";   //Debit Amount
                        GenJnlLine.Validate(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UpperCase(CopyStr('W/TAX:' + Format(PaymentLine."Document No.") + '::' + Format(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));

                        GenJnlLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                        GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                        GenJnlLine.Validate("Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                        GenJnlLine."Employee Transaction Type" := PaymentLine."Employee Transaction Type";
                        GenJnlLine.HideDialog := true;
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;
                    end;
                end;
                //****************************************End Add W/TAX Amounts************************************************************//

                //****************************************Add W/VAT Amounts***************************************************************//
                if PaymentLine."Withholding VAT Code" <> '' then begin
                    TaxCodes.Reset;
                    TaxCodes.SetRange("Tax Code", PaymentLine."Withholding VAT Code");
                    if TaxCodes.FindFirst then begin
                        TaxCodes.TestField("Account No.");
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No.";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine.Amount := -(PaymentLine."Withholding VAT Amount");   //Credit Amount
                        GenJnlLine.Validate(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UpperCase(CopyStr('W/VAT:' + Format(PaymentLine."Document No.") + '::' + Format(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
                        GenJnlLine.Payee := PaymentHeader."Payee Name";
                        GenJnlLine.HideDialog := true;
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;

                        //W/VAT Balancing
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := PaymentLine."Account Type";
                        GenJnlLine."Account No." := PaymentLine."Account No.";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Posting Group" := PaymentLine."Posting Group";
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine.Amount := PaymentLine."Withholding VAT Amount";   //Debit Amount
                        GenJnlLine.Validate(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UpperCase(CopyStr('W/VAT:' + Format(PaymentLine."Document No.") + '::' + Format(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
                        GenJnlLine.Payee := PaymentHeader."Payee Name";
                        GenJnlLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                        GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                        GenJnlLine.Validate("Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                        GenJnlLine."Employee Transaction Type" := PaymentLine."Employee Transaction Type";
                        GenJnlLine.HideDialog := true;
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;
                    end;
                end;
                //***********************************End Add W/VAT Amounts*************************************************************//
                //salary Advance** create loan and pay
                if not Preview then begin
                    if PaymentLine."Payee Type" = PaymentLine."Payee Type"::"Salary Advance" then begin
                        SalaryAdvanceRec.Reset;
                        SalaryAdvanceRec.SetRange(ID, PaymentLine."Payee No.");
                        if SalaryAdvanceRec.FindFirst then begin
                            LoansAdvancesRec.Init;
                            LoansAdvancesRec.Type := LoansAdvancesRec.Type::Advance;
                            //Get Payroll code from employee
                            if EmployeeRec.Get(SalaryAdvanceRec.Employee) then
                                LoansAdvancesRec."Payroll Code" := EmployeeRec."Payroll Code"; //SNG 130611 payroll data segregation

                            LoansAdvancesRec.Employee := SalaryAdvanceRec.Employee;
                            LoansAdvancesRecCopy.Reset;
                            if LoansAdvancesCopy.FindLast then
                                LoansAdvancesRec.ID := LoansAdvancesCopy.ID + 1;
                            LoanTypesRec.Reset;
                            LoanTypesRec.SetRange(Type, LoanTypesRec.Type::Advance);
                            if LoanTypesRec.FindLast then
                                LoansAdvancesRec."Loan Types" := LoanTypesRec.Code;
                            LoansAdvancesRec.Validate(Principal, SalaryAdvanceRec.Principal);
                            LoansAdvancesRec."Principal (LCY)" := SalaryAdvanceRec."Principal (LCY)";
                            LoansAdvancesRec.Validate("Installment Amount", SalaryAdvanceRec."Installment Amount");
                            LoansAdvancesRec.Validate("Installment Amount (LCY)", SalaryAdvanceRec."Installment Amount (LCY)");
                            LoansAdvancesRec."Interest Rate" := SalaryAdvanceRec."Interest Rate";
                            LoansAdvancesRec.Validate(Installments, SalaryAdvanceRec.Installments);
                            LoansAdvancesRec.Validate("Start Period", SalaryAdvanceRec."Start Period");
                            LoansAdvancesRec.Validate("Currency Code", SalaryAdvanceRec."Currency Code");
                            LoansAdvancesRec.Employee := SalaryAdvanceRec.Employee;//PaymentLine."Account No.";
                            LoansAdvancesRec."Payments Method" := SalaryAdvanceRec."Payments Method";

                            LoansAdvancesRec."Salary Advance Request No" := SalaryAdvanceRec.ID;
                            LoansAdvancesRec.Insert(true);
                            //create and pay loan
                            LoansAdvancesCopy.Reset;
                            LoansAdvancesCopy.SetRange("Salary Advance Request No", SalaryAdvanceRec.ID);
                            if LoansAdvancesCopy.FindLast then begin
                                LoansAdvancesCopy.CreateLoan;
                                LoansAdvancesCopy.PayLoan;

                                //modify pay to employee
                                SalaryAdvanceRec."Paid to Employee" := true;
                                SalaryAdvanceRec.Modify;


                            end
                            else
                                Error('Loan not created');

                        end;
                    end;
                end;
            until PaymentLine.Next = 0;
        end;

        //*********************************************End Add Payment Lines************************************************************//
        Commit;
        //********************************************Post the Journal Lines************************************************************//
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", "Journal Template");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances

        if not Preview then begin
            //Post the Journal Lines
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            BankLedgerEntries.Reset;
            BankLedgerEntries.SetRange("Document No.", PaymentHeader."No.");
            if BankLedgerEntries.FindFirst then begin
                PaymentHeader2.Reset;
                PaymentHeader2.SetRange("No.", PaymentHeader."No.");
                if PaymentHeader2.FindFirst then begin
                    PaymentHeader2.Status := PaymentHeader2.Status::Posted;
                    PaymentHeader2.Validate(PaymentHeader2.Status);
                    PaymentHeader2.Posted := true;
                    PaymentHeader2."Posted By" := UserId;
                    PaymentHeader2."Date Posted" := Today;
                    PaymentHeader2."Time Posted" := Time;
                    if PaymentHeader2.Modify then
                        MarkImprestAsPosted(PaymentHeader."No.");
                end;
            end;
            Commit;
            //***********************************************End Update Document************************************************************//
        end else begin
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange("Journal Template Name", "Journal Template");
            GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
            if GenJnlLine.FindSet then begin
                GenJnlPost.Preview(GenJnlLine);
            end;
            //**********************************************End Preview Posting*************************************************************//
        end;

        BankLedgerEntries.Reset;
        BankLedgerEntries.SetRange("Document No.", PaymentHeader."No.");
        if BankLedgerEntries.FindFirst then begin
            ChequeRegisterLines.Reset;
            ChequeRegisterLines.SetRange(ChequeRegisterLines."Cheque No.", PaymentHeader."Cheque No.");
            if ChequeRegisterLines.FindFirst then begin
                ChequeRegisterLines."Assigned to PV" := true;
                ChequeRegisterLines."PV Posted with Cheque" := true;
                ChequeRegisterLines."Payee No" := PaymentHeader."Payee No.";
                ChequeRegisterLines.Payee := PaymentHeader."Payee Name";
                ChequeRegisterLines."PV No" := PaymentHeader."No.";
                ChequeRegisterLines."PV Description" := PaymentHeader.Description;
                ChequeRegisterLines."PV Prepared By" := PaymentHeader."User ID";
                ChequeRegisterLines.Modify;
            end;
        end;
    end;

    procedure CheckGLBudget(var Imprestheader: Record "Imprest Header")
    var
        ImprestLine: Record "Imprest Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
        Vendor: Record Vendor;
        BankAccount: Record "Bank Account";
    begin
        BCSetup.Get;

        //check if the dates are within the specified range
        if (Imprestheader."Date From" < BCSetup."Current Budget Start Date") or (Imprestheader."Date To" > BCSetup."Current Budget End Date") then begin
            /* ERROR(Text0004,Imprestheader."Date From",Imprestheader."Date To",
             BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");*/
            ;
        end;

        //CheckIfGLAccountBlocked(BCSetup."Current Budget Code");

        //get the lines related to the Imprest/Petty cash requisition header
        ImprestLine.Reset;
        ImprestLine.SetRange(ImprestLine."Document No.", Imprestheader."No.");
        if ImprestLine.FindSet then begin
            repeat
                ///vendor
                if (ImprestLine."Account Type" = ImprestLine."Account Type"::Vendor) then begin
                    if Vendor.Get(ImprestLine."Account No.") then
                        Vendor.Reset;
                    Vendor.TestField("Vendor Budget Gl");
                    GLAccount.TestField(GLAccount."Budget Controlled", true);
                    BudgetGL := Vendor."Vendor Budget Gl";
                end;
                //bank Account
                if (ImprestLine."Account Type" = ImprestLine."Account Type"::"Bank Account") then begin
                    if BankAccount.Get(ImprestLine."Account No.") then
                        BankAccount.Reset;
                    BankAccount.TestField("Budget Gl");
                    //GLAccount.TESTFIELD(GLAccount."Budget Controlled",TRUE);
                    BudgetGL := BankAccount."Budget Gl"
                end;

                //Items
                if (ImprestLine."Account Type" = ImprestLine."Account Type"::Item) then begin
                    if Items.Get(ImprestLine."Account No.") then
                        Items.Reset;
                    Items.TestField("Item G/L Budget Account");
                    GLAccount.TestField(GLAccount."Budget Controlled", true);
                    BudgetGL := Items."Item G/L Budget Account";
                end;

                //G/L Account i
                if ImprestLine."Account Type" = ImprestLine."Account Type"::"G/L Account" then begin
                    BudgetGL := ImprestLine."Account No.";
                    if GLAccount.Get(ImprestLine."Account No.") then
                        GLAccount.TestField(GLAccount."Budget Controlled", true);
                end;
                //check the votebook now
                FirstDay := DMY2Date(1, Date2DMY(Imprestheader."Document Date", 2), Date2DMY(Imprestheader."Document Date", 3));
                CurrMonth := Date2DMY(Imprestheader."Document Date", 2);
                if CurrMonth = 12 then begin
                    LastDay := DMY2Date(1, 1, Date2DMY(Imprestheader."Document Date", 3) + 1);
                    LastDay := CalcDate('-1D', LastDay);
                end else begin
                    CurrMonth := CurrMonth + 1;
                    LastDay := DMY2Date(1, CurrMonth, Date2DMY(Imprestheader."Document Date", 3));
                    LastDay := CalcDate('-1D', LastDay);
                end;
                //get the actual expenditure
                GLAccount.Reset;
                GLAccount.SetRange("No.", BudgetGL);
                GLAccount.SetFilter("Date Filter", '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");// GLAccount.SETFILTER("Date Filter",'%1..%2',FirstDay,LastDay);
                if GLAccount.FindSet then
                    GLAccount.CalcFields("Net Change");

                ActualsAmount := GLAccount."Net Change";

                //check the summation of the budget
                BudgetAmount := 0;
                Budget.Reset;
                Budget.SetRange(Budget."Budget Name", BCSetup."Current Budget Code");
                Budget.SetFilter(Budget.Date, '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Budget.SetRange(Budget."G/L Account No.", BudgetGL);

                if Budget.FindSet then begin
                    Budget.CalcSums(Amount);
                    BudgetAmount := Budget.Amount;
                end;

                //get the committments

                CommitmentAmount := 0;
                Commitments.Reset;
                Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");//BCSetup."Current Budget Start Date",LastDay);
                Commitments.SetRange(Commitments."Shortcut Dimension 1 Code", ImprestLine."Global Dimension 1 Code");
                Commitments.SetRange(Commitments."Shortcut Dimension 2 Code", ImprestLine."Global Dimension 2 Code");
                Commitments.CalcSums(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;

                //check if there is any budget
                if (BudgetAmount <= 0) then
                    Error(Text0010, GLAccount."No.", GLAccount.Name);

                //check if the actuals plus the amount plus the commitments is greater then the budget amount
                if ((ImprestLine."Net Amount" + CommitmentAmount) > BudgetAmount) and (BCSetup."Allow OverExpenditure" = false) then begin
                    Error(Text0011,
                    ImprestLine."Document No.", ImprestLine."Account Type", ImprestLine."Account No.",
                    Format(Abs(BudgetAmount - (CommitmentAmount + ImprestLine."Net Amount"))));

                end;
            until ImprestLine.Next = 0;
            Imprestheader."Passed Budget" := true;
            Imprestheader.Modify;
        end;

    end;

    procedure DecommitGLBudget(var Imprestheader: Record "Imprest Header")
    var
        ImprestLine: Record "Imprest Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
        CommitmentsCopy: Record "Budget Committment";
        lineno: Integer;
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        /*
        IF (Imprestheader."Date From"< BCSetup."Current Budget Start Date") OR (Imprestheader."Date To"> BCSetup."Current Budget End Date") THEN BEGIN
          ERROR(Text0004,Imprestheader."Date From",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        END;
        */

        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        if Commitments.FindLast then
            lineno := Commitments."Line No."
        else
            lineno := 0;
        //get the lines related to the Imprest/Petty cash requisition header
        ImprestLine.Reset;
        ImprestLine.SetRange(ImprestLine."Document No.", Imprestheader."No.");
        if ImprestLine.FindSet then begin
            repeat
                /*
                //Items
                IF PurchLine.Type=PurchLine.Type::Item THEN BEGIN
                  Items.RESET;
                  IF NOT Items.GET(PurchLine."No.") THEN
                  ERROR(Text0007);
                  Items.TESTFIELD("Item G/L Budget Account");
                  BudgetGL:=Items."Item G/L Budget Account";
                END;
                */
                //Fixed Asset
                /*
              IF PurchLine.Type=PurchLine.Type::"Fixed Asset" THEN BEGIN
                FixedAssets.RESET;
                FixedAssets.SETRANGE(FixedAssets."No.",PurchLine."No.");
                IF FixedAssets.FINDFIRST THEN BEGIN
                  FAPostingGroup.RESET;
                  FAPostingGroup.SETRANGE(FAPostingGroup.Code,FixedAssets."FA Posting Group");
                  IF FAPostingGroup.FINDFIRST THEN
                  IF PurchLine."FA Posting Type"=PurchLine."FA Posting Type"::Maintenance THEN BEGIN
                    BudgetGL:=FAPostingGroup."Maintenance Expense Account";
                    IF BudgetGL ='' THEN
                    ERROR(Text0008,PurchLine."No.");
                  END ELSE BEGIN
                    BudgetGL:=FAPostingGroup."Acquisition Cost Account";
                    IF BudgetGL ='' THEN
                    ERROR(Text0009,PurchLine."No.");
                  END;
                END;
              END;
                */

                //G/L Account i
                if ImprestLine."Account Type" = ImprestLine."Account Type"::"G/L Account" then begin
                    BudgetGL := ImprestLine."Account No.";
                    if GLAccount.Get(ImprestLine."Account No.") then
                        GLAccount.TestField(GLAccount."Budget Controlled", true);
                end;
                //check the votebook now
                /*
                FirstDay:=DMY2DATE(1,DATE2DMY(Imprestheader."Document Date",2),DATE2DMY(Imprestheader."Document Date",3));
                CurrMonth:=DATE2DMY(Imprestheader."Document Date",2);
                IF CurrMonth=12 THEN BEGIN
                  LastDay:=DMY2DATE(1,1,DATE2DMY(Imprestheader."Document Date",3) +1);
                  LastDay:=CALCDATE('-1D',LastDay);
                END ELSE BEGIN
                  CurrMonth:=CurrMonth +1;
                  LastDay:=DMY2DATE(1,CurrMonth,DATE2DMY(Imprestheader."Document Date",3));
                  LastDay:=CALCDATE('-1D',LastDay);
                END;
                GLAccount.RESET;
                GLAccount.SETRANGE("No.",BudgetGL);
                GLAccount.SETFILTER("Date Filter",'%1..%2',FirstDay,LastDay);
                IF GLAccount.FINDSET THEN
                GLAccount.CALCFIELDS("Net Change");

                ActualsAmount:=GLAccount."Net Change";

                //check the summation of the budget
                BudgetAmount:=0;
                Budget.RESET;
                Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
                Budget.SETFILTER(Budget.Date,'%1',BCSetup."Current Budget Start Date",FirstDay);
                Budget.SETRANGE(Budget."G/L Account No.",BudgetGL);
                {Budget.SETRANGE(Budget."Global Dimension 1 Code",PurchLine."Global Dimension 1 Code");
                Budget.SETRANGE(Budget."Global Dimension 2 Code",PurchLine."Global Dimension 2 Code");
                IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
                 Budget.SETRANGE(Budget."Budget Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
                IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
                 Budget.SETRANGE(Budget."Budget Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");}
                IF Budget.FINDSET THEN BEGIN
                 Budget.CALCSUMS(Amount);
                 BudgetAmount:=Budget.Amount;
                END;

                //get the committments
                {
                CommitmentAmount:=0;
                Commitments.RESET;
                Commitments.SETRANGE(Commitments.Budget,BCSetup."Current Budget Code");
                Commitments.SETRANGE(Commitments."G/L Account No.",BudgetGL);
                Commitments.SETRANGE(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PurchLine."Global Dimension 1 Code");
                Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PurchLine."Global Dimension 2 Code");
                IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
                 Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
                IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
                 Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");
                Commitments.CALCSUMS(Commitments.Amount);
                CommitmentAmount:= Commitments.Amount;
                }
                //check if there is any budget
                IF (BudgetAmount<=0) THEN
                 ERROR(Text0010);

                //check if the actuals plus the amount is greater then the budget amount
                IF ((ImprestLine."Net Amount") > BudgetAmount) AND (BCSetup."Allow OverExpenditure"=FALSE) THEN BEGIN
                  ERROR(Text0011,
                  ImprestLine."Document No.",ImprestLine."Account Type" ,ImprestLine."Account No.",
                  FORMAT(ABS(BudgetAmount-(ActualsAmount+ImprestLine."Net Amount"))));
                END ELSE BEGIN
                MESSAGE('Budget test passed');
                */
                //Decommit Amounts
                lineno := lineno + 1;
                Commitments.Reset;
                Commitments.SetRange("Document No.", Imprestheader."No.");
                Commitments.SetRange("Document Type", Imprestheader."Document Type");
                CommitmentsCopy.SetRange("Line No.", ImprestLine."Line No.");
                if CommitmentsCopy.FindFirst then begin
                    Commitments.Init;
                    Commitments."Line No." := lineno;
                    Commitments.Date := Today;
                    Commitments."Posting Date" := Imprestheader."Document Date";
                    Commitments."Document Type" := Imprestheader."Document Type";
                    Commitments."Document No." := Imprestheader."No.";
                    Commitments.Amount := -ImprestLine."Net Amount";
                    Commitments."Month Budget" := BudgetAmount;
                    Commitments.Committed := true;
                    Commitments.Cancelled := true;
                    Commitments."Cancelled By" := UserId;
                    Commitments."Cancelled Date" := Today;
                    Commitments."Cancelled Time" := Time;
                    Commitments."Committed By" := UserId;
                    Commitments."Committed Date" := Imprestheader."Document Date";
                    Commitments."G/L Account No." := BudgetGL;
                    Commitments."Committed Time" := Time;
                    Commitments."Shortcut Dimension 1 Code" := ImprestLine."Global Dimension 1 Code";
                    Commitments."Shortcut Dimension 2 Code" := ImprestLine."Global Dimension 2 Code";
                    Commitments."Shortcut Dimension 3 Code" := ImprestLine."Shortcut Dimension 3 Code";
                    Commitments."Shortcut Dimension 4 Code" := ImprestLine."Shortcut Dimension 4 Code";
                    Commitments.Budget := BCSetup."Current Budget Code";
                    Commitments.Type := Commitments.Type::" ";
                    Commitments.Committed := true;
                    Commitments.Insert
                end;

            until ImprestLine.Next = 0;
        end;

    end;

    procedure commitGLBudget(var Imprestheader: Record "Imprest Header")
    var
        ImprestLine: Record "Imprest Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
        CommitmentsCopy: Record "Budget Committment";
        Vendor: Record Vendor;
        BankAccount: Record "Bank Account";
    begin

        BCSetup.Get;

        //check if the dates are within the specified range
        if (Imprestheader."Date From" < BCSetup."Current Budget Start Date") or (Imprestheader."Date To" > BCSetup."Current Budget End Date") then begin
            Error(Text0004, Imprestheader."Date From", Imprestheader."Date To",
            BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
        end;

        //CheckIfGLAccountBlocked(BCSetup."Current Budget Code");

        //get the lines related to the Imprest/Petty cash requisition header
        ImprestLine.Reset;
        ImprestLine.SetRange(ImprestLine."Document No.", Imprestheader."No.");
        if ImprestLine.FindSet then begin
            repeat
                if (ImprestLine."Account Type" = ImprestLine."Account Type"::Vendor) then begin
                    if Vendor.Get(ImprestLine."Account No.") then
                        Vendor.Reset;
                    Vendor.TestField("Vendor Budget Gl");
                    GLAccount.TestField(GLAccount."Budget Controlled", true);
                    BudgetGL := Vendor."Vendor Budget Gl";
                end;
                //bank Account
                if (ImprestLine."Account Type" = ImprestLine."Account Type"::"Bank Account") then begin
                    if BankAccount.Get(ImprestLine."Account No.") then
                        BankAccount.Reset;
                    BankAccount.TestField("Budget Gl");
                    //GLAccount.TESTFIELD(GLAccount."Budget Controlled",TRUE);
                    BudgetGL := BankAccount."Budget Gl"
                end;

                //Items
                if (ImprestLine."Account Type" = ImprestLine."Account Type"::Item) then begin
                    if Items.Get(ImprestLine."Account No.") then
                        Items.Reset;
                    Items.TestField("Item G/L Budget Account");
                    GLAccount.TestField(GLAccount."Budget Controlled", true);
                    BudgetGL := Items."Item G/L Budget Account";
                end;


                //G/L Account i
                if ImprestLine."Account Type" = ImprestLine."Account Type"::"G/L Account" then begin
                    if GLAccount.Get(ImprestLine."Account No.") then
                        GLAccount.TestField(GLAccount."Budget Controlled", true);
                    BudgetGL := ImprestLine."Account No.";
                end;
                //check the votebook now
                FirstDay := DMY2Date(1, Date2DMY(Imprestheader."Document Date", 2), Date2DMY(Imprestheader."Document Date", 3));
                CurrMonth := Date2DMY(Imprestheader."Document Date", 2);
                if CurrMonth = 12 then begin
                    LastDay := DMY2Date(1, 1, Date2DMY(Imprestheader."Document Date", 3) + 1);
                    LastDay := CalcDate('-1D', LastDay);
                end else begin
                    CurrMonth := CurrMonth + 1;
                    LastDay := DMY2Date(1, CurrMonth, Date2DMY(Imprestheader."Document Date", 3));
                    LastDay := CalcDate('-1D', LastDay);
                end;
                //get the netchange/actuals
                GLAccount.Reset;
                GLAccount.SetRange("No.", BudgetGL);
                GLAccount.SetFilter("Date Filter", '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");// GLAccount.SETFILTER("Date Filter",'%1..%2',FirstDay,LastDay);
                if GLAccount.FindSet then
                    GLAccount.CalcFields("Net Change");
                ActualsAmount := GLAccount."Net Change";
                //check the summation of the budget
                BudgetAmount := 0;
                Budget.Reset;
                Budget.SetRange(Budget."Budget Name", BCSetup."Current Budget Code");
                Budget.SetFilter(Budget.Date, '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Budget.SetRange(Budget."G/L Account No.", BudgetGL);
                if Budget.FindSet then begin
                    Budget.CalcSums(Amount);
                    BudgetAmount := Budget.Amount;
                end;
                //get the committments
                CommitmentAmount := 0;
                Commitments.Reset;
                Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");//BCSetup."Current Budget Start Date",LastDay);
                Commitments.SetRange(Commitments."Shortcut Dimension 1 Code", ImprestLine."Global Dimension 1 Code");
                Commitments.SetRange(Commitments."Shortcut Dimension 2 Code", ImprestLine."Global Dimension 2 Code");
                Commitments.CalcSums(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;
                //check if there is any budget
                if (BudgetAmount <= 0) then
                    Error(Text0010, GLAccount."No.", GLAccount.Name);
                //check if the actuals plus the amount plus the commitments is greater then the budget amount
                if ((ImprestLine."Net Amount" + CommitmentAmount) > BudgetAmount) and (BCSetup."Allow OverExpenditure" = false) then begin
                    Error(Text0011,
                    ImprestLine."Document No.", ImprestLine."Account Type", ImprestLine."Account No.",
                    Format(Abs(BudgetAmount - (CommitmentAmount + ImprestLine."Net Amount"))));
                end else begin
                    //commit Amounts
                    Commitments.Init;
                    Commitments."Line No." := 0;
                    Commitments.Date := Imprestheader."Document Date";
                    Commitments."G/L Account No." := BudgetGL;
                    Commitments."Posting Date" := Today;
                    Commitments."Document Type" := Commitments."Document Type"::Imprest;
                    Commitments."Document No." := Imprestheader."No.";
                    Commitments.Amount := ImprestLine."Net Amount";
                    Commitments."Month Budget" := BudgetAmount;
                    Commitments."Month Actual" := ActualsAmount;
                    Commitments.Committed := true;
                    Commitments."Committed By" := UserId;
                    Commitments."Committed Date" := Today;
                    Commitments."Committed Time" := Time;
                    Commitments."Shortcut Dimension 1 Code" := ImprestLine."Global Dimension 1 Code";
                    Commitments."Shortcut Dimension 2 Code" := ImprestLine."Global Dimension 2 Code";
                    Commitments."Shortcut Dimension 3 Code" := ImprestLine."Shortcut Dimension 3 Code";
                    Commitments."Shortcut Dimension 4 Code" := ImprestLine."Shortcut Dimension 4 Code";
                    Commitments.Budget := BCSetup."Current Budget Code";
                    Commitments."Budget Balance" := BudgetAmount - (CommitmentAmount + ImprestLine."Net Amount");
                    Commitments.Type := Commitments.Type::" ";
                    Commitments.Committed := true;
                    if GLAccount.Get(Commitments."G/L Account No.") then
                        Commitments."Gl Name" := GLAccount.Name;
                    if Commitments.Insert then begin
                        ImprestLine."Budget Committed" := true;
                        ImprestLine.Committed := true;
                        ImprestLine.Modify;
                    end;
                end;
            until ImprestLine.Next = 0;
            Imprestheader.Voted := true;
            Imprestheader."Passed Budget" := true;
            Imprestheader.Modify;
        end;
        //END;
    end;

    procedure CommitImprest(var ImprestHeader: Record "Imprest Header")
    var
        ImprestLine: Record "Imprest Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;

    begin
        BCSetup.GET;
        //check if the dates are within the specified range
        IF (Imprestheader."Date From" < BCSetup."Current Budget Start Date") OR (Imprestheader."Date To" > BCSetup."Current Budget End Date") then begin
            ERROR(Text0004, Imprestheader."Date From",
            BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date")
        END;

        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        Imprestheader.TESTFIELD(Voted, FALSE);

        //get the lines related to the Imprest/Petty cash requisition header
        ImprestLine.RESET;
        ImprestLine.SETRANGE(ImprestLine."Document No.", Imprestheader."No.");
        ImprestLine.SETRANGE(ImprestLine.Committed, FALSE);
        IF ImprestLine.FINDSET THEN BEGIN
            REPEAT
                //ImprestLine.TESTFIELD("Budget Gl");

                //BudgetGL := ImprestLine."Budget Gl";
                FirstDay := DMY2DATE(1, DATE2DMY(Imprestheader."Document Date", 2), DATE2DMY(Imprestheader."Document Date", 3));
                CurrMonth := DATE2DMY(Imprestheader."Document Date", 2);
                IF CurrMonth = 12 THEN BEGIN
                    LastDay := DMY2DATE(1, 1, DATE2DMY(Imprestheader."Document Date", 3) + 1);
                    LastDay := CALCDATE('-1D', LastDay);
                END ELSE BEGIN
                    CurrMonth := CurrMonth + 1;
                    LastDay := DMY2DATE(1, CurrMonth, DATE2DMY(Imprestheader."Document Date", 3));
                    LastDay := CALCDATE('-1D', LastDay);
                END;
                GLAccount.RESET;
                GLAccount.SETRANGE("No.", BudgetGL);
                GLAccount.SETFILTER("Date Filter", '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");//FirstDay,LastDay);
                IF GLAccount.FINDSET THEN
                    GLAccount.CALCFIELDS("Net Change");

                ActualsAmount := GLAccount."Net Change";

                //check the summation of the budget
                BudgetAmount := 0;
                ActualsAmount := 0;
                Budget.RESET;
                Budget.SETRANGE(Budget."Budget Name", BCSetup."Current Budget Code");
                Budget.SETFILTER(Budget.Date, '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Budget.SETRANGE(Budget."G/L Account No.", BudgetGL);
                IF Budget.FINDSET THEN BEGIN
                    Budget.CALCSUMS(Amount);
                    BudgetAmount := Budget.Amount;
                END;
                //get the actual expenditure
                GLAccount.RESET;
                GLAccount.SETFILTER("Date Filter", '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");//SalaryAdvanceRec
                GLAccount.SETRANGE(GLAccount."No.", BudgetGL);
                GLAccount.SETRANGE(GLAccount."Budget Controlled", TRUE);
                IF GLAccount.FINDSET THEN
                    GLAccount.CALCFIELDS("Net Change");
                ActualsAmount := GLAccount."Net Change";

                //get the committments

                CommitmentAmount := 0;
                Commitments.RESET;
                Commitments.SETRANGE(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SETRANGE(Commitments."G/L Account No.", BudgetGL);
                Commitments.SETFILTER(Commitments."Posting Date", '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Commitments.CALCSUMS(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;

                //check if there is any budget
                IF (BudgetAmount <= 0) THEN
                    ERROR(Text0010);
                IF ((CommitmentAmount + ImprestLine."Net Amount") > BudgetAmount) AND (BCSetup."Allow OverExpenditure" = FALSE) THEN BEGIN
                    ERROR(Text0011,
                    ImprestLine."Document No.", ImprestLine."Account Type", ImprestLine."Account No.",
                    FORMAT(ABS(BudgetAmount - (CommitmentAmount + ImprestLine."Net Amount"))));
                END ELSE BEGIN

                    //Commit Amounts

                    Commitments.INIT;
                    Commitments.Date := Imprestheader."Posting Date";
                    Commitments."Posting Date" := TODAY;
                    Commitments."G/L Account No." := BudgetGL;
                    //Commitments."Document Type":=Imprestheader."Document Type"::Imprest;;
                    Commitments."Document Type" := Commitments."Document Type"::Imprest;//
                    Commitments."Document No." := Imprestheader."No.";
                    Commitments.Amount := ImprestLine."Net Amount";
                    Commitments."Month Budget" := BudgetAmount;
                    //Commitments.Actual := ActualsAmount;
                    Commitments."Month Actual" := ActualsAmount;
                    Commitments.Committed := TRUE;
                    Commitments."Committed By" := USERID;
                    Commitments."Committed Date" := Imprestheader."Posting Date";
                    //Commitments."G/L Account No.":=BudgetGL;
                    Commitments."Committed Time" := TIME;
                    Commitments."Shortcut Dimension 1 Code" := ImprestLine."Global Dimension 1 Code";
                    Commitments."Shortcut Dimension 2 Code" := ImprestLine."Global Dimension 2 Code";
                    Commitments."Shortcut Dimension 3 Code" := ImprestLine."Shortcut Dimension 3 Code";
                    Commitments."Shortcut Dimension 4 Code" := ImprestLine."Shortcut Dimension 4 Code";
                    Commitments.Budget := BCSetup."Current Budget Code";
                    Commitments.Description := ImprestLine.Description;
                    IF GLAccount.GET(Commitments."G/L Account No.") THEN
                        Commitments."G/L Name" := GLAccount.Name;
                    Commitments.Type := Commitments.Type::" ";
                    Commitments."Budget Balance" := BudgetAmount - (CommitmentAmount + ImprestLine."Net Amount");
                    Commitments.Committed := TRUE;
                    IF Commitments.INSERT(TRUE) THEN BEGIN
                        ImprestLine."Budget Committed" := TRUE;
                        //ImprestLine."Budget Balance" := BudgetAmount - (CommitmentAmount + ImprestLine."Net Amount");
                        //ImprestLine."Amount Committed" := ImprestLine."Net Amount";
                        //ImprestLine."Total Commitment Before" := CommitmentAmount;
                        ImprestLine.Committed := TRUE;//
                        ImprestLine.MODIFY;
                    END;

                END;

            UNTIL ImprestLine.NEXT = 0;
            Imprestheader.Voted := TRUE;
            Imprestheader.MODIFY;

        END;
    end;


    procedure CheckIfGLAccountBlocked(BudgetName: Code[20])
    var
        GLBudgetName: Record "G/L Budget Name";
    begin
        GLBudgetName.Get(BudgetName);
        GLBudgetName.TestField(Blocked, false);
    end;

    procedure CalcBudgetGLBudgetAvailAmt(var Imprestheader: Record "Imprest Header")
    var
        ImprestLine: Record "Imprest Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (Imprestheader."Date From" < BCSetup."Current Budget Start Date") or (Imprestheader."Date To" > BCSetup."Current Budget End Date") then begin
            Error(Text0004, Imprestheader."Date From",
            BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
        end;


        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");

        //get the lines related to the Imprest/Petty cash requisition header
        ImprestLine.Reset;
        ImprestLine.SetRange(ImprestLine."Document No.", Imprestheader."No.");
        if ImprestLine.FindSet then begin
            repeat
                /*
                //Items
                IF PurchLine.Type=PurchLine.Type::Item THEN BEGIN
                  Items.RESET;
                  IF NOT Items.GET(PurchLine."No.") THEN
                  ERROR(Text0007);
                  Items.TESTFIELD("Item G/L Budget Account");
                  BudgetGL:=Items."Item G/L Budget Account";
                END;
                */
                //Fixed Asset
                /*
                IF PurchLine.Type=PurchLine.Type::"Fixed Asset" THEN BEGIN
                  FixedAssets.RESET;
                  FixedAssets.SETRANGE(FixedAssets."No.",PurchLine."No.");
                  IF FixedAssets.FINDFIRST THEN BEGIN
                    FAPostingGroup.RESET;
                    FAPostingGroup.SETRANGE(FAPostingGroup.Code,FixedAssets."FA Posting Group");
                    IF FAPostingGroup.FINDFIRST THEN
                    IF PurchLine."FA Posting Type"=PurchLine."FA Posting Type"::Maintenance THEN BEGIN
                      BudgetGL:=FAPostingGroup."Maintenance Expense Account";
                      IF BudgetGL ='' THEN
                      ERROR(Text0008,PurchLine."No.");
                    END ELSE BEGIN
                      BudgetGL:=FAPostingGroup."Acquisition Cost Account";
                      IF BudgetGL ='' THEN
                      ERROR(Text0009,PurchLine."No.");
                    END;
                  END;
                END;
                */

                //G/L Account i
                if ImprestLine."Account Type" = ImprestLine."Account Type"::"G/L Account" then begin
                    BudgetGL := ImprestLine."Account No.";
                    if GLAccount.Get(ImprestLine."Account No.") then
                        GLAccount.TestField(GLAccount."Budget Controlled", true);
                end;
                //check the votebook now
                FirstDay := DMY2Date(1, Date2DMY(Imprestheader."Document Date", 2), Date2DMY(Imprestheader."Document Date", 3));
                CurrMonth := Date2DMY(Imprestheader."Document Date", 2);
                if CurrMonth = 12 then begin
                    LastDay := DMY2Date(1, 1, Date2DMY(Imprestheader."Document Date", 3) + 1);
                    LastDay := CalcDate('-1D', LastDay);
                end else begin
                    CurrMonth := CurrMonth + 1;
                    LastDay := DMY2Date(1, CurrMonth, Date2DMY(Imprestheader."Document Date", 3));
                    LastDay := CalcDate('-1D', LastDay);
                end;
                GLAccount.Reset;
                GLAccount.SetRange("No.", BudgetGL);
                GLAccount.SetFilter("Date Filter", '%1..%2', FirstDay, LastDay);
                if GLAccount.FindSet then
                    GLAccount.CalcFields("Net Change");

                ActualsAmount := GLAccount."Net Change";

                //check the summation of the budget
                BudgetAmount := 0;
                Budget.Reset;
                Budget.SetRange(Budget."Budget Name", BCSetup."Current Budget Code");
                // Budget.SETFILTER(Budget.Date,'%1',BCSetup."Current Budget Start Date",FirstDay);
                Budget.SetFilter(Budget.Date, '%1', FirstDay, LastDay);

                Budget.SetRange(Budget."G/L Account No.", BudgetGL);
                /*Budget.SETRANGE(Budget."Global Dimension 1 Code",PurchLine."Global Dimension 1 Code");
                Budget.SETRANGE(Budget."Global Dimension 2 Code",PurchLine."Global Dimension 2 Code");
                IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
                 Budget.SETRANGE(Budget."Budget Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
                IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
                 Budget.SETRANGE(Budget."Budget Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");*/
                if Budget.FindSet then begin
                    Budget.CalcSums(Amount);
                    BudgetAmount := Budget.Amount;
                end;

                //get the committments

                CommitmentAmount := 0;
                Commitments.Reset;
                Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                Commitments.SetRange(Commitments."Shortcut Dimension 1 Code", ImprestLine."Global Dimension 1 Code");
                Commitments.SetRange(Commitments."Shortcut Dimension 2 Code", ImprestLine."Global Dimension 2 Code");
                if ImprestLine."Shortcut Dimension 3 Code" <> '' then
                    Commitments.SetRange(Commitments."Shortcut Dimension 3 Code", ImprestLine."Shortcut Dimension 3 Code");
                if ImprestLine."Shortcut Dimension 4 Code" <> '' then
                    Commitments.SetRange(Commitments."Shortcut Dimension 4 Code", ImprestLine."Shortcut Dimension 4 Code");
                Commitments.CalcSums(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;

                //check if there is any budget
                if (BudgetAmount <= 0) then
                    Error(Text0010);

                //check if the actuals plus the amount plus the commitments is greater then the budget amount
                if ((ImprestLine."Net Amount" + ActualsAmount + CommitmentAmount) > BudgetAmount) and (BCSetup."Allow OverExpenditure" = false) then begin
                    Error(Text0011,
                    ImprestLine."Document No.", ImprestLine."Account Type", ImprestLine."Account No.",
                    Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + ImprestLine."Net Amount"))));
                end else begin
                    Message('Budget test passed');

                    //commit Amounts
                    /*
                    Commitments.INIT;
                    Commitments."Line No.":=0;
                    Commitments.Date:=TODAY;
                    Commitments."Posting Date":=Imprestheader."Document Date";
                    Commitments."Document Type":=Imprestheader."Document Type";
                    Commitments."Document No.":=Imprestheader."No.";
                    Commitments.Amount:=ImprestLine."Net Amount";
                    Commitments."Month Budget":=BudgetAmount;
                    Commitments.Committed:=TRUE;
                    Commitments."Committed By":=USERID;
                    Commitments."Committed Date":=Imprestheader."Document Date";
                    Commitments."G/L Account No.":=BudgetGL;
                    Commitments."Committed Time":=TIME;
                    Commitments."Shortcut Dimension 1 Code":=ImprestLine."Global Dimension 1 Code";
                    Commitments."Shortcut Dimension 2 Code":=ImprestLine."Global Dimension 2 Code";
                    Commitments."Shortcut Dimension 3 Code":=ImprestLine."Shortcut Dimension 3 Code";
                    Commitments."Shortcut Dimension 4 Code":=ImprestLine."Shortcut Dimension 4 Code";
                    Commitments.Budget:=BCSetup."Current Budget Code";
                    Commitments.Type:=Commitments.Type::" ";
                    Commitments.Committed:=TRUE;
                    IF Commitments.INSERT THEN BEGIN
                      ImprestLine."Budget Committed":=TRUE;
                      ImprestLine.MODIFY;
                     END;
                     */

                end;
            until ImprestLine.Next = 0;
        end;

    end;

    procedure CheckCasualPaymentMandatoryFields("Imprest Header": Record "Imprest Header"; Posting: Boolean)
    var
        ImprestHeader: Record "Imprest Header";
        ImprestLine: Record "Imprest Line";
        EmptyImprestLine: Label 'You cannot Post Imprest with empty Line';
    begin
        ImprestHeader.TransferFields("Imprest Header", true);
        ImprestHeader.TestField("Posting Date");
        ImprestHeader.TestField("Casual Requisition");
        //ImprestHeader.TESTFIELD("Bank Account No.");
        ImprestHeader.TestField("Employee No.");
        ImprestHeader.TestField(Description);
        ImprestHeader.TestField("Employee Posting Group");
        ImprestHeader.TestField("Global Dimension 1 Code");
        ImprestHeader.TestField("Global Dimension 2 Code");
        ImprestHeader.TestField(Type);
        ImprestHeader.TestField("Date From");
        ImprestHeader.TestField("Date To");
        ImprestHeader.TestField("Supervisor Report");
        ImprestHeader.TestField("Any Remaining Work");
        if Posting then
            // ImprestHeader.TESTFIELD(Status,ImprestHeader.Status::Released);
            //Check Imprest Lines
            ImprestLine.Reset;
        ImprestLine.SetRange("Document No.", ImprestHeader."No.");
        if ImprestLine.FindSet then begin
            repeat
                if ImprestLine."Casual Payment" = true then begin
                    ImprestLine.TestField(Names);
                    ImprestLine.TestField("Unit Amount");
                    ImprestLine.TestField(Quantity);
                    ImprestLine.TestField("Telephone No.");
                    ImprestLine.TestField("ID No.");
                end else begin
                    ImprestLine.TestField(Names);
                    ImprestLine.TestField("Daily Rate");
                end;
            until ImprestLine.Next = 0;
        end else begin
            Error(EmptyImprestLine);
        end;
    end;

    procedure PostWithholding("Payment Header": Record "Payment Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        PaymentLine: Record "Payment Line";
        PaymentHeader: Record "Payment Header";
        SourceCode: Code[20];
        BankLedgerEntries: Record "Bank Account Ledger Entry";
        PaymentLine2: Record "Payment Line";
        PaymentHeader2: Record "Payment Header";
        DocumentExist: Label 'Payment Document is already posted, Document No.:%1 already exists in Bank No:%2';
        EmployeeLoanAccounts: Record "Employee Loan Accounts";
        LoanRepayment: Record "Employee Repayment Schedule";
        PaymentCodes: Record "Funds Transaction Code";
        EmployeeRec: Record Employee;
    begin
        PaymentHeader.TransferFields("Payment Header", true);
        SourceCode := PAYMENTJNL;

        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", "Journal Template");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        LineNo := 1000;
        //*********************************************Add Payment Header***************************************************************//
        PaymentHeader.CalcFields("Net Amount");
        /*GenJnlLine.INIT;
        GenJnlLine."Journal Template Name":="Journal Template";
        GenJnlLine.VALIDATE("Journal Template Name");
        GenJnlLine."Journal Batch Name":="Journal Batch";
        GenJnlLine.VALIDATE("Journal Batch Name");
        GenJnlLine."Line No.":=LineNo;
        GenJnlLine."Source Code":=SourceCode;
        GenJnlLine."Posting Date":=PaymentHeader."Posting Date";
        GenJnlLine."Document Type":=GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No.":=PaymentHeader."No.";
        GenJnlLine."External Document No.":=PaymentHeader."Reference No.";
        GenJnlLine."Cheque No.":=PaymentHeader."Cheque No.";
        GenJnlLine."Account Type":=GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No.":=PaymentHeader."Bank Account No.";
        GenJnlLine.VALIDATE("Account No.");
        GenJnlLine."Currency Code":=PaymentHeader."Currency Code";
        GenJnlLine.VALIDATE("Currency Code");
        GenJnlLine.Amount:=-(PaymentHeader."Net Amount");  //Credit Amount
        GenJnlLine.VALIDATE(Amount);
        GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No.":='';
        GenJnlLine.VALIDATE("Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code":=PaymentHeader."Global Dimension 1 Code";
        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code":=PaymentHeader."Global Dimension 2 Code";
        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3,PaymentHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4,PaymentHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5,PaymentHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6,PaymentHeader."Shortcut Dimension 6 Code");
        GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
        GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description:=UPPERCASE(COPYSTR(PaymentHeader.Description,1,249));
        GenJnlLine.Description2:=UPPERCASE(COPYSTR(PaymentHeader."Payee Name",1,249));
        GenJnlLine.Payee:=PaymentHeader."Payee Name";
        GenJnlLine.VALIDATE(Description);
        IF PaymentHeader."Loan No."<>'' THEN BEGIN
          GenJnlLine."Investment Account No.":=PaymentHeader."Loan No.";
          GenJnlLine."Investment Transaction Type":=GenJnlLine."Investment Transaction Type"::"Loan Disbursement";
        END;
        IF GenJnlLine.Amount<>0 THEN
            GenJnlLine.INSERT;*/
        //************************************************End Add to Bank***************************************************************//

        //***********************************************Add Payment Lines**************************************************************//
        PaymentLine.Reset;
        PaymentLine.SetRange("Document No.", PaymentHeader."No.");
        PaymentLine.SetFilter("Total Amount", '<>%1', 0);
        if PaymentLine.FindSet then begin
            repeat
                //****************************************Add Line Amounts***********************************************************//
                // MESSAGE('in');
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate("Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate("Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                GenJnlLine."Document No." := PaymentLine."Document No.";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Account Type" := PaymentLine."Account Type";
                GenJnlLine."Account No." := PaymentLine."Account No.";
                GenJnlLine.Validate("Account No.");
                GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                GenJnlLine.Validate("Currency Code");
                // GenJnlLine.Amount:=PaymentLine."Net Amount";  //Debit Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                if PaymentHeader."Loan No." <> '' then begin
                    GenJnlLine."Investment Account No." := PaymentHeader."Loan No.";
                    GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Loan Disbursement";
                end;
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                GenJnlLine.Validate("Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PaymentLine."Global Dimension 2 Code";
                GenJnlLine.Validate("Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PaymentLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PaymentLine."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, PaymentLine."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, PaymentLine."Shortcut Dimension 6 Code");
                GenJnlLine.ValidateShortcutDimCode(7, PaymentLine."Shortcut Dimension 7 Code");
                GenJnlLine.ValidateShortcutDimCode(8, PaymentLine."Shortcut Dimension 8 Code");
                GenJnlLine.Description := UpperCase(CopyStr(PaymentLine.Description, 1, 249));
                GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
                GenJnlLine.Validate(Description);
                GenJnlLine.Payee := PaymentHeader."Payee Name";
                GenJnlLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                GenJnlLine.Validate("Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                GenJnlLine."Employee Transaction Type" := PaymentLine."Employee Transaction Type";
                if PaymentHeader."Loan No." <> '' then begin
                    GenJnlLine."Investment Account No." := PaymentHeader."Loan No.";
                    GenJnlLine."Investment Transaction Type" := GenJnlLine."Investment Transaction Type"::"Loan Disbursement";
                end;
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;
                //*************************************End Add Line Amounts**********************************************************//

                //**************************************Add W/TAX Amounts************************************************************//
                if PaymentLine."Withholding Tax Code" <> '' then begin
                    TaxCodes.Reset;
                    TaxCodes.SetRange("Tax Code", PaymentLine."Withholding Tax Code");
                    if TaxCodes.FindFirst then begin
                        TaxCodes.TestField("Account No.");
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No.";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine.Amount := -(PaymentLine."Withholding Tax Amount");   //Credit Amount
                        GenJnlLine.Validate(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UpperCase(CopyStr('W/TAX:' + Format(PaymentLine."Document No.") + '::' + Format(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
                        GenJnlLine.Payee := PaymentHeader."Payee Name";
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;

                        //W/TAX Balancing
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := PaymentLine."Account Type";
                        GenJnlLine."Account No." := PaymentLine."Account No.";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Posting Group" := PaymentLine."Posting Group";
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine.Amount := PaymentLine."Withholding Tax Amount";   //Debit Amount
                        GenJnlLine.Validate(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UpperCase(CopyStr('W/TAX:' + Format(PaymentLine."Document No.") + '::' + Format(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));

                        GenJnlLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                        GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                        GenJnlLine.Validate("Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                        GenJnlLine."Employee Transaction Type" := PaymentLine."Employee Transaction Type";
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;
                    end;
                end;
                //****************************************End Add W/TAX Amounts************************************************************//

                //****************************************Add W/VAT Amounts***************************************************************//
                if PaymentLine."Withholding VAT Code" <> '' then begin
                    TaxCodes.Reset;
                    TaxCodes.SetRange("Tax Code", PaymentLine."Withholding VAT Code");
                    if TaxCodes.FindFirst then begin
                        TaxCodes.TestField("Account No.");
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No.";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine.Amount := -(PaymentLine."Withholding VAT Amount");   //Credit Amount
                        GenJnlLine.Validate(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UpperCase(CopyStr('W/VAT:' + Format(PaymentLine."Document No.") + '::' + Format(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
                        GenJnlLine.Payee := PaymentHeader."Payee Name";
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;

                        //W/VAT Balancing
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := PaymentLine."Account Type";
                        GenJnlLine."Account No." := PaymentLine."Account No.";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Posting Group" := PaymentLine."Posting Group";
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine.Amount := PaymentLine."Withholding VAT Amount";   //Debit Amount
                        GenJnlLine.Validate(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UpperCase(CopyStr('W/VAT:' + Format(PaymentLine."Document No.") + '::' + Format(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UpperCase(CopyStr(PaymentHeader."Payee Name", 1, 249));
                        GenJnlLine.Payee := PaymentHeader."Payee Name";
                        GenJnlLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                        GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                        GenJnlLine.Validate("Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                        GenJnlLine."Employee Transaction Type" := PaymentLine."Employee Transaction Type";
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;
                    end;
                end;
                //***********************************End Add W/VAT Amounts*************************************************************//
                //salary Advance** create loan and pay
                if not Preview then begin
                    if PaymentLine."Payee Type" = PaymentLine."Payee Type"::"Salary Advance" then begin
                        SalaryAdvanceRec.Reset;
                        SalaryAdvanceRec.SetRange(ID, PaymentLine."Payee No.");
                        if SalaryAdvanceRec.FindFirst then begin
                            LoansAdvancesRec.Init;
                            LoansAdvancesRec.Type := LoansAdvancesRec.Type::Advance;
                            //Get Payroll code from employee
                            if EmployeeRec.Get(SalaryAdvanceRec.Employee) then
                                LoansAdvancesRec."Payroll Code" := EmployeeRec."Payroll Code"; //SNG 130611 payroll data segregation

                            LoansAdvancesRec.Employee := SalaryAdvanceRec.Employee;

                            LoanTypesRec.Reset;
                            LoanTypesRec.SetRange(Type, LoanTypesRec.Type::Advance);
                            if LoanTypesRec.FindLast then
                                LoansAdvancesRec."Loan Types" := LoanTypesRec.Code;
                            LoansAdvancesRec.Validate(Principal, SalaryAdvanceRec.Principal);
                            LoansAdvancesRec."Principal (LCY)" := SalaryAdvanceRec."Principal (LCY)";
                            LoansAdvancesRec.Validate("Installment Amount", SalaryAdvanceRec."Installment Amount");
                            LoansAdvancesRec.Validate("Installment Amount (LCY)", SalaryAdvanceRec."Installment Amount (LCY)");
                            LoansAdvancesRec."Interest Rate" := SalaryAdvanceRec."Interest Rate";
                            LoansAdvancesRec.Validate(Installments, SalaryAdvanceRec.Installments);
                            LoansAdvancesRec.Validate("Start Period", SalaryAdvanceRec."Start Period");
                            LoansAdvancesRec.Validate("Currency Code", SalaryAdvanceRec."Currency Code");
                            LoansAdvancesRec.Employee := PaymentLine."Account No.";
                            LoansAdvancesRec."Payments Method" := SalaryAdvanceRec."Payments Method";

                            LoansAdvancesRec."Salary Advance Request No" := SalaryAdvanceRec.ID;
                            LoansAdvancesRec.Insert(true);
                            //create and pay loan
                            LoansAdvancesCopy.Reset;
                            LoansAdvancesCopy.SetRange("Salary Advance Request No", SalaryAdvanceRec.ID);
                            if LoansAdvancesCopy.FindLast then begin
                                LoansAdvancesCopy.CreateLoan;
                                LoansAdvancesCopy.PayLoan;

                                //modify pay to employee
                                SalaryAdvanceRec."Paid to Employee" := true;
                                SalaryAdvanceRec.Modify;


                            end
                            else
                                Error('Loan not created');

                        end;
                    end;
                end;
            until PaymentLine.Next = 0;
        end;

        //*********************************************End Add Payment Lines************************************************************//
        Commit;
        //********************************************Post the Journal Lines************************************************************//
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", "Journal Template");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances

        if not Preview then begin
            //Post the Journal Lines
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            //BankLedgerEntries.RESET;
            // BankLedgerEntries.SETRANGE("Document No.",PaymentHeader."No.");
            // IF BankLedgerEntries.FINDFIRST THEN BEGIN
            PaymentHeader2.Reset;
            PaymentHeader2.SetRange("No.", PaymentHeader."No.");
            if PaymentHeader2.FindFirst then begin
                PaymentHeader2.Status := PaymentHeader2.Status::Posted;
                PaymentHeader2.Validate(PaymentHeader2.Status);
                PaymentHeader2.Posted := true;
                PaymentHeader2."Posted By" := UserId;
                PaymentHeader2."Date Posted" := Today;
                PaymentHeader2."Time Posted" := Time;
                if PaymentHeader2.Modify then
                    MarkImprestAsPosted(PaymentHeader."No.");
            end;
            // END;
            Commit;
            //***********************************************End Update Document************************************************************//
        end else begin
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange("Journal Template Name", "Journal Template");
            GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
            if GenJnlLine.FindSet then begin
                GenJnlPost.Preview(GenJnlLine);
            end;
            //**********************************************End Preview Posting*************************************************************//
        end;

        BankLedgerEntries.Reset;
        BankLedgerEntries.SetRange("Document No.", PaymentHeader."No.");
        if BankLedgerEntries.FindFirst then begin
            ChequeRegisterLines.Reset;
            ChequeRegisterLines.SetRange(ChequeRegisterLines."Cheque No.", PaymentHeader."Cheque No.");
            if ChequeRegisterLines.FindFirst then begin
                ChequeRegisterLines."Assigned to PV" := true;
                ChequeRegisterLines."PV Posted with Cheque" := true;
                ChequeRegisterLines."Payee No" := PaymentHeader."Payee No.";
                ChequeRegisterLines.Payee := PaymentHeader."Payee Name";
                ChequeRegisterLines."PV No" := PaymentHeader."No.";
                ChequeRegisterLines."PV Description" := PaymentHeader.Description;
                ChequeRegisterLines."PV Prepared By" := PaymentHeader."User ID";
                ChequeRegisterLines.Modify;
            end;
        end;

    end;

    procedure CheckWithholdingMandatoryFields("Payment Header": Record "Payment Header"; Posting: Boolean)
    var
        PaymentHeader: Record "Payment Header";
        PaymentLine: Record "Payment Line";
        EmptyPaymentLine: Label 'You cannot Post Payment with empty Line';
        "G/LAccount": Record "G/L Account";
    begin
        PaymentHeader.TestField("Posting Date");
        PaymentHeader.TestField("Cheque No.");
        PaymentHeader.TestField(Description);
        PaymentHeader.TestField("Global Dimension 1 Code");
        if Posting then
            PaymentHeader.TestField(Status, PaymentHeader.Status::Approved);

        //Check Payment Lines
        PaymentLine.Reset;
        PaymentLine.SetRange("Document No.", PaymentHeader."No.");
        if PaymentLine.FindSet then begin
            repeat
                PaymentLine.TestField("Account No.");
                PaymentLine.TestField("Total Amount");
                PaymentLine.TestField(Description);
                if PaymentLine."Account Type" = PaymentLine."Account Type"::"G/L Account" then begin
                    "G/LAccount".Reset;
                    "G/LAccount".Get(PaymentLine."Account No.");
                    if "G/LAccount"."Income/Balance" = "G/LAccount"."Income/Balance"::"Income Statement" then begin
                        //PaymentLine.TESTFIELD("Global Dimension 2 Code");
                        /* PaymentLine.TESTFIELD("Shortcut Dimension 3 Code");
                         PaymentLine.TESTFIELD("Shortcut Dimension 4 Code");
                         PaymentLine.TESTFIELD("Shortcut Dimension 5 Code");
                         PaymentLine.TESTFIELD("Shortcut Dimension 6 Code");*/
                    end;
                end;
            until PaymentLine.Next = 0;
        end else begin
            Error(EmptyPaymentLine);
        end;

    end;

    procedure CommitjounalVoucher(var JournalVoucher: Record "Journal Voucher Header")
    var
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
        CommitmentsCopy: Record "Budget Committment";
        JvLines: Record "Journal Voucher Lines";
    begin
        /*BCSetup.GET;
        //check if the dates are within the specified range
        IF (JournalVoucher."Document date"< BCSetup."Current Budget Start Date") OR (JournalVoucher."Document date"> BCSetup."Current Budget End Date") THEN BEGIN
          ERROR(Text0004,JournalVoucher."Document date",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        END;
        
        JournalVoucher.TESTFIELD(Voted,FALSE);
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        
        JvLines.RESET;
        JvLines.SETRANGE(JvLines."JV No.",JournalVoucher."JV No.");
        IF JvLines.FINDSET THEN BEGIN
          REPEAT
          //JvLines
            BudgetGL:=JvLines."Account No.";
        
        
            FirstDay:=DMY2DATE(1,DATE2DMY(JournalVoucher."Document date",2),DATE2DMY(JournalVoucher."Document date",3));
            CurrMonth:=DATE2DMY(JournalVoucher."Document date",2);
            IF CurrMonth=12 THEN BEGIN
              LastDay:=DMY2DATE(1,1,DATE2DMY(JournalVoucher."Document date",3) +1);
              LastDay:=CALCDATE('-1D',LastDay);
            END ELSE BEGIN
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2DATE(1,CurrMonth,DATE2DMY(JournalVoucher."Document date",3));
              LastDay:=CALCDATE('-1D',LastDay);
            END;
        
            BudgetAmount:=0;
            Budget.RESET;
            Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SETFILTER(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Budget.SETRANGE(Budget."G/L Account No.",BudgetGL);
            IF Budget.FINDSET THEN BEGIN
             Budget.CALCSUMS(Amount);
             BudgetAmount:=Budget.Amount;
            END;
        
        
            GLAccount.RESET;
            GLAccount.SETRANGE("No.",BudgetGL);
            GLAccount.SETFILTER("Date Filter",'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");// GLAccount.SETFILTER("Date Filter",'%1..%2',FirstDay,LastDay);
            IF GLAccount.FINDSET THEN
            GLAccount.CALCFIELDS("Net Change");
            ActualsAmount:=GLAccount."Net Change";
        
            //get the committments
        
            CommitmentAmount:=0;
            Commitments.RESET;
            Commitments.SETRANGE(Commitments.Budget,BCSetup."Current Budget Code");
            Commitments.SETRANGE(Commitments."G/L Account No.",BudgetGL);
            Commitments.SETFILTER(Commitments."Posting Date",'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Commitments.CALCSUMS(Commitments.Amount);
            CommitmentAmount:= Commitments.Amount;
        
            //check if there is any budget
            IF (BudgetAmount<=0) THEN
             ERROR(Text0010);
        
            //check if the actuals plus the amount is greater than the budget amount
            IF ((CommitmentAmount + JournalVoucher."Total Debit") > BudgetAmount) AND (BCSetup."Allow OverExpenditure"=FALSE) THEN BEGIN
              ERROR(Text0011,
              JournalVoucher."JV No.",JournalVoucher."Document date" ,JournalVoucher."Budget GL",
              FORMAT(ABS(BudgetAmount-(CommitmentAmount +JournalVoucher."Total Debit"))));
            END ELSE BEGIN
        
            //Commit Amounts
        
            Commitments.INIT;
            Commitments.Date:=JournalVoucher."Document date";
            Commitments."Posting Date":=TODAY;
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Document Type":=Commitments."Document Type"::"Journal Voucher";
            Commitments."Document No.":=JournalVoucher."JV No.";
            Commitments.Amount:=JournalVoucher."Total Debit";
            Commitments."Month Budget":=BudgetAmount;
            Commitments."Month Actual":=CommitmentAmount +JournalVoucher."Total Debit";
            Commitments.Committed:=TRUE;
            Commitments."Committed By":=USERID;
            Commitments."Committed Date":=TODAY;
            Commitments."Committed Time":=TIME;
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Type:=Commitments.Type::" ";
            Commitments."Employee Name":=JournalVoucher."User ID";
            Commitments.Description:=JournalVoucher.Description;
            Commitments."Budget Balance":=BudgetAmount-(CommitmentAmount +JournalVoucher."Total Debit");
            Commitments.Committed:=TRUE;
            IF GLAccount.GET(Commitments."G/L Account No.") THEN
            Commitments."G/L Name":=GLAccount.Name;
           IF  Commitments.INSERT(TRUE) THEN BEGIN
           END;
        
        END;
          UNTIL JvLines.NEXT=0;
        JournalVoucher.Voted:=TRUE;
        JournalVoucher.MODIFY;
        
        END;*/
        BCSetup.Get;
        //check if the dates are within the specified range
        if (JournalVoucher."Document date" < BCSetup."Current Budget Start Date") or (JournalVoucher."Document date" > BCSetup."Current Budget End Date") then begin
            Error(Text0004, JournalVoucher."Document date",
            BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
        end;

        JournalVoucher.TestField(Voted, false);
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");

        JvLines.Reset;
        JvLines.SetRange(JvLines."JV No.", JournalVoucher."JV No.");
        JvLines.SetFilter("Account Type", '%1', JvLines."Account Type"::"G/L Account");
        if JvLines.FindSet then begin
            repeat


                BudgetGL := JvLines."Account No.";


                FirstDay := DMY2Date(1, Date2DMY(JournalVoucher."Document date", 2), Date2DMY(JournalVoucher."Document date", 3));
                CurrMonth := Date2DMY(JournalVoucher."Document date", 2);
                if CurrMonth = 12 then begin
                    LastDay := DMY2Date(1, 1, Date2DMY(JournalVoucher."Document date", 3) + 1);
                    LastDay := CalcDate('-1D', LastDay);
                end else begin
                    CurrMonth := CurrMonth + 1;
                    LastDay := DMY2Date(1, CurrMonth, Date2DMY(JournalVoucher."Document date", 3));
                    LastDay := CalcDate('-1D', LastDay);
                end;

                BudgetAmount := 0;
                Budget.Reset;
                Budget.SetRange(Budget."Budget Name", BCSetup."Current Budget Code");
                Budget.SetFilter(Budget.Date, '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Budget.SetRange(Budget."G/L Account No.", BudgetGL);
                if Budget.FindSet then begin
                    Budget.CalcSums(Amount);
                    BudgetAmount := Budget.Amount;
                end;

                //get the committments
                CommitmentAmount := 0;
                Commitments.Reset;
                Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                Commitments.SetFilter(Commitments."Posting Date", '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Commitments.CalcSums(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;


                GLAccount.Reset;
                GLAccount.SetRange("No.", BudgetGL);
                GLAccount.SetFilter("Date Filter", '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");//GLAccount.SETFILTER("Date Filter",'%1..%2',FirstDay,LastDay);
                if GLAccount.FindSet then
                    GLAccount.CalcFields("Net Change");
                ActualsAmount := GLAccount."Net Change";

                //check if there is any budget
                if (BudgetAmount <= 0) then
                    Error(Text0010);

                //check if the actuals plus the amount is greater then the budget amount
                if ((JvLines."Debit Amount" + CommitmentAmount) > BudgetAmount) and (BCSetup."Allow OverExpenditure" = false) then begin
                    Error(Text0011,
                    JvLines."JV No.", JvLines."Account Type", JvLines."Account No.",
                    Format(Abs(BudgetAmount - (CommitmentAmount + JvLines."Debit Amount"))));
                end else begin
                    //MESSAGE('Budget test passed');
                    //check if the actuals plus the amount is greater than the budget amount
                    if ((CommitmentAmount + JournalVoucher."Total Debit") > BudgetAmount) and (BCSetup."Allow OverExpenditure" = false) then begin
                        Error(Text0011, JournalVoucher."JV No.", JournalVoucher."Document date", BudgetGL,
                        Format(Abs(BudgetAmount - (CommitmentAmount + JournalVoucher."Total Debit"))));
                    end else begin

                        //Commit Amounts

                        Commitments.Init;
                        Commitments.Date := JournalVoucher."Document date";
                        Commitments."Posting Date" := Today;
                        Commitments."G/L Account No." := BudgetGL;
                        Commitments."Document Type" := Commitments."Document Type"::"Payment Voucher";
                        Commitments."Document No." := JournalVoucher."JV No.";
                        Commitments.Amount := JvLines."Debit Amount";
                        Commitments."Month Budget" := BudgetAmount;
                        // Commitments."Month Actual":=CommitmentAmount +JournalVoucher."Total Debit";
                        Commitments."Month Actual" := ActualsAmount;
                        Commitments.Committed := true;
                        Commitments."Committed By" := UserId;
                        Commitments."Committed Date" := Today;
                        Commitments."Committed Time" := Time;
                        Commitments.Budget := BCSetup."Current Budget Code";
                        Commitments.Type := Commitments.Type::" ";
                        Commitments."Employee Name" := JournalVoucher."User ID";
                        Commitments.Description := JournalVoucher.Description;
                        Commitments."Budget Balance" := BudgetAmount - (CommitmentAmount + JournalVoucher."Total Debit");
                        Commitments.Committed := true;
                        if GLAccount.Get(Commitments."G/L Account No.") then
                            Commitments."Gl Name" := GLAccount.Name;

                        if Commitments.Insert(true) then begin
                            //JournalVoucher.MODIFY;
                        end;

                    end;
                end;
            until JvLines.Next = 0;

            JournalVoucher.Voted := true;
            //JournalVoucher.MODIFY;


        end;

    end;

    procedure ReverseJournalVoucherBudget(JournalVoucher: Record "Journal Voucher Header")
    var
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
        CommitmentsCopy: Record "Budget Committment";
        JvLines: Record "Journal Voucher Lines";
    begin
        /*BCSetup.GET;
        //check if the dates are within the specified range
        IF (JournalVoucher."Document date"< BCSetup."Current Budget Start Date") OR (JournalVoucher."Document date"> BCSetup."Current Budget End Date") THEN BEGIN
          ERROR(Text0004,JournalVoucher."Document date",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        END;
        
        JournalVoucher.TESTFIELD(Voted,TRUE);
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        
        
        
            BudgetGL:=JournalVoucher."Budget GL";
        
        
            FirstDay:=DMY2DATE(1,DATE2DMY(JournalVoucher."Document date",2),DATE2DMY(JournalVoucher."Document date",3));
            CurrMonth:=DATE2DMY(JournalVoucher."Document date",2);
            IF CurrMonth=12 THEN BEGIN
              LastDay:=DMY2DATE(1,1,DATE2DMY(JournalVoucher."Document date",3) +1);
              LastDay:=CALCDATE('-1D',LastDay);
            END ELSE BEGIN
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2DATE(1,CurrMonth,DATE2DMY(JournalVoucher."Document date",3));
              LastDay:=CALCDATE('-1D',LastDay);
            END;
        
            BudgetAmount:=0;
            Budget.RESET;
            Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SETFILTER(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Budget.SETRANGE(Budget."G/L Account No.",BudgetGL);
            IF Budget.FINDSET THEN BEGIN
             Budget.CALCSUMS(Amount);
             BudgetAmount:=Budget.Amount;
            END;
        
            //get the committments
        
            CommitmentAmount:=0;
            Commitments.RESET;
            Commitments.SETRANGE(Commitments.Budget,BCSetup."Current Budget Code");
            Commitments.SETRANGE(Commitments."G/L Account No.",BudgetGL);
            Commitments.SETFILTER(Commitments."Posting Date",'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        
              Commitments.CALCSUMS(Commitments.Amount);
            CommitmentAmount:= Commitments.Amount;
        
            //check if there is any budget
            IF (BudgetAmount<=0) THEN
             ERROR(Text0010);
        
              //check if the actuals plus the amount is greater than the budget amount
            IF ((CommitmentAmount + JournalVoucher."Total Debit") > BudgetAmount) AND (BCSetup."Allow OverExpenditure"=FALSE) THEN BEGIN
              ERROR(Text0011,
              JournalVoucher."JV No.",JournalVoucher."Posting Date" ,JournalVoucher."Budget GL",
              FORMAT(ABS(BudgetAmount-(CommitmentAmount +JournalVoucher."Total Debit"))));
            END ELSE BEGIN
        
            //Commit Amounts
        
            Commitments.INIT;
            Commitments.Date:=JournalVoucher."Document date";
            Commitments."Posting Date":=TODAY;
            Commitments."Document Type":=Commitments."Document Type"::"Journal Voucher";
            Commitments."Document No.":=JournalVoucher."JV No.";
            Commitments.Amount:=-JournalVoucher."Total Debit";
            Commitments."Month Budget":=BudgetAmount;
            Commitments.Committed:=TRUE;
            Commitments."Committed By":=USERID;
            Commitments."Committed Date":=TODAY;
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=TIME;
            Commitments.Cancelled:=TRUE;
            Commitments."Cancelled By":=USERID;
            Commitments."Cancelled Date":=TODAY;
            Commitments."Cancelled Time":=TIME;
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Type:=Commitments.Type::" ";
            Commitments."Employee Name":=JournalVoucher."User ID";
            Commitments.Description:=JournalVoucher.Description;
            Commitments."Budget Balance":=BudgetAmount-(CommitmentAmount +JournalVoucher."Total Debit");
            Commitments.Committed:=TRUE;
            IF GLAccount.GET(Commitments."G/L Account No.") THEN
              Commitments."G/L Name":=GLAccount.Name;
           IF  Commitments.INSERT(TRUE) THEN BEGIN
          // EmployeeRequisition."Committed Budget":=TRUE;
           //JournalVoucher."Budget Balance" := BudgetAmount-(CommitmentAmount +JournalVoucher."Total Debit");
           //JournalVoucher."Amount Committed" := JournalVoucher."Total Debit";
           //JournalVoucher."Total Commitment Before" := CommitmentAmount;
           JournalVoucher.MODIFY;
           END;
        
        JournalVoucher.Voted:=FALSE;
        JournalVoucher.MODIFY;
        
        END;*/
        BCSetup.Get;
        //check if the dates are within the specified range
        /*IF (JournalVoucher."Document date"< BCSetup."Current Budget Start Date") OR (JournalVoucher."Document date"> BCSetup."Current Budget End Date") THEN BEGIN
          ERROR(Text0004,JournalVoucher."Document date",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        END;
        */
        //JournalVoucher.TESTFIELD(Voted,TRUE);
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");

        JvLines.Reset;
        JvLines.SetRange(JvLines."JV No.", JournalVoucher."JV No.");
        JvLines.SetFilter("Account Type", '%1', JvLines."Account Type"::"G/L Account");
        if JvLines.FindSet then begin
            repeat


                BudgetGL := JvLines."Account No.";


                FirstDay := DMY2Date(1, Date2DMY(JournalVoucher."Document date", 2), Date2DMY(JournalVoucher."Document date", 3));
                CurrMonth := Date2DMY(JournalVoucher."Document date", 2);
                if CurrMonth = 12 then begin
                    LastDay := DMY2Date(1, 1, Date2DMY(JournalVoucher."Document date", 3) + 1);
                    LastDay := CalcDate('-1D', LastDay);
                end else begin
                    CurrMonth := CurrMonth + 1;
                    LastDay := DMY2Date(1, CurrMonth, Date2DMY(JournalVoucher."Document date", 3));
                    LastDay := CalcDate('-1D', LastDay);
                end;

                BudgetAmount := 0;
                Budget.Reset;
                Budget.SetRange(Budget."Budget Name", BCSetup."Current Budget Code");
                Budget.SetFilter(Budget.Date, '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Budget.SetRange(Budget."G/L Account No.", BudgetGL);
                if Budget.FindSet then begin
                    Budget.CalcSums(Amount);
                    BudgetAmount := Budget.Amount;
                end;

                //get the committments
                CommitmentAmount := 0;
                Commitments.Reset;
                Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                Commitments.SetFilter(Commitments."Posting Date", '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Commitments.CalcSums(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;


                GLAccount.Reset;
                GLAccount.SetRange("No.", BudgetGL);
                GLAccount.SetFilter("Date Filter", '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");//GLAccount.SETFILTER("Date Filter",'%1..%2',FirstDay,LastDay);
                if GLAccount.FindSet then
                    GLAccount.CalcFields("Net Change");
                ActualsAmount := GLAccount."Net Change";

                //check if there is any budget
                if (BudgetAmount <= 0) then
                    Error(Text0010);

                //check if the actuals plus the amount is greater then the budget amount
                if ((JvLines."Debit Amount" + CommitmentAmount) > BudgetAmount) and (BCSetup."Allow OverExpenditure" = false) then begin
                    Error(Text0011,
                    JvLines."JV No.", JvLines."Account Type", JvLines."Account No.",
                    Format(Abs(BudgetAmount - (CommitmentAmount + JvLines."Debit Amount"))));
                end else begin
                    //MESSAGE('Budget test passed');
                    //check if the actuals plus the amount is greater than the budget amount
                    if ((CommitmentAmount + JournalVoucher."Total Debit") > BudgetAmount) and (BCSetup."Allow OverExpenditure" = false) then begin
                        Error(Text0011, JournalVoucher."JV No.", JournalVoucher."Document date", BudgetGL,
                        Format(Abs(BudgetAmount - (CommitmentAmount + JournalVoucher."Total Debit"))));
                    end else begin

                        //Commit Amounts

                        Commitments.Init;
                        Commitments.Date := JournalVoucher."Document date";
                        Commitments."Posting Date" := Today;
                        Commitments."G/L Account No." := BudgetGL;
                        Commitments."Document Type" := Commitments."Document Type"::"Payment Voucher";
                        Commitments."Document No." := JournalVoucher."JV No.";
                        Commitments.Amount := -JvLines."Debit Amount";
                        Commitments."Month Budget" := BudgetAmount;
                        // Commitments."Month Actual":=CommitmentAmount +JournalVoucher."Total Debit";
                        Commitments."Month Actual" := ActualsAmount;
                        Commitments.Committed := true;//SalaryAdvanceRec
                        Commitments."Committed By" := UserId;
                        Commitments."Committed Date" := Today;
                        Commitments."Committed Time" := Time;
                        Commitments.Cancelled := true;
                        Commitments."Cancelled By" := UserId;
                        Commitments."Cancelled Date" := Today;
                        Commitments."Cancelled Time" := Time;
                        Commitments.Budget := BCSetup."Current Budget Code";
                        Commitments.Type := Commitments.Type::" ";
                        Commitments."Employee Name" := JournalVoucher."User ID";
                        Commitments.Description := JournalVoucher.Description;
                        Commitments."Budget Balance" := BudgetAmount - (CommitmentAmount + JournalVoucher."Total Debit");
                        Commitments.Committed := true;

                        if GLAccount.Get(Commitments."G/L Account No.") then
                            Commitments."Gl Name" := GLAccount.Name;

                        if Commitments.Insert(true) then begin
                            //JournalVoucher.MODIFY;
                        end;

                    end;
                end;
            until JvLines.Next = 0;

            JournalVoucher.Voted := false;
            //JournalVoucher.MODIFY;


        end;

    end;

    procedure commitPaymentsGLBudget(var PaymentHeader: Record "Payment Header") Ok: Boolean
    var
        PayemntLIne: Record "Payment Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
        CommitmentsCopy: Record "Budget Committment";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (PaymentHeader."Document Date" < BCSetup."Current Budget Start Date") or (PaymentHeader."Document Date" > BCSetup."Current Budget End Date") then begin
            Error(Text0004, ImprestHeader."Date From",
            BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
        end;


        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        PaymentHeader.TestField(Voted, false);
        /*Imprestheader.RESET;
        Imprestheader.SETRANGE(Type,Imprestheader.Type::Imprest);
        Imprestheader.SETRANGE(Voted,TRUE);
        IF Imprestheader.FINDFIRST THEN BEGIN
          ERROR (Text0005);*/
        //END ELSE
        //IF Imprestheader.Type = Imprestheader.Type::Imprest, AND Imprestheader.Type = Imprestheader.Type::"Petty Cash",AND Imprestheader.Voted,TRUE  THEN
        //ERROR (Text0007);
        /*Imprestheader.RESET;
        Imprestheader.SETRANGE(Type,Imprestheader.Type::"Petty Cash");
        Imprestheader.SETRANGE(Voted,TRUE);
        IF Imprestheader.FINDFIRST THEN BEGIN
          ERROR (Text0005);
          END;*/
        //get the lines related to the Imprest/Petty cash requisition header
        PayemntLIne.Reset;
        PayemntLIne.SetRange(PayemntLIne."Document No.", PaymentHeader."No.");
        PayemntLIne.SetRange(PayemntLIne.Committed, false);
        if PayemntLIne.FindSet then begin
            repeat
                BudgetGL := PayemntLIne."Account No.";
                //G/L Account i
                if PayemntLIne."Account Type" = PayemntLIne."Account Type"::"G/L Account" then begin
                    //BudgetGL:=ImprestLine."Account No.";
                    if GLAccount.Get(PayemntLIne."Account No.") then
                        GLAccount.TestField(GLAccount."Budget Controlled", true);
                end;
                //check the votebook now

                FirstDay := DMY2Date(1, Date2DMY(PaymentHeader."Document Date", 2), Date2DMY(PaymentHeader."Document Date", 3));
                CurrMonth := Date2DMY(PaymentHeader."Document Date", 2);
                if CurrMonth = 12 then begin
                    LastDay := DMY2Date(1, 1, Date2DMY(PaymentHeader."Document Date", 3) + 1);
                    LastDay := CalcDate('-1D', LastDay);
                end else begin
                    CurrMonth := CurrMonth + 1;
                    LastDay := DMY2Date(1, CurrMonth, Date2DMY(PaymentHeader."Document Date", 3));
                    LastDay := CalcDate('-1D', LastDay);
                end;
                //check the summation of the budget
                BudgetAmount := 0;
                Budget.Reset;
                Budget.SetRange(Budget."Budget Name", BCSetup."Current Budget Code");
                Budget.SetFilter(Budget.Date, '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Budget.SetRange(Budget."G/L Account No.", BudgetGL);
                if Budget.FindSet then begin
                    Budget.CalcSums(Amount);
                    BudgetAmount := Budget.Amount;
                end;

                //get the committments

                CommitmentAmount := 0;
                Commitments.Reset;
                Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                Commitments.SetFilter(Commitments."Posting Date", '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Commitments.CalcSums(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;

                //check if there is any budget
                if (BudgetAmount <= 0) then
                    Error(Text0010);

                //check if the actuals plus the amount is greater than the budget amount
                if ((CommitmentAmount + PayemntLIne."Net Amount") > BudgetAmount) and (BCSetup."Allow OverExpenditure" = false) then begin
                    Error(Text0011,
                    PayemntLIne."Document No.", PayemntLIne."Account Type", PayemntLIne."Account No.",
                    Format(Abs(BudgetAmount - (CommitmentAmount + PayemntLIne."Net Amount"))));
                end else begin

                    //Commit Amounts

                    Commitments.Init;
                    Commitments.Date := PaymentHeader."Posting Date";
                    Commitments."Posting Date" := PaymentHeader."Posting Date";
                    //Commitments."Document Type":=Imprestheader."Document Type"::Imprest;;
                    Commitments."Document Type" := Commitments."Document Type"::"Payment Voucher";//jm
                    Commitments."Document No." := PaymentHeader."No.";
                    Commitments.Amount := PayemntLIne."Net Amount";
                    Commitments."Month Budget" := BudgetAmount;
                    Commitments.Committed := true;
                    Commitments."Committed By" := UserId;
                    Commitments."Committed Date" := PaymentHeader."Posting Date";
                    Commitments."G/L Account No." := BudgetGL;
                    Commitments."Committed Time" := Time;
                    Commitments."Shortcut Dimension 1 Code" := PayemntLIne."Global Dimension 1 Code";
                    Commitments."Shortcut Dimension 2 Code" := PayemntLIne."Global Dimension 2 Code";
                    Commitments."Shortcut Dimension 3 Code" := PayemntLIne."Shortcut Dimension 3 Code";
                    Commitments."Shortcut Dimension 4 Code" := PayemntLIne."Shortcut Dimension 4 Code";
                    Commitments.Budget := BCSetup."Current Budget Code";
                    Commitments.Description := PayemntLIne.Description;
                    Commitments.Type := Commitments.Type::" ";
                    Commitments."G/L Account No." := BudgetGL;
                    Commitments."Budget Balance" := BudgetAmount - (CommitmentAmount + PayemntLIne."Net Amount");
                    Commitments.Committed := true;
                    if Commitments.Insert(true) then begin
                        //PayemntLIne."Budget Committed":=TRUE;
                        PayemntLIne.Committed := true;//
                        PayemntLIne.Modify;
                    end;

                end;
            until PayemntLIne.Next = 0;

            PaymentHeader.Voted := true;
            PaymentHeader.Modify;

        end;

    end;

    procedure CommitBudgetPayroll(var GeneraJournal: Record "Gen. Journal Line")
    var
        ImprestLine: Record "Payment Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
        CommitmentsCopy: Record "Budget Committment";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (GeneraJournal."Posting Date" < BCSetup."Current Budget Start Date") or (GeneraJournal."Document Date" > BCSetup."Current Budget End Date") then begin
            Error(Text0004, GeneraJournal."Document Date",
            BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
        end;

        /*GenJournalTemplate.RESET;
        GenJournalTemplate.SETRANGE(Name,GeneraJournalII."Journal Template Name");
        IF GenJournalTemplate.FINDFIRST THEN BEGIN
        
        JournalBatches.RESET;
        JournalBatches.SETRANGE("Journal Template Name",GeneraJournalII."Journal Template Name");
        IF JournalBatches.FINDFIRST THEN BEGIN*/

        /* GeneraJournal.RESET;
         GeneraJournal.SETRANGE("Document No.",*/

        //EmployeeRequisition.TESTFIELD(Voted,FALSE);
        //CheckIfGLAccountBlocked(BCSetup."Current Budget Code");

        BudgetGL := GeneraJournal."Account No.";

        FirstDay := DMY2Date(1, Date2DMY(GeneraJournal."Document Date", 2), Date2DMY(GeneraJournal."Document Date", 3));
        CurrMonth := Date2DMY(GeneraJournal."Document Date", 2);
        if CurrMonth = 12 then begin
            LastDay := DMY2Date(1, 1, Date2DMY(GeneraJournal."Document Date", 3) + 1);
            LastDay := CalcDate('-1D', LastDay);
        end else begin
            CurrMonth := CurrMonth + 1;
            LastDay := DMY2Date(1, CurrMonth, Date2DMY(GeneraJournal."Document Date", 3));
            LastDay := CalcDate('-1D', LastDay);
        end;

        BudgetAmount := 0;
        Budget.Reset;
        Budget.SetRange(Budget."Budget Name", BCSetup."Current Budget Code");
        Budget.SetFilter(Budget.Date, '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
        Budget.SetRange(Budget."G/L Account No.", BudgetGL);
        if Budget.FindSet then begin
            Budget.CalcSums(Amount);
            BudgetAmount := Budget.Amount;
        end;
        //get the committments
        CommitmentAmount := 0;
        Commitments.Reset;
        Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
        Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
        Commitments.SetFilter(Commitments."Posting Date", '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");

        Commitments.CalcSums(Commitments.Amount);
        CommitmentAmount := Commitments.Amount;

        //check if there is any budget
        if (BudgetAmount <= 0) then
            Error(Text0010);

        //check if the actuals plus the amount is greater then the budget amount
        if ((GeneraJournal."Debit Amount") > BudgetAmount) and (BCSetup."Allow OverExpenditure" = false) then begin
            Error(Text0011,
            GeneraJournal."Document No.", GeneraJournal."Account Type", GeneraJournal."Account No.",
            Format(Abs(BudgetAmount - (ActualsAmount + GeneraJournal."Debit Amount"))));
        end else begin
            Message('Budget test passed');
            //check if the actuals plus the amount is greater than the budget amount
            if ((CommitmentAmount + GeneraJournal."Debit Amount") > BudgetAmount) and (BCSetup."Allow OverExpenditure" = false) then begin
                Error(Text0011,
                GeneraJournal."Document No.", GeneraJournal."Document Type", GeneraJournal."Account No.",
                Format(Abs(BudgetAmount - (CommitmentAmount + GeneraJournal."Debit Amount"))));
            end else begin

                //Commit Amounts

                if (GeneraJournal."Account Type" = GeneraJournal."Account Type"::"G/L Account") and (GeneraJournal."Debit Amount" > 0.0) then
                    Commitments.Init;
                Commitments.Date := Today;
                Commitments."Posting Date" := Today;
                //Commitments."Document Type":=Commitments."Document Type"
                Commitments."Document No." := GeneraJournal."Document No.";
                Commitments.Amount := GeneraJournal."Debit Amount";
                Commitments."Month Budget" := BudgetAmount;
                Commitments.Committed := true;
                Commitments."Committed By" := UserId;
                Commitments."Committed Date" := Today;
                Commitments."G/L Account No." := BudgetGL;
                Commitments."Committed Time" := Time;
                Commitments.Budget := BCSetup."Current Budget Code";
                Commitments.Description := GeneraJournal.Description;
                Commitments."Budget Balance" := BudgetAmount - (CommitmentAmount + GeneraJournal."Debit Amount");
                Commitments.Committed := true;
                if Commitments.Insert(true) then begin
                    //GeneraJournal."Budget Balance" := BudgetAmount-(CommitmentAmount +GeneraJournal."Debit Amount");
                    //GeneraJournal."Amount Committed" := GeneraJournal."Debit Amount";
                    //GeneraJournal."Total Commitment Before" := CommitmentAmount;
                    GeneraJournal.Modify;
                end;

                //GeneraJournal.MODIFY;
            end;
        end;
        //END;
        //END;
        //END;

    end;

    procedure ReversePaymentsGLBudget(var PaymentHeader: Record "Payment Header") Ok: Boolean
    var
        PayemntLIne: Record "Payment Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
        CommitmentsCopy: Record "Budget Committment";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (PaymentHeader."Document Date" < BCSetup."Current Budget Start Date") or (PaymentHeader."Document Date" > BCSetup."Current Budget End Date") then begin
            Error(Text0004, ImprestHeader."Date From",
            BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
        end;


        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        PaymentHeader.TestField(Voted, true);
        /*Imprestheader.RESET;
        Imprestheader.SETRANGE(Type,Imprestheader.Type::Imprest);
        Imprestheader.SETRANGE(Voted,TRUE);
        IF Imprestheader.FINDFIRST THEN BEGIN
          ERROR (Text0005);*/
        //END ELSE
        //IF Imprestheader.Type = Imprestheader.Type::Imprest, AND Imprestheader.Type = Imprestheader.Type::"Petty Cash",AND Imprestheader.Voted,TRUE  THEN
        //ERROR (Text0007);
        /*Imprestheader.RESET;
        Imprestheader.SETRANGE(Type,Imprestheader.Type::"Petty Cash");
        Imprestheader.SETRANGE(Voted,TRUE);
        IF Imprestheader.FINDFIRST THEN BEGIN
          ERROR (Text0005);
          END;*/
        //get the lines related to the Imprest/Petty cash requisition header
        PayemntLIne.Reset;
        PayemntLIne.SetRange(PayemntLIne."Document No.", PaymentHeader."No.");
        //PayemntLIne.SETRANGE(PayemntLIne.Committed,FALSE);
        if PayemntLIne.FindSet then begin
            repeat
                BudgetGL := PayemntLIne."Account No.";
                //G/L Account i
                if PayemntLIne."Account Type" = PayemntLIne."Account Type"::"G/L Account" then begin
                    //BudgetGL:=ImprestLine."Account No.";
                    if GLAccount.Get(PayemntLIne."Account No.") then
                        GLAccount.TestField(GLAccount."Budget Controlled", true);
                end;
                //check the votebook now

                FirstDay := DMY2Date(1, Date2DMY(PaymentHeader."Document Date", 2), Date2DMY(PaymentHeader."Document Date", 3));
                CurrMonth := Date2DMY(PaymentHeader."Document Date", 2);
                if CurrMonth = 12 then begin
                    LastDay := DMY2Date(1, 1, Date2DMY(PaymentHeader."Document Date", 3) + 1);
                    LastDay := CalcDate('-1D', LastDay);
                end else begin
                    CurrMonth := CurrMonth + 1;
                    LastDay := DMY2Date(1, CurrMonth, Date2DMY(PaymentHeader."Document Date", 3));
                    LastDay := CalcDate('-1D', LastDay);
                end;
                //check the summation of the budget
                BudgetAmount := 0;
                Budget.Reset;
                Budget.SetRange(Budget."Budget Name", BCSetup."Current Budget Code");
                Budget.SetFilter(Budget.Date, '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Budget.SetRange(Budget."G/L Account No.", BudgetGL);
                if Budget.FindSet then begin
                    Budget.CalcSums(Amount);
                    BudgetAmount := Budget.Amount;
                end;

                //get the committments

                CommitmentAmount := 0;
                Commitments.Reset;
                Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                Commitments.SetFilter(Commitments."Posting Date", '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Commitments.CalcSums(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;

                //check if there is any budget
                if (BudgetAmount <= 0) then
                    Error(Text0010);

                //check if the actuals plus the amount is greater than the budget amount
                if ((CommitmentAmount + PayemntLIne."Net Amount") > BudgetAmount) and (BCSetup."Allow OverExpenditure" = false) then begin
                    Error(Text0011,
                    PayemntLIne."Document No.", PayemntLIne."Account Type", PayemntLIne."Account No.",
                    Format(Abs(BudgetAmount - (CommitmentAmount + PayemntLIne."Net Amount"))));
                end else begin

                    //Commit Amounts

                    Commitments.Init;
                    Commitments.Date := PaymentHeader."Posting Date";
                    Commitments."Posting Date" := Today;
                    //Commitments."Document Type":=Imprestheader."Document Type"::Imprest;;
                    Commitments."Document Type" := Commitments."Document Type"::"Payment Voucher";//jm
                    Commitments."Document No." := PaymentHeader."No.";
                    Commitments.Amount := -PayemntLIne."Net Amount";
                    Commitments."Month Budget" := BudgetAmount;
                    Commitments.Committed := true;
                    Commitments."Committed By" := UserId;
                    Commitments."Committed Date" := PaymentHeader."Posting Date";
                    Commitments."G/L Account No." := BudgetGL;
                    Commitments."Committed Time" := Time;
                    Commitments."Shortcut Dimension 1 Code" := PayemntLIne."Global Dimension 1 Code";
                    Commitments."Shortcut Dimension 2 Code" := PayemntLIne."Global Dimension 2 Code";
                    Commitments."Shortcut Dimension 3 Code" := PayemntLIne."Shortcut Dimension 3 Code";
                    Commitments."Shortcut Dimension 4 Code" := PayemntLIne."Shortcut Dimension 4 Code";
                    Commitments.Budget := BCSetup."Current Budget Code";
                    Commitments.Description := PayemntLIne.Description;
                    Commitments.Type := Commitments.Type::" ";
                    Commitments."G/L Account No." := BudgetGL;
                    Commitments."Budget Balance" := BudgetAmount - (CommitmentAmount + -PayemntLIne."Net Amount");
                    Commitments.Committed := true;
                    Commitments.Cancelled := true;
                    Commitments."Cancelled By" := UserId;
                    Commitments."Cancelled Date" := Today;
                    Commitments."Cancelled Time" := Time;
                    if Commitments.Insert(true) then begin
                        //PayemntLIne."Budget Committed":=TRUE;
                        PayemntLIne.Committed := false;//
                        PayemntLIne.Modify;
                    end;

                end;
            until PayemntLIne.Next = 0;

            PaymentHeader.Voted := false;
            PaymentHeader.Modify;
        end;

    end;
}

