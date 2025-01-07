report 50080 "HR Job Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/HR Job Details.rdl';

    dataset
    {
        dataitem("HR Jobs"; "HR Jobs")
        {
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
                column(LN1; LN1)
                {
                }
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
                column(LN2; LN2)
                {
                }
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
                column(LN3; LN3)
                {
                }
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

    var
        HRJobQualifications: Record "HR Job Qualifications";
        HRJobRequirements: Record "HR Job Requirements";
        HRJobResponsibilities: Record "HR Job Responsibilities";
        LN1: Integer;
        LN2: Integer;
        LN3: Integer;
        JobPurposeFullDescription: Text;
}

