report 51123 "Petty Cash Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Petty Cash Report.rdl';

    dataset
    {
        dataitem("Payment Header"; "Payment Header")
        {
            DataItemTableView = WHERE("Bank Account No." = CONST('BANK0003'), Status = CONST(Posted));
            RequestFilterFields = "Posting Date";
            column(No_PaymentHeader; "Payment Header"."No.")
            {
            }
            column(DocumentType_PaymentHeader; "Payment Header"."Document Type")
            {
            }
            column(DocumentDate_PaymentHeader; "Payment Header"."Document Date")
            {
            }
            column(PostingDate_PaymentHeader; "Payment Header"."Posting Date")
            {
            }
            column(PaymentMode_PaymentHeader; "Payment Header"."Payment Mode")
            {
            }
            column(PaymentType_PaymentHeader; "Payment Header"."Payment Type")
            {
            }
            column(BankAccountNo_PaymentHeader; "Payment Header"."Bank Account No.")
            {
            }
            column(BankAccountName_PaymentHeader; "Payment Header"."Bank Account Name")
            {
            }
            column(BankAccountBalance_PaymentHeader; "Payment Header"."Bank Account Balance")
            {
            }
            column(ChequeType_PaymentHeader; "Payment Header"."Cheque Type")
            {
            }
            column(ReferenceNo_PaymentHeader; "Payment Header"."Reference No.")
            {
            }
            column(PayeeType_PaymentHeader; "Payment Header"."Payee Type")
            {
            }
            column(PayeeNo_PaymentHeader; "Payment Header"."Payee No.")
            {
            }
            column(PayeeName_PaymentHeader; "Payment Header"."Payee Name")
            {
            }
            column(OnBehalfOf_PaymentHeader; "Payment Header"."On Behalf Of")
            {
            }
            column(CurrencyCode_PaymentHeader; "Payment Header"."Currency Code")
            {
            }
            column(CurrencyFactor_PaymentHeader; "Payment Header"."Currency Factor")
            {
            }
            column(TotalAmount_PaymentHeader; "Payment Header"."Total Amount")
            {
            }
            column(TotalAmountLCY_PaymentHeader; "Payment Header"."Total Amount(LCY)")
            {
            }
            column(VATAmount_PaymentHeader; "Payment Header"."VAT Amount")
            {
            }
            column(VATAmountLCY_PaymentHeader; "Payment Header"."VAT Amount(LCY)")
            {
            }
            column(WithHoldingTaxAmount_PaymentHeader; "Payment Header"."WithHolding Tax Amount")
            {
            }
            column(WithHoldingTaxAmountLCY_PaymentHeader; "Payment Header"."WithHolding Tax Amount(LCY)")
            {
            }
            column(WithholdingVATAmount_PaymentHeader; "Payment Header"."Withholding VAT Amount")
            {
            }
            column(WithholdingVATAmountLCY_PaymentHeader; "Payment Header"."Withholding VAT Amount(LCY)")
            {
            }
            column(NetAmount_PaymentHeader; "Payment Header"."Net Amount")
            {
            }
            column(NetAmountLCY_PaymentHeader; "Payment Header"."Net Amount(LCY)")
            {
            }
            column(Description_PaymentHeader; "Payment Header".Description)
            {
            }
            column(GlobalDimension1Code_PaymentHeader; "Payment Header"."Global Dimension 1 Code")
            {
                IncludeCaption = true;
            }
            column(GlobalDimension2Code_PaymentHeader; "Payment Header"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_PaymentHeader; "Payment Header"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_PaymentHeader; "Payment Header"."Shortcut Dimension 4 Code")
            {
            }
            column(ShortcutDimension5Code_PaymentHeader; "Payment Header"."Shortcut Dimension 5 Code")
            {
            }
            column(ShortcutDimension6Code_PaymentHeader; "Payment Header"."Shortcut Dimension 6 Code")
            {
            }
            column(ShortcutDimension7Code_PaymentHeader; "Payment Header"."Shortcut Dimension 7 Code")
            {
            }
            column(ShortcutDimension8Code_PaymentHeader; "Payment Header"."Shortcut Dimension 8 Code")
            {
            }
            column(ResponsibilityCenter_PaymentHeader; "Payment Header"."Responsibility Center")
            {
            }
            column(Status_PaymentHeader; "Payment Header".Status)
            {
            }
            column(Posted_PaymentHeader; "Payment Header".Posted)
            {
            }
            column(PostedBy_PaymentHeader; "Payment Header"."Posted By")
            {
            }
            column(DatePosted_PaymentHeader; "Payment Header"."Date Posted")
            {
            }
            column(TimePosted_PaymentHeader; "Payment Header"."Time Posted")
            {
            }
            column(Reversed_PaymentHeader; "Payment Header".Reversed)
            {
            }
            column(ReversedBy_PaymentHeader; "Payment Header"."Reversed By")
            {
            }
            column(ReversalDate_PaymentHeader; "Payment Header"."Reversal Date")
            {
            }
            column(ReversalTime_PaymentHeader; "Payment Header"."Reversal Time")
            {
            }
            column(ReversalPostingDate_PaymentHeader; "Payment Header"."Reversal Posting Date")
            {
            }
            column(ChequeNo_PaymentHeader; "Payment Header"."Cheque No.")
            {
            }
            column(UserID_PaymentHeader; "Payment Header"."User ID")
            {
            }
            column(NoSeries_PaymentHeader; "Payment Header"."No. Series")
            {
            }
            column(NoPrinted_PaymentHeader; "Payment Header"."No. Printed")
            {
            }
            column(IncomingDocumentEntryNo_PaymentHeader; "Payment Header"."Incoming Document Entry No.")
            {
            }
            column(PayeeBankAccountName_PaymentHeader; "Payment Header"."Payee Bank Account Name")
            {
            }
            column(PayeeBankAccountNo_PaymentHeader; "Payment Header"."Payee Bank Account No.")
            {
            }
            column(MPESAPaybillAccountNo_PaymentHeader; "Payment Header"."MPESA/Paybill Account No.")
            {
            }
            column(PayeeBankCode_PaymentHeader; "Payment Header"."Payee Bank Code")
            {
            }
            column(PayeeBankName_PaymentHeader; "Payment Header"."Payee Bank Name")
            {
            }
            column(LoanDisbursementType_PaymentHeader; "Payment Header"."Loan Disbursement Type")
            {
            }
            column(PVCNo_PaymentHeader; "Payment Header"."PVC No.")
            {
            }
            dataitem("Payment Line"; "Payment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Line No.", "Document No.") ORDER(Ascending) WHERE(Status = CONST(Posted));
                column(LineNo_PaymentLine; "Payment Line"."Line No.")
                {
                }
                column(DocumentNo_PaymentLine; "Payment Line"."Document No.")
                {
                }
                column(DocumentType_PaymentLine; "Payment Line"."Document Type")
                {
                }
                column(PaymentCode_PaymentLine; "Payment Line"."Payment Code")
                {
                }
                column(PaymentCodeDescription_PaymentLine; "Payment Line"."Payment Code Description")
                {
                }
                column(AccountType_PaymentLine; "Payment Line"."Account Type")
                {
                }
                column(AccountNo_PaymentLine; "Payment Line"."Account No.")
                {
                }
                column(AccountName_PaymentLine; "Payment Line"."Account Name")
                {
                }
                column(PostingGroup_PaymentLine; "Payment Line"."Posting Group")
                {
                }
                column(Description_PaymentLine; "Payment Line".Description)
                {
                }
                column(ReferenceNo_PaymentLine; "Payment Line"."Reference No.")
                {
                }
                column(PostingDate_PaymentLine; "Payment Line"."Posting Date")
                {
                }
                column(CurrencyCode_PaymentLine; "Payment Line"."Currency Code")
                {
                }
                column(CurrencyFactor_PaymentLine; "Payment Line"."Currency Factor")
                {
                }
                column(TotalAmount_PaymentLine; "Payment Line"."Total Amount")
                {
                }
                column(TotalAmountLCY_PaymentLine; "Payment Line"."Total Amount(LCY)")
                {
                }
                column(VATCode_PaymentLine; "Payment Line"."VAT Code")
                {
                }
                column(VATAmount_PaymentLine; "Payment Line"."VAT Amount")
                {
                }
                column(VATAmountLCY_PaymentLine; "Payment Line"."VAT Amount(LCY)")
                {
                }
                column(WithholdingTaxCode_PaymentLine; "Payment Line"."Withholding Tax Code")
                {
                }
                column(WithholdingTaxAmount_PaymentLine; "Payment Line"."Withholding Tax Amount")
                {
                }
                column(WithholdingTaxAmountLCY_PaymentLine; "Payment Line"."Withholding Tax Amount(LCY)")
                {
                }
                column(WithholdingVATCode_PaymentLine; "Payment Line"."Withholding VAT Code")
                {
                }
                column(WithholdingVATAmount_PaymentLine; "Payment Line"."Withholding VAT Amount")
                {
                }
                column(WithholdingVATAmountLCY_PaymentLine; "Payment Line"."Withholding VAT Amount(LCY)")
                {
                }
                column(NetAmount_PaymentLine; "Payment Line"."Net Amount")
                {
                }
                column(NetAmountLCY_PaymentLine; "Payment Line"."Net Amount(LCY)")
                {
                }
                column(AppliestoDocType_PaymentLine; "Payment Line"."Applies-to Doc. Type")
                {
                }
                column(AppliestoDocNo_PaymentLine; "Payment Line"."Applies-to Doc. No.")
                {
                }
                column(AppliestoID_PaymentLine; "Payment Line"."Applies-to ID")
                {
                }
                column(Committed_PaymentLine; "Payment Line".Committed)
                {
                }
                column(BudgetCode_PaymentLine; "Payment Line"."Budget Code")
                {
                }
                column(PayeeType_PaymentLine; "Payment Line"."Payee Type")
                {
                }
                column(PayeeNo_PaymentLine; "Payment Line"."Payee No.")
                {
                }
                column(GlobalDimension1Code_PaymentLine; "Payment Line"."Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_PaymentLine; "Payment Line"."Global Dimension 2 Code")
                {
                }
                column(ShortcutDimension3Code_PaymentLine; "Payment Line"."Shortcut Dimension 3 Code")
                {
                }
                column(ShortcutDimension4Code_PaymentLine; "Payment Line"."Shortcut Dimension 4 Code")
                {
                }
                column(ShortcutDimension5Code_PaymentLine; "Payment Line"."Shortcut Dimension 5 Code")
                {
                }
                column(ShortcutDimension6Code_PaymentLine; "Payment Line"."Shortcut Dimension 6 Code")
                {
                }
                column(ShortcutDimension7Code_PaymentLine; "Payment Line"."Shortcut Dimension 7 Code")
                {
                }
                column(ShortcutDimension8Code_PaymentLine; "Payment Line"."Shortcut Dimension 8 Code")
                {
                }
                column(ResponsibilityCenter_PaymentLine; "Payment Line"."Responsibility Center")
                {
                }
                column(PayeeBankCode_PaymentLine; "Payment Line"."Payee Bank Code")
                {
                }
                column(PayeeBankName_PaymentLine; "Payment Line"."Payee Bank Name")
                {
                }
                column(PayeeBankBranchCode_PaymentLine; "Payment Line"."Payee Bank Branch Code")
                {
                }
                column(PayeeBankBranchName_PaymentLine; "Payment Line"."Payee Bank Branch Name")
                {
                }
                column(PayeeBankAccountNo_PaymentLine; "Payment Line"."Payee Bank Account No.")
                {
                }
                column(MobilePaymentAccountNo_PaymentLine; "Payment Line"."Mobile Payment Account No.")
                {
                }
                column(PaymentType_PaymentLine; "Payment Line"."Payment Type")
                {
                }
                column(Status_PaymentLine; "Payment Line".Status)
                {
                }
                column(Posted_PaymentLine; "Payment Line".Posted)
                {
                }
                column(PostedBy_PaymentLine; "Payment Line"."Posted By")
                {
                }
                column(DatePosted_PaymentLine; "Payment Line"."Date Posted")
                {
                }
                column(TimePosted_PaymentLine; "Payment Line"."Time Posted")
                {
                }
                column(Reversed_PaymentLine; "Payment Line".Reversed)
                {
                }
                column(ReversedBy_PaymentLine; "Payment Line"."Reversed By")
                {
                }
                column(ReversalDate_PaymentLine; "Payment Line"."Reversal Date")
                {
                }
                column(ReversalTime_PaymentLine; "Payment Line"."Reversal Time")
                {
                }
                column(JobNo_PaymentLine; "Payment Line"."Job No.")
                {
                }
                column(EmployeeTransactionType_PaymentLine; "Payment Line"."Employee Transaction Type")
                {
                }
                column(RetentionAmount_PaymentLine; "Payment Line"."Retention Amount")
                {
                }
            }
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
}

