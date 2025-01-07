report 50016 "Posed Bank Acc Reconciliation"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Posed Bank Acc Reconciliation.rdl';

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            column(BankAccNo; "Bank Account No.")
            {
            }
            column(StmtNo; "Statement No.")
            {
            }
            column(StmtBal; "Statement Ending Balance")
            {
            }
            column(BankName; BankAccName)
            {
            }
            column(StmtDate; "Statement Date")
            {
            }
            column(CashBookBal; CashBookBal)
            {
            }
            column(RecMsg; RecMsg)
            {
            }
            column(TotalUncreditedChqs; TotalUncreditedChqs)
            {
            }
            column(TotalUnpresentedChqs; TotalUnpresentedChqs)
            {
            }
            column(Pic; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            dataitem(BankRec; "Bank Acc. Reconciliation Line2")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                column(DocNo; BankRec."Document No.")
                {
                }
                column(Amount; BankRec.Difference)
                {
                }
                column(Description; BankRec.Description)
                {
                }
                column(ChequeNo; BankRec."Check No.")
                {
                }
                column(PostingDate; BankRec."Transaction Date")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                BankAccount.Reset;
                BankAccount.SetRange(BankAccount."No.", "Bank Account No.");
                if BankAccount.FindSet then begin
                    BankAccName := BankAccount.Name;
                end;

                BankAccount.Reset;
                BankAccount.SetRange(BankAccount."No.", "Bank Account No.");
                if BankAccount.FindFirst then begin
                end;

                CashBookBal := 0;
                BankEntries.Reset;
                BankEntries.SetRange(BankEntries."Bank Account No.", "Bank Account No.");
                BankEntries.SetRange(BankEntries."Posting Date", 0D, "Bank Account Statement"."Statement Date");
                if BankEntries.FindSet then begin
                    repeat
                        CashBookBal := CashBookBal + BankEntries.Amount;
                    until BankEntries.Next = 0;
                end;

                TotalUncreditedChqs := 0;
                TotalUnpresentedChqs := 0;
                BankRecLine.Reset;
                BankRecLine.SetRange(BankRecLine."Bank Account No.", "Bank Account No.");
                BankRecLine.SetRange(BankRecLine."Statement Type", BankRecLine."Statement Type"::"Bank Reconciliation");
                BankRecLine.SetRange(BankRecLine."Statement No.", "Statement No.");
                BankRecLine.SetFilter(BankRecLine.Difference, '<>%1', 0);
                if BankRecLine.FindSet then begin
                    repeat
                        if BankRecLine.Difference > 0 then begin
                            //UncreditedChqs
                            TotalUncreditedChqs := TotalUncreditedChqs + BankRecLine.Difference;
                        end else begin
                            //UnpresentedChqs
                            TotalUnpresentedChqs := TotalUnpresentedChqs + BankRecLine.Difference;
                        end;
                    until BankRecLine.Next = 0;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        DefinedBankNo: Code[10];
        DefinedStatementNo: Code[10];
        CashBookBal: Decimal;
        BankStatBalance: Decimal;
        BankAccount: Record "Bank Account";
        BankRecHdr: Record "Bank Acc. Reconciliation";
        BankRecLine: Record "Bank Acc. Reconciliation Line2";
        TotalDifference: Decimal;
        TotalUncreditedChqs: Decimal;
        TotalUnpresentedChqs: Decimal;
        BankAccNo: Code[10];
        BankAccName: Text[50];
        BankRecLineDiff: Record "Bank Acc. Reconciliation Line";
        BankRecCash: Record "Bank Acc. Reconciliation";
        RecMsg: Text[250];
        BancRecReconciled: Record "Bank Acc. Reconciliation Line";
        TotalReconciled: Decimal;
        LastStatBal: Decimal;
        DiffBal: Decimal;
        CompanyInfo: Record "Company Information";
        BankEntries: Record "Bank Account Ledger Entry";
        BankRecLineNew: Record "Bank Acc. Reconciliation Line";
        PeriodStart: Date;
        PeriodEnd: Date;
}

