xmlport 50095 ProjectStoreReqExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(ProjectStoreRoot)
        {
            tableelement("Store Requisition Header";"Store Requisition Header")
            {
                XmlName = 'ProjectStore';
                fieldelement(StoreReqNo;"Store Requisition Header"."No.")
                {
                }
                fieldelement(ProjectNo;"Store Requisition Header"."Project No")
                {
                }
                fieldelement(RequiredDate;"Store Requisition Header"."Required Date")
                {
                }
                fieldelement(PostingDate;"Store Requisition Header"."Posting Date")
                {
                }
                fieldelement(Description;"Store Requisition Header".Description)
                {
                }
                fieldelement(UnitCode;"Store Requisition Header"."Global Dimension 2 Code")
                {
                }
                fieldelement(ZoneCode;"Store Requisition Header"."Shortcut Dimension 4 Code")
                {
                }
                fieldelement(Status;"Store Requisition Header".Status)
                {
                }
                fieldelement(Amount;"Store Requisition Header"."Cost Amount")
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

