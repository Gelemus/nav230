xmlport 50138 "AllowanceLines Xml"
{
    Caption = 'Tender Evaluation Criteria Export';
    UseDefaultNamespace = true;

    schema
    {
        textelement(AllowanceLineRoot)
        {
            tableelement("Allowance Line";"Allowance Line")
            {
                XmlName = 'AllowanceLine';
                fieldelement(LineNo;"Allowance Line"."Line No.")
                {
                }
                fieldelement(DocumentNo;"Allowance Line"."Document No.")
                {
                }
                fieldelement(DocumentType;"Allowance Line"."Document Type")
                {
                }
                fieldelement(AllowanceCode;"Allowance Line"."Allowance Code")
                {
                }
                fieldelement(AllowanceDescription;"Allowance Line"."Allowance Code Description")
                {
                }
                fieldelement(Description;"Allowance Line".Description)
                {
                }
                fieldelement(GrossAmount;"Allowance Line"."Gross Amount")
                {
                }
                fieldelement(TaxAmount;"Allowance Line"."Tax Amount")
                {
                }
                fieldelement(NetAmount;"Allowance Line"."Net Amount")
                {
                }
                fieldelement(UnitAmount;"Allowance Line"."Unit Amount")
                {
                }
                fieldelement(Quantity;"Allowance Line".Quantity)
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

