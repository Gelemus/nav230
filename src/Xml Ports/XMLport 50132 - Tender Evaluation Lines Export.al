xmlport 50132 "Tender Evaluation Lines Export"
{
    Caption = 'Tender Evaluation Criteria Export';
    UseDefaultNamespace = true;

    schema
    {
        textelement(TenderEvaluationLinesRoot)
        {
            tableelement("Tender Evaluation Line";"Tender Evaluation Line")
            {
                XmlName = 'TenderEvaluationLines';
                fieldelement(DocumentNo;"Tender Evaluation Line"."Document No.")
                {
                }
                fieldelement(MaxScore;"Tender Evaluation Line"."Max Score")
                {
                }
                fieldelement(Requirement;"Tender Evaluation Line".Requirements)
                {
                }
                fieldelement(Marks;"Tender Evaluation Line".Marks)
                {
                }
                fieldelement(Comments;"Tender Evaluation Line".Comments)
                {
                }
                fieldelement(EvaluationCategory;"Tender Evaluation Line"."Evaluation Category")
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

