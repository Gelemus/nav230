report 50149 "Investment  Loan Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Investment  Loan Schedule.rdl';

    dataset
    {
        dataitem("Loan Accounts"; "Meeting Attendance")
        {
            column(No; "Meeting No")
            {
            }
            column(DocumentDate; "Member No")
            {
            }
            column(CustNo; "Meeting Date")
            {
            }
            column(CustName; "Meeting Name")
            {
            }
            column(Branch; "Meeting No")
            {
            }
            column(Department; "Meeting No")
            {
            }
            column(LoanProductCode; "Meeting No")
            {
            }
            column(LoanProductDescription; "Meeting No")
            {
            }
            column(RepaymentFrequency; "Meeting No")
            {
            }
            column(AmountDisbursed; "Meeting No")
            {
            }
            column(LoanAmount; LoanAmount)
            {
            }
            column(RepaymentStartDate; "Meeting No")
            {
            }
            column(RepaymentPeriod; "Meeting No")
            {
            }
            column(RepaymentEndDate; "Meeting No")
            {
            }
            column(NoOfInstallments; "Meeting No")
            {
            }
            column(InterestRate; "Meeting No")
            {
            }
            column(Description; "Meeting No")
            {
            }
            column(GlobalDimension1Code; "Meeting No")
            {
            }
            column(GlobalDimension2Code; "Meeting No")
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
            dataitem("Application Amortization Sch."; "Agenda vote items")
            {
                DataItemLink = "Item No" = FIELD("Meeting No");
                column(LoanDisbursementNo; "Meeting No")
                {
                }
                column(RepaymentDate; "Agenda No")
                {
                }
                column(InstalmentNo; "Vote start Date")
                {
                }
                column(PrincipalRepayment; "Vote start Time")
                {
                }
                column(PrincipalMoratoriumPeriod; "Vote Enda date")
                {
                }
                column(InterestRepayment; "Vote Enda Time")
                {
                }
                column(InterestMoratoriumPeriod; "Meeting No")
                {
                }
                column(TotalRepayment; "Meeting No")
                {
                }
                column(LoanBalance; "Meeting No")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                /*"Loan Accounts".CALCFIELDS("Loan Accounts"."Disbursed Amount");
                
                LoanAmount:=0;
                IF "Loan Accounts"."Approved Amount" <> 0 THEN
                 LoanAmount:="Loan Accounts"."Approved Amount" ELSE
                 LoanAmount:="Loan Accounts"."Applied Amount";
                 */

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

