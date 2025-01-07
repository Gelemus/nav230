xmlport 50008 "HR Job Qualification Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("HR Job Qualifications";"HR Job Qualifications")
            {
                XmlName = 'HRJobsQualificationstImport';
                fieldelement(A;"HR Job Qualifications"."Job No.")
                {
                }
                fieldelement(B;"HR Job Qualifications"."Qualification Code")
                {
                }
                fieldelement(C;"HR Job Qualifications".Description)
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

    trigger OnPostXmlPort()
    begin
        Message('Jobs Qualifications Import completed!');
    end;
}

