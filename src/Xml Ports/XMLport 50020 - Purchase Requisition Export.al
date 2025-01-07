xmlport 50020 "Purchase Requisition Export"
{
    DefaultNamespace = 'urn:microsoft-dynamics-schemas/codeunit/FundManagementWS';
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(PurchaseRequisition)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement("Purchase Requisitions";"Purchase Requisitions")
            {
                MinOccurs = Zero;
                XmlName = 'PurchaseReqHeader';
                fieldelement(No;"Purchase Requisitions"."No.")
                {
                }
                fieldelement(EmployeeNo;"Purchase Requisitions"."Employee No.")
                {
                }
                fieldelement(RequiredDate;"Purchase Requisitions"."Requested Receipt Date")
                {
                }
                fieldelement(Description;"Purchase Requisitions".Description)
                {
                }
                fieldelement(DocumentDate;"Purchase Requisitions"."Document Date")
                {
                }
                fieldelement(Status;"Purchase Requisitions".Status)
                {
                }
                fieldelement(Amount;"Purchase Requisitions".Amount)
                {
                }
                fieldelement(Department;"Purchase Requisitions"."Global Dimension 2 Code")
                {
                }
                fieldelement(ProjectNo;"Purchase Requisitions"."Project No")
                {
                }
                fieldelement(projectName;"Purchase Requisitions"."Project Name")
                {
                }
                fieldelement(DocumentName;"Purchase Requisitions"."Document Name")
                {
                }
                tableelement("Purchase Requisition Line";"Purchase Requisition Line")
                {
                    LinkFields = "Document No."=FIELD("No.");
                    LinkTable = "Purchase Requisitions";
                    MinOccurs = Zero;
                    XmlName = 'PurchaseReqLines';
                    fieldelement(DocumentNo;"Purchase Requisition Line"."Document No.")
                    {
                    }
                    fieldelement(LineNo;"Purchase Requisition Line"."Line No.")
                    {
                    }
                    fieldelement(ReqType;"Purchase Requisition Line"."Requisition Type")
                    {
                    }
                    fieldelement(No;"Purchase Requisition Line"."No.")
                    {
                    }
                    fieldelement(Name;"Purchase Requisition Line".Name)
                    {
                    }
                    fieldelement(Description;"Purchase Requisition Line".Description)
                    {
                    }
                    fieldelement(Quantity;"Purchase Requisition Line".Quantity)
                    {
                    }
                    fieldelement(UnitCost;"Purchase Requisition Line"."Unit Cost")
                    {
                    }
                    fieldelement(TotalAmount;"Purchase Requisition Line"."Total Cost")
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

