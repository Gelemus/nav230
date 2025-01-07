report 50086 "HR Interview Results Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/HR Interview Results Report.rdl';

    dataset
    {
        dataitem("HR Job Applicant Results"; "HR Job Applicant Results")
        {
            DataItemTableView = SORTING(Total) ORDER(Descending);
            RequestFilterFields = "Job Requistion No";
            column(JobApplicantNo_HRJobApplicantResults; "HR Job Applicant Results"."Job Applicant No")
            {
            }
            column(Surname_HRJobApplicantResults; "HR Job Applicant Results".Surname)
            {
            }
            column(Firstname_HRJobApplicantResults; "HR Job Applicant Results".Firstname)
            {
            }
            column(Middlename_HRJobApplicantResults; "HR Job Applicant Results".Middlename)
            {
            }
            column(JobNo_HRJobApplicantResults; "HR Job Applicant Results"."Job No")
            {
            }
            column(JobRequistionNo_HRJobApplicantResults; "HR Job Applicant Results"."Job Requistion No")
            {
            }
            column(Closed_HRJobApplicantResults; "HR Job Applicant Results".Closed)
            {
            }
            column(EV1_HRJobApplicantResults; "HR Job Applicant Results"."EV 1")
            {
            }
            column(EV2_HRJobApplicantResults; "HR Job Applicant Results"."EV 2")
            {
            }
            column(EV3_HRJobApplicantResults; "HR Job Applicant Results"."EV 3")
            {
            }
            column(EV4_HRJobApplicantResults; "HR Job Applicant Results"."EV 4")
            {
            }
            column(EV5_HRJobApplicantResults; "HR Job Applicant Results"."EV 5")
            {
            }
            column(EV6_HRJobApplicantResults; "HR Job Applicant Results"."EV 6")
            {
            }
            column(EV7_HRJobApplicantResults; "HR Job Applicant Results"."EV 7")
            {
            }
            column(EV8_HRJobApplicantResults; "HR Job Applicant Results"."EV 8")
            {
            }
            column(EV9_HRJobApplicantResults; "HR Job Applicant Results"."EV 9")
            {
            }
            column(EV10_HRJobApplicantResults; "HR Job Applicant Results"."EV 10")
            {
            }
            column(Total_HRJobApplicantResults; "HR Job Applicant Results".Total)
            {
            }
            column(Position_HRJobApplicantResults; "HR Job Applicant Results".Position)
            {
            }
            column(TODAY; Format(Today, 0, 4))
            {
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
}

