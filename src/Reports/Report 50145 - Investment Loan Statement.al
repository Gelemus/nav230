report 50145 "Investment Loan Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Investment Loan Statement.rdl';

    dataset
    {
        dataitem("Meeting Attendance"; "Meeting Attendance")
        {
            column(No_EmployeeLoanAccounts; "Meeting Attendance"."Meeting No")
            {
            }
            column(EmployeeNo_EmployeeLoanAccounts; "Meeting Attendance"."Meeting Date")
            {
            }
            column(EmployeeName_EmployeeLoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(LoanProductCode_EmployeeLoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(LoanProductDescription_EmployeeLoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(RepaymentFrequency_EmployeeLoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(AppliedAmount_EmployeeLoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(EntitledAmount_EmployeeLoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(RepaymentStartDate_EmployeeLoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(RepaymentPeriod_EmployeeLoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(RepaymentEndDate_EmployeeLoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(NoofInstallments_EmployeeLoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(InterestRate_EmployeeLoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(RepaymentAmount_EmployeeLoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(DisbursedAmount; "Meeting Attendance"."Meeting Name")
            {
            }
            column(AccountBalance; AccountBalance)
            {
            }
            column(CurrentPayOff; CurrentPayOff)
            {
            }
            column(Pic; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
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
            column(PrincipalInArrears_LoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(PenaltyInterestInArrears_LoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(InterestInArrears_LoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(LoanFeeInArrears_LoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(InterestAccrued_LoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(NonDueDateFilter_LoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(NonDuePrincipal_LoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(NonDueInterest_LoanAccounts; "Meeting Attendance"."Meeting Name")
            {
            }
            column(TODAY; Format(Today, 0, 4))
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Investment Account No." = FIELD("Meeting No");
                DataItemTableView = WHERE(Reversed = CONST(false));
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
                    if EndDate <> 0D then
                        "Cust. Ledger Entry".SetRange("Cust. Ledger Entry"."Posting Date", 0D, EndDate);

                    "Cust. Ledger Entry".CalcFields("Cust. Ledger Entry"."Debit Amount");
                    "Cust. Ledger Entry".CalcFields("Cust. Ledger Entry"."Credit Amount");

                    DebitAmountText := Format("Cust. Ledger Entry"."Debit Amount");
                    if DebitAmountText = Format(0) then DebitAmountText := '';
                    CreditAmountText := Format("Cust. Ledger Entry"."Credit Amount");
                    if CreditAmountText = Format('') then CreditAmountText := '';

                    RunningAmount := RunningAmount + "Cust. Ledger Entry".Amount;
                end;

                trigger OnPreDataItem()
                begin
                    if EndDate <> 0D then
                        "Cust. Ledger Entry".SetRange("Cust. Ledger Entry"."Posting Date", 0D, EndDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*CurrentPayOff:=0;
                AccountBalance:=0;
                
                LoanAccounts.RESET;
                LoanAccounts.SETRANGE("Meeting No","Meeting Attendance"."Meeting No");
                IF LoanAccounts.FINDFIRST THEN BEGIN
                  IF LoanAccounts."Repayment Frequency"='MONTHLY' THEN BEGIN
                  LoanAccounts.SETFILTER("Arrears Date Filter",'%1..%2',0D,CALCDATE('CM',CALCDATE('-1M',WORKDATE)));
                  LoanAccounts.SETFILTER("NonDue Date Filter",'%1..%2',CALCDATE('-CM',WORKDATE),CALCDATE('CM',WORKDATE));
                  END;
                  LoanAccounts.CALCFIELDS(LoanAccounts."NonDue Principal");
                  LoanAccounts.CALCFIELDS("Account Balance");
                  LoanAccounts.CALCFIELDS(LoanAccounts."NonDue Interest");
                  LoanAccounts.CALCFIELDS(LoanAccounts."Loan Fee In Arrears");
                  LoanAccounts.CALCFIELDS(LoanAccounts."Principal In Arrears");
                  LoanAccounts.CALCFIELDS(LoanAccounts."Interest In Arrears");
                  LoanAccounts.CALCFIELDS("Interest Accrued Current Month");
                END;
                
                CurrentPayOff:=LoanAccounts."Account Balance"+LoanAccounts."Interest Accrued Current Month";
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
            area(content)
            {
                field(StartDate; StartDate)
                {
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    Caption = 'End Date';
                }
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
        RunningAmount := 0;
    end;

    var
        CompanyInfo: Record "Company Information";
        LoanAccounts: Record "Meeting Attendance";
        DebitAmountText: Text;
        CreditAmountText: Text;
        RunningAmount: Decimal;
        StartDate: Date;
        EndDate: Date;
        CurrentPayOff: Decimal;
        AccountBalance: Decimal;
}

