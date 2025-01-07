xmlport 50104 "Online Repo Category Export"
{
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(OnlineRepoCategoryRoot)
        {
            tableelement("Online Repo Category";"Online Repo Category")
            {
                XmlName = 'OnlineRepoCategory';
                fieldelement(No;"Online Repo Category".No)
                {
                }
                fieldelement(Name;"Online Repo Category".Name)
                {
                }
                fieldelement(Description;"Online Repo Category".Description)
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

