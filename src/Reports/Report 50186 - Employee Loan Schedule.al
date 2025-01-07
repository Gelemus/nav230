report 50186 "Employee Loan Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Employee Loan Schedule.rdl';

    dataset
    {
        dataitem("Employee Loan Accounts"; "Employee Loan Accounts")
        {
            column(No; "No.")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(EmployeeNo; "Employee No.")
            {
            }
            column(EmployeeName; "Employee Name")
            {
            }
            column(EmployeeBranch; "HR Branch")
            {
            }
            column(EmployeeDepartment; "HR Department")
            {
            }
            column(LoanProductCode; "Loan Product Code")
            {
            }
            column(LoanProductDescription; "Loan Product Description")
            {
            }
            column(RepaymentFrequency; "Repayment Frequency")
            {
            }
            column(ApprovedAmount; "Applied Amount")
            {
            }
            column(RepaymentStartDate; "Repayment Start Date")
            {
            }
            column(RepaymentPeriod; "Repayment Period")
            {
            }
            column(RepaymentEndDate; "Repayment End Date")
            {
            }
            column(NoOfInstallments; "No. of Installments")
            {
            }
            column(InterestRate; "Interest Rate")
            {
            }
            column(Description; Description)
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
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
            dataitem("Employee Repayment Schedule"; "Employee Repayment Schedule")
            {
                DataItemLink = "Loan No." = FIELD("No.");
                column(LoanDisbursementNo; "Loan Disbursement No.")
                {
                }
                column(RepaymentDate; "Repayment Date")
                {
                }
                column(InstalmentNo; "Instalment No.")
                {
                }
                column(PrincipalRepayment; "Principal Repayment")
                {
                }
                column(PrincipalMoratoriumPeriod; "Principal Moratorium Period")
                {
                }
                column(InterestRepayment; "Interest Repayment")
                {
                }
                column(InterestMoratoriumPeriod; "Interest Moratorium Period")
                {
                }
                column(TotalRepayment; "Total Repayment")
                {
                }
                column(LoanBalance; "Loan Balance")
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
}

