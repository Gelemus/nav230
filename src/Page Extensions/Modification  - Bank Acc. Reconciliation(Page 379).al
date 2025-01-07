pageextension 60253 pageextension60253 extends "Bank Acc. Reconciliation"
{
    PromotedActionCategories = 'New,Process,Report,Bank,Matching';

    layout
    {
        modify(BalanceLastStatement)
        {
            Editable = false;
        }

        addafter(BankAccountNo)
        {
            field("Bank Account name"; Rec."Bank Account Name")
            {
                Caption = 'Bank Account name';
                Editable = false;
            }
        }
    }
    actions
    {
        addafter(ImportBankStatement)
        {
            action("Import Mpesa Statement")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import Bank Statement';
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Import electronic bank statements from your bank to populate with data about actual bank transactions.';

                trigger OnAction()
                begin
                    CurrPage.Update;
                    Clear(ImportBankStatementxml);
                    ImportBankStatementxml.SetstatementDetails(Rec."Statement No.", Rec."Bank Account No.");
                    ImportBankStatementxml.Run;

                    //ImportBankStatement;
                end;
            }
            action("AutoMatch Mpesa Transactions")
            {
                Caption = 'AutoMatch Bank Transactions';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Automatch(Rec);
                    Message('Automatch Complete');
                end;
            }

        }
        addafter("&Test Report")
        {
            action("Reconciliation Report")
            {
                Caption = 'Reconciliation Report';
                Image = ReceivableBill;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ReconciliationReport.getbankRec(Rec, Rec."Statement Ending Balance");
                    ReconciliationReport.Run;
                end;
            }
            action("Reconciliation Summary")
            {
                Caption = 'Reconciliation Summary';
                Image = Ranges;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin
                    ReconcileReportSummary.getbankRec(Rec, Rec."Statement Ending Balance");
                    ReconcileReportSummary.Run;
                end;
            }
            action("Bank Statement Summary")
            {
                Caption = 'Bank Statement Summary';
                Image = Purchasing;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin
                    BankStatementSummary.getbankRec(Rec, Rec."Statement Ending Balance");
                    BankStatementSummary.Run;

                end;
            }
            action(Action21)
            {
            }
        }
        addafter(PostAndPrint)
        {
            action("Transfer New Cashbook Items")
            {
                Image = TransferReceipt;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
                    BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
                    LineNo: Integer;
                    BankAccReconciliationLine2: Record "Bank Acc. Reconciliation Line";
                begin
                    BankAccReconciliationLine.Reset;
                    BankAccReconciliationLine.SetRange("Statement No.", Rec."Statement No.");
                    BankAccReconciliationLine.SetRange("Bank Account No.", Rec."Bank Account No.");
                    if BankAccReconciliationLine.FindLast then
                        LineNo := BankAccReconciliationLine."Statement Line No."
                    else
                        LineNo := 0;
                    BankAccountLedgerEntry.Reset;
                    BankAccountLedgerEntry.SetRange("Bank Account No.", Rec."Bank Account No.");
                    BankAccountLedgerEntry.SetRange(Open, true);
                    BankAccountLedgerEntry.SetFilter("Posting Date", '..%1', Rec."Statement Date");
                    BankAccountLedgerEntry.SetRange("Statement Status", BankAccountLedgerEntry."Statement Status"::Open);
                    if BankAccountLedgerEntry.FindFirst then
                        repeat
                            BankAccReconciliationLine.Reset;
                            BankAccReconciliationLine.SetRange("Statement No.", Rec."Statement No.");
                            BankAccReconciliationLine.SetRange("Document No.", BankAccountLedgerEntry."External Document No.");
                            BankAccReconciliationLine.SetRange("Bank Account No.", BankAccountLedgerEntry."Bank Account No.");
                            BankAccReconciliationLine.SetRange("Transaction Date", BankAccountLedgerEntry."Posting Date");
                            BankAccReconciliationLine.SetRange("Statement Amount", BankAccountLedgerEntry.Amount);
                            BankAccReconciliationLine.SetRange(Description, BankAccountLedgerEntry.Description);
                            if BankAccReconciliationLine.FindFirst then
                                LineNo := LineNo
                            else begin
                                LineNo := LineNo + 1;
                                BankAccReconciliationLine2.Init;
                                BankAccReconciliationLine2."Bank Account No." := Rec."Bank Account No.";
                                BankAccReconciliationLine2."Statement Type" := BankAccReconciliationLine2."Statement Type"::"Bank Reconciliation";
                                BankAccReconciliationLine2."Statement Line No." := LineNo;
                                BankAccReconciliationLine2."Statement No." := Rec."Statement No.";
                                BankAccReconciliationLine2."Document No." := BankAccountLedgerEntry."External Document No.";
                                BankAccReconciliationLine2."Transaction Date" := BankAccountLedgerEntry."Posting Date";
                                BankAccReconciliationLine2.Description := BankAccountLedgerEntry.Description;
                                //added on 11/11/2020

                                PaymentHeader.Reset;
                                PaymentHeader.SetRange("No.", BankAccountLedgerEntry."Document No.");
                                if PaymentHeader.FindSet then begin
                                    if BankAccountLedgerEntry."External Document No." <> ' ' then begin
                                        BankAccReconciliationLine2."Payee Details" := PaymentHeader."Payee Name";
                                    end else
                                        if BankAccountLedgerEntry."External Document No." = ' ' then begin
                                            BankAccReconciliationLine2."Payee Details" := ' ';
                                        end;
                                end;
                                //
                                BankAccReconciliationLine2."Statement Amount" := BankAccountLedgerEntry.Amount;
                                BankAccReconciliationLine2.Insert(true);

                            end

                        until BankAccountLedgerEntry.Next = 0;

                    Message('Transfer complete');
                end;
            }

            action("Clear Unreconciled Items")
            {
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
                begin
                    BankAccReconciliationLine.Reset;
                    BankAccReconciliationLine.SetRange("Statement No.", Rec."Statement No.");
                    BankAccReconciliationLine.SetRange("Bank Account No.", Rec."Bank Account No.");
                    BankAccReconciliationLine.SetRange(Applied, false);
                    BankAccReconciliationLine.SetRange("Applied Amount", 0);
                    if BankAccReconciliationLine.FindFirst then
                        repeat
                            BankAccReconciliationLine.Delete;
                        until BankAccReconciliationLine.Next = 0;
                    Message('Clearing complete');
                end;
            }
        }
    }
    var
        ReconciliationReport: Report "Bank Reconciliation Report";
        ReconcileReportSummary: Report "Bank Reconciliation Summary";
        BankStatementSummary: Report "Bank Statement Summary";
        PaymentHeader: Record "Payment Header";
        ImportBankStatementxml: XMLport "Import Bank Statement";

    local procedure Automatch(BankAccReconciliation: Record "Bank Acc. Reconciliation")
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        BankAccEntrySetReconNo: Codeunit "Bank Acc. Entry Set Recon.-No.";
        Relation: Option "One-to-One","One-to-Many";
        window: Dialog;
    begin
        window.Open('Automatching Line #1#########');
        BankAccReconciliationLine.Reset;
        BankAccReconciliationLine.SetRange("Statement Type", BankAccReconciliation."Statement Type");
        BankAccReconciliationLine.SetRange("Statement No.", BankAccReconciliation."Statement No.");
        BankAccReconciliationLine.SetRange("Bank Account No.", BankAccReconciliation."Bank Account No.");
        BankAccReconciliationLine.SetRange("Applied Entries", 0);
        if BankAccReconciliationLine.FindFirst then
            repeat
                window.Update(1, BankAccReconciliationLine."Statement Line No.");
                BankAccountLedgerEntry.Reset;
                BankAccountLedgerEntry.SetRange("Bank Account No.", BankAccReconciliationLine."Bank Account No.");
                BankAccountLedgerEntry.SetFilter("Posting Date", '..%1', BankAccReconciliation."Statement Date");
                BankAccountLedgerEntry.SetRange(Amount, BankAccReconciliationLine."Statement Amount");
                BankAccountLedgerEntry.SetFilter("External Document No.", '%1', '*' + BankAccReconciliationLine."Document No." + '*');
                //BankAccountLedgerEntry.SETRANGE("External Document No.",BankAccReconciliationLine."Document No.");
                BankAccountLedgerEntry.SetRange("Statement Status", BankAccountLedgerEntry."Statement Status"::Open);
                if BankAccountLedgerEntry.FindFirst then
                    repeat

                        BankAccEntrySetReconNo.RemoveApplication(BankAccountLedgerEntry);
                        BankAccEntrySetReconNo.ApplyEntries(BankAccReconciliationLine, BankAccountLedgerEntry, Relation::"One-to-Many");

                    until BankAccountLedgerEntry.Next = 0;

            until BankAccReconciliationLine.Next = 0;
        window.Close;

        /*
          IF SelectedBankAccountLedgerEntry.FINDSET THEN BEGIN
            REPEAT
              BankAccountLedgerEntry.GET(SelectedBankAccountLedgerEntry."Entry No.");
              BankAccEntrySetReconNo.RemoveApplication(BankAccountLedgerEntry);
              BankAccEntrySetReconNo.ApplyEntries(BankAccReconciliationLine,BankAccountLedgerEntry,Relation::"One-to-Many");
            UNTIL SelectedBankAccountLedgerEntry.NEXT = 0;
          END;
        END;*/

    end;
}
