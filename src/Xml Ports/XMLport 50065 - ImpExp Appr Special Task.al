xmlport 50065 "Imp/Exp Appr Special Task"
{
    // FieldDelimiter = '<None>';
    // FieldSeparator = '<TAB>';
    Format = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(HRAppraisalSpecialTaskRoot)
        {
            tableelement("HR Appraisal Special Task";"HR Appraisal Special Task")
            {
                XmlName = 'HRAppraisalSpecialTask';
                fieldelement(VNo;"HR Appraisal Special Task"."No.")
                {
                }
                fieldelement(VLineNo;"HR Appraisal Special Task"."Line No.")
                {
                }
                fieldelement(VTask;"HR Appraisal Special Task".Task)
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

