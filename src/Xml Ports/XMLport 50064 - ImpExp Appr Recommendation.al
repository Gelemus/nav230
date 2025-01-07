xmlport 50064 "Imp/Exp Appr Recommendation"
{
    // FieldDelimiter = '<None>';
    // FieldSeparator = '<TAB>';
    Format = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(AppraisalRecommendation)
        {
            tableelement("HR Appraisal Recommendation";"HR Appraisal Recommendation")
            {
                XmlName = 'HRAppraisalRecommendation';
                fieldelement(VAppraisalNo;"HR Appraisal Recommendation"."Appraisal No.")
                {
                }
                fieldelement(VLineNo;"HR Appraisal Recommendation"."Line No.")
                {
                }
                fieldelement(VRecommendation;"HR Appraisal Recommendation".Recommendation)
                {
                }
                fieldelement(VReason;"HR Appraisal Recommendation".Reason)
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

