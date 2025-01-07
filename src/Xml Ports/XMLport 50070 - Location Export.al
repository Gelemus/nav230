xmlport 50070 "Location Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(LocationRoot)
        {
            tableelement(Location;Location)
            {
                XmlName = 'Locationion';
                fieldelement(Code;Location.Code)
                {
                }
                fieldelement(Name;Location.Name)
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

