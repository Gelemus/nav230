xmlport 50060 "Import/Export ApprPerfSugg"
{
    // FieldDelimiter = '<None>';
    // FieldSeparator = '<TAB>';
    Format = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(HRAppraisalPerformanceSuggestionRoot)
        {
            tableelement("Hr Appraisal Performace Sugge";"Hr Appraisal Performace Sugge")
            {
                XmlName = 'HRAppraisalPerformanceSuggestion';
                fieldelement(VAppraisalNo;"Hr Appraisal Performace Sugge"."Appraisal No.")
                {
                }
                fieldelement(VLineNo;"Hr Appraisal Performace Sugge"."Line No.")
                {
                }
                fieldelement(VSuggestion;"Hr Appraisal Performace Sugge".Suggestion)
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

