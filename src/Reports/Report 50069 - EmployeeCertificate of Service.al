report 50069 "EmployeeCertificate of Service"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/EmployeeCertificate of Service.rdl';

    dataset
    {
        dataitem("HR Employee Exit Interviews"; "HR Employee Exit Interviews")
        {
            RequestFilterFields = "Employee No.";
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_Name; CI.Name)
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
            column(EmployeeNo_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Employee No.")
            {
            }
            column(EmployeeName_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Employee Name")
            {
            }
            column(NationalIDNo_HREmployeeExitInterviews; "HR Employee Exit Interviews"."National ID No.")
            {
            }
            column(PassportNo_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Passport No.")
            {
            }
            column(InterviewerName_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Interviewer Name")
            {
            }
            column(EmployementDate_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Employement Date")
            {
            }
            column(DateOfSeparation_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Date Of Separation")
            {
            }
            column(HRJobTitle_HREmployeeExitInterviews; "HR Employee Exit Interviews"."HR Job Title")
            {
            }
            column(ExitInterviewNo_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Exit Interview No")
            {
            }
            column(Certificate_Date; CertificateDate)
            {
            }
            column(Designation; Designation)
            {
            }
            column(ID; ID)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LNo := LNo + 1;
                CertificateDate := Today;
                Employee.Reset;
                Employee.SetRange(Employee."No.", "HR Employee Exit Interviews"."Employee No.");
                if Employee.FindSet then begin
                    Designation := Employee."Job Title";
                    ID := Employee."National ID";
                end;
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
        CI: Record "Company Information";
        LNo: Integer;
        CertificateDate: Date;
        Text0001: Label 'TURNING IDEAS INTO WEALTH';
        Designation: Text;
        Employee: Record Employee;
        ID: Text;
}

