xmlport 50057 "Import/Export Appr Perf Factor"
{
    // FieldDelimiter = '<None>';
    // FieldSeparator = '<TAB>';
    Format = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(HRAppraisalPerformanceFactorsRoot)
        {
            tableelement("HR Appraisal Performance Facto";"HR Appraisal Performance Facto")
            {
                XmlName = 'HRAppraisalPerformanceFactors';
                fieldelement(VAppraisalNo;"HR Appraisal Performance Facto"."Appraisal No.")
                {
                }
                fieldelement(VLineNo;"HR Appraisal Performance Facto"."Line No.")
                {
                }
                fieldelement(VPerformanceFactor;"HR Appraisal Performance Facto"."Performance Factor")
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

