report 57020 "Petty Cash Surrender Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Petty Cash Surrender Summary.rdl';

    dataset
    {
        dataitem("Imprest Surrender Line"; "Imprest Surrender Line")
        {
            DataItemTableView = WHERE(Posted = CONST(true), "Document Type" = CONST("Petty Cash Surrender"), "Document Type" = CONST("Imprest Surrender"));
            RequestFilterFields = "Posting Date";
            column(LineNo_ImprestSurrenderLine; "Imprest Surrender Line"."Line No.")
            {
            }
            column(DocumentNo_ImprestSurrenderLine; "Imprest Surrender Line"."Document No.")
            {
            }
            column(DocumentType_ImprestSurrenderLine; "Imprest Surrender Line"."Document Type")
            {
            }
            column(ImprestCode_ImprestSurrenderLine; "Imprest Surrender Line"."Imprest Code")
            {
            }
            column(ImprestCodeDescription_ImprestSurrenderLine; "Imprest Surrender Line"."Imprest Code Description")
            {
            }
            column(AccountType_ImprestSurrenderLine; "Imprest Surrender Line"."Account Type")
            {
            }
            column(AccountNo_ImprestSurrenderLine; "Imprest Surrender Line"."Account No.")
            {
            }
            column(AccountName_ImprestSurrenderLine; "Imprest Surrender Line"."Account Name")
            {
            }
            column(PostingGroup_ImprestSurrenderLine; "Imprest Surrender Line"."Posting Group")
            {
            }
            column(Description_ImprestSurrenderLine; "Imprest Surrender Line".Description)
            {
            }
            column(PostingDate_ImprestSurrenderLine; "Imprest Surrender Line"."Posting Date")
            {
            }
            column(CurrencyCode_ImprestSurrenderLine; "Imprest Surrender Line"."Currency Code")
            {
            }
            column(CurrencyFactor_ImprestSurrenderLine; "Imprest Surrender Line"."Currency Factor")
            {
            }
            column(GrossAmount_ImprestSurrenderLine; "Imprest Surrender Line"."Gross Amount")
            {
            }
            column(GrossAmountLCY_ImprestSurrenderLine; "Imprest Surrender Line"."Gross Amount(LCY)")
            {
            }
            column(ActualSpent_ImprestSurrenderLine; "Imprest Surrender Line"."Actual Spent")
            {
            }
            column(ActualSpentLCY_ImprestSurrenderLine; "Imprest Surrender Line"."Actual Spent(LCY)")
            {
            }
            column(Difference_ImprestSurrenderLine; "Imprest Surrender Line".Difference)
            {
            }
            column(DifferenceLCY_ImprestSurrenderLine; "Imprest Surrender Line"."Difference(LCY)")
            {
            }
            column(ReceiptNo_ImprestSurrenderLine; "Imprest Surrender Line"."Receipt No.")
            {
            }
            column(CashReceipt_ImprestSurrenderLine; "Imprest Surrender Line"."Cash Receipt")
            {
            }
            column(CashReceiptLCY_ImprestSurrenderLine; "Imprest Surrender Line"."Cash Receipt(LCY)")
            {
            }
            column(PaidAmount_ImprestSurrenderLine; "Imprest Surrender Line"."Paid Amount")
            {
            }
            column(TaxAmount_ImprestSurrenderLine; "Imprest Surrender Line"."Tax Amount")
            {
            }
            column(Committed_ImprestSurrenderLine; "Imprest Surrender Line".Committed)
            {
            }
            column(BudgetCode_ImprestSurrenderLine; "Imprest Surrender Line"."Budget Code")
            {
            }
            column(GlobalDimension1Code_ImprestSurrenderLine; "Imprest Surrender Line"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_ImprestSurrenderLine; "Imprest Surrender Line"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_ImprestSurrenderLine; "Imprest Surrender Line"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_ImprestSurrenderLine; "Imprest Surrender Line"."Shortcut Dimension 4 Code")
            {
            }
            column(ShortcutDimension5Code_ImprestSurrenderLine; "Imprest Surrender Line"."Shortcut Dimension 5 Code")
            {
            }
            column(ShortcutDimension6Code_ImprestSurrenderLine; "Imprest Surrender Line"."Shortcut Dimension 6 Code")
            {
            }
            column(ShortcutDimension7Code_ImprestSurrenderLine; "Imprest Surrender Line"."Shortcut Dimension 7 Code")
            {
            }
            column(ShortcutDimension8Code_ImprestSurrenderLine; "Imprest Surrender Line"."Shortcut Dimension 8 Code")
            {
            }
            column(ResponsibilityCenter_ImprestSurrenderLine; "Imprest Surrender Line"."Responsibility Center")
            {
            }
            column(Status_ImprestSurrenderLine; "Imprest Surrender Line".Status)
            {
            }
            column(Posted_ImprestSurrenderLine; "Imprest Surrender Line".Posted)
            {
            }
            column(PostedBy_ImprestSurrenderLine; "Imprest Surrender Line"."Posted By")
            {
            }
            column(DatePosted_ImprestSurrenderLine; "Imprest Surrender Line"."Date Posted")
            {
            }
            column(TimePosted_ImprestSurrenderLine; "Imprest Surrender Line"."Time Posted")
            {
            }
            column(Reversed_ImprestSurrenderLine; "Imprest Surrender Line".Reversed)
            {
            }
            column(ReversedBy_ImprestSurrenderLine; "Imprest Surrender Line"."Reversed By")
            {
            }
            column(ReversalDate_ImprestSurrenderLine; "Imprest Surrender Line"."Reversal Date")
            {
            }
            column(ReversalTime_ImprestSurrenderLine; "Imprest Surrender Line"."Reversal Time")
            {
            }
            column(FADepreciationBook_ImprestSurrenderLine; "Imprest Surrender Line"."FA Depreciation Book")
            {
            }
            column(EmployeeNo_ImprestSurrenderLine; "Imprest Surrender Line"."Employee No.")
            {
            }
            column(EmployeeName_ImprestSurrenderLine; "Imprest Surrender Line"."Employee Name")
            {
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

