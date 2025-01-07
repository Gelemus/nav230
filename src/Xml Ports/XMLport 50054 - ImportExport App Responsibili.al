xmlport 50054 "Import/Export App Responsibili"
{
    // FieldDelimiter = '<None>';
    // FieldSeparator = '<TAB>';
    Format = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(HRAppraisalRespDutiesRoot)
        {
            tableelement("HR Appraisal Resp/Duties";"HR Appraisal Resp/Duties")
            {
                XmlName = 'HRAppraisalRespDuties';
                fieldelement(VAppraisalCode;"HR Appraisal Resp/Duties"."Appraisal Code")
                {
                }
                fieldelement(VLineNo;"HR Appraisal Resp/Duties"."Line No.")
                {
                }
                fieldelement(VResponsibilityDuty;"HR Appraisal Resp/Duties"."Responsibility/Duty")
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

