xmlport 50002 "Tenant Applications"
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

