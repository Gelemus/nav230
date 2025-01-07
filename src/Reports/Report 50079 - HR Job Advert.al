report 50079 "HR Job Advert"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/HR Job Advert.rdl';
    WordLayout = 'src/Layouts/HR Job Advert.docx';

    dataset
    {
        dataitem("HR Employee Requisitions"; "HR Employee Requisitions")
        {
            RequestFilterFields = "No.";
            column(No_HREmployeeRequisitions; "No.")
            {
            }
            column(JobNo_HREmployeeRequisitions; "Job No.")
            {
            }
            column(JobTitle_HREmployeeRequisitions; "HR Employee Requisitions"."Job Title")
            {
            }
            column(JobDescription_HREmployeeRequisitions; "HR Employee Requisitions"."Emp. Requisition Description")
            {
            }
            column(JobGrade_HREmployeeRequisitions; "HR Employee Requisitions"."Job Grade")
            {
            }
            column(MaximumPositions_HREmployeeRequisitions; "HR Employee Requisitions"."Maximum Positions")
            {
            }
            column(OccupiedPositions_HREmployeeRequisitions; "HR Employee Requisitions"."Occupied Positions")
            {
            }
            column(VacantPositions_HREmployeeRequisitions; "HR Employee Requisitions"."Vacant Positions")
            {
            }
            column(RequestedEmployees_HREmployeeRequisitions; "HR Employee Requisitions"."Requested Employees")
            {
            }
            column(ClosingDate_HREmployeeRequisitions; "HR Employee Requisitions"."Closing Date")
            {
            }
            column(RequisitionType_HREmployeeRequisitions; "HR Employee Requisitions"."Requisition Type")
            {
            }
            column(ReasonforRequisition_HREmployeeRequisitions; "HR Employee Requisitions"."Emplymt. Contract Code")
            {
            }
            column(InterviewDate_HREmployeeRequisitions; "HR Employee Requisitions"."Interview Date")
            {
            }
            column(InterviewTime_HREmployeeRequisitions; "HR Employee Requisitions"."Interview Time")
            {
            }
            column(InterviewLocation_HREmployeeRequisitions; "HR Employee Requisitions"."Interview Location")
            {
            }
            column(Description_HREmployeeRequisitions; "HR Employee Requisitions".Description)
            {
            }
            column(GlobalDimension1Code_HREmployeeRequisitions; "HR Employee Requisitions"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_HREmployeeRequisitions; "HR Employee Requisitions"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_HREmployeeRequisitions; "HR Employee Requisitions"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_HREmployeeRequisitions; "HR Employee Requisitions"."Shortcut Dimension 4 Code")
            {
            }
            column(ShortcutDimension5Code_HREmployeeRequisitions; "HR Employee Requisitions"."Shortcut Dimension 5 Code")
            {
            }
            column(ShortcutDimension6Code_HREmployeeRequisitions; "HR Employee Requisitions"."Shortcut Dimension 6 Code")
            {
            }
            column(ShortcutDimension7Code_HREmployeeRequisitions; "HR Employee Requisitions"."Shortcut Dimension 7 Code")
            {
            }
            column(ShortcutDimension8Code_HREmployeeRequisitions; "HR Employee Requisitions"."Shortcut Dimension 8 Code")
            {
            }
            column(ResponsibilityCenter_HREmployeeRequisitions; "HR Employee Requisitions"."Responsibility Center")
            {
            }
            column(Status_HREmployeeRequisitions; "HR Employee Requisitions".Status)
            {
            }
            column(UserID_HREmployeeRequisitions; "HR Employee Requisitions"."User ID")
            {
            }
            column(NoSeries_HREmployeeRequisitions; "HR Employee Requisitions"."No. Series")
            {
            }
            column(JobPurpose; JobPurpose)
            {
            }
            dataitem("HR Job Qualifications"; "HR Job Qualifications")
            {
                DataItemLink = "Job No." = FIELD("Job No.");
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
                DataItemLink = "Job No." = FIELD("Job No.");
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
                DataItemLink = "Job No." = FIELD("Job No.");
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
                if HRJobs.Get("HR Employee Requisitions"."Job No.") then
                    JobPurpose := HRJobs."Job Purpose";
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
        LN1: Integer;
        LN2: Integer;
        LN3: Integer;
        JobPurpose: Text;
        HRJobs: Record "HR Jobs";
}

