xmlport 50043 "Import/Export Employ Appraisal"
{
   // FieldDelimiter = '<None>';
    //FieldSeparator = '<TAB>';
    Format = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(HREmployeeAppraisalHeaderRoot)
        {
            tableelement("HR Employee Appraisal Header";"HR Employee Appraisal Header")
            {
                XmlName = 'HREmployeeAppraisalHeader';
                fieldelement(VNo;"HR Employee Appraisal Header"."No.")
                {
                }
                fieldelement(VEmployeeNo;"HR Employee Appraisal Header"."Employee No.")
                {
                }
                fieldelement(VEmployeeName;"HR Employee Appraisal Header"."Employee Name")
                {
                }
                fieldelement(VAppraisalPeriod;"HR Employee Appraisal Header"."Appraisal Period")
                {
                }
                fieldelement(VAppraisalStage;"HR Employee Appraisal Header"."Appraisal Stage")
                {
                }
                fieldelement(VJobGrade;"HR Employee Appraisal Header"."Job Grade")
                {
                }
                fieldelement(VJobTitle;"HR Employee Appraisal Header"."Job code")
                {
                }
                fieldelement(VAppraisalLevel;"HR Employee Appraisal Header"."Appraisal Level")
                {
                }
                fieldelement(VDate;"HR Employee Appraisal Header".Date)
                {
                }
                fieldelement(VSupervisor;"HR Employee Appraisal Header".Supervisor)
                {
                }
                fieldelement(VSupervisorName;"HR Employee Appraisal Header"."Supervisor Name")
                {
                }
                fieldelement(VSupervisorUserID;"HR Employee Appraisal Header"."Supervisor User ID")
                {
                }
                fieldelement(VEvaluationPeriodStart;"HR Employee Appraisal Header"."Evaluation Period Start")
                {
                }
                fieldelement(VEvaluationPeriodEnd;"HR Employee Appraisal Header"."Evaluation Period End")
                {
                }
                fieldelement(VSelfAssesmentWeightedRating;"HR Employee Appraisal Header"."Self Assesment Weighted Rating")
                {
                }
                fieldelement(VAgreedRatingwithSupervisor;"HR Employee Appraisal Header"."Agreed Rating with Supervisor")
                {
                }
                fieldelement(VWeightedRatingwithSuperviso;"HR Employee Appraisal Header"."Weighted Rating with Superviso")
                {
                }
                fieldelement(VModeratedAssementRating;"HR Employee Appraisal Header"."Moderated Assement Rating")
                {
                }
                fieldelement(VWeightedRatModeratedValue;"HR Employee Appraisal Header"."Weighted Rat. Moderated Value")
                {
                }
                fieldelement(VDescription;"HR Employee Appraisal Header".Description)
                {
                }
                fieldelement(VGlobalDimension1Code;"HR Employee Appraisal Header"."Global Dimension 1 Code")
                {
                }
                fieldelement(VGlobalDimension2Code;"HR Employee Appraisal Header"."Global Dimension 2 Code")
                {
                }
                fieldelement(VShortcutDimension3Code;"HR Employee Appraisal Header"."Shortcut Dimension 3 Code")
                {
                }
                fieldelement(VShortcutDimension4Code;"HR Employee Appraisal Header"."Shortcut Dimension 4 Code")
                {
                }
                fieldelement(VShortcutDimension5Code;"HR Employee Appraisal Header"."Shortcut Dimension 5 Code")
                {
                }
                fieldelement(VShortcutDimension6Code;"HR Employee Appraisal Header"."Shortcut Dimension 6 Code")
                {
                }
                fieldelement(VShortcutDimension7Code;"HR Employee Appraisal Header"."Shortcut Dimension 7 Code")
                {
                }
                fieldelement(VShortcutDimension8Code;"HR Employee Appraisal Header"."Shortcut Dimension 8 Code")
                {
                }
                fieldelement(VResponsibilityCenter;"HR Employee Appraisal Header"."Responsibility Center")
                {
                }
                fieldelement(VStatus;"HR Employee Appraisal Header".Status)
                {
                }
                fieldelement(VUserID;"HR Employee Appraisal Header"."User ID")
                {
                }
                fieldelement(VNoSeries;"HR Employee Appraisal Header"."No. Series")
                {
                }
                fieldelement(VIncomingDocumentEntryNo;"HR Employee Appraisal Header"."Incoming Document Entry No.")
                {
                }
                fieldelement(VDateofAppointment;"HR Employee Appraisal Header"."Date of Appointment")
                {
                }
                fieldelement(VDateAssignedCurrentPosition;"HR Employee Appraisal Header"."Date Assigned Current Position")
                {
                }
                fieldelement(VDateofLastAppraisal;"HR Employee Appraisal Header"."Date of Last Appraisal")
                {
                }
                fieldelement(VEmploymentTerm;"HR Employee Appraisal Header"."Employment Term")
                {
                }
                fieldelement(VSpecialTasksifany;"HR Employee Appraisal Header"."Special Tasks (if any)")
                {
                }
                fieldelement(VLastPerformanceRating;"HR Employee Appraisal Header"."Last Performance Rating")
                {
                }
                fieldelement(VCommentsByHOD;"HR Employee Appraisal Header"."Comments By HOD")
                {
                }
                fieldelement(VCommentsByHODHR;"HR Employee Appraisal Header"."Comments By HOD HR")
                {
                }
                fieldelement(VFinalCommentsbyAppraiser;"HR Employee Appraisal Header"."Final Comments by Appraiser")
                {
                }
                fieldelement(VObjectivesScore;"HR Employee Appraisal Header"."Objectives Score")
                {
                }
                fieldelement(VCompetencyFactorScore;"HR Employee Appraisal Header"."Competency Factor Score")
                {
                }
                fieldelement(VCommentsByAppraisee;"HR Employee Appraisal Header"."Comments By Appraisee")
                {
                }
                fieldelement(VCommentsByAppraiseeDate;"HR Employee Appraisal Header"."Comments By Appraisee Date")
                {
                }
                fieldelement(VCommentsbyAppraiserDate;"HR Employee Appraisal Header"."Comments by Appraiser Date")
                {
                }
                fieldelement(VTotalRating;"HR Employee Appraisal Header"."Total Rating")
                {
                }
                fieldelement(VApprovalByMDCEO;"HR Employee Appraisal Header"."Approval By MDCEO")
                {
                }
                fieldelement(VApprovalByMDDate;"HR Employee Appraisal Header"."Approval By MD Date")
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
}

