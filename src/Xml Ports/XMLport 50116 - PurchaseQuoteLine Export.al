xmlport 50116 "PurchaseQuoteLine Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(purchaselineroot)
        {
            XmlName = 'PurchaseLineRoot';
            tableelement("Purchase Line";"Purchase Line")
            {
                XmlName = 'PurchaseLine';
                fieldelement(LineNo;"Purchase Line"."Line No.")
                {
                }
                fieldelement(PurchaseQuoteType;"Purchase Line".Type)
                {
                }
                fieldelement(DocumentType;"Purchase Line"."Document Type")
                {
                }
                fieldelement(DocumentNo;"Purchase Line"."Document No.")
                {
                }
                fieldelement(No;"Purchase Line"."No.")
                {
                }
                fieldelement(Description;"Purchase Line".Description)
                {
                }
                fieldelement(UnitofMeasure;"Purchase Line"."Unit of Measure")
                {
                }
                fieldelement(Quantity;"Purchase Line".Quantity)
                {
                }
                fieldelement(Amount;"Purchase Line".Amount)
                {
                }
                fieldelement(UnitCost;"Purchase Line"."Direct Unit Cost")
                {
                }
                fieldelement(Remarks;"Purchase Line".Remarks)
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

