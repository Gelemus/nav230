xmlport 50061 "Import/Export Appr Objectives"
{
    // FieldDelimiter = '<None>';
    // FieldSeparator = '<TAB>';
    Format = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(HRAppraisalObjectivesRoot)
        {
            tableelement("HR Appraisal Objectives";"HR Appraisal Objectives")
            {
                XmlName = 'HRAppraisalObjectives';
                fieldelement(VAppraisalNo;"HR Appraisal Objectives"."Appraisal No.")
                {
                }
                fieldelement(VLineNo;"HR Appraisal Objectives"."Line No.")
                {
                }
                fieldelement(VAppraisalObjective;"HR Appraisal Objectives"."Appraisal Objective")
                {
                }
                fieldelement(VScore;"HR Appraisal Objectives".Score)
                {
                }
                fieldelement(VComments;"HR Appraisal Objectives".Comments)
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

