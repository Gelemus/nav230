xmlport 50136 "BankledgerEntry Xml"
{
    Caption = 'Tender Evaluation Criteria Export';
    UseDefaultNamespace = true;

    schema
    {
        textelement(BankLedgerEntryRoot)
        {
            tableelement("Bank Account Ledger Entry";"Bank Account Ledger Entry")
            {
                XmlName = 'BankLedgerEntry';
                fieldelement(BankAccountNo;"Bank Account Ledger Entry"."Bank Account No.")
                {
                }
                fieldelement(DocumentNo;"Bank Account Ledger Entry"."Document No.")
                {
                }
                fieldelement(PostingDate;"Bank Account Ledger Entry"."Posting Date")
                {
                    FieldValidate = no;
                }
                fieldelement(Amount;"Bank Account Ledger Entry".Amount)
                {
                }
                fieldelement(Description;"Bank Account Ledger Entry".Description)
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

