xmlport 50053 "Import/Export Appraisal Academ"
{
    //FieldDelimiter = '<None>';
    //FieldSeparator = '<TAB>';
    Format = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(HRAppraisalAcademicProfessioRoot)
        {
            tableelement("Hr Appraisal Academic/Prof Qua";"Hr Appraisal Academic/Prof Qua")
            {
                XmlName = 'HRAppraisalAcademicProfessio';
                fieldelement(VAppraisalCode;"Hr Appraisal Academic/Prof Qua"."Appraisal Code")
                {
                }
                fieldelement(VLineNo;"Hr Appraisal Academic/Prof Qua"."Line No.")
                {
                }
                fieldelement(VNameofInstitution;"Hr Appraisal Academic/Prof Qua"."Name of Institution")
                {
                }
                fieldelement(VQualificationAwarded;"Hr Appraisal Academic/Prof Qua"."Qualification Awarded")
                {
                }
                fieldelement(VPeriodOfStudy;"Hr Appraisal Academic/Prof Qua"."Period Of Study")
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

