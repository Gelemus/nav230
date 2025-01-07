report 50066 "Human Resource Staff Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Human Resource Staff Report.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = Status, "Emplymt. Contract Code", "Global Dimension 1 Code", "Global Dimension 2 Code";
            column(CName; CompanyInfo.Name)
            {
            }
            column(CAddress; CompanyInfo.Address)
            {
            }
            column(CAddress2; CompanyInfo."Address 2")
            {
            }
            column(CCity; CompanyInfo.City)
            {
            }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(CEmail; CompanyInfo."E-Mail")
            {
            }
            column(CWebsite; CompanyInfo."Home Page")
            {
            }
            column(CPhone; CompanyInfo."Phone No.")
            {
            }
            column(CVision; Text0001)
            {
            }
            column(No_Employee; Employee."No.")
            {
            }
            column(First_Name; Employee."First Name")
            {
            }
            column(MiddleName_Employee; Employee."Middle Name")
            {
            }
            column(LastName_Employee; Employee."Last Name")
            {
            }
            column(JobTitle_Employee; Employee."Job Title")
            {
            }
            column(EmployementCategory_Employee; Employee."Age-d")
            {
            }
            column(Gender_Employee; Employee.Gender)
            {
            }
            column(EmploymentDate_Employee; Employee."Employment Date")
            {
            }
            column(ID; Employee."National ID")
            {
            }
            column(NationalIDNo_Employee; Employee."National ID No.-d")
            {
            }
            column(BirthDate_Employee; Employee."Birth Date")
            {
            }
            column(EMail_Employee; Employee."E-Mail")
            {
            }
            column(MobilePhoneNo_Employee; Employee."Mobile Phone No.")
            {
            }
            column(GlobalDimension1Code_Employee; Employee."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_Employee; Employee."Global Dimension 2 Code")
            {
            }
            column(No; LNo)
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI__Address; CI."Address 2")
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(Country; CI."Country/Region Code")
            {
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
            }
            column(CI_TelephoneNo; CI."Telephone No.")
            {
            }
            column(CI_Email; CI."E-Mail")
            {
            }
            column(CI_Website; CI."Home Page")
            {
            }
            column(CI_Vision; Text0001)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LNo := LNo + 1;
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
        CI.Get;
        CI.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        LNo: Integer;
        Text0001: Label '"Turning Ideas Into Wealth"';
        CI: Record "Company Information";
}

