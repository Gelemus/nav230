table 50058 "Tender Evaluation"
{

    fields
    {
        field(10;"Evaluation No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Tender No.";Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tender Header"."No." WHERE ("Tender Status"=FILTER("Tender Evaluation"));

            trigger OnValidate()
            begin
                
                TestField(Status,Status::Open);
                if "Evaluation No." = '' then begin
                  "Purchases&PayablesSetup".Get;
                  "Purchases&PayablesSetup".TestField("Purchases&PayablesSetup"."Tender Evaluation No.");
                  "Evaluation No.":=NoSeriesMgt.GetNextNo("Purchases&PayablesSetup"."Tender Evaluation No.",Today,true);
                  //NoSeriesMgt.InitSeries("Purchases&PayablesSetup"."Tender Evaluation No.",xRec."No. Series",0D,"Evaluation No.","No. Series");
                end;
                "Tender Date":=0D;
                "Tender Close Date":=0D;
                
                
                TenderEvaluationLine.Reset;
                TenderEvaluationLine.SetRange(TenderEvaluationLine."Document No.","Evaluation No.");
                if TenderEvaluationLine.FindSet then begin
                  TenderEvaluationLine.DeleteAll;
                end;
                /*
                TenderEvaluators.RESET;
                TenderEvaluators.SETRANGE(TenderEvaluators."Tender No","Tender No.");
                TenderEvaluators.SETRANGE(TenderEvaluators."User ID","User ID");
                IF NOT TenderEvaluators.FINDFIRST THEN
                  ERROR(Txt10002);
                  */
                
                TenderHeader.Reset;
                TenderHeader.SetRange(TenderHeader."No.","Tender No.");
                if TenderHeader.FindFirst then begin
                  "Tender Date":=TenderHeader."Tender Submission (From)";
                  "Tender Close Date":=TenderHeader."Tender Closing Date";
                  end;
                
                /*TenderQuestions.RESET;
                TenderQuestions.SETRANGE(TenderQuestions."Tender No.","Tender No.");
                IF TenderQuestions.FINDSET THEN BEGIN
                  REPEAT
                    LineNo:=LineNo+1;
                    TenderEvaluationLine.INIT;
                    TenderEvaluationLine."Line No.":=LineNo;
                    TenderEvaluationLine."Document No.":="Evaluation No.";
                    TenderEvaluationLine."Tender No.":=TenderQuestions."Tender No.";
                    TenderEvaluationLine.Question:=TenderQuestions.Question;
                    TenderEvaluationLine.Marks:=TenderQuestions.Marks;
                    TenderEvaluationLine.INSERT
                  UNTIL TenderQuestions.NEXT=0;
                END;
                */
                
                TenderLines.Reset;
                TenderLines.SetRange("Document No.","Tender No.");
                TenderLines.SetRange(Disqualified,false);
                if TenderLines.FindSet then begin
                 repeat
                  TenderEvaluators.Reset;
                  TenderEvaluators.SetRange(TenderEvaluators."Tender No","Tender No.");
                  if TenderEvaluators.FindSet then begin
                    repeat
                      LineNo:=LineNo+1;
                      TenderEvaluationLine.Init;
                      TenderEvaluationLine."Line No.":=LineNo;
                      TenderEvaluationLine."Document No.":="Evaluation No.";
                      TenderEvaluationLine."Tender No.":=TenderEvaluators."Tender No";
                      TenderEvaluationLine."Supplier Name":=TenderLines."Supplier Name";
                      TenderEvaluationLine.Evaluator:=TenderEvaluators."Evaluator No";
                      TenderEvaluationLine."Evaluator Name":=TenderEvaluators."Evaluator Name";
                      TenderEvaluationLine."Evaluator User ID":=TenderEvaluators."User ID";
                      TenderEvaluationLine.Insert
                    until TenderEvaluators.Next=0;
                  end;
                  until TenderLines.Next=0;
                end;

            end;
        }
        field(12;"Tender Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Tender Close Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Evaluation Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15;Supplier;Text[80])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tender Lines"."Supplier Name" WHERE ("Document No."=FIELD("Tender No."));

            trigger OnValidate()
            begin
                TestField("Tender No.");
            end;
        }
        field(16;Marks;Decimal)
        {
            CalcFormula = Sum("Tender Evaluation Line"."Marks Assigned" WHERE ("Document No."=FIELD("Evaluation No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(19;"Document Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(30;"No. Series";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(31;"User ID";Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32;Status;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Submitted';
            OptionMembers = Open,"Pending Approval",Approved,Submitted;
        }
        field(33;"Evaluation Criteria";Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Lookup Values".Code WHERE (Type=CONST("Tender Criteria"));

            trigger OnValidate()
            begin
                TestField("Tender No.");

                TenderEvaluation.Reset;
                //TenderEvaluation.SETRANGE(TenderEvaluation."Evaluation No.","Evaluation No.");
                TenderEvaluation.SetRange(TenderEvaluation."Tender No.","Tender No.");
                TenderEvaluation.SetRange(TenderEvaluation."User ID","User ID");
                TenderEvaluation.SetRange(TenderEvaluation."Evaluation Criteria","Evaluation Criteria");
                if TenderEvaluation.FindFirst then
                  Error(Text10001,TenderEvaluation."Evaluation No.");
            end;
        }
        field(34;"Document Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Registration of Supplier,Open Tender,Request for Proposal';
            OptionMembers = " ","Registration of Supplier","Open Tender","Request for Proposal";
        }
        field(35;Eligibility;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Reserved for Special group';
            OptionMembers = Open,"Reserved for Special group";
        }
        field(36;"Application No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tender Lines";
        }
        field(37;"Supplier Profile ID";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(38;"Supplier Name";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(39;"Evaluator Name";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(40;"Employee No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                EmployeeRec.Get("Employee No");
                "User ID" := EmployeeRec."User ID";
            end;
        }
    }

    keys
    {
        key(Key1;"Evaluation No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Evaluation No." = '' then begin
          "Purchases&PayablesSetup".Get;
          "Purchases&PayablesSetup".TestField("Purchases&PayablesSetup"."Tender Evaluation No.");
          NoSeriesMgt.InitSeries("Purchases&PayablesSetup"."Tender Evaluation No.",xRec."No. Series",0D,"Evaluation No.","No. Series");
        end;

        "Evaluation Date":=Today;
        "Document Date":=Today;
        "User ID":=UserId;
    end;

    var
        "Purchases&PayablesSetup": Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TenderHeader: Record "Tender Header";
        TenderLines: Record "Tender Lines";
        TenderEvaluationLine: Record "Tender Evaluation Line";
        TenderQuestions: Record "Tender Evaluation Results";
        LineNo: Integer;
        TenderEvaluators: Record "Tender Evaluators";
        TenderEvaluation: Record "Tender Evaluation";
        Text10001: Label 'The evaluation criteria has already been used in tender evaluation %1';
        Txt10002: Label 'You are not part of the evaluation Committe for this tender. Consult Procurement!';
        EmployeeRec: Record Employee;
}

