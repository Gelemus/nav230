report 50089 "Medical Examination"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Medical Examination.rdl';

    dataset
    {
        dataitem("HR Job Applications"; "HR Job Applications")
        {
            RequestFilterFields = Status, ShortListed, "Committee Shortlisted", "Employee Requisition No.", "To be Interviewed";
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
            column(No_HRJobApplications; "HR Job Applications"."No.")
            {
            }
            column(EmployeeRequisitionNo_HRJobApplications; "Employee Requisition No.")
            {
            }
            column(JobNo_HRJobApplications; "HR Job Applications"."Job No.")
            {
            }
            column(JobTitle_HRJobApplications; "HR Job Applications"."Job Title")
            {
            }
            column(Surname_HRJobApplications; "HR Job Applications".Surname)
            {
            }
            column(Firstname_HRJobApplications; "HR Job Applications".Firstname)
            {
            }
            column(Middlename_HRJobApplications; "HR Job Applications".Middlename)
            {
            }
            column(FullName; FullName)
            {
            }
            column(Gender_HRJobApplications; "HR Job Applications".Gender)
            {
            }
            column(Age_HRJobApplications; "HR Job Applications".Age)
            {
            }
            column(DateToday; Format(Today, 0, 4))
            {
            }

            trigger OnAfterGetRecord()
            begin
                Lno := Lno + 1;
                DateToday := Today;
                FullName := "HR Job Applications".Firstname + '  ' + "HR Job Applications".Middlename + '  ' + "HR Job Applications".Surname;
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
        FullName: Text;
}

