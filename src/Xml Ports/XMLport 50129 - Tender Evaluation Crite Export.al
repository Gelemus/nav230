xmlport 50129 "Tender Evaluation Crite Export"
{
    Caption = 'Tender Evaluation Criteria Export';
    UseDefaultNamespace = true;

    schema
    {
        textelement(TenderEvaluationCriteriaRoot)
        {
            tableelement("Evaluation Criteria";"Evaluation Criteria")
            {
                XmlName = 'TenderEvaluationCriteria';
                fieldelement(Code;"Evaluation Criteria".Code)
                {
                }
                fieldelement(MaxScore;"Evaluation Criteria"."Max Score")
                {
                }
                fieldelement(Particulars;"Evaluation Criteria".Particulars)
                {
                }
                fieldelement(TenderNo;"Evaluation Criteria"."Tender No")
                {
                }
                fieldelement(CreatedBy;"Evaluation Criteria"."Created By")
                {
                }
                fieldelement(UpdatedBy;"Evaluation Criteria"."Updated By")
                {
                }
                fieldelement(DateCreated;"Evaluation Criteria"."Date Created")
                {
                }
                fieldelement(Status;"Evaluation Criteria".Status)
                {
                }
                fieldelement(DateUpdated;"Evaluation Criteria"."Date Updated")
                {
                }
                fieldelement(Description;"Evaluation Criteria".Description)
                {
                }
                fieldelement(Section;"Evaluation Criteria".Section)
                {
                }
                fieldelement(Category;"Evaluation Criteria"."Evaluation Category")
                {
                }
                fieldelement(Eligibity;"Evaluation Criteria".Eligibility)
                {
                }
                fieldelement(DocumentType;"Evaluation Criteria"."Document Type")
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

