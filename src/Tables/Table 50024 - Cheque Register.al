table 50024 "Cheque Register"
{

    fields
    {
        field(10;"No.";Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11;"Document Date";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12;"Bank Account";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                "Bank Account Name":='';
                "Last Cheque No.":='';

                if BankAccount.Get("Bank Account") then
                  BankAccount.TestField(BankAccount."Last Check No.");
                  "Bank Account Name":=BankAccount.Name;
                  "Last Cheque No.":=BankAccount."Last Check No.";
            end;
        }
        field(13;"Bank Account Name";Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14;"Last Cheque No.";Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15;"Cheque Book Number";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16;"No of Leaves";Integer)
        {
            CalcFormula = Count("Cheque Register Lines" WHERE ("Document No."=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                /*"Cheque Number From":='';
                "Cheque Number To.":='';
                
                ChequeRegisterLines.RESET;
                ChequeRegisterLines.SETRANGE(ChequeRegisterLines."Document No.","No.");
                IF ChequeRegisterLines.FINDSET THEN BEGIN
                  ChequeRegisterLines.DELETEALL;
                END;
                
                
                
                EVALUATE(Leaves,"Last Cheque No.");
                
                "Cheque Number From":=INCSTR("Last Cheque No.");
                EVALUATE(Leaves,"Cheque Number From");
                //MESSAGE(FORMAT(Leaves));
                LastLeafNumber:=Leaves+"No of Leaves";
                //MESSAGE(FORMAT(LastLeafNumber));
                "Cheque Number To.":=FORMAT(LastLeafNumber);
                
                EVALUATE("Cheque Number To.", DELCHR(FORMAT("Cheque Number To."),'<=>',','));
                //MESSAGE("Cheque Number To.");
                
                
                
                IncrNo:="Cheque Number From";
                
                WHILE IncrNo<="Cheque Number To." DO BEGIN
                
                ChequeRegisterLines.INIT;
                ChequeRegisterLines."Document No.":="No.";
                ChequeRegisterLines."Cheque No.":=IncrNo;
                ChequeRegisterLines."Bank  Account No.":="Bank Account";
                ChequeRegisterLines.INSERT;
                
                IncrNo:=INCSTR(IncrNo);
                END;
                */

            end;
        }
        field(17;"Cheque Number From";Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                ChequeRegisterLines.Reset;
                ChequeRegisterLines.SetRange(ChequeRegisterLines."Document No.","No.");
                if ChequeRegisterLines.FindSet then begin
                  ChequeRegisterLines.DeleteAll;
                end;
            end;
        }
        field(18;"Cheque Number To.";Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Cheque Number From");
            end;
        }
        field(30;"Created By";Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(31;"No. Series";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(32;Status;Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted,Reversed';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted,Reversed;

            trigger OnValidate()
            begin
                ChequeRegisterLines.Reset;
                ChequeRegisterLines.SetRange(ChequeRegisterLines."Document No.","No.");
                if ChequeRegisterLines.FindSet then begin
                  repeat
                    ChequeRegisterLines.Status:=Status;
                    ChequeRegisterLines.Modify;
                  until ChequeRegisterLines.Next=0;
                end;
            end;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
          FundsSetup.Get;
          FundsSetup.TestField(FundsSetup."Imprest Surrender Nos.");
          NoSeriesMgt.InitSeries(FundsSetup."Imprest Surrender Nos.",xRec."No. Series",0D,"No.","No. Series");
        end;

        "Document Date":=Today;
        "Created By":=UserId;
    end;

    var
        FundsSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ChequeRegisterLines: Record "Cheque Register Lines";
        BankAccount: Record "Bank Account";
        Leaves: Decimal;
        IncrNo: Code[30];
        LastLeafNumber: Decimal;
}

