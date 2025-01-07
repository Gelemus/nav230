report 50147 "Equity Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Equity Statement.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
            column(No_EmployeeLoanAccounts; "Payment Terms".Code)
            {
            }
            column(EmployeeNo_EmployeeLoanAccounts; "Payment Terms".Code)
            {
            }
            column(EmployeeName_EmployeeLoanAccounts; "Payment Terms".Code)
            {
            }
            column(LoanProductCode_EmployeeLoanAccounts; "Payment Terms".Code)
            {
            }
            column(LoanProductDescription_EmployeeLoanAccounts; "Payment Terms".Code)
            {
            }
            column(RepaymentFrequency_EmployeeLoanAccounts; "Payment Terms".Code)
            {
            }
            column(AppliedAmount_EmployeeLoanAccounts; "Payment Terms".Code)
            {
            }
            column(EntitledAmount_EmployeeLoanAccounts; "Payment Terms".Code)
            {
            }
            column(RepaymentStartDate_EmployeeLoanAccounts; "Payment Terms".Code)
            {
            }
            column(RepaymentPeriod_EmployeeLoanAccounts; "Payment Terms".Code)
            {
            }
            column(RepaymentEndDate_EmployeeLoanAccounts; "Payment Terms".Code)
            {
            }
            column(NoofInstallments_EmployeeLoanAccounts; "Payment Terms".Code)
            {
            }
            column(InterestRate_EmployeeLoanAccounts; "Payment Terms".Code)
            {
            }
            column(RepaymentAmount_EmployeeLoanAccounts; "Payment Terms".Code)
            {
            }
            column(DisbursedAmount; "Payment Terms".Code)
            {
            }
            column(Pic; "Payment Terms".Code)
            {
            }
            column(CompanyInfo_Name; "Payment Terms".Code)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; "Payment Terms".Code)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_Web; CompanyInfo."Home Page")
            {
            }
            column(PrincipalInArrears_LoanAccounts; "Payment Terms".Code)
            {
            }
            column(InterestInArrears_LoanAccounts; "Payment Terms".Code)
            {
            }
            column(LoanFeeInArrears_LoanAccounts; "Payment Terms".Code)
            {
            }
            column(NonDueDateFilter_LoanAccounts; "Payment Terms".Code)
            {
            }
            column(NonDuePrincipal_LoanAccounts; "Payment Terms".Code)
            {
            }
            column(NonDueInterest_LoanAccounts; "Payment Terms".Code)
            {
            }
            column(TODAY; Format(Today, 0, 4))
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Investment Account No." = FIELD(Code);
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
                column(RunningAmount; RunningAmount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    "Cust. Ledger Entry".CalcFields("Cust. Ledger Entry"."Debit Amount");
                    "Cust. Ledger Entry".CalcFields("Cust. Ledger Entry"."Credit Amount");

                    DebitAmountText := Format("Cust. Ledger Entry"."Debit Amount");
                    if DebitAmountText = Format(0) then DebitAmountText := '';
                    CreditAmountText := Format("Cust. Ledger Entry"."Credit Amount");
                    if CreditAmountText = Format('') then CreditAmountText := '';

                    RunningAmount := RunningAmount + "Cust. Ledger Entry".Amount;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*CurrentPayOff:=0;
                AccountBalance:=0;
                
                EquityAccounts.RESET;
                EquityAccounts.SETRANGE("No.",Table50324."No.");
                IF EquityAccounts.FINDFIRST THEN BEGIN
                  IF EquityAccounts."Repayment Frequency"='MONTHLY' THEN BEGIN
                  EquityAccounts.SETFILTER("Arrears Date Filter",'%1..%2',0D,CALCDATE('CM',CALCDATE('-1M',WORKDATE)));
                  EquityAccounts.SETFILTER("NonDue Date Filter",'%1..%2',CALCDATE('-CM',WORKDATE),CALCDATE('CM',WORKDATE));
                  END;
                  EquityAccounts.CALCFIELDS(EquityAccounts."NonDue Principal");
                  EquityAccounts.CALCFIELDS("Account Balance");
                  EquityAccounts.CALCFIELDS(EquityAccounts."NonDue Interest");
                  EquityAccounts.CALCFIELDS(EquityAccounts."Loan Fee In Arrears");
                  EquityAccounts.CALCFIELDS(EquityAccounts."Principal In Arrears");
                  EquityAccounts.CALCFIELDS(EquityAccounts."Interest In Arrears");
                  //EquityAccounts.CALCFIELDS("Interest Accrued Current Month");
                END;
                
                //CurrentPayOff:=EquityAccounts."Account Balance"+EquityAccounts."Interest Accrued Current Month";
                AccountBalance:=CurrentPayOff;
                */

            end;

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
        RunningAmount := 0;
    end;

    var
        CompanyInfo: Record "Company Information";
        DebitAmountText: Text;
        CreditAmountText: Text;
        RunningAmount: Decimal;
        AccountBalance: Decimal;
        CurrentPayOff: Decimal;
}

