report 50187 "Employee App. Loan Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Employee App. Loan Schedule.rdl';

    dataset
    {
        dataitem("Employee Loan Applications"; "Employee Loan Applications")
        {
            column(No; "Employee Loan Applications"."No.")
            {
            }
            column(DocumentDate; "Employee Loan Applications"."Document Date")
            {
            }
            column(EmployeeNo; "Employee Loan Applications"."Employee No.")
            {
            }
            column(EmployeeName; "Employee Loan Applications"."Employee Name")
            {
            }
            column(EmployeeBranch; "Employee Loan Applications"."HR Branch")
            {
            }
            column(EmployeeDepartment; "Employee Loan Applications"."HR Department")
            {
            }
            column(LoanProductCode; "Employee Loan Applications"."Loan Product Code")
            {
            }
            column(LoanProductDescription; "Employee Loan Applications"."Loan Product Description")
            {
            }
            column(RepaymentFrequency; "Employee Loan Applications"."Repayment Frequency")
            {
            }
            column(ApprovedAmount; "Employee Loan Applications"."Applied Amount")
            {
            }
            column(RepaymentStartDate; "Employee Loan Applications"."Repayment Start Date")
            {
            }
            column(RepaymentPeriod; "Employee Loan Applications"."Repayment Period")
            {
            }
            column(RepaymentEndDate; "Employee Loan Applications"."Repayment End Date")
            {
            }
            column(NoOfInstallments; "Employee Loan Applications"."No. of Installments")
            {
            }
            column(InterestRate; "Employee Loan Applications"."Interest Rate")
            {
            }
            column(Description; "Employee Loan Applications".Description)
            {
            }
            column(GlobalDimension1Code; "Employee Loan Applications"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code; "Employee Loan Applications"."Global Dimension 2 Code")
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
            dataitem("Employee App. Repay. Schedule"; "Employee App. Repay. Schedule")
            {
                DataItemLink = "Application No." = FIELD("No.");
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

