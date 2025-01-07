xmlport 50130 "Tender Evaluation Cat Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(TenderEvaluationCategoryRoot)
        {
            tableelement("Evaluation Category";"Evaluation Category")
            {
                XmlName = 'TenderEvaluationCategory';
                fieldelement(LineNo;"Evaluation Category".LineNo)
                {
                }
                fieldelement(Category;"Evaluation Category".Category)
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

