xmlport 50058 "Import/Export Appr TraingCours"
{
    // FieldDelimiter = '<None>';
    // FieldSeparator = '<TAB>';
    Format = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(HRAppraisalCourseTrainingRoot)
        {
            tableelement("HR Appraisal Course/Training";"HR Appraisal Course/Training")
            {
                XmlName = 'HRAppraisalCourseTraining';
                fieldelement(VAppraisalNo;"HR Appraisal Course/Training"."Appraisal No.")
                {
                }
                fieldelement(VLineNo;"HR Appraisal Course/Training"."Line No.")
                {
                }
                fieldelement(VCourseTraining;"HR Appraisal Course/Training"."Course/Training")
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

