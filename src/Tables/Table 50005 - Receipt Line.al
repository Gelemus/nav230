table 50005 "Receipt Line"
{
    Caption = 'Receipt Line';

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
            TableRelation = "Receipt Header"."No.";
        }
        field(3;"Document Type";Option)
        {
            Caption = 'Document Type';
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender";
        }
        field(4;"Receipt Code";Code[50])
        {
            Caption = 'Receipt Code';
            TableRelation = "Funds Transaction Code"."Transaction Code" WHERE ("Transaction Type"=CONST(Receipt));

            trigger OnValidate()
            begin
                "Account Type":="Account Type"::"G/L Account";
                "Account No.":='';
                "Posting Group":='';
                "Receipt Code Description":='';
                "VAT Code":='';
                "Withholding Tax Code":='';
                "Withholding VAT Code":='';
                FundsTransactionCodes.Reset;
                FundsTransactionCodes.SetRange(FundsTransactionCodes."Transaction Code","Receipt Code");
                if FundsTransactionCodes.FindFirst then begin
                  "Account Type":=FundsTransactionCodes."Account Type";
                  "Account No.":=FundsTransactionCodes."Account No.";
                  "Posting Group":=FundsTransactionCodes."Posting Group";
                  "Receipt Code Description":=FundsTransactionCodes.Description;
                  if FundsTransactionCodes."Include VAT" then
                      "VAT Code":=FundsTransactionCodes."VAT Code";
                  if FundsTransactionCodes."Include Withholding Tax" then
                      "Withholding Tax Code":=FundsTransactionCodes."Withholding Tax Code";
                  if FundsTransactionCodes."Include Withholding VAT" then
                      "Withholding VAT Code":=FundsTransactionCodes."Withholding VAT Code";
                  //Employee Transaction Type
                  "Employee Transaction Type":=FundsTransactionCodes."Transaction Type";
                end;

                Validate("Account No.");
            end;
        }
        field(5;"Receipt Code Description";Text[100])
        {
            Caption = 'Receipt Code Description';
            Editable = false;
        }
        field(6;"Account Type";Option)
        {
            Caption = 'Account Type';
            Editable = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(7;"Account No.";Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type"=CONST("G/L Account")) "G/L Account"."No."
                            ELSE IF ("Account Type"=CONST(Customer)) Customer."No."
                            ELSE IF ("Account Type"=CONST(Vendor)) Vendor."No."
                            ELSE IF ("Account Type"=CONST(Employee)) Employee."No.";

            trigger OnValidate()
            begin
                "Account Name":='';

                if "Account Type"="Account Type"::"G/L Account" then begin
                  if "G/LAccount".Get("Account No.") then begin
                    "Account Name":="G/LAccount".Name;
                  end;
                end;

                if "Account Type"="Account Type"::Customer then begin
                  if Customer.Get("Account No.") then begin
                    "Account Name":=Customer.Name;
                    ReceiptHeader.Reset;
                    ReceiptHeader.SetRange(ReceiptHeader."No.","Document No.");
                    if ReceiptHeader.FindFirst then begin
                      if ReceiptHeader."Received From"='' then
                      ReceiptHeader."Received From":=Customer.Name;
                      ReceiptHeader.Modify;
                    end;
                  end;
                end;

                if "Account Type"="Account Type"::Vendor then begin
                  if Vendor.Get("Account No.") then begin
                    "Account Name":=Vendor.Name;
                  end;
                end;

                if "Account Type"="Account Type"::Employee then begin
                  if Employee.Get("Account No.") then begin
                    "Account Name":=Employee.FullName;
                    ReceiptHeader.Reset;
                    if ReceiptHeader.Get("Account No.") then begin
                      ReceiptHeader."Received From":=Employee.FullName;
                      ReceiptHeader.Modify;
                    end;
                  end;
                end;
            end;
        }
        field(8;"Account Name";Text[50])
        {
            Caption = 'Account Name';
            Editable = false;
        }
        field(9;"Posting Group";Code[20])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = IF ("Account Type"=CONST(Customer)) "Customer Posting Group".Code
                            ELSE IF ("Account Type"=CONST(Vendor)) "Vendor Posting Group".Code
                            ELSE IF ("Account Type"=CONST(Employee)) "Employee Posting Group".Code;
        }
        field(10;Description;Text[100])
        {
            Caption = 'Description';
        }
        field(20;"Posting Date";Date)
        {
            Caption = 'Posting Date';
            Editable = false;
        }
        field(21;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(22;"Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
        }
        field(23;Amount;Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            begin
                "Net Amount":=Amount;
                if "Currency Code"<>'' then begin
                    "Amount(LCY)":= Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date","Currency Code",Amount,"Currency Factor"));
                    "Net Amount(LCY)":="Amount(LCY)";
                end else begin
                    "Amount(LCY)":=Amount;
                    "Net Amount(LCY)":=Amount;
                end;

                Validate("VAT Code");
                Validate("Withholding Tax Code");
            end;
        }
        field(24;"Amount(LCY)";Decimal)
        {
            Caption = 'Amount(LCY)';
            Editable = false;
        }
        field(25;"VAT Code";Code[10])
        {
            Caption = 'VAT Code';
            TableRelation = "Funds Tax Code"."Tax Code" WHERE (Type=CONST(VAT));
        }
        field(26;"VAT Amount";Decimal)
        {
            Caption = 'VAT Amount';
            Editable = false;
        }
        field(27;"VAT Amount(LCY)";Decimal)
        {
            Caption = 'VAT Amount(LCY)';
            Editable = false;
        }
        field(28;"Withholding Tax Code";Code[10])
        {
            Caption = 'Withholding Tax Code';
            TableRelation = "Funds Tax Code"."Tax Code" WHERE (Type=CONST("W/TAX"));
        }
        field(29;"Withholding Tax Amount";Decimal)
        {
            Caption = 'Withholding Tax Amount';
            Editable = false;
        }
        field(30;"Withholding Tax Amount(LCY)";Decimal)
        {
            Caption = 'Withholding Tax Amount(LCY)';
            Editable = false;
        }
        field(31;"Withholding VAT Code";Code[10])
        {
            Caption = 'Withholding VAT Code';
            TableRelation = "Funds Tax Code"."Tax Code" WHERE (Type=CONST("W/VAT"));
        }
        field(32;"Withholding VAT Amount";Decimal)
        {
            Caption = 'Withholding VAT Amount';
            Editable = false;
        }
        field(33;"Withholding VAT Amount(LCY)";Decimal)
        {
            Caption = 'Withholding VAT Amount(LCY)';
            Editable = false;
        }
        field(34;"Net Amount";Decimal)
        {
            Caption = 'Net Amount';
            Editable = false;
        }
        field(35;"Net Amount(LCY)";Decimal)
        {
            Caption = 'Net Amount(LCY)';
            Editable = false;
        }
        field(36;"Applies-to Doc. Type";Option)
        {
            Caption = 'Applies-to Doc. Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Invoice,SCMProFit Job';
            OptionMembers = " ",Invoice,"SCMProFit Job";
        }
        field(37;"Applies-to Doc. No.";Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                VendLedgEntry: Record "Vendor Ledger Entry";
                PayToVendorNo: Code[20];
                OK: Boolean;
                Text000: Label 'You must specify %1 or %2.';
            begin
                with Rec do begin
                  Amount:=0;
                  Validate(Amount);
                  BillToCustNo := Rec."Account No." ;
                  CustLedgEntry.SetCurrentKey("Customer No.",Open);
                  CustLedgEntry.SetRange("Customer No.", BillToCustNo);
                  CustLedgEntry.SetRange(Open,true);
                  if "Applies-to ID" = '' then
                    "Applies-to ID" := "Document No.";
                  if "Applies-to ID" = '' then
                    Error(
                      Text000,
                      FieldCaption("Document No."),FieldCaption("Applies-to ID"));
                  ApplyCustEntries.SetReceiptLine(Rec,Rec.FieldNo("Applies-to ID"));
                  ApplyCustEntries.SetRecord(CustLedgEntry);
                  ApplyCustEntries.SetTableView(CustLedgEntry);
                  ApplyCustEntries.LookupMode(true);
                  OK := ApplyCustEntries.RunModal = ACTION::LookupOK;
                  Clear(ApplyCustEntries);
                  if not OK then
                    exit;
                  CustLedgEntry.Reset;
                  CustLedgEntry.SetCurrentKey("Customer No.",Open);
                  CustLedgEntry.SetRange("Customer No.", BillToCustNo);
                  CustLedgEntry.SetRange(Open,true);
                  CustLedgEntry.SetRange("Applies-to ID","Applies-to ID");
                  if CustLedgEntry.Find('-') then begin
                    "Applies-to Doc. Type" :=CustLedgEntry."Applies-to Doc. Type";
                    "Applies-to Doc. No.":=  CustLedgEntry."Applies-to Doc. No.";
                  end else
                    "Applies-to ID" := '';

                end;
                //Calculate Total Amount
                  CustLedgEntry.Reset;
                  CustLedgEntry.SetCurrentKey("Customer No.",Open,"Applies-to ID");
                  CustLedgEntry.SetRange("Customer No.", BillToCustNo);
                  CustLedgEntry.SetRange(Open,true);
                  CustLedgEntry.SetRange("Applies-to ID","Applies-to ID");
                  if CustLedgEntry.FindFirst then begin
                      CustLedgEntry.CalcSums(CustLedgEntry."Amount to Apply");
                      Amount:=Abs(CustLedgEntry."Amount to Apply");
                      Validate(Amount);
                  end;
            end;
        }
        field(38;"Applies-to ID";Code[20])
        {
            Caption = 'Applies-to ID';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                TempVendLedgEntry: Record "Vendor Ledger Entry";
            begin
                if ("Applies-to ID" <> xRec."Applies-to ID") and (xRec."Applies-to ID" <> '') then begin
                  CustLedgEntry.SetCurrentKey("Customer No.",Open);
                  CustLedgEntry.SetRange("Customer No.","Account No.");
                  CustLedgEntry.SetRange(Open,true);
                  CustLedgEntry.SetRange("Applies-to ID",xRec."Applies-to ID");
                  if CustLedgEntry.FindFirst then
                   CustEntrySetAppliesToID.SetApplId(CustLedgEntry,TempCustLedgEntry,'');
                  CustLedgEntry.Reset;
                  end;
            end;
        }
        field(39;Committed;Boolean)
        {
            Caption = 'Committed';
            Editable = false;
        }
        field(40;"Budget Code";Code[20])
        {
            Caption = 'Budget Code';
        }
        field(50;"Global Dimension 1 Code";Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(51;"Global Dimension 2 Code";Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
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
        field(52136965;"Job No.";Code[20])
        {
            Description = 'SCMProFit Integration';
        }
        field(52137023;"Employee Transaction Type";Option)
        {
            Caption = 'Employee Transaction Type';
            Description = '//Sysre NextGen Addon-Categories Employee Transactions';
            OptionCaption = ' ,NetPay,Imprest';
            OptionMembers = " ",NetPay,Imprest;
        }
        field(52137640;"Loan Account No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137641;"Loan Transaction Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Loan Disbursed,Principal Receivable,Principal Paid,Interest Receivable,Interest Paid,Penalty Receivable,Penalty Paid,Loan Charge Receivable,Loan Charge Paid';
            OptionMembers = " ","Loan Disbursed","Principal Receivable","Principal Paid","Interest Receivable","Interest Paid","Penalty Receivable","Penalty Paid","Loan Charge Receivable","Loan Charge Paid";
        }
        field(52137862;"Investment Application No.";Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                InvestmentApplications.RESET;
                InvestmentApplications.SETRANGE(InvestmentApplications."No.","Investment Application No.");
                IF InvestmentApplications.FINDFIRST THEN BEGIN
                  ReceiptHeader.RESET;
                  ReceiptHeader.SETRANGE(ReceiptHeader."No.","Document No.");
                  IF ReceiptHeader.FINDFIRST THEN BEGIN
                    IF ReceiptHeader."Received From"='' THEN
                    ReceiptHeader."Received From":=InvestmentApplications.Name;
                    ReceiptHeader.MODIFY;
                  END;
                END;
                */

            end;
        }
        field(52137863;"Investment Account No.";Code[20])
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
        ReceiptHeader.Reset;
        ReceiptHeader.SetRange(ReceiptHeader."No.","Document No.");
        if ReceiptHeader.FindFirst then begin
          ReceiptHeader.TestField(ReceiptHeader.Status,ReceiptHeader.Status::Open);
        end;
    end;

    trigger OnInsert()
    begin
        ReceiptHeader.Reset;
        ReceiptHeader.SetRange(ReceiptHeader."No.","Document No.");
        if ReceiptHeader.FindFirst then begin
          ReceiptHeader.TestField(ReceiptHeader.Description);
          Description:=ReceiptHeader.Description;
          "Document Type":="Document Type"::Receipt;
          "Posting Date":=ReceiptHeader."Posting Date";
          "Currency Code":=ReceiptHeader."Currency Code";
          "Currency Factor":=ReceiptHeader."Currency Factor";
          "Global Dimension 1 Code":=ReceiptHeader."Global Dimension 1 Code";
          "Global Dimension 2 Code":=ReceiptHeader."Global Dimension 2 Code";
          "Shortcut Dimension 3 Code":=ReceiptHeader."Shortcut Dimension 3 Code";
          "Shortcut Dimension 4 Code":=ReceiptHeader."Shortcut Dimension 4 Code";
          "Shortcut Dimension 5 Code":=ReceiptHeader."Shortcut Dimension 5 Code";
          "Shortcut Dimension 6 Code":=ReceiptHeader."Shortcut Dimension 6 Code";
          "Shortcut Dimension 7 Code":=ReceiptHeader."Shortcut Dimension 7 Code";
          "Shortcut Dimension 8 Code":=ReceiptHeader."Shortcut Dimension 8 Code";
          "Responsibility Center":=ReceiptHeader."Responsibility Center";
        end;
    end;

    var
        Text000: Label 'You must specify %1 or %2';
        FundsTransactionCodes: Record "Funds Transaction Code";
        FundsTaxCodes: Record "Funds Tax Code";
        "G/LAccount": Record "G/L Account";
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
        Employee: Record Employee;
        ReceiptHeader: Record "Receipt Header";
        ReceiptLine: Record "Receipt Line";
        CurrExchRate: Record "Currency Exchange Rate";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        EmplLedgEntry: Record "Employee Ledger Entry";
        BillToCustNo: Code[30];
        ApplyCustEntries: Page "Apply Customer Entries";
        CustEntrySetAppliesToID: Codeunit "Cust. Entry-SetAppl.ID";
        TempCustLedgEntry: Record "Cust. Ledger Entry";

    [Scope('Internal')]
    procedure LookUpAppliesToDocCust(AccNo: Code[20])
    var
        ApplyCustEntries: Page "Apply Customer Entries";
    begin
        /*CLEAR(CustLedgEntry);
        CustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive,"Due Date");
        IF AccNo <> '' THEN
          CustLedgEntry.SETRANGE("Customer No.",AccNo);
        CustLedgEntry.SETRANGE(Open,TRUE);
        IF "Applies-to Doc. No." <> '' THEN BEGIN
          CustLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          CustLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
          IF CustLedgEntry.ISEMPTY THEN BEGIN
            CustLedgEntry.SETRANGE("Document Type");
            CustLedgEntry.SETRANGE("Document No.");
          END;
        END;
        IF "Applies-to ID" <> '' THEN BEGIN
          CustLedgEntry.SETRANGE("Applies-to ID","Applies-to ID");
          IF CustLedgEntry.ISEMPTY THEN
            CustLedgEntry.SETRANGE("Applies-to ID");
        END;
        IF "Applies-to Doc. Type" <> "Applies-to Doc. Type"::" " THEN BEGIN
          CustLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          IF CustLedgEntry.ISEMPTY THEN
            CustLedgEntry.SETRANGE("Document Type");
        END;
        IF Amount <> 0 THEN BEGIN
          CustLedgEntry.SETRANGE(Positive,Amount < 0);
          IF CustLedgEntry.ISEMPTY THEN
            CustLedgEntry.SETRANGE(Positive);
        END;
        ApplyCustEntries.SetReceiptLine(Rec,ReceiptLine.FIELDNO("Applies-to Doc. No."));
        ApplyCustEntries.SETTABLEVIEW(CustLedgEntry);
        ApplyCustEntries.SETRECORD(CustLedgEntry);
        ApplyCustEntries.LOOKUPMODE(TRUE);
        IF ApplyCustEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
          ApplyCustEntries.GETRECORD(CustLedgEntry);
          IF AccNo = '' THEN BEGIN
            AccNo := CustLedgEntry."Customer No.";
            VALIDATE("Account No.",AccNo);
          END;
          SetAmountWithCustLedgEntry;
          "Applies-to Doc. Type" := CustLedgEntry."Document Type";
          "Applies-to Doc. No." := CustLedgEntry."Document No.";
          "Applies-to ID" := '';
        END;*/

    end;

    [Scope('Internal')]
    procedure LookUpAppliesToDocVend(AccNo: Code[20])
    var
        ApplyVendEntries: Page "Apply Vendor Entries";
    begin
        /*CLEAR(VendLedgEntry);
        VendLedgEntry.SETCURRENTKEY("Vendor No.",Open,Positive,"Due Date");
        IF AccNo <> '' THEN
          VendLedgEntry.SETRANGE("Vendor No.",AccNo);
        VendLedgEntry.SETRANGE(Open,TRUE);
        IF "Applies-to Doc. No." <> '' THEN BEGIN
          VendLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          VendLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
          IF VendLedgEntry.ISEMPTY THEN BEGIN
            VendLedgEntry.SETRANGE("Document Type");
            VendLedgEntry.SETRANGE("Document No.");
          END;
        END;
        IF "Applies-to ID" <> '' THEN BEGIN
          VendLedgEntry.SETRANGE("Applies-to ID","Applies-to ID");
          IF VendLedgEntry.ISEMPTY THEN
            VendLedgEntry.SETRANGE("Applies-to ID");
        END;
        IF "Applies-to Doc. Type" <> "Applies-to Doc. Type"::" " THEN BEGIN
          VendLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          IF VendLedgEntry.ISEMPTY THEN
            VendLedgEntry.SETRANGE("Document Type");
        END;
        IF  "Applies-to Doc. No." <> ''THEN BEGIN
          VendLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
          IF VendLedgEntry.ISEMPTY THEN
            VendLedgEntry.SETRANGE("Document No.");
        END;
        IF Amount <> 0 THEN BEGIN
          VendLedgEntry.SETRANGE(Positive,Amount < 0);
          IF VendLedgEntry.ISEMPTY THEN;
          VendLedgEntry.SETRANGE(Positive);
        END;
        ApplyVendEntries.SetGenJnlLine(Rec,GenJnlLine.FIELDNO("Applies-to Doc. No."));
        ApplyVendEntries.SETTABLEVIEW(VendLedgEntry);
        ApplyVendEntries.SETRECORD(VendLedgEntry);
        ApplyVendEntries.LOOKUPMODE(TRUE);
        IF ApplyVendEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
          ApplyVendEntries.GETRECORD(VendLedgEntry);
          IF AccNo = '' THEN BEGIN
            AccNo := VendLedgEntry."Vendor No.";
            IF "Bal. Account Type" = "Bal. Account Type"::Vendor THEN
              VALIDATE("Bal. Account No.",AccNo)
            ELSE
              VALIDATE("Account No.",AccNo);
          END;
          SetAmountWithVendLedgEntry;
          "Applies-to Doc. Type" := VendLedgEntry."Document Type";
          "Applies-to Doc. No." := VendLedgEntry."Document No.";
          "Applies-to ID" := '';
        END;
        */

    end;

    [Scope('Internal')]
    procedure LookUpAppliesToDocEmpl(AccNo: Code[20])
    var
        ApplyEmplEntries: Page "Apply Employee Entries";
    begin
        /*CLEAR(EmplLedgEntry);
        EmplLedgEntry.SETCURRENTKEY("Employee No.",Open,Positive);
        IF AccNo <> '' THEN
          EmplLedgEntry.SETRANGE("Employee No.",AccNo);
        EmplLedgEntry.SETRANGE(Open,TRUE);
        IF "Applies-to Doc. No." <> '' THEN BEGIN
          EmplLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          EmplLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
          IF EmplLedgEntry.ISEMPTY THEN BEGIN
            EmplLedgEntry.SETRANGE("Document Type");
            EmplLedgEntry.SETRANGE("Document No.");
          END;
        END;
        IF "Applies-to ID" <> '' THEN BEGIN
          EmplLedgEntry.SETRANGE("Applies-to ID","Applies-to ID");
          IF EmplLedgEntry.ISEMPTY THEN
            EmplLedgEntry.SETRANGE("Applies-to ID");
        END;
        IF "Applies-to Doc. Type" <> "Applies-to Doc. Type"::" " THEN BEGIN
          EmplLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          IF EmplLedgEntry.ISEMPTY THEN
            EmplLedgEntry.SETRANGE("Document Type");
        END;
        IF  "Applies-to Doc. No." <> '' THEN BEGIN
          EmplLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
          IF EmplLedgEntry.ISEMPTY THEN
            EmplLedgEntry.SETRANGE("Document No.");
        END;
        IF Amount <> 0 THEN BEGIN
          EmplLedgEntry.SETRANGE(Positive,Amount < 0);
          IF EmplLedgEntry.ISEMPTY THEN;
          EmplLedgEntry.SETRANGE(Positive);
        END;
        ApplyEmplEntries.SetGenJnlLine(Rec,GenJnlLine.FIELDNO("Applies-to Doc. No."));
        ApplyEmplEntries.SETTABLEVIEW(EmplLedgEntry);
        ApplyEmplEntries.SETRECORD(EmplLedgEntry);
        ApplyEmplEntries.LOOKUPMODE(TRUE);
        IF ApplyEmplEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
          ApplyEmplEntries.GETRECORD(EmplLedgEntry);
          IF AccNo = '' THEN BEGIN
            AccNo := EmplLedgEntry."Employee No.";
            IF "Bal. Account Type" = "Bal. Account Type"::Employee THEN
              VALIDATE("Bal. Account No.",AccNo)
            ELSE
              VALIDATE("Account No.",AccNo);
          END;
          SetAmountWithEmplLedgEntry;
          "Applies-to Doc. Type" := EmplLedgEntry."Document Type";
          "Applies-to Doc. No." := EmplLedgEntry."Document No.";
          "Applies-to ID" := '';
        END;
        */

    end;
}

