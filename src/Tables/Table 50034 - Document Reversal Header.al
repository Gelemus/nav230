table 50034 "Document Reversal Header"
{

    fields
    {
        field(10;"No.";Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11;"Document Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Payment,Receipt,Funds Transfer';
            OptionMembers = " ",Payment,Receipt,"Funds Transfer";

            trigger OnValidate()
            begin
                TestField(Status,Status::Open);

                "Document No.":='';
                "Doc. Posting date":=0D;
                Description:='';
                Amount:=0;
                "Amount (LCY)":=0;
                "Account No.":='';
                "Account Name":='';


                DocumentReversalLine.Reset;
                DocumentReversalLine.SetRange(DocumentReversalLine."No.","No.");
                  if DocumentReversalLine.FindSet then begin
                    DocumentReversalLine.DeleteAll;
                 end;
            end;
        }
        field(12;"Document No.";Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Document Type"=FILTER(Payment)) "Payment Header"."No." WHERE (Reversed=CONST(false),
                                                                                               Posted=CONST(true))
                                                                                               ELSE IF ("Document Type"=FILTER(Receipt)) "Receipt Header"."No." WHERE (Reversed=CONST(false),
                                                                                                                                                                       Posted=CONST(true))
                                                                                                                                                                       ELSE IF ("Document Type"=CONST("Funds Transfer")) "Funds Transfer Header"."No." WHERE (Reversed=CONST(false),
                                                                                                                                                                                                                                                              Posted=CONST(true));

            trigger OnValidate()
            begin
                "Doc. Posting date":=0D;
                Description:='';
                Amount:=0;
                "Amount (LCY)":=0;
                "Account No.":='';
                "Account Name":='';
                "Shortcut Dimension 1 Code":='';
                "Shortcut Dimension 2 Code":='';
                "Shortcut Dimension 3 Code":='';
                "Shortcut Dimension 4 Code":='';
                "Shortcut Dimension 5 Code":='';
                "Shortcut Dimension 6 Code":='';
                "Shortcut Dimension 7 Code":='';
                "Shortcut Dimension 8 Code":='';

                DocumentReversalLine.Reset;
                DocumentReversalLine.SetRange(DocumentReversalLine."No.","No.");
                if DocumentReversalLine.FindSet then begin
                  DocumentReversalLine.DeleteAll;
                end;

                if "Document Type"="Document Type"::Payment then begin
                  PaymentHeader.Reset;
                  PaymentHeader.SetRange(PaymentHeader."No.","Document No.");
                  if PaymentHeader.FindFirst then begin
                    PaymentHeader.CalcFields(PaymentHeader."Net Amount");
                    PaymentHeader.CalcFields(PaymentHeader."Net Amount(LCY)");

                   "Doc. Posting date":=PaymentHeader."Posting Date";
                    Description:=PaymentHeader.Description;
                    Amount:=PaymentHeader."Net Amount";
                    "Amount (LCY)":=PaymentHeader."Net Amount(LCY)";
                    "Account Type":="Account Type"::"Bank Account";
                    "Account No.":=PaymentHeader."Bank Account No.";
                    "Account Name":=PaymentHeader."Bank Account Name";
                    "Shortcut Dimension 1 Code":=PaymentHeader."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code":=PaymentHeader."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code":=PaymentHeader."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code":=PaymentHeader."Shortcut Dimension 4 Code";
                    "Shortcut Dimension 5 Code":=PaymentHeader."Shortcut Dimension 5 Code";
                    "Shortcut Dimension 6 Code":=PaymentHeader."Shortcut Dimension 6 Code";
                    "Shortcut Dimension 7 Code":=PaymentHeader."Shortcut Dimension 7 Code";
                    "Shortcut Dimension 8 Code":=PaymentHeader."Shortcut Dimension 8 Code";
                    InsertPaymentLines("Document No.","No.");
                  end;
                end;

                if "Document Type"="Document Type"::Receipt then begin
                  ReceiptHeader.Reset;
                  ReceiptHeader.SetRange(ReceiptHeader."No.","Document No.");
                  if ReceiptHeader.FindFirst then begin
                    //ReceiptHeader.CALCFIELDS(ReceiptHeader."Amount Received");
                   // ReceiptHeader.CALCFIELDS(ReceiptHeader."Amount Received(LCY)");

                   "Doc. Posting date":=ReceiptHeader."Posting Date";
                    Description:=ReceiptHeader.Description;
                    Amount:=ReceiptHeader."Amount Received";
                    "Amount (LCY)":=ReceiptHeader."Amount Received(LCY)";
                     "Account Type":="Account Type"::"Bank Account";
                    "Account No.":=ReceiptHeader."Account No.";
                    "Account Name":=ReceiptHeader."Account Name";
                     "Shortcut Dimension 1 Code":=ReceiptHeader."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code":=ReceiptHeader."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code":=ReceiptHeader."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code":=ReceiptHeader."Shortcut Dimension 4 Code";
                    "Shortcut Dimension 5 Code":=ReceiptHeader."Shortcut Dimension 5 Code";
                    "Shortcut Dimension 6 Code":=ReceiptHeader."Shortcut Dimension 6 Code";
                    "Shortcut Dimension 7 Code":=ReceiptHeader."Shortcut Dimension 7 Code";
                    "Shortcut Dimension 8 Code":=ReceiptHeader."Shortcut Dimension 8 Code";
                    InsertReceiptLines("Document No.","No.");
                  end;
                end;

                if "Document Type"="Document Type"::"Funds Transfer" then begin
                  FundsTransferHeader.Reset;
                  FundsTransferHeader.SetRange(FundsTransferHeader."No.","Document No.");
                  if FundsTransferHeader.FindFirst then begin
                    //FundsTransferHeader.CALCFIELDS(FundsTransferHeader."Amount Received");
                   // FundsTransferHeader.CALCFIELDS(FundsTransferHeader."Amount Received(LCY)");

                   "Doc. Posting date":=FundsTransferHeader."Posting Date";
                    Description:=FundsTransferHeader.Description;
                    Amount:=FundsTransferHeader."Amount To Transfer";
                    "Amount (LCY)":=FundsTransferHeader."Amount To Transfer(LCY)";
                     "Account Type":="Account Type"::"Bank Account";
                    "Account No.":=FundsTransferHeader."Bank Account No.";
                    "Account Name":=FundsTransferHeader."Bank Account Name";
                     "Shortcut Dimension 1 Code":=FundsTransferHeader."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code":=FundsTransferHeader."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code":=FundsTransferHeader."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code":=FundsTransferHeader."Shortcut Dimension 4 Code";
                    "Shortcut Dimension 5 Code":=FundsTransferHeader."Shortcut Dimension 5 Code";
                    "Shortcut Dimension 6 Code":=FundsTransferHeader."Shortcut Dimension 6 Code";
                    "Shortcut Dimension 7 Code":=FundsTransferHeader."Shortcut Dimension 7 Code";
                    "Shortcut Dimension 8 Code":=FundsTransferHeader."Shortcut Dimension 8 Code";
                    InsertReceiptLines("Document No.","No.");
                  end;
                end;
            end;
        }
        field(13;"Doc. Posting date";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14;Description;Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15;Amount;Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16;"Amount (LCY)";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17;Status;Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(18;"Reversal Posted";Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19;"Reversal Posted By";Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20;"Reversal Posting Date";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21;"Document Date";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22;"User ID";Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23;"No. Series";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(24;"Account Type";Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(25;"Account No.";Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26;"Account Name";Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27;Posted;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50;"Shortcut Dimension 1 Code";Code[50])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(51;"Shortcut Dimension 2 Code";Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(52;"Shortcut Dimension 3 Code";Code[50])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(53;"Shortcut Dimension 4 Code";Code[50])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(54;"Shortcut Dimension 5 Code";Code[50])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(55;"Shortcut Dimension 6 Code";Code[50])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(56;"Shortcut Dimension 7 Code";Code[50])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(57;"Shortcut Dimension 8 Code";Code[50])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
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
          FundsSetup.TestField(FundsSetup."Reversal Header");
          NoSeriesMgt.InitSeries(FundsSetup."Reversal Header",xRec."No. Series",0D,"No.","No. Series");
        end;

        "Document Date":=Today;
        "User ID":=UserId;
    end;

    var
        FundsClaimHeader: Record "Funds Claim Header";
        ReceiptHeader: Record "Receipt Header";
        PaymentHeader: Record "Payment Header";
        ImprestHeader: Record "Imprest Header";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        GLEntry: Record "G/L Entry";
        Customer: Record Customer;
        Vendor: Record Vendor;
        Employee: Record Employee;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FundsSetup: Record "Funds General Setup";
        DocumentReversalLine: Record "Document Reversal Line";
        LineNo: Integer;
        ClaimLines: Record "Funds Claim Line";
        ClaimHeader: Record "Funds Claim Header";
        ImprestSurrender: Record "Imprest Surrender Header";
        ImprestLine: Record "Imprest Line";
        PaymentLine: Record "Payment Line";
        ReceiptLine: Record "Receipt Line";
        FundsTransferLine: Record "Funds Transfer Line";
        FundsTransferHeader: Record "Funds Transfer Header";

    local procedure InsertFundsTransfer(PayeeNo: Code[20];DocumentNo: Code[20])
    begin
        Message(PayeeNo);
        Message(DocumentNo);
        DocumentReversalLine.Reset;
        DocumentReversalLine.SetRange("Document No.",DocumentNo);
        if DocumentReversalLine.FindSet then
          DocumentReversalLine.DeleteAll;

        FundsTransferLine.Reset;
        FundsTransferLine.SetRange("Document No.",PayeeNo);
        if FundsTransferLine.FindSet then begin
          repeat
          LineNo:=10000;
          DocumentReversalLine.Init;
          DocumentReversalLine."Line No.":=LineNo+1;
          DocumentReversalLine."No.":=DocumentNo;
          DocumentReversalLine."Account Type":=FundsTransferLine."Account Type";
          DocumentReversalLine."Document No.":=PayeeNo;
          DocumentReversalLine."Account No.":=FundsTransferLine."Account No.";
          DocumentReversalLine."Account Name":=FundsTransferLine."Account Name";
          DocumentReversalLine.Description:=FundsTransferLine.Description;
          DocumentReversalLine.Amount:=FundsTransferLine.Amount;
          DocumentReversalLine."Amount (LCY)":=FundsTransferLine."Amount(LCY)";
          DocumentReversalLine."Shortcut Dimension 1 Code":=FundsTransferLine."Global Dimension 1 Code";
          DocumentReversalLine."Shortcut Dimension 2 Code":=FundsTransferLine."Global Dimension 2 Code";
          DocumentReversalLine."Shortcut Dimension 3 Code":=FundsTransferLine."Shortcut Dimension 3 Code";
          DocumentReversalLine."Shortcut Dimension 4 Code":=FundsTransferLine."Shortcut Dimension 4 Code";
          DocumentReversalLine."Shortcut Dimension 5 Code":=FundsTransferLine."Shortcut Dimension 5 Code";
          DocumentReversalLine."Shortcut Dimension 6 Code":=FundsTransferLine."Shortcut Dimension 6 Code";
          DocumentReversalLine."Shortcut Dimension 7 Code":=FundsTransferLine."Shortcut Dimension 7 Code";
          DocumentReversalLine."Shortcut Dimension 8 Code":=FundsTransferLine."Shortcut Dimension 8 Code";
          DocumentReversalLine.Insert;
          until FundsTransferLine.Next=0;
        end;
        //MESSAGE(Txt060);
    end;

    local procedure InsertPaymentLines(PayeeNo: Code[20];DocumentNo: Code[20])
    begin
        //MESSAGE(PayeeNo);
        //MESSAGE(DocumentNo);
        DocumentReversalLine.Reset;
        DocumentReversalLine.SetRange("Document No.",DocumentNo);
        if DocumentReversalLine.FindSet then
          DocumentReversalLine.DeleteAll;

        PaymentLine.Reset;
        PaymentLine.SetRange("Document No.",PayeeNo);
        if PaymentLine.FindSet then begin
          repeat
          LineNo:=10000;
          DocumentReversalLine.Init;
          DocumentReversalLine."Line No.":=LineNo+1;
          DocumentReversalLine."No.":=DocumentNo;
          DocumentReversalLine."Account Type":=PaymentLine."Account Type";
          DocumentReversalLine."Document No.":=PayeeNo;
          DocumentReversalLine."Account No.":=PaymentLine."Account No.";
          DocumentReversalLine."Account Name":=PaymentLine."Account Name";
          DocumentReversalLine.Description:=PaymentLine.Description;
          DocumentReversalLine.Amount:=PaymentLine."Net Amount";
          DocumentReversalLine."Amount (LCY)":=PaymentLine."Net Amount(LCY)";
          DocumentReversalLine."Shortcut Dimension 1 Code":=PaymentLine."Global Dimension 1 Code";
          DocumentReversalLine."Shortcut Dimension 2 Code":=PaymentLine."Global Dimension 2 Code";
          DocumentReversalLine."Shortcut Dimension 3 Code":=PaymentLine."Shortcut Dimension 3 Code";
          DocumentReversalLine."Shortcut Dimension 4 Code":=PaymentLine."Shortcut Dimension 4 Code";
          DocumentReversalLine."Shortcut Dimension 5 Code":=PaymentLine."Shortcut Dimension 5 Code";
          DocumentReversalLine."Shortcut Dimension 6 Code":=PaymentLine."Shortcut Dimension 6 Code";
          DocumentReversalLine."Shortcut Dimension 7 Code":=PaymentLine."Shortcut Dimension 7 Code";
          DocumentReversalLine."Shortcut Dimension 8 Code":=PaymentLine."Shortcut Dimension 8 Code";
          DocumentReversalLine.Insert;
          until PaymentLine.Next=0;
        end;
        //MESSAGE(Txt060);
    end;

    local procedure InsertReceiptLines(PayeeNo: Code[20];DocumentNo: Code[20])
    begin
        //MESSAGE(PayeeNo);
        //MESSAGE(DocumentNo);
        DocumentReversalLine.Reset;
        DocumentReversalLine.SetRange("Document No.",DocumentNo);
        if DocumentReversalLine.FindSet then
          DocumentReversalLine.DeleteAll;

        ReceiptLine.Reset;
        ReceiptLine.SetRange("Document No.",PayeeNo);
        if ReceiptLine.FindSet then begin
          repeat
          LineNo:=10000;
          DocumentReversalLine.Init;
          DocumentReversalLine."Line No.":=LineNo+1;
          DocumentReversalLine."No.":=DocumentNo;
          DocumentReversalLine."Account Type":=ReceiptLine."Account Type";
          DocumentReversalLine."Document No.":=PayeeNo;
          DocumentReversalLine."Account No.":=ReceiptLine."Account No.";
          DocumentReversalLine."Account Name":=ReceiptLine."Account Name";
          DocumentReversalLine.Description:=ReceiptLine.Description;
          DocumentReversalLine.Amount:=ReceiptLine."Net Amount";
          DocumentReversalLine."Amount (LCY)":=ReceiptLine."Net Amount(LCY)";
          DocumentReversalLine."Shortcut Dimension 1 Code":=ReceiptLine."Global Dimension 1 Code";
          DocumentReversalLine."Shortcut Dimension 2 Code":=ReceiptLine."Global Dimension 2 Code";
          DocumentReversalLine."Shortcut Dimension 3 Code":=ReceiptLine."Shortcut Dimension 3 Code";
          DocumentReversalLine."Shortcut Dimension 4 Code":=ReceiptLine."Shortcut Dimension 4 Code";
          DocumentReversalLine."Shortcut Dimension 5 Code":=ReceiptLine."Shortcut Dimension 5 Code";
          DocumentReversalLine."Shortcut Dimension 6 Code":=ReceiptLine."Shortcut Dimension 6 Code";
          DocumentReversalLine."Shortcut Dimension 7 Code":=ReceiptLine."Shortcut Dimension 7 Code";
          DocumentReversalLine."Shortcut Dimension 8 Code":=ReceiptLine."Shortcut Dimension 8 Code";
          DocumentReversalLine.Insert;
          until ReceiptLine.Next=0;
        end;
        //MESSAGE(Txt060);
    end;
}

