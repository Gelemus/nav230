xmlport 50112 "Supplier Profile Doc Export"
{
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(SupplierProfileDocRoot)
        {
            tableelement("Supplier Profile Documents";"Supplier Profile Documents")
            {
                XmlName = 'SupplierProfileDoc';
                fieldelement(EntryNo;"Supplier Profile Documents"."Entry No")
                {
                }
                fieldelement(ReferenceNo;"Supplier Profile Documents"."Reference No")
                {
                }
                fieldelement(FileName;"Supplier Profile Documents"."File Name")
                {
                }
                fieldelement(ActualFile;"Supplier Profile Documents"."Actual File")
                {
                }
                fieldelement(Type;"Supplier Profile Documents".Type)
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

