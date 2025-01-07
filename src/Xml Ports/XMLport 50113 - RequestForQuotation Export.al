xmlport 50113 "RequestForQuotation Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(requesforquotationheaderroot)
        {
            XmlName = 'RequesForQuotationHeaderRoot';
            tableelement("Request for Quotation Header";"Request for Quotation Header")
            {
                XmlName = 'RequesForQuotationHeader';
                fieldelement(No;"Request for Quotation Header"."No.")
                {
                }
                fieldelement(RfqType;"Request for Quotation Header".Type)
                {
                }
                fieldelement(RfqDocDate;"Request for Quotation Header"."Document Date")
                {
                }
                fieldelement(ClosingDate;"Request for Quotation Header"."Closing Date")
                {
                }
                fieldelement(IssueDate;"Request for Quotation Header"."Issue Date")
                {
                }
                fieldelement(Amount;"Request for Quotation Header".Amount)
                {
                }
                fieldelement(RfqDesc;"Request for Quotation Header".Description)
                {
                }
                fieldelement(Status;"Request for Quotation Header".Status)
                {
                }
                fieldelement(UserId;"Request for Quotation Header"."User ID")
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

