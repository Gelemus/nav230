xmlport 50056 "Import/Export App Probl/Challe"
{
    // FieldDelimiter = '<None>';
    // FieldSeparator = '<TAB>';
    Format = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(HRAppraisalProblemsChallengesRoot)
        {
            tableelement("HR Appraisal Problems/Challeng";"HR Appraisal Problems/Challeng")
            {
                XmlName = 'HRAppraisalProblemsChallenges';
                fieldelement(VNo;"HR Appraisal Problems/Challeng"."No.")
                {
                }
                fieldelement(VLineNo;"HR Appraisal Problems/Challeng"."Line No.")
                {
                }
                fieldelement(VProblemChallenge;"HR Appraisal Problems/Challeng"."Problem/Challenge")
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

