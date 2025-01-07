xmlport 50017 "Store Requisition Export"
{
    DefaultNamespace = 'urn:microsoft-dynamics-schemas/codeunit/FundManagementWS';
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(Store)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement("Store Requisition Header";"Store Requisition Header")
            {
                MinOccurs = Zero;
                XmlName = 'StoreReqHeader';
                SourceTableView = WHERE(Status=FILTER(Open|"Pending Approval"|Approved|Posted));
                fieldelement(No;"Store Requisition Header"."No.")
                {
                }
                fieldelement(EmployeeNo;"Store Requisition Header"."Employee No.")
                {
                }
                fieldelement(RequiredDate;"Store Requisition Header"."Required Date")
                {
                }
                fieldelement(Description;"Store Requisition Header".Description)
                {
                }
                fieldelement(DocumentDate;"Store Requisition Header"."Document Date")
                {
                }
                fieldelement(Status;"Store Requisition Header".Status)
                {
                }
                textelement(EmployeeName)
                {
                }
                fieldelement(Template;"Store Requisition Header".Template)
                {
                }
                fieldelement(Department;"Store Requisition Header"."Global Dimension 1 Code")
                {
                }
                fieldelement(DocumentName;"Store Requisition Header"."Document Name")
                {
                }
                fieldelement(ProjectNo;"Store Requisition Header"."Project No")
                {
                }
                fieldelement(ProjectName;"Store Requisition Header"."Project Name")
                {
                }
                fieldelement(CustomerNo;"Store Requisition Header"."Customer No")
                {
                }
                fieldelement(CustomerName;"Store Requisition Header"."Customer Name")
                {
                }
                fieldelement(CostAmount;"Store Requisition Header"."Total Sale Amount")
                {
                }
                tableelement("Store Requisition Line";"Store Requisition Line")
                {
                    LinkFields = "Document No."=FIELD("No.");
                    LinkTable = "Store Requisition Header";
                    MinOccurs = Zero;
                    XmlName = 'StoreReqLines';
                    fieldelement(DocumentNo;"Store Requisition Line"."Document No.")
                    {
                    }
                    fieldelement(LineNo;"Store Requisition Line"."Line No.")
                    {
                    }
                    fieldelement(Type;"Store Requisition Line".Type)
                    {
                    }
                    fieldelement(ItemNo;"Store Requisition Line"."Item No.")
                    {
                    }
                    fieldelement(Description;"Store Requisition Line".Description)
                    {
                    }
                    fieldelement(Inventory;"Store Requisition Line".Inventory)
                    {
                    }
                    fieldelement(Quantity;"Store Requisition Line".Quantity)
                    {
                    }
                    fieldelement(UnitCost;"Store Requisition Line"."Total Sale Amount")
                    {
                    }
                    fieldelement(LineAmount;"Store Requisition Line"."Total Sale Amount")
                    {
                    }
                    fieldelement(Location;"Store Requisition Line"."Location Code")
                    {
                    }
                    fieldelement(zone;"Store Requisition Line"."Shortcut Dimension 4 Code")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if Employee.Get("Store Requisition Header"."Employee No.") then
                      EmployeeName:=Employee."Full Name";
                end;
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

    var
        Employee: Record Employee;
}

