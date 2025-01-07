xmlport 50006 "HR Job Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("HR Jobs";"HR Jobs")
            {
                XmlName = 'HRJobsImport';
                fieldelement(A;"HR Jobs"."No.")
                {
                }
                fieldelement(B;"HR Jobs"."Job Title")
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
        Message('Job Import completed!');
    end;
}

