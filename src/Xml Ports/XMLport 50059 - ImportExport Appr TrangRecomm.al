xmlport 50059 "Import/Export Appr TrangRecomm"
{
    // FieldDelimiter = '<None>';
    // FieldSeparator = '<TAB>';
    Format = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(HRAppraisalTrainingRecommendationsRoot)
        {
            tableelement("HR Appraisal Training Recommen";"HR Appraisal Training Recommen")
            {
                XmlName = 'HRAppraisalTrainingRecommendations';
                fieldelement(VAppraisalNo;"HR Appraisal Training Recommen"."Appraisal No.")
                {
                }
                fieldelement(VLineNo;"HR Appraisal Training Recommen"."Line No.")
                {
                }
                fieldelement(VTrainingRecommended;"HR Appraisal Training Recommen"."Training Recommended")
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

