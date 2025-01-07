report 50188 "Employee Loan Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Employee Loan Statement.rdl';

    dataset
    {
        dataitem("Employee Loan Accounts"; "Employee Loan Accounts")
        {
            column(No_EmployeeLoanAccounts; "No.")
            {
            }
            column(EmployeeNo_EmployeeLoanAccounts; "Employee No.")
            {
            }
            column(EmployeeName_EmployeeLoanAccounts; "Employee Name")
            {
            }
            column(LoanProductCode_EmployeeLoanAccounts; "Loan Product Code")
            {
            }
            column(LoanProductDescription_EmployeeLoanAccounts; "Loan Product Description")
            {
            }
            column(RepaymentFrequency_EmployeeLoanAccounts; "Repayment Frequency")
            {
            }
            column(AppliedAmount_EmployeeLoanAccounts; "Applied Amount")
            {
            }
            column(EntitledAmount_EmployeeLoanAccounts; "Entitled Amount")
            {
            }
            column(RepaymentStartDate_EmployeeLoanAccounts; "Repayment Start Date")
            {
            }
            column(RepaymentPeriod_EmployeeLoanAccounts; "Repayment Period")
            {
            }
            column(RepaymentEndDate_EmployeeLoanAccounts; "Repayment End Date")
            {
            }
            column(NoofInstallments_EmployeeLoanAccounts; "No. of Installments")
            {
            }
            column(InterestRate_EmployeeLoanAccounts; "Interest Rate")
            {
            }
            column(RepaymentAmount_EmployeeLoanAccounts; "Repayment Amount")
            {
            }
            column(Pic; CompanyInfo.Picture)
            {
            }
            column(TODAY; Format(Today, 0, 4))
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Investment Account No." = FIELD("No.");
                column(PostingDate_EmployeeLedgerEntry; "Posting Date")
                {
                }
                column(DocumentType_EmployeeLedgerEntry; "Document Type")
                {
                }
                column(DocumentNo_EmployeeLedgerEntry; "Document No.")
                {
                }
                column(Description_EmployeeLedgerEntry; Description)
                {
                }
                column(CurrencyCode_EmployeeLedgerEntry; "Currency Code")
                {
                }
                column(Amount_EmployeeLedgerEntry; Amount)
                {
                }
                column(RemainingAmount_EmployeeLedgerEntry; "Remaining Amount")
                {
                }
                column(AmountLCY_EmployeeLedgerEntry; "Amount (LCY)")
                {
                }
                column(Open_EmployeeLedgerEntry; Open)
                {
                }
                column(LoanTransactionType_EmployeeLedgerEntry; "Investment Transaction Type")
                {
                }
                column(DebitAmount_EmployeeLedgerEntry; DebitAmountText)
                {
                }
                column(CreditAmount_EmployeeLedgerEntry; CreditAmountText)
                {
                }
                column(RunningBalance; RunningBalance)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    "Cust. Ledger Entry".CalcFields("Cust. Ledger Entry"."Debit Amount", "Cust. Ledger Entry".Amount, "Cust. Ledger Entry"."Credit Amount");

                    DebitAmountText := Format("Cust. Ledger Entry"."Debit Amount");
                    if DebitAmountText = Format(0) then DebitAmountText := '';
                    CreditAmountText := Format("Cust. Ledger Entry"."Credit Amount");
                    if CreditAmountText = Format(0) then CreditAmountText := '';

                    RunningBalance := RunningBalance + "Cust. Ledger Entry".Amount;
                end;
            }

            trigger OnPreDataItem()
            begin
                if CompanyInfo.Get then
                    CompanyInfo.CalcFields(Picture);
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
        RunningBalance := 0;
    end;

    var
        CompanyInfo: Record "Company Information";
        DebitAmountText: Text;
        CreditAmountText: Text;
        RunningBalance: Decimal;
}

