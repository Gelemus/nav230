xmlport 50007 "HR Job Requirement Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("HR Job Requirements";"HR Job Requirements")
            {
                XmlName = 'HRJobsRequirementImport';
                fieldelement(A;"HR Job Requirements"."Job No.")
                {
                }
                fieldelement(B;"HR Job Requirements"."Requirement Code")
                {
                }
                fieldelement(C;"HR Job Requirements".Description)
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
        Message('Jobs Requirements Import completed!');
    end;
}

