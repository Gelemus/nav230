report 50202 "Bank Reconciliation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Bank Reconciliation Report.rdl';

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = WHERE(Number = CONST(1));
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; Company.Name)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(VarBankRec__Statement_Date_; VarBankRec."Statement Date")
            {
            }
            column(BankStatBalance; BankStatBalance)
            {
            }
            column(BankName; BankName)
            {
            }
            column(companypic; Company.Picture)
            {
            }
            column(BankAccNo; BankAccNo)
            {
            }
            column(ReconciliationStatement; ReconciliationStatement)
            {
            }
            column(Bank_Code_Caption; Bank_Code_CaptionLbl)
            {
            }
            column(Bank_Account_No_Caption; Bank_Account_No_CaptionLbl)
            {
            }
            column(Bank_Name_Caption; Bank_Name_CaptionLbl)
            {
            }

            trigger OnPreDataItem()
            begin
                GetBank;
                GetCashBK;
            end;
        }
        dataitem("Bank Acc. Reconciliation Line"; "Bank Acc. Reconciliation Line")
        {
            DataItemTableView = WHERE("Statement Amount" = FILTER(<> 0), Difference = FILTER(<> 0), Reconciled = CONST(false));
            RequestFilterFields = "Bank Account No.";
            column(Bank_Acc__Reconciliation_Line__Bank_Account_No__; "Bank Account No.")
            {
            }
            column(CheckNo_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Check No.")
            {
            }
            column(CashBkBal_BankStatBalance; CashBkBal - BankStatBalance)
            {
            }
            column(TotalUnPresented_TotalDifference; TotalUnPresented + TotalDifference)
            {
            }
            column(UncreditedChqs; UncreditedChqs)
            {
            }
            column(TotalUnpresentedChqs; TotalUnpresentedChqs)
            {
            }
            column(Reconciled_BankAccReconciliationLine; "Bank Acc. Reconciliation Line".Reconciled)
            {
            }
            column(CashBkBal; CashBkBal)
            {
            }
            column(DebitDiff; DebitDiff)
            {
            }
            column(CreditDiff; CreditDiff)
            {
            }
            column(DebitDiff_UncreditedChqs; DebitDiff + UncreditedChqs)
            {
            }
            column(CreditDiff_TotalUnpresentedChqs; CreditDiff + DepositDiff + TotalUnpresentedChqs)
            {
            }
            column(BANK_ACCOUNT_RECONCILIATION_REPORTCaption; BANK_ACCOUNT_RECONCILIATION_REPORTCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Reconciliation_as_at_Caption; Reconciliation_as_at_CaptionLbl)
            {
            }
            column(BANK_BALANCE_AS_PER_BANK_STATEMENTCaption; BANK_BALANCE_AS_PER_BANK_STATEMENTCaptionLbl)
            {
            }
            column(Difference_between_Cash_book_and_Bank_Statement_BalanceCaption; Difference_between_Cash_book_and_Bank_Statement_BalanceCaptionLbl)
            {
            }
            column(Total_Unreconciling_itemsCaption; Total_Unreconciling_itemsCaptionLbl)
            {
            }
            column(RECEIPTS_IN_CASHBOOK_NOT_IN_BANKCaption; RECEIPTS_IN_CASHBOOK_NOT_IN_BANKCaptionLbl)
            {
            }
            column(PAYMENTS_IN_CASHBOOK_NOT_IN_BANK__UNPRESENTED_CHEQUES_Caption; PAYMENTS_IN_CASHBOOK_NOT_IN_BANK__UNPRESENTED_CHEQUES_CaptionLbl)
            {
            }
            column(Add_Caption; Add_CaptionLbl)
            {
            }
            column(BANK_BALANCE_AS_PER_CASH_BOOKCaption; BANK_BALANCE_AS_PER_CASH_BOOKCaptionLbl)
            {
            }
            column(Less_Caption; Less_CaptionLbl)
            {
            }
            column(PAYMENTS_IN_BANK_NOT_IN_CASH_BOOKCaption; PAYMENTS_IN_BANK_NOT_IN_CASH_BOOKCaptionLbl)
            {
            }
            column(TotalCaptions; TotalCaptionLbl)
            {
            }
            column(RECEIPTS_IN_BANK_NOT_IN_CASH_BOOKCaption; RECEIPTS_IN_BANK_NOT_IN_CASH_BOOKCaptionLbl)
            {
            }
            // column(DataItem50;Prepared_by_________________________________________________________________________________Date_____________________________Lbl)
            // {
            // }
            // column(DataItem51;Reviewed__by_______________________________________________________________________________Date______________________________Lbl)
            // {
            // }
            column(ACCOUNTANTCaption; ACCOUNTANTCaptionLbl)
            {
            }
            column(Bank_Acc__Reconciliation_Line_Statement_No_; "Statement No.")
            {
            }
            column(Bank_Acc__Reconciliation_Line_Statement_Line_No_; "Statement Line No.")
            {
            }
            column(Bank_Acc__Reconciliation_Line_Difference; Difference)
            {
            }
            column(DateChequeEFT; Text000)
            {
            }
            column(ChequeEFT; Text001)
            {
            }
            column(DispatchDate; Text002)
            {
            }
            column(Amount; Text003)
            {
            }
            column(DateReceipt; Text004)
            {
            }
            column(ReceiptNumber; Text005)
            {
            }
            column(DateBanked; Text006)
            {
            }
            column(Description; "Bank Acc. Reconciliation Line".Description)
            {
            }
            column(DocumentNo; "Bank Acc. Reconciliation Line"."Document No.")
            {
            }
            column(TransactionDate; "Bank Acc. Reconciliation Line"."Transaction Date")
            {
            }
            column(AppliedAmount; "Bank Acc. Reconciliation Line"."Applied Amount")
            {
            }
            // column(DataItem1000000020;Approved__by_______________________________________________________________________________Date______________________________Lbl)
            // {
            // }
            column(DepositDiff; DepositDiff)
            {
            }
            column(DepositDiffCaption; DepositDiffCaption)
            {
            }
            column(Difference; "Bank Acc. Reconciliation Line".Difference)
            {
            }
            column(TotalcashDBT; TotalcashDBT)
            {
            }
            column(TotalCashCRDT; TotalCashCRDT)
            {
            }

            trigger OnAfterGetRecord()
            begin
                UncreditedChqs := 0;
                TotalUnpresentedChqs := 0;
                if "Bank Acc. Reconciliation Line".Difference <> 0 then begin
                    if "Bank Acc. Reconciliation Line"."Applied Amount" > 0 then begin
                        if "Bank Acc. Reconciliation Line"."Applied Amount" = "Bank Acc. Reconciliation Line"."Statement Amount" then
                            UncreditedChqs := "Bank Acc. Reconciliation Line"."Applied Amount"
                        else if ("Bank Acc. Reconciliation Line"."Applied Amount" <> "Bank Acc. Reconciliation Line"."Statement Amount")
                               //AND ("Bank Acc. Reconciliation Line"."Statement Amount"=0)
                               then
                            UncreditedChqs := "Bank Acc. Reconciliation Line"."Applied Amount" - "Bank Acc. Reconciliation Line"."Statement Amount";
                    end else
                        TotalUnpresentedChqs := "Bank Acc. Reconciliation Line"."Applied Amount";
                end;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Bank Account No.");
                TotalPresentedFunc;
                TotalUnpresentedFunc;
                TotalDiffFunc;
                GetBank;
                GetCashBK;
                CashBal := CashBkBal;



                "Bank Acc. Reconciliation Line".SetRange("Bank Acc. Reconciliation Line"."Bank Account No.", VarBankRec."Bank Account No.");
                "Bank Acc. Reconciliation Line".SetRange("Bank Acc. Reconciliation Line"."Statement No.", VarBankRec."Statement No.");
                if (TotalUnPresented + TotalDifference) = (CashBkBal - BankStatBalance) then
                    Finished := true;
                if TotalUnPresented <> 0 then
                    IsDifferent := true;
            end;
        }
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = SORTING("Document No.", "Posting Date") ORDER(Descending) WHERE("Statement Status" = CONST(Open), Reversed = CONST(false));
            column(BnkAccno; "Bank Account Ledger Entry"."Bank Account No.")
            {
            }
            column(BnkDocumentno; "Bank Account Ledger Entry"."Document No.")
            {
            }
            column(BnkAmount; "Bank Account Ledger Entry".Amount)
            {
            }
            column(BnkCheck; "Bank Account Ledger Entry"."External Document No.")
            {
            }
            column(BnkStatus; "Bank Account Ledger Entry"."Statement Status")
            {
            }
            column(VrecbankDate; VarBankRec."Statement Date")
            {
            }
            column(Bnkpostingdate; "Bank Account Ledger Entry"."Posting Date")
            {
            }
            column(Debit; "Bank Account Ledger Entry"."Debit Amount")
            {
            }
            column(Credit; "Bank Account Ledger Entry"."Credit Amount")
            {
            }
            column(BnkDesc; BnkDesc)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Bank Account Ledger Entry".CalcFields(Payee);
                if "Bank Account Ledger Entry".Payee <> '' then
                    BnkDesc := "Bank Account Ledger Entry".Payee
                else
                    BnkDesc := "Bank Account Ledger Entry".Description;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Bank Account No.");
                "Bank Account Ledger Entry".SetRange("Bank Account Ledger Entry"."Bank Account No.", VarBankRec."Bank Account No.");
                "Bank Account Ledger Entry".SetFilter("Bank Account Ledger Entry"."Posting Date", '<=%1', VarBankRec."Statement Date");
                "Bank Account Ledger Entry".SetRange("Bank Account Ledger Entry".Applied, false);
            end;
        }
        dataitem("Bank Acc. Reconciliation Line1"; "Bank Acc. Reconciliation Line")
        {
            DataItemTableView = WHERE("Statement Amount" = FILTER(<> 0), Difference = FILTER(<> 0), Reconciled = CONST(false));
            column(BankAccountNo_BankAccReconciliationLine1; "Bank Acc. Reconciliation Line1"."Bank Account No.")
            {
            }
            column(StatementNo_BankAccReconciliationLine1; "Bank Acc. Reconciliation Line1"."Statement No.")
            {
            }
            column(DocumentNo_BankAccReconciliationLine1; "Bank Acc. Reconciliation Line1"."Document No.")
            {
            }
            column(TransactionDate_BankAccReconciliationLine1; "Bank Acc. Reconciliation Line1"."Transaction Date")
            {
            }
            column(Description_BankAccReconciliationLine1; "Bank Acc. Reconciliation Line1".Description)
            {
            }
            column(StatementAmount_BankAccReconciliationLine1; "Bank Acc. Reconciliation Line1"."Statement Amount")
            {
            }
            column(Difference_BankAccReconciliationLine1; "Bank Acc. Reconciliation Line1".Difference)
            {
            }
            column(AppliedAmount_BankAccReconciliationLine1; "Bank Acc. Reconciliation Line1"."Applied Amount")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Reconciled = true then
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                GetBank;
                "Bank Acc. Reconciliation Line1".SetRange("Bank Acc. Reconciliation Line1"."Bank Account No.", VarBankRec."Bank Account No.");
                "Bank Acc. Reconciliation Line1".SetRange("Bank Acc. Reconciliation Line1"."Statement No.", VarBankRec."Statement No.");
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
        Company.Get;
        Company.CalcFields(Picture)
        // ReconciliationStatement:='Reconciliation is incomplete please go through it again';
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        VarBankRec: Record "Bank Acc. Reconciliation";
        BankRecPresented: Record "Bank Acc. Reconciliation Line";
        BankRecUnPresented: Record "Bank Acc. Reconciliation Line";
        TotalPresented: Decimal;
        TotalUnPresented: Decimal;
        BankStatBalance: Decimal;
        BankLastBalance: Decimal;
        BankName: Text[100];
        BankAcc: Record "Bank Account";
        CashBkBal: Decimal;
        Difference: Decimal;
        Company: Record "Company Information";
        UncreditedChqs: Decimal;
        BankAccNo: Code[100];
        ReconciliationStatement: Text[250];
        Finished: Boolean;
        PrintWithRecon: Boolean;
        IsDifferent: Boolean;
        TotalUnpresentedChqs: Decimal;
        TotalDifference: Decimal;
        CreditDiff: Decimal;
        DebitDiff: Decimal;
        CashBal: Decimal;
        BANK_ACCOUNT_RECONCILIATION_REPORTCaptionLbl: Label 'BANK ACCOUNT RECONCILIATION REPORT';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Bank_Code_CaptionLbl: Label 'Bank Code:';
        Bank_Name_CaptionLbl: Label 'Bank Name:';
        Reconciliation_as_at_CaptionLbl: Label 'Reconciliation as at:';
        BANK_BALANCE_AS_PER_BANK_STATEMENTCaptionLbl: Label 'BANK BALANCE AS PER BANK STATEMENT';
        Bank_Account_No_CaptionLbl: Label 'Bank Account No:';
        Difference_between_Cash_book_and_Bank_Statement_BalanceCaptionLbl: Label 'Difference between Cash book and Bank Statement Balance';
        Total_Unreconciling_itemsCaptionLbl: Label 'Total Unreconciling items';
        RECEIPTS_IN_CASHBOOK_NOT_IN_BANKCaptionLbl: Label 'UNCREDITED PAYMENTS (RECEIPTS IN CASHBOOK NOT IN BANK)';
        PAYMENTS_IN_CASHBOOK_NOT_IN_BANK__UNPRESENTED_CHEQUES_CaptionLbl: Label 'UNPRESENTED CHEQUES (PAYMENTS IN CASHBOOK NOT IN BANK )';
        Add_CaptionLbl: Label 'Add:';
        BANK_BALANCE_AS_PER_CASH_BOOKCaptionLbl: Label 'CASH BOOK BALANCE';
        Less_CaptionLbl: Label 'Less:';
        PAYMENTS_IN_BANK_NOT_IN_CASH_BOOKCaptionLbl: Label 'PAYMENTS IN BANK NOT IN CASH BOOK';
        TotalCaptionLbl: Label 'Total';
        RECEIPTS_IN_BANK_NOT_IN_CASH_BOOKCaptionLbl: Label 'PAYMENTS IN BANK NOT IN CASH BOOK';
        // Prepared_by_________________________________________________________________________________Date_____________________________Lbl: Label 'Prepared by:........................................                                        Date...............................................';
        // Reviewed__by_______________________________________________________________________________Date______________________________Lbl: Label 'Reviewed by:.......................................                                        Date...............................................';
        ACCOUNTANTCaptionLbl: Label 'ACCOUNTANT';
        Text000: Label 'Date of Cheque/EFT';
        Text001: Label 'Cheque/EFT No';
        Text002: Label 'Dispatch Date';
        Text003: Label 'Amount';
        Text004: Label 'Date of Receipt';
        Text005: Label 'Receipt Number';
        Text006: Label 'Date Banked';
        //  Approved__by_______________________________________________________________________________Date______________________________Lbl: Label 'Approved by:.........................................                                      Date................................................';
        DepositDiff: Decimal;
        DepositDiffCaption: Label 'RECEIPTS IN CASH BOOK  NOT IN BANK';
        BankLedger: Record "Bank Account Ledger Entry";
        Totalcashbal: Decimal;
        TotalcashDBT: Decimal;
        TotalCashCRDT: Decimal;
        BnkDesc: Text;

    procedure getbankRec(var BankRec: Record "Bank Acc. Reconciliation"; var StatementBalance: Decimal)
    begin
        VarBankRec := BankRec;
        BankStatBalance := StatementBalance;
        //BankStatBalance:=BankRec."Statement Ending Balance"-BankRec."Balance Last Statement";
        //ADDED BY ERIC
        BankStatBalance := BankRec."Statement Ending Balance";
        BankLastBalance := BankRec."Balance Last Statement";
    end;

    procedure TotalPresentedFunc()
    begin
        BankRecPresented.SetRange(BankRecPresented."Bank Account No.", VarBankRec."Bank Account No.");
        BankRecPresented.SetRange(BankRecPresented."Statement No.", VarBankRec."Statement No.");
        BankRecPresented.SetRange(BankRecPresented.Reconciled, true);
        if BankRecPresented.Find('-') then begin
            repeat
                TotalPresented := TotalPresented + BankRecPresented."Applied Amount";
            until BankRecPresented.Next = 0;
        end;
    end;

    procedure TotalUnpresentedFunc()
    begin

        BankRecUnPresented.Reset;
        BankRecUnPresented.SetRange(BankRecUnPresented."Bank Account No.", VarBankRec."Bank Account No.");
        BankRecUnPresented.SetRange(BankRecUnPresented."Statement No.", VarBankRec."Statement No.");
        BankRecUnPresented.SetRange(BankRecUnPresented.Reconciled, false);

        if BankRecUnPresented.Find('-') then begin
            repeat
                //MESSAGE('doing it account %1 Statement No=%2',VarBankRec."Bank Account No.",VarBankRec."Statement No.");
                //BankRecUnPresented.CALCFIELDS(BankRecUnPresented."Applied Amount");
                TotalUnPresented := TotalUnPresented + BankRecUnPresented."Applied Amount";
            until BankRecUnPresented.Next = 0;
        end;
    end;

    procedure GetBank()
    begin
        if BankAcc.Get(VarBankRec."Bank Account No.") then begin
            BankAcc.SetRange(BankAcc."Date Filter", 0D, VarBankRec."Statement Date");
            BankAcc.CalcFields(BankAcc."Balance at Date");
            CashBkBal := BankAcc."Balance at Date";
            BankName := BankAcc.Name;
            BankAccNo := BankAcc."Bank Account No.";

        end;
    end;

    procedure TotalDiffFunc()
    begin
        BankRecPresented.Reset;
        BankRecPresented.SetRange(BankRecPresented."Bank Account No.", VarBankRec."Bank Account No.");
        BankRecPresented.SetRange(BankRecPresented."Statement No.", VarBankRec."Statement No.");
        //BankRecPresented.SETRANGE(BankRecPresented.Reconciled,TRUE);
        if BankRecPresented.Find('-') then begin

            DebitDiff := 0;
            CreditDiff := 0;
            DepositDiff := 0;
            repeat
                TotalDifference := TotalDifference + BankRecPresented.Difference;

                if BankRecPresented.Difference > 0 then
                    DebitDiff := DebitDiff + BankRecPresented.Difference;

                //Cater for Less bank Deposits
                if BankRecPresented.Difference < 0 then
                    if BankRecPresented."Applied Amount" > 0 then
                        DepositDiff := DepositDiff + BankRecPresented.Difference
                    else
                        CreditDiff := CreditDiff + BankRecPresented.Difference;


            until BankRecPresented.Next = 0;
        end;
    end;

    procedure GetCashBK()
    begin
        BankLedger.Reset;
        BankLedger.SetRange(BankLedger."Bank Account No.", VarBankRec."Bank Account No.");
        BankLedger.SetRange(BankLedger."Statement Status", BankLedger."Statement Status"::Open);
        BankLedger.SetRange(BankLedger.Reversed, false);
        BankLedger.SetFilter(BankLedger."Posting Date", '<=%1', VarBankRec."Statement Date");
        //BankLedger.SETRANGE();
        if BankLedger.FindFirst then
            repeat

                Totalcashbal := Totalcashbal + BankLedger.Amount;
                TotalcashDBT := TotalcashDBT + BankLedger."Debit Amount";
                TotalCashCRDT := TotalCashCRDT + BankLedger."Credit Amount";
            until BankLedger.Next = 0;
        //MESSAGE(FORMAT(TotalCashCRDT));
    end;
}

