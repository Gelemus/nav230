xmlport 50009 "HR Job Responsibilities Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("HR Job Responsibilities";"HR Job Responsibilities")
            {
                XmlName = 'HRJobResponsibilitiesImport';
                fieldelement(A;"HR Job Responsibilities"."Job No.")
                {
                }
                fieldelement(B;"HR Job Responsibilities"."Responsibility Code")
                {
                }
                fieldelement(C;"HR Job Responsibilities".Description)
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
        Message('Job Responsibilities Import completed!');
    end;
}

