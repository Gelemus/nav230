xmlport 50131 "Tender Evaluation Heade Export"
{
    Caption = 'Tender Evaluation Criteria Export';
    UseDefaultNamespace = true;

    schema
    {
        textelement(TenderEvaluationHeadeRoot)
        {
            tableelement("Tender Evaluation";"Tender Evaluation")
            {
                XmlName = 'TenderEvaluationHeader';
                fieldelement(EvaluationNo;"Tender Evaluation"."Evaluation No.")
                {
                }
                fieldelement(TenderNo;"Tender Evaluation"."Tender No.")
                {
                }
                fieldelement(TenderDate;"Tender Evaluation"."Tender Date")
                {
                }
                fieldelement(TenderClosingDate;"Tender Evaluation"."Tender Close Date")
                {
                }
                fieldelement(EvaluationDate;"Tender Evaluation"."Evaluation Date")
                {
                }
                fieldelement(Supplier;"Tender Evaluation"."Supplier Name")
                {
                }
                fieldelement(SupplierProfileID;"Tender Evaluation"."Supplier Profile ID")
                {
                }
                fieldelement(Marks;"Tender Evaluation".Marks)
                {
                }
                fieldelement(DocumentDate;"Tender Evaluation"."Document Date")
                {
                }
                fieldelement(UserID;"Tender Evaluation"."User ID")
                {
                }
                fieldelement(EvaluationCriteria;"Tender Evaluation"."Evaluation Criteria")
                {
                }
                fieldelement(DocumentType;"Tender Evaluation"."Document Type")
                {
                }
                fieldelement(Eligibity;"Tender Evaluation".Eligibility)
                {
                }
                fieldelement(ApplicationNo;"Tender Evaluation"."Application No")
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

