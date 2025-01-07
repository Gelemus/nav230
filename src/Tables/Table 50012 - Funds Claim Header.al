table 50012 "Funds Claim Header"
{
    Caption = 'Funds Claim Header';

    fields
    {
        field(1;"No.";Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2;"Document Type";Option)
        {
            Caption = 'Document Type';
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender";
        }
        field(3;"Document Date";Date)
        {
            Caption = 'Document Date';
            Editable = false;
        }
        field(4;"Posting Date";Date)
        {
            Caption = 'Posting Date';
        }
        field(5;"Payment Mode";Option)
        {
            Caption = 'Payment Mode';
            Editable = true;
            OptionCaption = ' ,Cheque,EFT,RTGS,MPESA,Cash';
            OptionMembers = " ",Cheque,EFT,RTGS,MPESA,Cash;
        }
        field(6;"Payment Type";Option)
        {
            Caption = 'Payment Type';
            Editable = false;
            OptionCaption = 'Cheque Payment,Cash Payment,EFT,RTGS,MPESA';
            OptionMembers = "Cheque Payment","Cash Payment",EFT,RTGS,MPESA;
        }
        field(7;"Bank Account No.";Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                TestField("Posting Date");

                "Bank Account Name":='';
                "Currency Code":='';
                Validate("Currency Code");

                BankAccount.Reset;
                BankAccount.SetRange(BankAccount."No.","Bank Account No.");
                if BankAccount.FindFirst then begin
                  "Bank Account Name":=BankAccount.Name;
                  "Currency Code":=BankAccount."Currency Code";
                  Validate("Currency Code");
                end;
            end;
        }
        field(8;"Bank Account Name";Text[100])
        {
            Caption = 'Bank Account Name';
            Editable = false;
        }
        field(9;"Bank Account Balance";Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE ("Bank Account No."=FIELD("Bank Account No.")));
            Caption = 'Bank Account Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10;"Cheque Type";Option)
        {
            Caption = 'Cheque Type';
            OptionCaption = ' ,Computer Cheque,Manual Cheque';
            OptionMembers = " ","Computer Cheque","Manual Cheque";
        }
        field(11;"Reference No.";Code[20])
        {
            Caption = 'Reference No.';

            trigger OnValidate()
            begin
                BankAccountLedgerEntry.Reset;
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."External Document No.","Reference No.");
                if BankAccountLedgerEntry.FindFirst then begin
                  Error(ErrorUsedReferenceNumber,BankAccountLedgerEntry."Document No.");
                end;
            end;
        }
        field(12;"Payee Type";Option)
        {
            Caption = 'Payee Type';
            OptionCaption = ' ,Employee';
            OptionMembers = " ",Employee;
        }
        field(13;"Payee No.";Code[20])
        {
            Caption = 'Payee No.';
            TableRelation = IF ("Payee Type"=CONST(Employee)) Employee;

            trigger OnValidate()
            begin
                "Payee Name":='';
                if "Payee Type"="Payee Type"::Employee then begin
                  Employee.Reset;
                  Employee.SetRange(Employee."No.","Payee No.");
                  if Employee.FindFirst then begin
                    "Payee Name":=Employee."First Name"+' '+Employee."Middle Name"+' '+Employee."Last Name";
                    FundsClaimLine.Reset;
                    FundsClaimLine.SetRange(FundsClaimLine."Document No.","No.");
                    FundsClaimLine.SetRange(FundsClaimLine."Account Type",FundsClaimLine."Account Type"::Employee);
                    if FundsClaimLine.FindSet then begin
                      repeat
                        FundsClaimLine."Account No.":=Employee."No.";
                        FundsClaimLine.Validate(FundsClaimLine."Account No.");
                      until FundsClaimLine.Next=0;
                    end;

                  end;
                end;
                Validate("Payee Name");
            end;
        }
        field(14;"Payee Name";Text[100])
        {
            Caption = 'Payee Name';

            trigger OnValidate()
            begin
                "Payee Name":=UpperCase("Payee Name");
            end;
        }
        field(15;"On Behalf Of";Text[100])
        {
            Caption = 'On Behalf Of';
        }
        field(16;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                TestField("Bank Account No.");
                TestField("Posting Date");
                if "Currency Code"<>'' then begin
                  if BankAccount.Get("Bank Account No.") then begin
                      BankAccount.TestField(BankAccount."Currency Code","Currency Code");
                      "Currency Factor" :=CurrExchRate.ExchangeRate("Posting Date","Currency Code");
                  end;
                end else begin
                  if BankAccount.Get("Bank Account No.") then begin
                      BankAccount.TestField(BankAccount."Currency Code",'');
                  end;
                end;
            end;
        }
        field(17;"Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
        }
        field(18;Amount;Decimal)
        {
            CalcFormula = Sum("Funds Claim Line".Amount WHERE ("Document No."=FIELD("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19;"Amount(LCY)";Decimal)
        {
            CalcFormula = Sum("Funds Claim Line"."Amount(LCY)" WHERE ("Document No."=FIELD("No.")));
            Caption = 'Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(38;"Net Amount";Decimal)
        {
            CalcFormula = Sum("Funds Claim Line"."Net Amount" WHERE ("Document No."=FIELD("No.")));
            Caption = 'Net Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39;"Net Amount(LCY)";Decimal)
        {
            CalcFormula = Sum("Funds Claim Line"."Net Amount(LCY)" WHERE ("Document No."=FIELD("No.")));
            Caption = 'Net Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(49;Description;Text[100])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                Description:=UpperCase(Description);
            end;
        }
        field(50;"Global Dimension 1 Code";Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard));

            trigger OnValidate()
            begin
                //Delete the previous dimensions
                "Global Dimension 2 Code":='';
                "Shortcut Dimension 3 Code":='';
                "Shortcut Dimension 4 Code":='';
                "Shortcut Dimension 5 Code":='';
                "Shortcut Dimension 6 Code":='';
                "Shortcut Dimension 7 Code":='';
                "Shortcut Dimension 8 Code":='';
                FundsClaimLine.Reset;
                FundsClaimLine.SetRange(FundsClaimLine."Document No.","No.");
                if FundsClaimLine.FindSet then begin
                  repeat
                    FundsClaimLine."Global Dimension 2 Code":='';
                    FundsClaimLine."Shortcut Dimension 3 Code":='';
                    FundsClaimLine."Shortcut Dimension 4 Code":='';
                    FundsClaimLine."Shortcut Dimension 5 Code":='';
                    FundsClaimLine."Shortcut Dimension 6 Code":='';
                    FundsClaimLine."Shortcut Dimension 7 Code":='';
                    FundsClaimLine."Shortcut Dimension 8 Code":='';
                    FundsClaimLine.Modify;
                  until FundsClaimLine.Next=0;
                end;
                //End delete the previous dimensions

                FundsClaimLine.Reset;
                FundsClaimLine.SetRange(FundsClaimLine."Document No.","No.");
                if FundsClaimLine.FindSet then begin
                  repeat
                    FundsClaimLine."Global Dimension 1 Code":="Global Dimension 1 Code";
                    FundsClaimLine.Modify;
                  until FundsClaimLine.Next=0;
                end;
            end;
        }
        field(51;"Global Dimension 2 Code";Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2));
        }
        field(52;"Shortcut Dimension 3 Code";Code[50])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
        }
        field(53;"Shortcut Dimension 4 Code";Code[50])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
        }
        field(54;"Shortcut Dimension 5 Code";Code[50])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
        }
        field(55;"Shortcut Dimension 6 Code";Code[50])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
        }
        field(56;"Shortcut Dimension 7 Code";Code[50])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
        }
        field(57;"Shortcut Dimension 8 Code";Code[50])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
        }
        field(58;"Responsibility Center";Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center".Code;
        }
        field(70;Status;Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Released,Rejected,Posted,Reversed';
            OptionMembers = Open,"Pending Approval",Released,Rejected,Posted,Reversed;

            trigger OnValidate()
            begin
                FundsClaimLine.Reset;
                FundsClaimLine.SetRange(FundsClaimLine."Document No.","No.");
                if FundsClaimLine.FindSet then begin
                  repeat
                    FundsClaimLine.Status:=Status;
                    FundsClaimLine.Modify;
                  until FundsClaimLine.Next=0;
                end;
            end;
        }
        field(71;Posted;Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(72;"Posted By";Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(73;"Date Posted";Date)
        {
            Caption = 'Date Posted';
            Editable = false;
        }
        field(74;"Time Posted";Time)
        {
            Caption = 'Time Posted';
            Editable = false;
        }
        field(75;Reversed;Boolean)
        {
            Caption = 'Reversed';
            Editable = false;
        }
        field(76;"Reversed By";Code[50])
        {
            Caption = 'Reversed By';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(77;"Reversal Date";Date)
        {
            Caption = 'Reversal Date';
            Editable = false;
        }
        field(78;"Reversal Time";Time)
        {
            Caption = 'Reversal Time';
            Editable = false;
        }
        field(80;"Reversal Posting Date";Date)
        {
        }
        field(99;"User ID";Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(100;"No. Series";Code[20])
        {
            Caption = 'No. Series';
        }
        field(101;"No. Printed";Integer)
        {
            Caption = 'No. Printed';
        }
        field(102;"Incoming Document Entry No.";Integer)
        {
            Caption = 'Incoming Document Entry No.';
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

    trigger OnDelete()
    begin
        TestField(Status,Status::Open);
        FundsClaimLine.Reset;
        FundsClaimLine.SetRange(FundsClaimLine."Document No.","No.");
        if FundsClaimLine.FindSet then
          FundsClaimLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
          FundsSetup.Get;
          FundsSetup.TestField("Funds Claim Nos.");
          NoSeriesMgt.InitSeries(FundsSetup."Funds Claim Nos.",xRec."No. Series",0D,"No.","No. Series");
        end;
        "Document Type":="Document Type"::Refund;
        "Document Date":=Today;
        "User ID":=UserId;
    end;

    var
        FundsSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        "G/LAccount": Record "G/L Account";
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
        Employee: Record Employee;
        FundsClaimHeader: Record "Funds Claim Header";
        FundsClaimLine: Record "Funds Claim Line";
        CurrExchRate: Record "Currency Exchange Rate";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        ErrorUsedReferenceNumber: Label 'The Reference Number has been used in Document No:%1';
}

