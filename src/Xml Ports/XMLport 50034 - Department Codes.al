xmlport 50034 "Department Codes"
{
    DefaultNamespace = 'urn:microsoft-dynamics-schemas/codeunit/FundManagementWS';
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(DepartmentCodes)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement("Dimension Value";"Dimension Value")
            {
                MinOccurs = Zero;
                XmlName = 'DepartmentCodes';
                SourceTableView = WHERE("Global Dimension No."=CONST(3));
                fieldelement(Code;"Dimension Value".Code)
                {
                }
                fieldelement(Name;"Dimension Value".Name)
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

