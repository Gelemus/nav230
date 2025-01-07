codeunit 50047 "Risk Management"
{

    trigger OnRun()
    begin
    end;

    var
        RiskHeader: Record "Contract Request Header";
        TotalAggregate: Decimal;
        RiskCount: Integer;
        RiskHeader2: Record "Contract Request Header";
        TotalAggregate2: Decimal;

    procedure CalculateAggregateScoreFormula(RiskAssessmentPlan: Record "Contract Setup") AggregatedScore: Decimal
    begin
        /*TotalAggregate:=0;
        CASE RiskAssessmentPlan."Aggregated Score Formula" OF
          RiskAssessmentPlan."Aggregated Score Formula"::"0":
            BEGIN
              AggregatedScore:=0;
            END
        END;
        //straight average
        CASE RiskAssessmentPlan."Aggregated Score Formula" OF
          RiskAssessmentPlan."Aggregated Score Formula"::"1":
            BEGIN
              RiskHeader.RESET;
              RiskHeader.SETRANGE(Objective,RiskAssessmentPlan.Objective);
              IF RiskHeader.FINDSET THEN BEGIN
                RiskCount:=RiskHeader.COUNT;
                REPEAT
                 TotalAggregate:=TotalAggregate+RiskHeader."Risk Residue";
                UNTIL RiskHeader.NEXT=0;
                 AggregatedScore:=TotalAggregate/RiskCount;
              END;
            END;
        END;
        
        //weighted average
        CASE RiskAssessmentPlan."Aggregated Score Formula" OF
          RiskAssessmentPlan."Aggregated Score Formula"::"2":
            BEGIN
              RiskHeader.RESET;
              RiskHeader.SETRANGE(Objective,RiskAssessmentPlan.Objective);
              IF RiskHeader.FINDSET THEN BEGIN
                RiskCount:=RiskHeader.COUNT;
                REPEAT
                 TotalAggregate:=TotalAggregate+RiskHeader."Risk Residue";
                UNTIL RiskHeader.NEXT=0;
              END;
              TotalAggregate2:=0;
              RiskHeader2.RESET;
              RiskHeader2.SETRANGE(Objective,RiskAssessmentPlan.Objective);
              IF RiskHeader2.FINDSET THEN BEGIN
                REPEAT
                 TotalAggregate2:=TotalAggregate2+(RiskHeader2."Risk Residue"*RiskHeader2."Risk Residue")/TotalAggregate;
                UNTIL RiskHeader2.NEXT=0;
              END;
              AggregatedScore:=TotalAggregate2;
            END;
        END;
        
        //sum
        CASE RiskAssessmentPlan."Aggregated Score Formula" OF
          RiskAssessmentPlan."Aggregated Score Formula"::"3":
            BEGIN
              RiskHeader.RESET;
              RiskHeader.SETRANGE(Objective,RiskAssessmentPlan.Objective);
              IF RiskHeader.FINDSET THEN BEGIN
                REPEAT
                 TotalAggregate:=TotalAggregate+RiskHeader."Risk Residue";
                UNTIL RiskHeader.NEXT=0;
                 AggregatedScore:=TotalAggregate;
              END;
            END;
        END;
        */

    end;
}

