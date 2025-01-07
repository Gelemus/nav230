xmlport 50107 "Tender Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(TenderHeaderRoot)
        {
            tableelement("Tender Header";"Tender Header")
            {
                XmlName = 'TenderHeader';
                fieldelement(No;"Tender Header"."No.")
                {
                }
                fieldelement(TenderDescription;"Tender Header"."Tender Description")
                {
                }
                fieldelement(TenderSubmissionFrom;"Tender Header"."Tender Submission (From)")
                {
                }
                fieldelement(TenderSubmissionTo;"Tender Header"."Tender Submission (To)")
                {
                }
                fieldelement(TenderStatus;"Tender Header"."Tender Status")
                {
                }
                fieldelement(DocumentDate;"Tender Header"."Document Date")
                {
                }
                fieldelement(UserId;"Tender Header"."User ID")
                {
                }
                fieldelement(TenderClosingDate;"Tender Header"."Tender Closing Date")
                {
                }
                fieldelement(EvaluationDate;"Tender Header"."Evaluation Date")
                {
                }
                fieldelement(SupplierAwarded;"Tender Header"."Supplier Awarded")
                {
                }
                fieldelement(SupplierName;"Tender Header"."Supplier Name")
                {
                }
                fieldelement(PurchaseRequisition;"Tender Header"."Purchase Requisition")
                {
                }
                fieldelement(PurchaseReqDescription;"Tender Header"."Purchase Req. Description")
                {
                }
                fieldelement(TenderClosedBy;"Tender Header"."Tender closed by")
                {
                }
                fieldelement(SupplierCategory;"Tender Header"."Supplier Category")
                {
                }
                fieldelement(SupplierCategoryDescription;"Tender Header"."Supplier Category Description")
                {
                }
                fieldelement(Status;"Tender Header".Status)
                {
                }
                fieldelement(TenderPreparationApproved;"Tender Header"."Tender Preparation Approved")
                {
                }
                fieldelement(HeldBy;"Tender Header"."Held By")
                {
                }
                fieldelement(TenderClosingTime;"Tender Header"."Tender Closing Time")
                {
                }
                fieldelement(TenderOpeningTime;"Tender Header"."Tender Opening Time")
                {
                }
                fieldelement(TenderOpeningDate;"Tender Header"."Tender Opening Date")
                {
                }
                fieldelement(SpecialGroup;"Tender Header"."Special Group")
                {
                }
                fieldelement(TenderNo;"Tender Header"."Tender No")
                {
                }
                fieldelement(SpecialCondition;"Tender Header"."Special Condition")
                {
                }
                fieldelement(TypeOfSupply;"Tender Header"."Type of supply")
                {
                }
                fieldelement(DocumentType;"Tender Header"."Document Type")
                {
                }
                fieldelement(FinancialYearStartDate;"Tender Header"."Financial Year Start Date")
                {
                }
                fieldelement(FinancialYearEndDate;"Tender Header"."Financial Year End Date")
                {
                }
                fieldelement(AwardDate;"Tender Header"."Award Date")
                {
                }
                fieldelement(Eligibility;"Tender Header".Eligibility)
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

