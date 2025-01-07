xmlport 50121 "TenderQuestions Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(TenderQuestionsRoot)
        {
            tableelement("Tender Questions";"Tender Questions")
            {
                XmlName = 'TenderQuestions';
                fieldelement(LineNo;"Tender Questions"."Line No")
                {
                }
                fieldelement(QuestionType;"Tender Questions"."Quest type")
                {
                }
                fieldelement(Question;"Tender Questions".Question)
                {
                }
                fieldelement(Value;"Tender Questions".Description)
                {
                }
                fieldelement(Status;"Tender Questions".Status)
                {
                }
                fieldelement(Description;"Tender Questions".Description)
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

