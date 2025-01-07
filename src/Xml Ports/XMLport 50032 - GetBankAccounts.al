xmlport 50032 GetBankAccounts
{
    DefaultNamespace = 'urn:microsoft-dynamics-schemas/codeunit/FundManagementWS';
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(BankRoot)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement("Bank Account";"Bank Account")
            {
                MinOccurs = Zero;
                XmlName = 'BankAccounts';
                fieldelement(AccountCode;"Bank Account"."No.")
                {
                }
                fieldelement(AccountName;"Bank Account".Name)
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

