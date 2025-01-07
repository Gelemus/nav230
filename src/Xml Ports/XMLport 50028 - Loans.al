xmlport 50028 Loans
{
    DefaultNamespace = 'urn:microsoft-dynamics-schemas/codeunit/FundManagementWS';
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(LoanRoot)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement("Salary Advance";"Salary Advance")
            {
                MinOccurs = Zero;
                XmlName = 'Loan';
                fieldelement(LoanID;"Salary Advance".ID)
                {
                }
                fieldelement(Employee;"Salary Advance".Employee)
                {
                }
                fieldelement(LoanTypes;"Salary Advance"."Loan Types")
                {
                }
                fieldelement(InterestRate;"Salary Advance"."Interest Rate")
                {
                }
                fieldelement(PrincipalAmount;"Salary Advance".Principal)
                {
                }
                textelement(RemainingAmount)
                {
                }
                fieldelement(NoofInstallments;"Salary Advance".Installments)
                {
                }
                fieldelement(StartPeriod;"Salary Advance"."Start Period")
                {
                }
                fieldelement(InstallmentAmount;"Salary Advance"."Installment Amount")
                {
                }
                fieldelement(Paid;"Salary Advance"."Paid to Employee")
                {
                }
                fieldelement(Status;"Salary Advance".Status)
                {
                }
                fieldelement(Purpose;"Salary Advance"."Purpose of Salary Advance")
                {
                }
                fieldelement(fileName;"Salary Advance"."File Name")
                {
                }
                fieldelement(BasicPay;"Salary Advance"."Basic Pay")
                {
                }
                fieldelement(AthirdBasicPay;"Salary Advance"."1/3 Basic Pay")
                {
                }
                fieldelement(NetPay;"Salary Advance"."Net Pay")
                {
                }
                fieldelement(NetPayAfterAdvance;"Salary Advance"."Net Pay after Advance")
                {
                }
                fieldelement(GrossAmount;"Salary Advance"."Gross Amount")
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

