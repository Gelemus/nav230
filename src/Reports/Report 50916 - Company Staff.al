report 50916 "Company Staff"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Company Staff.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Emplymt. Contract Code";
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(No_Employee; Employee."No.")
            {
            }
            column(FullName_Employee; Employee."Full Name")
            {
            }
            column(EmploymentDate_Employee; Employee."Employment Date")
            {
            }
            column(EmplymtContractCode_Employee; Employee."Emplymt. Contract Code")
            {
            }
            column(NationalID_Employee; Employee."National ID")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if (Employee."Emplymt. Contract Code" = 'CASUALS') or (Employee."Emplymt. Contract Code" = 'INTERN') or (Employee."Emplymt. Contract Code" = '') then
                    CurrReport.Skip;
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
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
}

