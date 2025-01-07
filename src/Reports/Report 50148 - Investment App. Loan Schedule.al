report 50148 "Investment App. Loan Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Investment App. Loan Schedule.rdl';

    dataset
    {
        dataitem("Investment Applications"; "Payment Terms")
        {
            column(No; "Investment Applications".Code)
            {
            }
            column(DocumentDate; "Investment Applications".Code)
            {
            }
            column(CustNo; "Investment Applications".Code)
            {
            }
            column(CustName; "Investment Applications".Code)
            {
            }
            column(Branch; "Investment Applications".Code)
            {
            }
            column(Department; "Investment Applications".Code)
            {
            }
            column(LoanProductCode; "Investment Applications".Code)
            {
            }
            column(LoanProductDescription; "Investment Applications".Code)
            {
            }
            column(RepaymentFrequency; "Investment Applications".Code)
            {
            }
            column(LoanAmount; "Investment Applications".Code)
            {
            }
            column(RepaymentStartDate; "Investment Applications".Code)
            {
            }
            column(RepaymentPeriod; "Investment Applications".Code)
            {
            }
            column(RepaymentEndDate; "Investment Applications".Code)
            {
            }
            column(NoOfInstallments; "Investment Applications".Code)
            {
            }
            column(InterestRate; "Investment Applications".Code)
            {
            }
            column(Description; "Investment Applications".Code)
            {
            }
            column(GlobalDimension1Code; "Investment Applications".Code)
            {
            }
            column(GlobalDimension2Code; "Investment Applications".Code)
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyAddress; CompanyInformation.Address)
            {
            }
            column(CompanyAddress2; CompanyInformation."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInformation."Post Code")
            {
            }
            column(CompanyCity; CompanyInformation.City)
            {
            }
            column(CompanyCountry; CompanyInformation."Country/Region Code")
            {
            }
            column(CompanyPhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CompanyFaxNo; CompanyInformation."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInformation."E-Mail")
            {
            }
            column(CompanyHomePage; CompanyInformation."Home Page")
            {
            }
            column(CompanyLogo; CompanyInformation.Picture)
            {
            }
            dataitem("Application Amortization Sch."; "Agenda Supporting Documents")
            {
                DataItemLink = Code = FIELD(Code);
                column(LoanDisbursementNo; "Application Amortization Sch."."Meeting code")
                {
                }
                column(RepaymentDate; "Application Amortization Sch."."Agenda No")
                {
                }
                column(InstalmentNo; "Investment Applications".Code)
                {
                }
                column(PrincipalRepayment; "Investment Applications".Code)
                {
                }
                column(PrincipalMoratoriumPeriod; "Investment Applications".Code)
                {
                }
                column(InterestRepayment; "Investment Applications".Code)
                {
                }
                column(InterestMoratoriumPeriod; "Investment Applications".Code)
                {
                }
                column(TotalRepayment; "Investment Applications".Code)
                {
                }
                column(LoanBalance; "Investment Applications".Code)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                /*LoanAmount:=0;
                IF "Investment Applications"."Approved Amount" <> 0 THEN
                 LoanAmount:="Investment Applications"."Approved Amount" ELSE
                 LoanAmount:="Investment Applications"."Applied Amount";*/

            end;
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

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        CompanyInformation.CalcFields(CompanyInformation.Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        LoanAmount: Decimal;
}

