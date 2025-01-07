xmlport 50128 "Tender Evaluators Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(TenderEvaluatorRoot)
        {
            tableelement("Tender Evaluators";"Tender Evaluators")
            {
                XmlName = 'TenderEvaluators';
                fieldelement(LineNo;"Tender Evaluators"."Line No")
                {
                }
                fieldelement(TenderNo;"Tender Evaluators"."Tender No")
                {
                }
                fieldelement(Evaluator;"Tender Evaluators"."Evaluator No")
                {
                }
                fieldelement(EvaluatorName;"Tender Evaluators"."Evaluator Name")
                {
                }
                fieldelement(Email;"Tender Evaluators"."E-Mail")
                {
                }
                fieldelement(CommitteeChairperson;"Tender Evaluators"."Committee Chairperson")
                {
                }
                fieldelement(TenderOpening;"Tender Evaluators"."Tender Opening")
                {
                }
                fieldelement(TenderEvaluation;"Tender Evaluators".Evaluation)
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

