report 50216 "Procurement Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Procurement Report.rdl';

    dataset
    {
        dataitem("Purchase Requisitions"; "Purchase Requisitions")
        {
            DataItemTableView = WHERE(Status = FILTER(<> Open | Cancelled));
            column(No_PurchaseRequisitions; "Purchase Requisitions"."No.")
            {
            }
            column(DocumentDate_PurchaseRequisitions; "Purchase Requisitions"."Document Date")
            {
            }
            column(RequestedReceiptDate_PurchaseRequisitions; "Purchase Requisitions"."Requested Receipt Date")
            {
            }
            column(AmountLCY_PurchaseRequisitions; "Purchase Requisitions"."Amount(LCY)")
            {
            }
            column(Description_PurchaseRequisitions; "Purchase Requisitions".Description)
            {
            }
            column(GlobalDimension1Code_PurchaseRequisitions; "Purchase Requisitions"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_PurchaseRequisitions; "Purchase Requisitions"."Global Dimension 2 Code")
            {
            }
            column(Status_PurchaseRequisitions; "Purchase Requisitions".Status)
            {
            }
            column(PositionTitle_PurchaseRequisitions; "Purchase Requisitions"."Position Title")
            {
            }
            column(EmployeeName_PurchaseRequisitions; "Purchase Requisitions"."Employee Name")
            {
            }
            column(Signature_PurchaseRequisitions; "Purchase Requisitions".Signature)
            {
            }
            column(OrderNo_PurchaseRequisitions; "Purchase Requisitions"."Order No.")
            {
            }
            dataitem("Purchase Header"; "Purchase Header")
            {
                DataItemLink = "Purchase Requisition" = FIELD("No.");
                DataItemTableView = SORTING("Document Date") ORDER(Ascending);
                column(AmountIncludingVAT_PurchaseHeader; "Purchase Header"."Amount Including VAT")
                {
                }
                column(OrderDate_PurchaseHeader; "Purchase Header"."Order Date")
                {
                }
                column(DueDate_PurchaseHeader; "Purchase Header"."Due Date")
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

    labels
    {
    }
}

