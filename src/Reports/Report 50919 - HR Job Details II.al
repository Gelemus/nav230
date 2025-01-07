report 50919 "HR Job Details II"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/HR Job Details II.rdl';

    dataset
    {
        dataitem("HR Jobs"; "HR Jobs")
        {
            RequestFilterFields = "No.";
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
            column(No_HRJobs; "HR Jobs"."No.")
            {
            }
            column(JobTitle_HRJobs; "HR Jobs"."Job Title")
            {
            }
            column(JobGrade_HRJobs; "HR Jobs"."Job Grade")
            {
            }
            column(Description_HRJobs; "HR Jobs".Description)
            {
            }
            column(JobPurpose_HRJobs; "HR Jobs"."Job Purpose")
            {
            }
            dataitem("HR Job Qualifications"; "HR Job Qualifications")
            {
                DataItemLink = "Job No." = FIELD("No.");
                column(QualificationCode_HRJobQualifications; "HR Job Qualifications"."Qualification Code")
                {
                }
                column(Description_HRJobQualifications; "HR Job Qualifications".Description)
                {
                }
                column(Mandatory_HRJobQualifications; "HR Job Qualifications".Mandatory)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LN1 := LN1 + 1;
                end;
            }
            dataitem("HR Job Requirements"; "HR Job Requirements")
            {
                DataItemLink = "Job No." = FIELD("No.");
                column(JobNo_HRJobRequirements; "HR Job Requirements"."Job No.")
                {
                }
                column(RequirementCode_HRJobRequirements; "HR Job Requirements"."Requirement Code")
                {
                }
                column(Description_HRJobRequirements; "HR Job Requirements".Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LN2 := LN2 + 1;
                end;
            }
            dataitem("HR Job Responsibilities"; "HR Job Responsibilities")
            {
                DataItemLink = "Job No." = FIELD("No.");
                column(JobNo_HRJobResponsibilities; "HR Job Responsibilities"."Job No.")
                {
                }
                column(ResponsibilityCode_HRJobResponsibilities; "HR Job Responsibilities"."Responsibility Code")
                {
                }
                column(Description_HRJobResponsibilities; "HR Job Responsibilities".Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LN3 := LN3 + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //JobPurposeFullDescription:="Job Purpose"+''+"Job Purpose Description 2";
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
        HRJobQualifications: Record "HR Job Qualifications";
        HRJobRequirements: Record "HR Job Requirements";
        HRJobResponsibilities: Record "HR Job Responsibilities";
        LN1: Integer;
        LN2: Integer;
        LN3: Integer;
        JobPurposeFullDescription: Text;
        CI: Record "Company Information";
        Lno: Integer;
        Text0001: Label '"Turning Ideas into Wealth"';
}

