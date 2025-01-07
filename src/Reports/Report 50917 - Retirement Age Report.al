report 50917 "Retirement Age Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Retirement Age Report.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.") WHERE(Status = CONST(Active));
            RequestFilterFields = Age, "Emplymt. Contract Code", "Birth Date";
            column(FullName_Employee; Employee."Full Name")
            {
            }
            column(No_Employee; Employee."No.")
            {
            }
            column(Age_Employee; Employee.Age)
            {
            }
            column(BirthDate_Employee; Employee."Birth Date")
            {
            }
            column(DateofRetirement_Employee; Employee."Date of Retirement")
            {
            }
            column(EmploymentDate_Employee; Employee."Employment Date")
            {
            }
            column(EmployementYearsofService_Employee; Employee."Employement Years of Service")
            {
            }
            column(pic; CompanyInformation.Picture)
            {
            }
            column(Name; CompanyInformation.Name)
            {
            }
            column(EmplymtContractCode_Employee; Employee."Emplymt. Contract Code")
            {
            }
            column(Gender_Employee; Employee.Gender)
            {
            }
            column(Age; Age)
            {
            }

            trigger OnAfterGetRecord()
            begin

                //Calculate Age
                //Calculate Age
                HumanResourcesSetup.Get;
                if Employee."Employment Date" <> 0D then begin
                    Employee."Employement Years of Service" := Dates.DetermineAge_Years("Employment Date", Today);
                    /*IF Employee."Physically Challenged" = Employee."Physically Challenged"::Yes THEN
                     Employee."Date of Retirement" := Dates.pwdDetermineAgeService2("Employment Date",TODAY);*/
                end;
                if Employee."Birth Date" <> 0D then begin
                    Employee.Age := Dates.DetermineAge_Years("Birth Date", Today);
                    Employee."Date of Retirement" := CalcDate(HumanResourcesSetup."Retirement Age", "Birth Date");
                    if Employee."Physically Challenged" = Employee."Physically Challenged"::Yes then
                        Employee."Date of Retirement" := CalcDate(HumanResourcesSetup."Pwd Retirement Age", "Birth Date");
                end else begin
                    Employee.Age := '';
                    Employee."Date of Retirement" := 0D;
                end;
                Employee.Modify;
                if Employee."Birth Date" = 0D then
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
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        Dates: Codeunit Dates;
        HumanResourcesSetup: Record "Human Resources Setup";
        CompanyInformation: Record "Company Information";
        Age: Integer;
}

