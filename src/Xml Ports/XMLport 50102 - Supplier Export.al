xmlport 50102 "Supplier Export"
{
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(SupplierRoot)
        {
            tableelement(Vendor;Vendor)
            {
                XmlName = 'Supplier';
                fieldelement(No;Vendor."No.")
                {
                }
                fieldelement(Name;Vendor.Name)
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

