table 50044 "Tender Evaluators"
{

    fields
    {
        field(9;"Line No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(10;"Tender No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Evaluator No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if HREmployee.Get("Evaluator No") then
                  "Evaluator Name":=HREmployee."First Name"+' '+HREmployee."Middle Name"+' '+HREmployee."Last Name";
                  "User ID":=HREmployee."User ID";
                  "E-Mail":=HREmployee."E-Mail";
                  if HREmployee."E-Mail"='' then
                    "E-Mail":=HREmployee."Company E-Mail";
            end;
        }
        field(12;"Evaluator Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13;"User ID";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(14;"E-Mail";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Committee Chairperson";Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                TenderEvaluators.Reset;
                TenderEvaluators.SetRange("Tender No","Tender No");
                TenderEvaluators.SetRange("Committee Chairperson",true);
                if TenderEvaluators.FindSet then begin
                  repeat
                  TenderEvaluators."Committee Chairperson":=false;
                  TenderEvaluators.Modify;
                  until TenderEvaluators.Next=0;
                end;


                "Committee Chairperson":=true;
            end;
        }
        field(16;"Tender Opening";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17;Evaluation;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18;"Date Created";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19;"Date Updated";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20;"Updated By";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(21;"Created By";Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Tender No","Line No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        HREmployee: Record Employee;
        TenderEvaluators: Record "Tender Evaluators";
        Txt10001: Label 'You cannot have two people having the Chaiperson role. Thank you!';
}

