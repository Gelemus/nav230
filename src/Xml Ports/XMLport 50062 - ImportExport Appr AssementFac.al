xmlport 50062 "Import/Export Appr AssementFac"
{
    // FieldDelimiter = '<None>';
    // FieldSeparator = '<TAB>';
    Format = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(HRAppraisalAssesmentFactorsRoot)
        {
            tableelement("HR Appraisal Competency Factor";"HR Appraisal Competency Factor")
            {
                XmlName = 'HRAppraisalAssesmentFactors';
                fieldelement(VAppraisalNo;"HR Appraisal Competency Factor"."Appraisal No.")
                {
                }
                fieldelement(VLineNo;"HR Appraisal Competency Factor"."Line No.")
                {
                }
                fieldelement(VAssessmentFactor;"HR Appraisal Competency Factor"."Competency Factor")
                {
                }
                fieldelement(VScore15;"HR Appraisal Competency Factor".Score)
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

