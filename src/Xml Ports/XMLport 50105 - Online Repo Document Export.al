xmlport 50105 "Online Repo Document Export"
{
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(OnlineRepoDocumentRoot)
        {
            tableelement("Online Repo Documents";"Online Repo Documents")
            {
                XmlName = 'OnlineRepoDocument';
                fieldelement(No;"Online Repo Documents"."Entry No")
                {
                }
                fieldelement(DocumentNo;"Online Repo Documents"."Document No")
                {
                }
                fieldelement(FileName;"Online Repo Documents"."File Name")
                {
                }
                fieldelement(ActualFile;"Online Repo Documents"."Actual File")
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

