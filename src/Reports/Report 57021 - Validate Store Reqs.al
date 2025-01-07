report 57021 "Validate Store Reqs"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Store Requisition Header";"Store Requisition Header")
        {

            trigger OnAfterGetRecord()
            begin
                "Store Requisition Header".Validate("Shortcut Dimension 4 Code");
            end;

            trigger OnPostDataItem()
            begin
                Message('validated');
            end;
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

    labels
    {
    }

    var
        StoreRequisitionHeaderREc: Record "Store Requisition Header";
}

