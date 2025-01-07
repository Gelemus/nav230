report 50072 "Retirement From Pension Letter"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Retirement From Pension Letter.rdl';

    dataset
    {
        dataitem("HR Employee Exit Interviews"; "HR Employee Exit Interviews")
        {
            RequestFilterFields = Status;
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
            column(Lno; Lno)
            {
            }
            column(ExitInterviewNo_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Exit Interview No")
            {
            }
            column(DateOfInterview_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Date Of Interview")
            {
            }
            column(InterviewDoneBy_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Interview Done By")
            {
            }
            column(ReEmployInFuture_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Re Employ In Future")
            {
            }
            column(ReasonForLeaving_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Grounds for Term. Code")
            {
            }
            column(ReasonForLeavingOther_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Reason For Leaving (Other)")
            {
            }
            column(DateOfLeaving_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Date Of Separation")
            {
            }
            column(Comment_HREmployeeExitInterviews; "HR Employee Exit Interviews".Comment)
            {
            }
            column(EmployeeNo_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Employee No.")
            {
            }
            column(NoSeries_HREmployeeExitInterviews; "HR Employee Exit Interviews"."No Series")
            {
            }
            column(FormSubmitted_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Clearance Form Submitted")
            {
            }
            column(GlobalDimension2_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Global Dimension 2 Code")
            {
            }
            column(EmployeeName_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Employee Name")
            {
            }
            column(InterviewerName_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Interviewer Name")
            {
            }
            column(Status_HREmployeeExitInterviews; "HR Employee Exit Interviews".Status)
            {
            }
            column(NationalIDNo_HREmployeeExitInterviews; "HR Employee Exit Interviews"."National ID No.")
            {
            }
            column(r; "HR Employee Exit Interviews"."Passport No.")
            {
            }
            column(EmployementDate_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Employement Date")
            {
            }
            column(HRJobTitle_HREmployeeExitInterviews; "HR Employee Exit Interviews"."HR Job Title")
            {
            }
            column(PensionProvider_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Pension Provider")
            {
            }
            column(PensionLetterRecipientName_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Pension Letter Recipient Name")
            {
            }
            column(PensionProviderAddress_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Pension Provider Address")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Lno := Lno + 1;
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
}

