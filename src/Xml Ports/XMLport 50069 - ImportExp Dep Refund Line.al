xmlport 50069 "Import/Exp Dep Refund Line"
{
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Payment Line";"Payment Line")
            {
                XmlName = 'PaymentHeader';
                fieldelement(VLineNo;"Payment Line"."Line No.")
                {
                }
                fieldelement(VDocumentNo;"Payment Line"."Document No.")
                {
                }
                fieldelement(VDocumentType;"Payment Line"."Document Type")
                {
                }
                fieldelement(VPaymentCode;"Payment Line"."Payment Code")
                {
                }
                fieldelement(VPaymentCodeDescription;"Payment Line"."Payment Code Description")
                {
                }
                fieldelement(VAccountType;"Payment Line"."Account Type")
                {
                }
                fieldelement(VAccountNo;"Payment Line"."Account No.")
                {
                }
                fieldelement(VAccountName;"Payment Line"."Account Name")
                {
                }
                fieldelement(VPostingGroup;"Payment Line"."Posting Group")
                {
                }
                fieldelement(VDescription;"Payment Line".Description)
                {
                }
                fieldelement(VReferenceNo;"Payment Line"."Reference No.")
                {
                }
                fieldelement(VPostingDate;"Payment Line"."Posting Date")
                {
                }
                fieldelement(VCurrencyCode;"Payment Line"."Currency Code")
                {
                }
                fieldelement(VCurrencyFactor;"Payment Line"."Currency Factor")
                {
                }
                fieldelement(VTotalAmount;"Payment Line"."Total Amount")
                {
                }
                fieldelement(VTotalAmountLCY;"Payment Line"."Total Amount(LCY)")
                {
                }
                fieldelement(VVATCode;"Payment Line"."VAT Code")
                {
                }
                fieldelement(VVATAmount;"Payment Line"."VAT Amount")
                {
                }
                fieldelement(VVATAmountLCY;"Payment Line"."VAT Amount(LCY)")
                {
                }
                fieldelement(VWithholdingTaxCode;"Payment Line"."Withholding Tax Code")
                {
                }
                fieldelement(VWithholdingTaxAmount;"Payment Line"."Withholding Tax Amount")
                {
                }
                fieldelement(VWithholdingTaxAmountLCY;"Payment Line"."Withholding Tax Amount(LCY)")
                {
                }
                fieldelement(VWithholdingVATCode;"Payment Line"."Withholding VAT Code")
                {
                }
                fieldelement(VWithholdingVATAmount;"Payment Line"."Withholding VAT Amount")
                {
                }
                fieldelement(VWithholdingVATAmountLCY;"Payment Line"."Withholding VAT Amount(LCY)")
                {
                }
                fieldelement(VNetAmount;"Payment Line"."Net Amount")
                {
                }
                fieldelement(VNetAmountLCY;"Payment Line"."Net Amount(LCY)")
                {
                }
                fieldelement(VAppliestoDocType;"Payment Line"."Applies-to Doc. Type")
                {
                }
                fieldelement(VAppliestoDocNo;"Payment Line"."Applies-to Doc. No.")
                {
                }
                fieldelement(VAppliestoID;"Payment Line"."Applies-to ID")
                {
                }
                fieldelement(VCommitted;"Payment Line".Committed)
                {
                }
                fieldelement(VBudgetCode;"Payment Line"."Budget Code")
                {
                }
                fieldelement(VPayeeType;"Payment Line"."Payee Type")
                {
                }
                fieldelement(VPayeeNo;"Payment Line"."Payee No.")
                {
                }
                fieldelement(VGlobalDimension1Code;"Payment Line"."Global Dimension 1 Code")
                {
                }
                fieldelement(VGlobalDimension2Code;"Payment Line"."Global Dimension 2 Code")
                {
                }
                fieldelement(VShortcutDimension3Code;"Payment Line"."Shortcut Dimension 3 Code")
                {
                }
                fieldelement(VShortcutDimension4Code;"Payment Line"."Shortcut Dimension 4 Code")
                {
                }
                fieldelement(VShortcutDimension5Code;"Payment Line"."Shortcut Dimension 5 Code")
                {
                }
                fieldelement(VShortcutDimension6Code;"Payment Line"."Shortcut Dimension 6 Code")
                {
                }
                fieldelement(VShortcutDimension7Code;"Payment Line"."Shortcut Dimension 7 Code")
                {
                }
                fieldelement(VShortcutDimension8Code;"Payment Line"."Shortcut Dimension 8 Code")
                {
                }
                fieldelement(VResponsibilityCenter;"Payment Line"."Responsibility Center")
                {
                }
                fieldelement(VPayeeBankCode;"Payment Line"."Payee Bank Code")
                {
                }
                fieldelement(VPayeeBankName;"Payment Line"."Payee Bank Name")
                {
                }
                fieldelement(VPayeeBankBranchCode;"Payment Line"."Payee Bank Branch Code")
                {
                }
                fieldelement(VPayeeBankBranchName;"Payment Line"."Payee Bank Branch Name")
                {
                }
                fieldelement(VPayeeBankAccountNo;"Payment Line"."Payee Bank Account No.")
                {
                }
                fieldelement(VMobilePaymentAccountNo;"Payment Line"."Mobile Payment Account No.")
                {
                }
                fieldelement(VPaymentType;"Payment Line"."Payment Type")
                {
                }
                fieldelement(VStatus;"Payment Line".Status)
                {
                }
                fieldelement(VPosted;"Payment Line".Posted)
                {
                }
                fieldelement(VPostedBy;"Payment Line"."Posted By")
                {
                }
                fieldelement(VDatePosted;"Payment Line"."Date Posted")
                {
                }
                fieldelement(VTimePosted;"Payment Line"."Time Posted")
                {
                }
                fieldelement(VReversed;"Payment Line".Reversed)
                {
                }
                fieldelement(VReversedBy;"Payment Line"."Reversed By")
                {
                }
                fieldelement(VReversalDate;"Payment Line"."Reversal Date")
                {
                }
                fieldelement(VReversalTime;"Payment Line"."Reversal Time")
                {
                }
                fieldelement(VRetentionAmount;"Payment Line"."Retention Amount")
                {
                }
                fieldelement(VJobNo;"Payment Line"."Job No.")
                {
                }
                fieldelement(VEmployeeTransactionType;"Payment Line"."Employee Transaction Type")
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

