table 50016 "Journal Voucher Header"
{

    fields
    {
        field(10;"JV No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Document date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Posting Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Date Created";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14;"User ID";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15;Status;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Reversed';
            OptionMembers = Open,"Pending Approval",Approved,Reversed;

            trigger OnValidate()
            begin
                /*IF Status = Status::Approved THEN BEGIN
                  IF FundsUserSetup.GET(USERID) THEN BEGIN
                  FundsUserSetup.TESTFIELD(FundsUserSetup."JV Template");
                  FundsUserSetup.TESTFIELD(FundsUserSetup."JV Batch");
                  JTemplate:=FundsUserSetup."JV Template";JBatch:=FundsUserSetup."JV Batch";
                  FundsManagement.PostJournalVoucher(Rec,JTemplate,JBatch,FALSE);
                 END;
                END;
                */

            end;
        }
        field(16;Description;Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(17;"JV Lines Cont";Integer)
        {
            CalcFormula = Count("Journal Voucher Lines" WHERE ("JV No."=FIELD("JV No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(18;"Total Amount";Decimal)
        {
            CalcFormula = Sum("Journal Voucher Lines".Amount WHERE ("JV No."=FIELD("JV No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24;"No. Series";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(25;Posted;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26;"Time Posted";Time)
        {
            DataClassification = ToBeClassified;
        }
        field(27;"Posted By";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(28;Reversed;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(29;"Reversal Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(30;"Reversal Time";Time)
        {
            DataClassification = ToBeClassified;
        }
        field(31;"Reversed By";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(32;"Total Debit";Decimal)
        {
            CalcFormula = Sum("Journal Voucher Lines"."Debit Amount" WHERE ("JV No."=FIELD("JV No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(33;"Total Credit";Decimal)
        {
            CalcFormula = Sum("Journal Voucher Lines"."Credit Amount" WHERE ("JV No."=FIELD("JV No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(34;"External Document No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(35;"Is Bill Adjustment";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(102;"Incoming Document Entry No.";Integer)
        {
            Caption = 'Incoming Document Entry No.';
            DataClassification = ToBeClassified;
        }
        field(103;Voted;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(104;"Budget GL";Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." WHERE ("Account Type"=CONST(Posting));
        }
        field(105;"Requires Voting";Option)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            OptionMembers = "   ",Yes,No;
        }
        field(106;Budget;Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name";
        }
    }

    keys
    {
        key(Key1;"JV No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        JvLines: Record "Journal Voucher Lines";
    begin
        JvLines.Reset;
        JvLines.SetRange("JV No.",Rec."JV No.");
        if JvLines.FindFirst then
          JvLines.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "JV No." = '' then begin
          FundsSetup.Get;
          FundsSetup.TestField(FundsSetup."JV Nos.");
          NoSeriesMgt.InitSeries(FundsSetup."JV Nos.",xRec."No. Series",0D,"JV No.","No. Series");
        end;

        "Document date":=Today;
        "User ID":=UserId;
        "Posting Date":=Today;
        Validate("User ID");
        BcSetup.Get;
        Budget:=BcSetup."Current Budget Code";
    end;

    var
        FundsSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FundsUserSetup: Record "Funds User Setup";
        FundsManagement: Codeunit "Funds Management";
        JTemplate: Code[30];
        JBatch: Code[30];
        BcSetup: Record "Budget Control Setup";
}

