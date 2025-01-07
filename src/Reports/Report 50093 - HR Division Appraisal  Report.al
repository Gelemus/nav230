report 50093 "HR Division Appraisal  Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/HR Division Appraisal  Report.rdl';

    dataset
    {
        dataitem("HR Employee Appraisal Header"; "HR Employee Appraisal Header")
        {
            dataitem("Divisional Appraisal Lines"; "Divisional Appraisal Lines")
            {
                DataItemLink = "Appraisal No" = FIELD("No.");
                RequestFilterFields = "Appraisal Period";
                column(AppraisalObjective_HREmployeeAppraisalLines; "Appraisal Objective")
                {
                }
                column(OrganizationObjectiveWeight_IndividualAppraisalLines; "Objective Weight")
                {
                }
                column(ActivityCode_IndividualAppraisalLines; "Activity Code")
                {
                }
                column(ActivityDescription_IndividualAppraisalLines; "Activity Description")
                {
                }
                column(ActivityWeight_IndividualAppraisalLines; "Activity Weight")
                {
                }
                column(TargetValue_IndividualAppraisalLines; "Target Value")
                {
                }
                column(ActualOutputDescription_IndividualAppraisalLines; "Actual Output Description")
                {
                }
                column(ActualValue_IndividualAppraisalLines; "Actual Value")
                {
                }
                column(SelfAssessmentRating_IndividualAppraisalLines; "Self Assessment Rating")
                {
                }
                column(SelfAssessmentWeightedRat_IndividualAppraisalLines; "Self Assessment Weighted Rat.")
                {
                }
                column(ActualagreedValue_IndividualAppraisalLines; "Actual agreed Value")
                {
                }
                column(AgreedRatingwithSupervisor_IndividualAppraisalLines; "Agreed Rating with Supervisor")
                {
                }
                column(WeightedRatWithSupervisor_IndividualAppraisalLines; "Weighted Rat. With Supervisor")
                {
                }
                column(ModeratedValue_IndividualAppraisalLines; "Moderated Value")
                {
                }
                column(ModeratedAssessmentRating_IndividualAppraisalLines; "Moderated Assessment Rating")
                {
                }
                column(WeightedRatModeratedValue_IndividualAppraisalLines; "Weighted Rat. Moderated Value")
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

    var
        "Objective Description": Text;
}
