xmlport 50119 "TenderBankInfo Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(TenderBankInfoRoot)
        {
            tableelement("Tender Bank Info";"Tender Bank Info")
            {
                XmlName = 'TenderBankInfo';
                fieldelement(LineNo;"Tender Bank Info"."Line No")
                {
                }
                fieldelement(DocumentNo;"Tender Bank Info"."Document No")
                {
                }
                fieldelement(Bank;"Tender Bank Info".Bank)
                {
                }
                fieldelement(SupplierProfileNo;"Tender Bank Info"."Supplier Profile ID")
                {
                }
                fieldelement(BankTelephoneNo;"Tender Bank Info"."Bank Telephone No")
                {
                }
                fieldelement(BankEmail;"Tender Bank Info"."Bank Email")
                {
                }
                fieldelement(BankMobileNo;"Tender Bank Info"."Bank Mobile No")
                {
                }
                fieldelement(TenderNo;"Tender Bank Info".TenderNo)
                {
                }
                fieldelement(BankAddress;"Tender Bank Info"."Bank Address")
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

