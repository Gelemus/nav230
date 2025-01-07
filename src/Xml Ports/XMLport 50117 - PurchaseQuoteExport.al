xmlport 50117 PurchaseQuoteExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(purchasequotheaderroot)
        {
            XmlName = 'PurchaseQuotHeaderRoot';
            tableelement("Purchase Header";"Purchase Header")
            {
                XmlName = 'PurchaseQuotHeader';
                fieldelement(VendorName;"Purchase Header"."Buy-from Vendor No.")
                {
                }
                fieldelement(RfqCode;"Purchase Header"."Request for Quotation Code")
                {
                }
                fieldelement(QuoteDesc;"Purchase Header"."Quote Description")
                {
                }
                fieldelement(DocumentType;"Purchase Header"."Document Type")
                {
                }
                fieldelement(DocumentDate;"Purchase Header"."Document Date")
                {
                }
                fieldelement(No;"Purchase Header"."No.")
                {
                }
                fieldelement(OrderDate;"Purchase Header"."Order Date")
                {
                }
                fieldelement(RequestedReceiptDate;"Purchase Header"."Requested Receipt Date")
                {
                }
                fieldelement(QuoteStatus;"Purchase Header".Status)
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

