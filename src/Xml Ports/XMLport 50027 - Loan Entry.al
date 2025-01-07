xmlport 50027 "Loan Entry"
{
    DefaultNamespace = 'urn:microsoft-dynamics-schemas/codeunit/FundManagementWS';
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(LoanEntryRoot)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement("Loan Entry";"Loan Entry")
            {
                MinOccurs = Zero;
                XmlName = 'LoanEntry';
                fieldelement(No;"Loan Entry"."No.")
                {
                }
                fieldelement(LoanID;"Loan Entry"."Loan ID")
                {
                }
                fieldelement(Employee;"Loan Entry".Employee)
                {
                }
                fieldelement(Period;"Loan Entry".Period)
                {
                }
                fieldelement(Interest;"Loan Entry".Interest)
                {
                }
                fieldelement(Repayment;"Loan Entry".Repayment)
                {
                }
                fieldelement(RemainingAmount;"Loan Entry"."Remaining Debt")
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

