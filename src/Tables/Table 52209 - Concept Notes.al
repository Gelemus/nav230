table 52209 "Concept Notes"
{
    Caption = 'Concept Notes';

    fields
    {
        field(1;"Line No.";Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(2;"Document No.";Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
            TableRelation = "Transport Request"."Request No." WHERE ("Document Type"=CONST("Concept Design"));
        }
        field(3;"Document Type";Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender";
        }
        field(4;Date;Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Concept Note";Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Line No.","Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //TestStatusOpen(TRUE);
    end;

    trigger OnInsert()
    begin
        /*ImprestHeader.RESET;
        ImprestHeader.SETRANGE(ImprestHeader."No.","Document No.");
        IF ImprestHeader.FINDFIRST THEN BEGIN
          ImprestHeader.TESTFIELD("Date From");
          ImprestHeader.TESTFIELD("Date To");
          Description:=ImprestHeader.Description;
          "Document Type":="Document Type"::Imprest;
          "Posting Date":=ImprestHeader."Posting Date";
          "Currency Code":=ImprestHeader."Currency Code";
          "Currency Factor":=ImprestHeader."Currency Factor";
          "Global Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
          "Global Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
          "Shortcut Dimension 3 Code":=ImprestHeader."Shortcut Dimension 3 Code";
          "Shortcut Dimension 4 Code":=ImprestHeader."Shortcut Dimension 4 Code";
          "Shortcut Dimension 5 Code":=ImprestHeader."Shortcut Dimension 5 Code";
          "Shortcut Dimension 6 Code":=ImprestHeader."Shortcut Dimension 6 Code";
          "Shortcut Dimension 7 Code":=ImprestHeader."Shortcut Dimension 7 Code";
          "Shortcut Dimension 8 Code":=ImprestHeader."Shortcut Dimension 8 Code";
          "HR Job Grade":=ImprestHeader."HR Job Grade";
          "Employee No":=ImprestHeader."Employee No.";
          Quantity:=ImprestHeader."Date To"-ImprestHeader."Date From";
          IF Quantity=0 THEN
            Quantity:=1;
        
        END;*/

    end;

    var
        FundsTransactionCodes: Record "Funds Transaction Code";
        FundsTaxCodes: Record "Funds Tax Code";
        "G/LAccount": Record "G/L Account";
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
        Employee: Record Employee;
        ImprestHeader: Record "Imprest Header";
        ImprestLine: Record "Imprest Line";
        CurrExchRate: Record "Currency Exchange Rate";
        DepreciationBook: Record "FA Depreciation Book";
        AlowanceMatrix: Record "Allowance Matrix";
        CityCodes: Record "Procurement Lookup Values";
        Error001: Label 'From City must be Inserted';
        Error002: Label 'Imprest code exists for this date. Cannot be twice on the same day';

    local procedure TestStatusOpen(AllowApproverEdit: Boolean)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ImprestHeader.Get("Document No.");
        if AllowApproverEdit then begin
          ApprovalEntry.Reset;
          ApprovalEntry.SetRange(ApprovalEntry."Document No.",ImprestHeader."No.");
          ApprovalEntry.SetRange(ApprovalEntry.Status,ApprovalEntry.Status::Open);
          ApprovalEntry.SetRange(ApprovalEntry."Approver ID",UserId);
          if not ApprovalEntry.FindFirst then begin
            ImprestHeader.TestField(Status,ImprestHeader.Status::Open);
          end;
        end else begin
          ImprestHeader.TestField(Status,ImprestHeader.Status::Open);
        end;
    end;
}
