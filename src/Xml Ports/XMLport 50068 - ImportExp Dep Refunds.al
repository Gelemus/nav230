xmlport 50068 "ImportExp Dep Refunds"
{
    // FieldDelimiter = '<None>';
    // FieldSeparator = '<TAB>';
    Format = Xml;
    UseDefaultNamespace = true;



    schema
    {
        textelement(DeprefundRoot)
        {
            tableelement("Payment Header";"Payment Header")
            {
                XmlName = 'PaymentHeader';
                fieldelement(VNo;"Payment Header"."No.")
                {
                }
                fieldelement(VDocumentType;"Payment Header"."Document Type")
                {
                }
                fieldelement(VDocumentDate;"Payment Header"."Document Date")
                {
                }
                fieldelement(VPostingDate;"Payment Header"."Posting Date")
                {
                }
                fieldelement(VPaymentMode;"Payment Header"."Payment Mode")
                {
                }
                fieldelement(VPaymentType;"Payment Header"."Payment Type")
                {
                }
                fieldelement(VBankAccountNo;"Payment Header"."Bank Account No.")
                {
                }
                fieldelement(VBankAccountName;"Payment Header"."Bank Account Name")
                {
                }
                fieldelement(VBankAccountBalance;"Payment Header"."Bank Account Balance")
                {
                }
                fieldelement(VChequeType;"Payment Header"."Cheque Type")
                {
                }
                fieldelement(VReferenceNo;"Payment Header"."Reference No.")
                {
                }
                fieldelement(VPayeeType;"Payment Header"."Payee Type")
                {
                }
                fieldelement(VPayeeNo;"Payment Header"."Payee No.")
                {
                }
                fieldelement(VPayeeName;"Payment Header"."Payee Name")
                {
                }
                fieldelement(VOnBehalfOf;"Payment Header"."On Behalf Of")
                {
                }
                fieldelement(VCurrencyCode;"Payment Header"."Currency Code")
                {
                }
                fieldelement(VCurrencyFactor;"Payment Header"."Currency Factor")
                {
                }
                fieldelement(VTotalAmount;"Payment Header"."Total Amount")
                {
                }
                fieldelement(VTotalAmountLCY;"Payment Header"."Total Amount(LCY)")
                {
                }
                fieldelement(VVATAmount;"Payment Header"."VAT Amount")
                {
                }
                fieldelement(VVATAmountLCY;"Payment Header"."VAT Amount(LCY)")
                {
                }
                fieldelement(VWithHoldingTaxAmount;"Payment Header"."WithHolding Tax Amount")
                {
                }
                fieldelement(VWithHoldingTaxAmountLCY;"Payment Header"."WithHolding Tax Amount(LCY)")
                {
                }
                fieldelement(VWithholdingVATAmount;"Payment Header"."Withholding VAT Amount")
                {
                }
                fieldelement(VWithholdingVATAmountLCY;"Payment Header"."Withholding VAT Amount(LCY)")
                {
                }
                fieldelement(VNetAmount;"Payment Header"."Net Amount")
                {
                }
                fieldelement(VNetAmountLCY;"Payment Header"."Net Amount(LCY)")
                {
                }
                fieldelement(VDescription;"Payment Header".Description)
                {
                }
                fieldelement(VGlobalDimension1Code;"Payment Header"."Global Dimension 1 Code")
                {
                }
                fieldelement(VGlobalDimension2Code;"Payment Header"."Global Dimension 2 Code")
                {
                }
                fieldelement(VShortcutDimension3Code;"Payment Header"."Shortcut Dimension 3 Code")
                {
                }
                fieldelement(VShortcutDimension4Code;"Payment Header"."Shortcut Dimension 4 Code")
                {
                }
                fieldelement(VShortcutDimension5Code;"Payment Header"."Shortcut Dimension 5 Code")
                {
                }
                fieldelement(VShortcutDimension6Code;"Payment Header"."Shortcut Dimension 6 Code")
                {
                }
                fieldelement(VShortcutDimension7Code;"Payment Header"."Shortcut Dimension 7 Code")
                {
                }
                fieldelement(VShortcutDimension8Code;"Payment Header"."Shortcut Dimension 8 Code")
                {
                }
                fieldelement(VResponsibilityCenter;"Payment Header"."Responsibility Center")
                {
                }
                fieldelement(VStatus;"Payment Header".Status)
                {
                }
                fieldelement(VPosted;"Payment Header".Posted)
                {
                }
                fieldelement(VPostedBy;"Payment Header"."Posted By")
                {
                }
                fieldelement(VDatePosted;"Payment Header"."Date Posted")
                {
                }
                fieldelement(VTimePosted;"Payment Header"."Time Posted")
                {
                }
                fieldelement(VReversed;"Payment Header".Reversed)
                {
                }
                fieldelement(VReversedBy;"Payment Header"."Reversed By")
                {
                }
                fieldelement(VReversalDate;"Payment Header"."Reversal Date")
                {
                }
                fieldelement(VReversalTime;"Payment Header"."Reversal Time")
                {
                }
                fieldelement(VReversalPostingDate;"Payment Header"."Reversal Posting Date")
                {
                }
                fieldelement(VChequeNo;"Payment Header"."Cheque No.")
                {
                }
                fieldelement(VUserID;"Payment Header"."User ID")
                {
                }
                fieldelement(VNoSeries;"Payment Header"."No. Series")
                {
                }
                fieldelement(VNoPrinted;"Payment Header"."No. Printed")
                {
                }
                fieldelement(VIncomingDocumentEntryNo;"Payment Header"."Incoming Document Entry No.")
                {
                }
                fieldelement(VPayeeBankAccountName;"Payment Header"."Payee Bank Account Name")
                {
                }
                fieldelement(VPayeeBankAccountNo;"Payment Header"."Payee Bank Account No.")
                {
                }
                fieldelement(VMPESAPaybillAccountNo;"Payment Header"."MPESA/Paybill Account No.")
                {
                }
                fieldelement(VPayeeBankCode;"Payment Header"."Payee Bank Code")
                {
                }
                fieldelement(VPayeeBankName;"Payment Header"."Payee Bank Name")
                {
                }
                fieldelement(VLoanDisbursementType;"Payment Header"."Loan Disbursement Type")
                {
                }
                fieldelement(VPayrollPayment;"Payment Header"."Payroll Payment")
                {
                }
                fieldelement(VLoanDisbursementNo;"Payment Header"."Loan Disbursement No.")
                {
                }
                fieldelement(VLoanNo;"Payment Header"."Loan No.")
                {
                }
                fieldelement(VLoanDisbursement;"Payment Header"."Loan Disbursement")
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
}

