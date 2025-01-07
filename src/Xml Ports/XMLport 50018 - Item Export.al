xmlport 50018 "Item Export"
{
    DefaultNamespace = 'urn:microsoft-dynamics-schemas/codeunit/FundManagementWS';
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(Itemroot)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement(Item;Item)
            {
                MinOccurs = Zero;
                XmlName = 'Item';
                fieldelement(No;Item."No.")
                {
                }
                fieldelement(Description;Item.Description)
                {
                }
                fieldelement(UOM;Item."Base Unit of Measure")
                {
                }
                fieldelement(Inventory;Item.Inventory)
                {
                }
                fieldelement(UnitPrice;Item."Unit Price")
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

