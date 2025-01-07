table 50002 "Payment Header"
{
    Caption = 'Payment Header';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = true;
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender";
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Editable = false;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                if "Posting Date" > Today then
                    Error('Posting date cannot be future date');
            end;
        }
        field(5; "Payment Mode"; Option)
        {
            Caption = 'Payment Mode';
            Editable = true;
            OptionCaption = ' ,Cheque,EFT,RTGS,MPESA,Cash,Online Banking,Inter-Bank Transfer,NdovuPay';
            OptionMembers = " ",Cheque,EFT,RTGS,MPESA,Cash,"Online Banking","Inter-Bank Transfer",NdovuPay;

            trigger OnValidate()
            begin
                "Bank Account No." := '';
                "Bank Account Name" := '';
                "Cheque No." := '';
            end;
        }
        field(6; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            Editable = false;
            OptionCaption = 'Cheque Payment,Cash Payment,EFT,RTGS,MPESA,Deposit Transfer,Online Banking';
            OptionMembers = "Cheque Payment","Cash Payment",EFT,RTGS,MPESA,"Deposit Transfer","Online Banking";
        }
        field(7; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = IF ("Payment Type" = CONST("Cash Payment")) "Bank Account"."No." WHERE("Bank Account Type" = CONST("Petty Cash"))
            ELSE IF ("Payment Type" = CONST("Cheque Payment")) "Bank Account"."No." WHERE("Bank Account Type" = FILTER(Normal | "Credit Card" | "Mobile Banking"));

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);
                TestField("Payment Mode");
                //TESTFIELD("Posting Date");

                "Bank Account Name" := '';
                "Cheque No." := '';

                /*ChequeRegisterLines.RESET;
                ChequeRegisterLines.SETRANGE(ChequeRegisterLines."Bank  Account No.","Bank Account No.");
                ChequeRegisterLines.SETRANGE(ChequeRegisterLines.Status,ChequeRegisterLines.Status::Approved);
                ChequeRegisterLines.SETRANGE(ChequeRegisterLines."PV Posted with Cheque",FALSE);
                IF ChequeRegisterLines.FINDSET THEN BEGIN
                  REPEAT
                  ChequeRegisterLines."Assigned to PV":=FALSE;
                  ChequeRegisterLines.MODIFY;
                  UNTIL ChequeRegisterLines.NEXT=0;
                END;
                */

                BankAccount.Reset;
                BankAccount.SetRange(BankAccount."No.", "Bank Account No.");
                if BankAccount.FindFirst then begin
                    "Bank Account Name" := BankAccount.Name;
                    "Currency Code" := BankAccount."Currency Code";
                    Validate("Currency Code");
                end;

                //Insert Cheque Number if paymode is cheque\

                if "Payment Mode" = "Payment Mode"::Cheque then
                    ChequeRegisterLines.Reset;
                ChequeRegisterLines.SetRange(ChequeRegisterLines."Bank  Account No.", "Bank Account No.");
                ChequeRegisterLines.SetRange(ChequeRegisterLines.Status, ChequeRegisterLines.Status::Approved);
                ChequeRegisterLines.SetRange(ChequeRegisterLines."Assigned to PV", false);
                if ChequeRegisterLines.FindFirst then begin
                    "Cheque No." := ChequeRegisterLines."Cheque No.";
                    ChequeRegisterLines."Assigned to PV" := true;
                    ChequeRegisterLines.Modify;
                end;

            end;
        }
        field(8; "Bank Account Name"; Text[100])
        {
            Caption = 'Bank Account Name';
            Editable = false;
        }
        field(9; "Bank Account Balance"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FIELD("Bank Account No.")));
            Caption = 'Bank Account Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Cheque Type"; Option)
        {
            Caption = 'Cheque Type';
            OptionCaption = ' ,Computer Cheque,Manual Cheque';
            OptionMembers = " ","Computer Cheque","Manual Cheque";
        }
        field(11; "Reference No."; Code[50])
        {
            Caption = 'Reference No.';

            trigger OnValidate()
            begin
                PaymentHeader.Reset;
                PaymentHeader.SetRange(PaymentHeader."Reference No.", "Reference No.");
                PaymentHeader.SetRange(PaymentHeader."Bank Account No.", "Bank Account No.");
                if PaymentHeader.FindFirst then begin
                    Error(ErrorUsedReferenceNumber, PaymentHeader."No.");
                end;
                BankAccountLedgerEntry.Reset;
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."External Document No.", "Reference No.");
                if BankAccountLedgerEntry.FindFirst then begin
                    Error(ErrorUsedReferenceNumber, BankAccountLedgerEntry."Document No.");
                end;
            end;
        }
        field(12; "Payee Type"; Option)
        {
            Caption = 'Payee Type';
            OptionCaption = ' ,Vendor,Employee,Claim,Imprest,Imprest Surrender';
            OptionMembers = " ",Vendor,Employee,Claim,Imprest,"Imprest Surrender";
        }
        field(13; "Payee No."; Code[20])
        {
            Caption = 'Payee No.';
            TableRelation = IF ("Payee Type" = CONST(Vendor)) Vendor
            ELSE IF ("Payee Type" = CONST(Employee)) Employee
            ELSE IF ("Payee Type" = CONST(Claim)) "Funds Claim Header" WHERE(Posted = CONST(false),
                                                                                            Status = CONST(Released))
            ELSE IF ("Payee Type" = CONST(Imprest)) "Imprest Header" WHERE(Posted = CONST(false),
                                                                                                                                                          Status = CONST(Approved))
            ELSE IF ("Payee Type" = CONST("Imprest Surrender")) "Imprest Surrender Header" WHERE(Difference = FILTER(< 0),
                                                                                                                                                                                                                                              Status = CONST(Released));
        }
        field(14; "Payee Name"; Text[100])
        {
            Caption = 'Payee Name';

            trigger OnValidate()
            begin
                "Payee Name" := UpperCase("Payee Name");
            end;
        }
        field(15; "On Behalf Of"; Text[100])
        {
            Caption = 'On Behalf Of';
        }
        field(16; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                TestField("Bank Account No.");
                //TESTFIELD("Posting Date");
                if "Currency Code" <> '' then begin
                    if BankAccount.Get("Bank Account No.") then begin
                        // BankAccount.TESTFIELD(BankAccount."Currency Code","Currency Code");
                        "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                    end;
                end else begin
                    if BankAccount.Get("Bank Account No.") then begin
                        BankAccount.TestField(BankAccount."Currency Code", '');
                    end;
                end;
            end;
        }
        field(17; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
        }
        field(18; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."Total Amount" WHERE("Document No." = FIELD("No.")));
            Caption = 'Amount Incl. VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Total Amount(LCY)"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."Total Amount(LCY)" WHERE("Document No." = FIELD("No.")));
            Caption = 'Amount Incl. VAT(LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "VAT Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."VAT Amount" WHERE("Document No." = FIELD("No.")));
            Caption = 'VAT Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "VAT Amount(LCY)"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."VAT Amount(LCY)" WHERE("Document No." = FIELD("No.")));
            Caption = 'VAT Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "WithHolding Tax Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."Withholding Tax Amount" WHERE("Document No." = FIELD("No.")));
            Caption = 'WithHolding Tax Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "WithHolding Tax Amount(LCY)"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."Withholding Tax Amount(LCY)" WHERE("Document No." = FIELD("No.")));
            Caption = 'WithHolding Tax Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Withholding VAT Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."Withholding VAT Amount" WHERE("Document No." = FIELD("No.")));
            Caption = 'Withholding VAT Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Withholding VAT Amount(LCY)"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."Withholding VAT Amount(LCY)" WHERE("Document No." = FIELD("No.")));
            Caption = 'Withholding VAT Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "Net Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."Net Amount" WHERE("Document No." = FIELD("No.")));
            Caption = 'Net Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; "Net Amount(LCY)"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."Net Amount(LCY)" WHERE("Document No." = FIELD("No.")));
            Caption = 'Net Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(49; Description; Text[100])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                Description := UpperCase(Description);
            end;
        }
        field(50; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));

            trigger OnValidate()
            begin
                //Delete the previous dimensions
                "Global Dimension 2 Code" := '';
                "Shortcut Dimension 3 Code" := '';
                "Shortcut Dimension 4 Code" := '';
                "Shortcut Dimension 5 Code" := '';
                "Shortcut Dimension 6 Code" := '';
                "Shortcut Dimension 7 Code" := '';
                "Shortcut Dimension 8 Code" := '';

                PaymentLine.Reset;
                PaymentLine.SetRange(PaymentLine."Document No.", "No.");
                if PaymentLine.FindSet then begin
                    repeat
                        PaymentLine."Global Dimension 2 Code" := '';
                        PaymentLine."Shortcut Dimension 3 Code" := '';
                        PaymentLine."Shortcut Dimension 4 Code" := '';
                        PaymentLine."Shortcut Dimension 5 Code" := '';
                        PaymentLine."Shortcut Dimension 6 Code" := '';
                        PaymentLine."Shortcut Dimension 7 Code" := '';
                        PaymentLine."Shortcut Dimension 8 Code" := '';
                        PaymentLine.Modify;
                    until PaymentLine.Next = 0;
                end;
                //End delete the previous dimensions

                PaymentLine.Reset;
                PaymentLine.SetRange(PaymentLine."Document No.", "No.");
                if PaymentLine.FindSet then begin
                    repeat
                        PaymentLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        PaymentLine.Modify;
                    until PaymentLine.Next = 0;
                end;
            end;
        }
        field(51; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(52; "Shortcut Dimension 3 Code"; Code[50])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(53; "Shortcut Dimension 4 Code"; Code[50])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(54; "Shortcut Dimension 5 Code"; Code[50])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(55; "Shortcut Dimension 6 Code"; Code[50])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(56; "Shortcut Dimension 7 Code"; Code[50])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(57; "Shortcut Dimension 8 Code"; Code[50])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(58; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center".Code;
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted,Reversed,Cancelled';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted,Reversed,Cancelled;

            trigger OnValidate()
            begin
                /*IF Status=Status::Released THEN BEGIN
                 //Send email to supplier
                  PaymentLine.RESET;
                  PaymentLine.SETRANGE(PaymentLine."Document No.","No.");
                  PaymentLine.SETRANGE(PaymentLine."Account Type",PaymentLine."Account Type"::Vendor);
                  IF PaymentLine.FINDFIRST THEN BEGIN
                   FundsManagement.SendVendorEmail(PaymentLine."Document No.",PaymentLine."Account No.",PaymentLine."Net Amount");
                  END;
                END;
                */


                PaymentLine.Reset;
                PaymentLine.SetRange(PaymentLine."Document No.", "No.");
                if PaymentLine.FindSet then begin
                    repeat
                        PaymentLine.Status := Status;
                        if Status = Status::Posted then begin
                            PaymentLine.Posted := true;
                            PaymentLine."Posted By" := UserId;
                            PaymentLine."Date Posted" := Today;
                            PaymentLine."Time Posted" := Time;
                        end;
                        PaymentLine.Modify;
                    until PaymentLine.Next = 0;
                end;

            end;
        }
        field(71; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = true;
        }
        field(72; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(73; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
        }
        field(74; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            Editable = false;
        }
        field(75; Reversed; Boolean)
        {
            Caption = 'Reversed';
            Editable = false;
        }
        field(76; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(77; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            Editable = false;
        }
        field(78; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            Editable = false;
        }
        field(80; "Reversal Posting Date"; Date)
        {
        }
        field(81; "Cheque No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = true;

            trigger OnValidate()
            begin
                "Reference No." := "Cheque No.";
                TestField(Posted, false);
            end;
        }
        field(99; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = "User Setup"."User ID";
        }
        field(100; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(101; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
        }
        field(102; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
        }
        field(103; "Payee Bank Account Name"; Text[100])
        {
            Editable = false;
        }
        field(104; "Payee Bank Account No."; Code[20])
        {
            Editable = false;
        }
        field(105; "MPESA/Paybill Account No."; Code[20])
        {
            Editable = false;
        }
        field(106; "Payee Bank Code"; Code[20])
        {
        }
        field(107; "Payee Bank Name"; Text[80])
        {
            Editable = false;
        }
        field(108; "Loan Disbursement Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Investment Loan,Staff Loan,Equity';
            OptionMembers = " ","Investment Loan","Staff Loan",Equity;
        }
        field(110; "PVC No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(112; "Cancelled By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(113; "Time Cancelled"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(114; "Date Cancelled"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(115; "Reason for Cancellation"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(116; "Office Imprest No."; Code[20])
        {
            Caption = 'Imprest No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                //TestStatusOpen(TRUE);
                /*
                TESTFIELD("Employee No.");
                //Reset Imprest Surrender
                ImprestSurrenderLine.RESET;
                ImprestSurrenderLine.SETRANGE(ImprestSurrenderLine."Document No.","No.");
                IF ImprestSurrenderLine.FINDSET THEN BEGIN
                  ImprestSurrenderLine.DELETEALL;
                END;
                
                "Imprest Date":=0D;
                "Global Dimension 1 Code":='';
                "Global Dimension 2 Code":='';
                "Shortcut Dimension 3 Code":='';
                "Shortcut Dimension 4 Code":='';
                "Shortcut Dimension 5 Code":='';
                "Shortcut Dimension 6 Code":='';
                "Shortcut Dimension 7 Code":='';
                "Shortcut Dimension 8 Code":='';
                "Responsibility Center":='';
                //End Reset Imprest Surrender
                
                COMMIT;
                
                IF "Imprest No." <> '' THEN BEGIN
                IF ImprestHeader.GET("Imprest No.") THEN BEGIN
                  "Imprest Date":=ImprestHeader."Posting Date";
                  "Currency Code":=ImprestHeader."Currency Code";
                  "Global Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
                  "Global Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
                  "Shortcut Dimension 3 Code":=ImprestHeader."Shortcut Dimension 3 Code";
                  "Shortcut Dimension 4 Code":=ImprestHeader."Shortcut Dimension 4 Code";
                  "Shortcut Dimension 5 Code":=ImprestHeader."Shortcut Dimension 5 Code";
                  "Shortcut Dimension 6 Code":=ImprestHeader."Shortcut Dimension 6 Code";
                  "Shortcut Dimension 7 Code":=ImprestHeader."Shortcut Dimension 7 Code";
                  "Shortcut Dimension 8 Code":=ImprestHeader."Shortcut Dimension 8 Code";
                  "Responsibility Center":=ImprestHeader."Responsibility Center";
                
                  ImprestLine.RESET;
                  ImprestLine.SETRANGE(ImprestLine."Document No.",ImprestHeader."No.");
                  ImprestLine.SETFILTER(ImprestLine."Gross Amount",'>%1',0);
                  IF ImprestLine.FINDSET THEN BEGIN
                    REPEAT
                      ImprestSurrenderLine.RESET;
                      ImprestSurrenderLine."Line No.":=0;
                      ImprestSurrenderLine."Document No.":="No.";
                      ImprestSurrenderLine."Document Type":="Document Type";//ImprestSurrenderLine."Document Type"::"Imprest Surrender";
                      ImprestSurrenderLine."Imprest Code":=ImprestLine."Imprest Code";
                      ImprestSurrenderLine."Imprest Code Description":=ImprestLine."Imprest Code Description";
                      ImprestSurrenderLine."Account Type":=ImprestLine."Account Type";
                      ImprestSurrenderLine."Account No.":=ImprestLine."Account No.";
                      ImprestSurrenderLine."Account Name":=ImprestLine."Account Name";
                      ImprestSurrenderLine."Posting Group":=ImprestLine."Posting Group";
                      ImprestSurrenderLine.Description:=ImprestLine.Description;
                      ImprestSurrenderLine."Currency Code":=ImprestLine."Currency Code";
                      ImprestSurrenderLine."Gross Amount":=ImprestLine."Gross Amount";
                      ImprestSurrenderLine."Gross Amount(LCY)":=ImprestLine."Gross Amount(LCY)";
                      ImprestSurrenderLine."Actual Spent":=ImprestLine."Net Amount";
                      ImprestSurrenderLine."Actual Spent(LCY)":=ImprestLine."Net Amount";
                      ImprestSurrenderLine."Paid Amount":=ImprestLine."Net Amount";
                      ImprestSurrenderLine."Tax Amount":=ImprestLine."Tax Amount";
                      ImprestSurrenderLine."Global Dimension 1 Code":=ImprestLine."Global Dimension 1 Code";
                      ImprestSurrenderLine."Global Dimension 2 Code":=ImprestLine."Global Dimension 2 Code";
                      ImprestSurrenderLine."Shortcut Dimension 3 Code":=ImprestLine."Shortcut Dimension 3 Code";
                      ImprestSurrenderLine."Shortcut Dimension 4 Code":=ImprestLine."Shortcut Dimension 4 Code";
                      ImprestSurrenderLine."Shortcut Dimension 5 Code":=ImprestLine."Shortcut Dimension 5 Code";
                      ImprestSurrenderLine."Shortcut Dimension 6 Code":=ImprestLine."Shortcut Dimension 6 Code";
                      ImprestSurrenderLine."Shortcut Dimension 7 Code":=ImprestLine."Shortcut Dimension 7 Code";
                      ImprestSurrenderLine."Shortcut Dimension 8 Code":=ImprestLine."Shortcut Dimension 8 Code";
                      ImprestSurrenderLine."Responsibility Center":=ImprestLine."Responsibility Center";
                      ImprestSurrenderLine."FA Depreciation Book":=ImprestLine."FA Depreciation Book";
                      ImprestSurrenderLine.INSERT;
                    UNTIL ImprestLine.NEXT=0;
                  END;
                END;
                END;
                */

            end;
        }
        field(117; "Cheque No. - WHVAT"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = true;

            trigger OnValidate()
            begin

                TestField(Posted, false);
            end;
        }
        field(118; "Cheque No. - WHTAX"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = true;

            trigger OnValidate()
            begin

                TestField(Posted, false);
            end;
        }
        field(119; "PAYE Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."PAYE Amount" WHERE("Document No." = FIELD("No.")));
            Caption = 'PAYE Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(120; "PAYE Amount LCY"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."PAYE Amount" WHERE("Document No." = FIELD("No.")));
            Caption = 'PAYE Amount LCY';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; "W/VAT"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52137123; "Payroll Payment"; Boolean)
        {
        }
        field(52137124; "Loan Disbursement No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137125; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52137126; "Loan Disbursement"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52137127; "Deposit Transaction No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137128; "Is Deposit Refund"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52137131; "Ndovu Pay Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Awaiting Payment,Payment In Progress,Payment Failed,Payment Completed';
            OptionMembers = "Awaiting Payment","Payment In Progress","Payment Failed","Payment Completed";
        }
        field(52137132; "Ndovu Pay Response"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(52137133; Voted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Status, Status::Open);

        PaymentLine.Reset;
        PaymentLine.SetRange(PaymentLine."Document No.", "No.");
        if PaymentLine.FindSet then
            PaymentLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if ("No." = '') and ("W/VAT" = false) then begin
            if "Payment Type" = "Payment Type"::"Cheque Payment" then begin//Cheque Payments
                FundsSetup.Get;
                FundsSetup.TestField(FundsSetup."Payment Voucher Nos.");
                NoSeriesMgt.InitSeries(FundsSetup."Payment Voucher Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            end;
            if "Payment Type" = "Payment Type"::"Cash Payment" then begin//Cash Payments
                FundsSetup.Get;
                FundsSetup.TestField(FundsSetup."Cash Voucher Nos.");
                NoSeriesMgt.InitSeries(FundsSetup."Cash Voucher Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            end;
        end else begin
            if ("No." = '') and ("W/VAT" = true) then begin
                if "Payment Type" = "Payment Type"::"Cheque Payment" then begin//Cheque Payments
                    FundsSetup.Get;
                    FundsSetup.TestField(FundsSetup."W-VAT Nos");
                    NoSeriesMgt.InitSeries(FundsSetup."W-VAT Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;

                if "Payment Type" = "Payment Type"::"Cash Payment" then begin//Cash Payments
                    FundsSetup.Get;
                    FundsSetup.TestField(FundsSetup."Cash Voucher Nos.");
                    NoSeriesMgt.InitSeries(FundsSetup."Cash Voucher Nos.", xRec."No. Series", 0D, "No.", "No. Series");
                end;
            end;
        end;
        "Document Type" := "Document Type"::Payment;
        "Document Date" := Today;
        "User ID" := UserId;
        "Posting Date" := 0D;//TODAY;
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
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        Employee: Record Employee;
        PaymentHeader: Record "Payment Header";
        PaymentLine: Record "Payment Line";
        CurrExchRate: Record "Currency Exchange Rate";
        ErrorUsedReferenceNumber: Label 'The Reference Number has been used for Payment No:%1';
        FundsManagement: Codeunit "Funds Management";
        ChequeRegisterLines: Record "Cheque Register Lines";
        EmployeeLoanDisbursement: Record "Employee Loan Disbursement";
        HRLoanProduct: Record "Employee Loans General Setup";
        ClaimHeader: Record "Funds Claim Header";
        StaffEmps: Record Employee;
        ImprestSurrender: Record "Imprest Surrender Header";
        ImportedBankPayments: Record "Cheque Register";
        FundsTransCodes: Record "Funds Transaction Code";
        ImprestHeader: Record "Imprest Header";
        LineNo: Integer;
        Txt060: Label 'Payment Lines Created Successfully';
        Text100: Label 'Imprest Allowance for employee: :';
        Text105: Label 'Imprest Surrender Claim by :';
        Txt055: Label 'Reference No already receipted by Receipt No:';
        Txt056: Label 'Reference Number not found in Bank Statement for Paymode:';
        Text4100: Label 'Reference No.';
        ClaimLines: Record "Funds Claim Line";

    local procedure TestStatusOpen(AllowApproverEdit: Boolean)
    var
        PaymentHeader: Record "Payment Header";
        ApprovalEntry: Record "Approval Entry";
    begin
        PaymentHeader.Get("No.");
        if AllowApproverEdit then begin
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", PaymentHeader."No.");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            ApprovalEntry.SetRange(ApprovalEntry."Approver ID", UserId);
            if not ApprovalEntry.FindFirst then begin
                PaymentHeader.TestField(Status, PaymentHeader.Status::Open);
            end;
        end else begin
            PaymentHeader.TestField(Status, PaymentHeader.Status::Open);
        end;
    end;

    [Scope('Personalization')]
    procedure AssistEdit(): Boolean
    begin
        FundsSetup.Get;
        FundsSetup.TestField("Payment Voucher Reference Nos.");
        if NoSeriesMgt.SelectSeries(FundsSetup."Payment Voucher Reference Nos.", xRec."No. Series", "No. Series") then begin
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;

    local procedure InsertImprestLines(PayeeNo: Code[20]; DocumentNo: Code[20])
    begin
        PaymentLine.Reset;
        PaymentLine.SetRange("Document No.", DocumentNo);
        if PaymentLine.FindSet then
            PaymentLine.DeleteAll;

        ImprestHeader.Reset;
        ImprestHeader.SetRange("No.", PayeeNo);
        if ImprestHeader.FindFirst then begin
            ImprestHeader.CalcFields(ImprestHeader.Amount);
            PaymentHeader.Reset;
            PaymentHeader.SetRange("No.", DocumentNo);
            if PaymentHeader.FindFirst then begin
                PaymentHeader."Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                PaymentHeader."Global Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
                PaymentHeader."Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
                PaymentHeader."Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
                PaymentHeader."Shortcut Dimension 5 Code" := ImprestHeader."Shortcut Dimension 5 Code";
                PaymentHeader."Shortcut Dimension 6 Code" := ImprestHeader."Shortcut Dimension 6 Code";
                PaymentHeader."Shortcut Dimension 8 Code" := ImprestHeader."Shortcut Dimension 7 Code";
            end;
            LineNo := 10000;
            PaymentLine.Init;
            PaymentLine."Line No." := LineNo;
            //PaymentLine."Payment Code":=
            PaymentLine."Account Type" := PaymentLine."Account Type"::Employee;
            PaymentLine."Document No." := DocumentNo;
            PaymentLine."Account No." := ImprestHeader."Employee No.";
            PaymentLine."Account Name" := ImprestHeader."Employee Name";
            PaymentLine.Description := Text100 + ImprestHeader."Employee Name";   //ImprestHeader.Description;
            PaymentLine."Total Amount" := ImprestHeader.Amount;
            PaymentLine.Validate(PaymentLine."Total Amount");
            PaymentLine."Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
            PaymentLine."Global Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
            PaymentLine."Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
            PaymentLine."Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
            PaymentLine."Shortcut Dimension 5 Code" := ImprestHeader."Shortcut Dimension 5 Code";
            PaymentLine."Shortcut Dimension 6 Code" := ImprestHeader."Shortcut Dimension 6 Code";
            PaymentLine."Shortcut Dimension 8 Code" := ImprestHeader."Shortcut Dimension 7 Code";
            PaymentLine.Insert;
        end;
        //MESSAGE(Txt060);
    end;

    local procedure InsertClaimLines(PayeeNo: Code[20]; DocumentNo: Code[20])
    var
        AccountNo: Code[20];
    begin
        PaymentLine.Reset;
        PaymentLine.SetRange("Document No.", DocumentNo);
        if PaymentLine.FindSet then
            PaymentLine.DeleteAll;

        ClaimLines.Reset;
        ClaimLines.SetRange("Document No.", PayeeNo);
        if ClaimLines.FindSet then begin
            ClaimHeader.Reset;
            ClaimHeader.SetRange("No.", PayeeNo);
            if ClaimHeader.FindFirst then begin
                ClaimHeader."Global Dimension 1 Code" := ClaimLines."Global Dimension 1 Code";
                ClaimHeader."Global Dimension 2 Code" := ClaimLines."Global Dimension 2 Code";
                ClaimHeader."Shortcut Dimension 3 Code" := ClaimLines."Shortcut Dimension 3 Code";
                ClaimHeader."Shortcut Dimension 4 Code" := ClaimLines."Shortcut Dimension 4 Code";
                ClaimHeader."Shortcut Dimension 5 Code" := ClaimLines."Shortcut Dimension 5 Code";
                ClaimHeader."Shortcut Dimension 6 Code" := ClaimLines."Shortcut Dimension 6 Code";
                ClaimHeader."Shortcut Dimension 8 Code" := ClaimLines."Shortcut Dimension 7 Code";
                AccountNo := ClaimHeader."Payee No.";
            end;
            LineNo := 10000;
            repeat
                LineNo += 1;
                PaymentLine.Init;
                PaymentLine."Line No." := LineNo;
                PaymentLine."Payment Code" := ClaimLines."Funds Claim Code";
                PaymentLine."Document No." := DocumentNo;
                PaymentLine."Account Type" := PaymentLine."Account Type"::"G/L Account";
                PaymentLine."Account No." := ClaimLines."Account No.";
                PaymentLine."Account Name" := ClaimLines."Account Name";
                PaymentLine.Description := ClaimLines.Description;
                PaymentLine."Total Amount" := ClaimLines.Amount;
                PaymentLine.Validate(PaymentLine."Total Amount");
                PaymentLine."Global Dimension 1 Code" := ClaimLines."Global Dimension 1 Code";
                PaymentLine."Global Dimension 2 Code" := ClaimLines."Global Dimension 2 Code";
                PaymentLine."Shortcut Dimension 3 Code" := ClaimLines."Shortcut Dimension 3 Code";
                PaymentLine."Shortcut Dimension 4 Code" := ClaimLines."Shortcut Dimension 4 Code";
                PaymentLine."Shortcut Dimension 5 Code" := ClaimLines."Shortcut Dimension 5 Code";
                PaymentLine."Shortcut Dimension 6 Code" := ClaimLines."Shortcut Dimension 6 Code";
                PaymentLine."Shortcut Dimension 8 Code" := ClaimLines."Shortcut Dimension 7 Code";
                PaymentLine.Insert;
            until ClaimLines.Next = 0;
        end;
        //MESSAGE(Txt060);
    end;

    local procedure InsertImprestSurrenderLines(PayeeNo: Code[20]; DocumentNo: Code[20])
    begin
        PaymentLine.Reset;
        PaymentLine.SetRange("Document No.", DocumentNo);
        if PaymentLine.FindSet then
            PaymentLine.DeleteAll;

        ImprestSurrender.Reset;
        ImprestSurrender.SetRange("No.", PayeeNo);
        if ImprestSurrender.FindFirst then begin
            ImprestSurrender.CalcFields(ImprestSurrender.Difference);
            PaymentHeader.Reset;
            PaymentHeader.SetRange("No.", DocumentNo);
            if PaymentHeader.FindFirst then begin
                PaymentHeader."Global Dimension 1 Code" := ImprestSurrender."Global Dimension 1 Code";
                PaymentHeader."Global Dimension 2 Code" := ImprestSurrender."Global Dimension 2 Code";
                PaymentHeader."Shortcut Dimension 3 Code" := ImprestSurrender."Shortcut Dimension 3 Code";
                PaymentHeader."Shortcut Dimension 4 Code" := ImprestSurrender."Shortcut Dimension 4 Code";
                PaymentHeader."Shortcut Dimension 5 Code" := ImprestSurrender."Shortcut Dimension 5 Code";
                PaymentHeader."Shortcut Dimension 6 Code" := ImprestSurrender."Shortcut Dimension 6 Code";
                PaymentHeader."Shortcut Dimension 8 Code" := ImprestSurrender."Shortcut Dimension 7 Code";
            end;
            LineNo := 10000;
            PaymentLine.Init;
            PaymentLine."Line No." := LineNo;
            //PaymentLine."Payment Code":=
            PaymentLine."Account Type" := PaymentLine."Account Type"::Employee;
            PaymentLine."Document No." := DocumentNo;
            PaymentLine."Account No." := ImprestSurrender."Employee No.";
            PaymentLine."Account Name" := ImprestSurrender."Employee Name";
            PaymentLine.Description := Text105 + ImprestSurrender."Employee Name";   //ImprestHeader.Description;
            PaymentLine."Total Amount" := ImprestSurrender.Difference * -1;
            PaymentLine.Validate(PaymentLine."Total Amount");
            PaymentLine."Global Dimension 1 Code" := ImprestSurrender."Global Dimension 1 Code";
            PaymentLine."Global Dimension 2 Code" := ImprestSurrender."Global Dimension 2 Code";
            PaymentLine."Shortcut Dimension 3 Code" := ImprestSurrender."Shortcut Dimension 3 Code";
            PaymentLine."Shortcut Dimension 4 Code" := ImprestSurrender."Shortcut Dimension 4 Code";
            PaymentLine."Shortcut Dimension 5 Code" := ImprestSurrender."Shortcut Dimension 5 Code";
            PaymentLine."Shortcut Dimension 6 Code" := ImprestSurrender."Shortcut Dimension 6 Code";
            PaymentLine."Shortcut Dimension 8 Code" := ImprestSurrender."Shortcut Dimension 7 Code";
            PaymentLine.Insert;
        end;
        //MESSAGE(Txt060);
    end;
}

