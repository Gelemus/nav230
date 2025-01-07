xmlport 50114 "RequestForQuotationLine Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(requesforquotationlineroot)
        {
            XmlName = 'RequesForQuotationLineRoot';
            tableelement("Request for Quotation Line";"Request for Quotation Line")
            {
                XmlName = 'RequestForQuotationLine';
                fieldelement(LineNo;"Request for Quotation Line"."Line No.")
                {
                }
                fieldelement(DocNo;"Request for Quotation Line"."Document No.")
                {
                }
                fieldelement(RfqDocDate;"Request for Quotation Line"."Document Date")
                {
                }
                fieldelement(RfqRequisitionType;"Request for Quotation Line"."Requisition Type")
                {
                }
                fieldelement(RfqUnitOfMeasure;"Request for Quotation Line"."Unit of Measure Code")
                {
                }
                fieldelement(RfqDesc;"Request for Quotation Line".Description)
                {
                }
                fieldelement(RfqPurchaseRequisition;"Request for Quotation Line"."Purchase Requisition No.")
                {
                }
                fieldelement(Status;"Request for Quotation Line".Status)
                {
                }
                fieldelement(RfqQuantity;"Request for Quotation Line"."Unit of Measure Code")
                {
                }
                fieldelement(TotalCost;"Request for Quotation Line"."Total Cost")
                {
                }
                fieldelement(UnitCost;"Request for Quotation Line"."Unit Cost")
                {
                }
                fieldelement(Type;"Request for Quotation Line".Type)
                {
                }
                fieldelement(Code;"Request for Quotation Line"."Requisition Code")
                {
                }
                fieldelement(No;"Request for Quotation Line"."No.")
                {
                }
                fieldelement(Name;"Request for Quotation Line".Name)
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

