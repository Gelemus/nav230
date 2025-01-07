xmlport 50127 "TenderAnswers Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(TenderAnswersRoot)
        {
            tableelement("Tender Answers";"Tender Answers")
            {
                XmlName = 'TenderAnswers';
                fieldelement(LineNo;"Tender Answers"."Line No")
                {
                }
                fieldelement(Answer;"Tender Answers".Answer)
                {
                }
                fieldelement(DateCreated;"Tender Answers"."Date Created")
                {
                }
                fieldelement(DateUpdated;"Tender Answers"."Date Update")
                {
                }
                fieldelement(CreatedBy;"Tender Answers"."Created By")
                {
                }
                fieldelement(UpdatedBy;"Tender Answers"."Updated By")
                {
                }
                fieldelement(DocumentNo;"Tender Answers"."Document No")
                {
                }
                fieldelement(QuestionId;"Tender Answers"."Question ID")
                {
                }
                fieldelement(SupplyProfileId;"Tender Answers"."Supplier Profile ID")
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

