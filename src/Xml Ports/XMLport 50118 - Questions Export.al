xmlport 50118 "Questions Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(QuestionRoot)
        {
            tableelement("Tender Questions";"Tender Questions")
            {
                XmlName = 'TenderQuestionsss';
                fieldelement(LineNo;"Tender Questions"."Line No")
                {
                }
                fieldelement(Question;"Tender Questions".Question)
                {
                }
                fieldelement(Status;"Tender Questions".Status)
                {
                }
                fieldelement(Description;"Tender Questions".Description)
                {
                }
                fieldelement(ParentID;"Tender Questions"."Parent ID")
                {
                }
                fieldelement(QuestionType;"Tender Questions"."Question Type")
                {
                }
                fieldelement(CatID;"Tender Questions"."Cat ID")
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

