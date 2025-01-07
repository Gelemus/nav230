xmlport 50031 GetGlAccounts
{
    DefaultNamespace = 'urn:microsoft-dynamics-schemas/codeunit/FundManagementWS';
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(GlRoot)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement("G/L Account";"G/L Account")
            {
                MinOccurs = Zero;
                XmlName = 'GlAccounts';
                SourceTableView = WHERE("Account Type"=CONST(Posting));
                fieldelement(AccountCode;"G/L Account"."No.")
                {
                }
                fieldelement(AccountName;"G/L Account".Name)
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

