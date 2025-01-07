xmlport 50063 "Import/Expo Training NEed/Obje"
{
    // FieldDelimiter = '<None>';
    // FieldSeparator = '<TAB>';
    Format = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(AppraisalTrainingNeedObj)
        {
            tableelement("HR Appraisal Training Need &Ob";"HR Appraisal Training Need &Ob")
            {
                XmlName = 'HRAppraisalTrainingNeedOb';
                fieldelement(VAppraisalNo;"HR Appraisal Training Need &Ob"."Appraisal No.")
                {
                }
                fieldelement(VLineNo;"HR Appraisal Training Need &Ob"."Line No.")
                {
                }
                fieldelement(VTrainingNeedObjective;"HR Appraisal Training Need &Ob"."Training Need & Objective")
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

