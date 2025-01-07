report 50092 "HR Exit Interview Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/HR Exit Interview Form.rdl';

    dataset
    {
        dataitem("HR Employee Exit Interviews"; "HR Employee Exit Interviews")
        {
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
            column(Lno; Lno)
            {
            }
            column(DateToday; Format(Today, 0, 4))
            {
            }
            column(ExitInterviewNo; "HR Employee Exit Interviews"."Exit Interview No")
            {
            }
            column(EmployeeNo; "HR Employee Exit Interviews"."Employee No.")
            {
            }
            column(EmployeeName; "HR Employee Exit Interviews"."Employee Name")
            {
            }
            column(GlobalDimension1Code; "HR Employee Exit Interviews"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code; "HR Employee Exit Interviews"."Global Dimension 2 Code")
            {
            }
            column(DateOfSeparation; Format("Date Of Separation", 0, 4))
            {
            }
            column(HRJobTitle; "HR Employee Exit Interviews"."HR Job Title")
            {
            }
            column(SupervisorJobNo; "HR Employee Exit Interviews"."Supervisor Job No.")
            {
            }
            column(SupervisorJobTitle; "HR Employee Exit Interviews"."Supervisor Job Title")
            {
            }
            column(EmployementYearsofService; "HR Employee Exit Interviews"."Employement Years of Service")
            {
            }
            column(EmployementDate; Format("Employement Date", 0, 4))
            {
            }

            trigger OnAfterGetRecord()
            begin
                Lno := Lno + 1;
                DateToday := Today;
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

    trigger OnInitReport()
    begin
        CI.Get;
        CI.CalcFields(Picture);
    end;

    var
        CI: Record "Company Information";
        Lno: Integer;
        Text0001: Label '"Empowered Healthy Communities"';
        DateToday: Date;
}

