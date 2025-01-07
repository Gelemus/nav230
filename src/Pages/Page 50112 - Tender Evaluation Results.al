page 50112 "Tender Evaluation Results"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Tender Evaluation Results";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field(Score; Rec.Score)
                {
                }
                field("Average"; Rec.Average)
                {
                }
                field(Position; Rec.Position)
                {
                }
                field("Drop Supplier"; Rec."Drop Supplier")
                {
                }
                field("Reason for Disqualification"; Rec."Reason for Disqualification")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Get Average Mark")
            {
                Image = BreakRulesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    TenderEvaluationResults.Reset;
                    TenderEvaluationResults.SetRange(TenderEvaluationResults."Tender No.", Rec."Tender No.");
                    TenderEvaluationResults.SetFilter(TenderEvaluationResults.Score, '<>%1', 0);
                    TenderEvaluationResults.SetFilter(TenderEvaluationResults."Count Evaluators", '<>%1', 0);
                    if TenderEvaluationResults.FindSet then begin
                        repeat
                            TenderEvaluationResults.CalcFields(TenderEvaluationResults.Score);
                            TenderEvaluationResults.CalcFields(TenderEvaluationResults."Count Evaluators");
                            TenderEvaluationResults.Average := (TenderEvaluationResults.Score / TenderEvaluationResults."Count Evaluators");
                            // MESSAGE(FORMAT(TenderEvaluationResults.Score));
                            // MESSAGE(FORMAT(TenderEvaluationResults."Count Evaluators"));
                            TenderEvaluationResults.Modify;
                        until TenderEvaluationResults.Next = 0;
                    end;

                    Commit;
                    Rec.Position := 1;
                    TenderEvaluationResults.Reset;
                    TenderEvaluationResults.SetRange("Tender No.", Rec."Tender No.");
                    TenderEvaluationResults.SetCurrentKey(Average);
                    TenderEvaluationResults.SetAscending(Average, false);
                    if TenderEvaluationResults.FindSet then begin
                        ProgressWindow.Open('Ranking for Supplier no. #1#######');
                        repeat
                            TenderEvaluationResults.Position := Rec.Position;
                            TenderEvaluationResults.Modify;
                            Rec.Position := Rec.Position + 1;
                            ProgressWindow.Update(1, TenderEvaluationResults."Supplier Name");
                        until TenderEvaluationResults.Next = 0;
                    end;
                    ProgressWindow.Close;

                    Message('Complete!');
                end;
            }
        }
    }

    var
        TenderEvaluationLine: Record "Tender Evaluation Line";
        TenderEvaluationResults: Record "Tender Evaluation Results";
        ProgressWindow: Dialog;
}

