xmlport 50016 "Imprests Export and Import"
{
    DefaultNamespace = 'urn:microsoft-dynamics-schemas/codeunit/FundManagementWS';
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(Imprest)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement("Imprest Header";"Imprest Header")
            {
                MinOccurs = Zero;
                XmlName = 'ImprestHeader';
                fieldelement(No;"Imprest Header"."No.")
                {
                }
                fieldelement(EmployeeNo;"Imprest Header"."Employee No.")
                {
                }
                fieldelement(EmployeeName;"Imprest Header"."Employee Name")
                {
                }
                fieldelement(Type;"Imprest Header".Type)
                {
                }
                fieldelement(Amount;"Imprest Header".Amount)
                {
                }
                fieldelement(FromDate;"Imprest Header"."Date From")
                {
                }
                fieldelement(ToDate;"Imprest Header"."Date To")
                {
                }
                fieldelement(Description;"Imprest Header".Description)
                {
                }
                fieldelement(Status;"Imprest Header".Status)
                {
                }
                fieldelement(posted;"Imprest Header".Posted)
                {
                }
                fieldelement(SurrenderStatus;"Imprest Header"."Surrender status")
                {
                }
                fieldelement(DocumentName;"Imprest Header"."Document Name")
                {
                }
                fieldelement(ProjectNo;"Imprest Header"."Project No")
                {
                }
                fieldelement(ProjectName;"Imprest Header"."Project Name")
                {
                }
                fieldelement(Department;"Imprest Header"."Global Dimension 2 Code")
                {
                }
                fieldelement(ImprestType;"Imprest Header"."Imprest Type")
                {
                }
                tableelement("Imprest Line";"Imprest Line")
                {
                    LinkFields = "Document No."=FIELD("No.");
                    LinkTable = "Imprest Header";
                    MinOccurs = Zero;
                    XmlName = 'ImprestLines';
                    fieldelement(DocumentNo;"Imprest Line"."Document No.")
                    {
                    }
                    fieldelement(LineNo;"Imprest Line"."Line No.")
                    {
                    }
                    fieldelement(ImprestCode;"Imprest Line"."Imprest Code")
                    {
                    }
                    fieldelement(Currency;"Imprest Line"."Currency Code")
                    {
                    }
                    fieldelement(City;"Imprest Line".City)
                    {
                    }
                    fieldelement(Quantity;"Imprest Line".Quantity)
                    {
                    }
                    fieldelement(UnitAmount;"Imprest Line"."Unit Amount")
                    {
                    }
                    fieldelement(Amount;"Imprest Line"."Gross Amount")
                    {
                    }
                    fieldelement(ImprestCodeDescription;"Imprest Line"."Imprest Code Description")
                    {
                    }
                    fieldelement(LineDescription;"Imprest Line".Description)
                    {
                    }
                    fieldelement(TaxAmount;"Imprest Line"."Tax Amount")
                    {
                    }
                    fieldelement(NetAmount;"Imprest Line"."Net Amount")
                    {
                    }
                    fieldelement(BankName;"Imprest Line"."Bank Name")
                    {
                    }
                    fieldelement(BankBranch;"Imprest Line"."Bank Branch")
                    {
                    }
                    fieldelement(BankAccountNo;"Imprest Line"."Bank A/C No.")
                    {
                    }
                    fieldelement(ActivityDate;"Imprest Line"."Activity Date")
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

