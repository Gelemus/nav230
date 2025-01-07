report 50904 "Employee Appraisal Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Employee Appraisal Report.rdl';

    dataset
    {
        dataitem("HR Employee Appraisal Header"; "HR Employee Appraisal Header")
        {
            column(CompanyInformationRec_Picture; CompanyInformationRec.Picture)
            {
            }
            column(Company_Name; CompanyInformationRec.Name)
            {
            }
            column(GlobalDimension1Code_HREmployeeAppraisalHeader; "HR Employee Appraisal Header"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_HREmployeeAppraisalHeader; "HR Employee Appraisal Header"."Global Dimension 2 Code")
            {
            }
            column(SupervisorName_HREmployeeAppraisalHeader; "HR Employee Appraisal Header"."Supervisor Name")
            {
            }
            column(DateofAppointment_HREmployeeAppraisalHeader; "HR Employee Appraisal Header"."Date of Appointment")
            {
            }
            column(DateAssignedCurrentPosition_HREmployeeAppraisalHeader; "HR Employee Appraisal Header"."Date Assigned Current Position")
            {
            }
            column(DateofLastAppraisal_HREmployeeAppraisalHeader; "HR Employee Appraisal Header"."Date of Last Appraisal")
            {
            }
            column(EmploymentTerm_HREmployeeAppraisalHeader; "HR Employee Appraisal Header"."Employment Term")
            {
            }
            column(EmployeeNo_HREmployeeAppraisalHeader; "HR Employee Appraisal Header"."Employee No.")
            {
            }
            column(EmployeeName_HREmployeeAppraisalHeader; "HR Employee Appraisal Header"."Employee Name")
            {
            }
            column(Designation_HREmployeeAppraisalHeader; "HR Employee Appraisal Header".Designation)
            {
            }
            column(LastPerformanceRating_HREmployeeAppraisalHeader; "HR Employee Appraisal Header"."Last Performance Rating")
            {
            }
            column(AppraisalPeriod_HREmployeeAppraisalHeader; "HR Employee Appraisal Header"."Appraisal Period")
            {
            }
            column(CommentsByHOD_HREmployeeAppraisalHeader; "HR Employee Appraisal Header"."Comments By HOD")
            {
            }
            column(JobGrade_HREmployeeAppraisalHeader; "HR Employee Appraisal Header"."Job Grade")
            {
            }
            column(CommentsByHODHR_HREmployeeAppraisalHeader; "HR Employee Appraisal Header"."Comments By HOD HR")
            {
            }
            column(No_HREmployeeAppraisalHeader; "HR Employee Appraisal Header"."No.")
            {
            }
            column(Status_HREmployeeAppraisalHeader; "HR Employee Appraisal Header".Status)
            {
            }
            column(FinalCommentsbyAppraiser_HREmployeeAppraisalHeader; "HR Employee Appraisal Header"."Final Comments by Appraiser")
            {
            }
            column(Objective_Score; "HR Employee Appraisal Header"."Objectives Score")
            {
            }
            column(TotalScore; "HR Employee Appraisal Header"."Competency Factor Score" + "HR Employee Appraisal Header"."Objectives Score")
            {
            }
            column(Kpi_Total; "HR Employee Appraisal Header"."Competency Factor Score")
            {
            }
            dataitem("Employee Qualification"; "Employee Qualification")
            {
                DataItemLink = "Employee No." = FIELD("Employee No.");
                column(PerformanceTarget_EmployeeQualification; "Employee Qualification"."Performance Target")
                {
                }
                column(Unit_EmployeeQualification; "Employee Qualification".Unit)
                {
                }
                column(MaximumScore_EmployeeQualification; "Employee Qualification"."Maximum Score")
                {
                }
                column(Apprasee_EmployeeQualification; "Employee Qualification".Apprasee)
                {
                }
                column(Appraiser_EmployeeQualification; "Employee Qualification".Appraiser)
                {
                }
            }
            dataitem("HR Appraisal Resp/Duties"; "HR Appraisal Resp/Duties")
            {
                DataItemLink = "Appraisal Code" = FIELD("No.");
                column(ResponsibilityDuty_HRAppraisalRespDuties; "HR Appraisal Resp/Duties"."Responsibility/Duty")
                {
                }
            }
            dataitem("Hr Appraisal Academic/Prof Qua"; "Hr Appraisal Academic/Prof Qua")
            {
                DataItemLink = "Appraisal Code" = FIELD("No.");
                column(NameofInstitution_HrAppraisalAcademicProfQua; "Hr Appraisal Academic/Prof Qua"."Name of Institution")
                {
                }
                column(QualificationAwarded_HrAppraisalAcademicProfQua; "Hr Appraisal Academic/Prof Qua"."Qualification Awarded")
                {
                }
                column(PeriodOfStudy_HrAppraisalAcademicProfQua; "Hr Appraisal Academic/Prof Qua"."Period Of Study")
                {
                }
            }
            dataitem("HR Job Qualifications"; "HR Job Qualifications")
            {
                DataItemLink = "Job No." = FIELD("Job code");
                column(QualificationCode_HRJobQualifications; "HR Job Qualifications"."Qualification Code")
                {
                }
                column(Description_HRJobQualifications; "HR Job Qualifications".Description)
                {
                }
                column(Mandatory_HRJobQualifications; "HR Job Qualifications".Mandatory)
                {
                }
            }
            dataitem("HR Job Requirements"; "HR Job Requirements")
            {
                DataItemLink = "Job No." = FIELD("Job code");
                column(Description_HRJobRequirements; "HR Job Requirements".Description)
                {
                }
                column(NoofYears_HRJobRequirements; "HR Job Requirements"."No. of Years")
                {
                }
                column(Mandatory_HRJobRequirements; "HR Job Requirements".Mandatory)
                {
                }
            }
            dataitem("HR Job Responsibilities"; "HR Job Responsibilities")
            {
                DataItemLink = "Job No." = FIELD("Job code");
                column(ResponsibilityCode_HRJobResponsibilities; "HR Job Responsibilities"."Responsibility Code")
                {
                }
                column(Description_HRJobResponsibilities; "HR Job Responsibilities".Description)
                {
                }
            }
            dataitem("HR Appraisal Special Task"; "HR Appraisal Special Task")
            {
                DataItemLink = "No." = FIELD("No.");
                column(Task_HRAppraisalSpecialTask; "HR Appraisal Special Task".Task)
                {
                }
            }
            dataitem("HR Appraisal Problems/Challeng"; "HR Appraisal Problems/Challeng")
            {
                DataItemLink = "No." = FIELD("No.");
                column(ProblemChallenge_HRAppraisalProblemsChalleng; "HR Appraisal Problems/Challeng"."Problem/Challenge")
                {
                }
            }
            dataitem("HR Appraisal Performance Facto"; "HR Appraisal Performance Facto")
            {
                DataItemLink = "Appraisal No." = FIELD("No.");
                column(PerformanceFactor_HRAppraisalPerformanceFacto; "HR Appraisal Performance Facto"."Performance Factor")
                {
                }
            }
            dataitem("HR Appraisal Course/Training"; "HR Appraisal Course/Training")
            {
                DataItemLink = "Appraisal No." = FIELD("No.");
                column(CourseTraining_HRAppraisalCourseTraining; "HR Appraisal Course/Training"."Course/Training")
                {
                }
            }
            dataitem("HR Appraisal Training Recommen"; "HR Appraisal Training Recommen")
            {
                DataItemLink = "Appraisal No." = FIELD("No.");
                column(TrainingRecommended_HRAppraisalTrainingRecommen; "HR Appraisal Training Recommen"."Training Recommended")
                {
                }
            }
            dataitem("Hr Appraisal Performace Sugge"; "Hr Appraisal Performace Sugge")
            {
                DataItemLink = "Appraisal No." = FIELD("No.");
                column(Suggestion_HrAppraisalPerformaceSugge; "Hr Appraisal Performace Sugge".Suggestion)
                {
                }
            }
            dataitem("HR Appraisal Training Need &Ob"; "HR Appraisal Training Need &Ob")
            {
                DataItemLink = "Appraisal No." = FIELD("No.");
                column(TrainingNeedObjective_HRAppraisalTrainingNeedOb; "HR Appraisal Training Need &Ob"."Training Need & Objective")
                {
                }
            }
            dataitem("HR Appraisal Identified Potent"; "HR Appraisal Identified Potent")
            {
                DataItemLink = "Appraisal No." = FIELD("No.");
                column(IdentifiedPotential_HRAppraisalIdentifiedPotent; "HR Appraisal Identified Potent"."Identified Potential")
                {
                }
            }
            dataitem("HR Appraisal Recommendation"; "HR Appraisal Recommendation")
            {
                DataItemLink = "Appraisal No." = FIELD("No.");
                column(Recommendation_HRAppraisalRecommendation; "HR Appraisal Recommendation".Recommendation)
                {
                }
                column(Reason_HRAppraisalRecommendation; "HR Appraisal Recommendation".Reason)
                {
                }
            }
            dataitem("HR Appraisal Competency Factor"; "HR Appraisal Competency Factor")
            {
                DataItemLink = "Appraisal No." = FIELD("No.");
                column(AppraisalObjective_HRAppraisalObjectives; "HR Appraisal Competency Factor"."Competency Factor")
                {
                }
                column(Score_HRAppraisalObjectives; "HR Appraisal Competency Factor".Score)
                {
                }
                column(SelfRating_HRAppraisalObjectives; "HR Appraisal Competency Factor"."Self Rating")
                {
                }
                column(Consensus_HRAppraisalObjectives; "HR Appraisal Competency Factor".Consensus)
                {
                }
                column(Comments_HRAppraisalObjectives; "HR Appraisal Competency Factor".Comments)
                {
                }
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

    trigger OnInitReport()
    begin
        CompanyInformationRec.Get;
        CompanyInformationRec.CalcFields(Picture);
    end;

    var
        CompanyInformationRec: Record "Company Information";
        TotalScore: Decimal;
}

