xmlport 50003 "Tenant Applications II"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
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
        Message('Bank Statement Import completed!');
    end;
}

