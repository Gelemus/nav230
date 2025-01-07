xmlport 50025 "Imprests Surr Export & Import"
{
    DefaultNamespace = 'urn:microsoft-dynamics-schemas/codeunit/FundManagementWS';
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(Imprestsurr)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement("Imprest Surrender Header";"Imprest Surrender Header")
            {
                MinOccurs = Zero;
                XmlName = 'ImprestSurrHeader';
                fieldelement(No;"Imprest Surrender Header"."No.")
                {
                }
                fieldelement(Imprestno;"Imprest Surrender Header"."Imprest No.")
                {
                }
                fieldelement(EmployeeNo;"Imprest Surrender Header"."Employee No.")
                {
                }
                fieldelement(EmployeeName;"Imprest Surrender Header"."Employee Name")
                {
                }
                fieldelement(Description;"Imprest Surrender Header".Description)
                {
                }
                fieldelement(Status;"Imprest Surrender Header".Status)
                {
                }
                fieldelement(DocumentType;"Imprest Surrender Header"."Document Type")
                {
                }
                fieldelement(DocumentName;"Imprest Surrender Header"."Document Name")
                {
                }
                tableelement("Imprest Surrender Line";"Imprest Surrender Line")
                {
                    LinkFields = "Document No."=FIELD("No.");
                    LinkTable = "Imprest Surrender Header";
                    MinOccurs = Zero;
                    XmlName = 'ImprestSurrLines';
                    fieldelement(DocumentNo;"Imprest Surrender Line"."Document No.")
                    {
                    }
                    fieldelement(LineNo;"Imprest Surrender Line"."Line No.")
                    {
                    }
                    fieldelement(ImprestCode;"Imprest Surrender Line"."Imprest Code")
                    {
                    }
                    fieldelement(Description;"Imprest Surrender Line"."Imprest Code Description")
                    {
                    }
                    fieldelement(Amount;"Imprest Surrender Line"."Gross Amount")
                    {
                    }
                    fieldelement(ActualSpent;"Imprest Surrender Line"."Actual Spent")
                    {
                    }
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

