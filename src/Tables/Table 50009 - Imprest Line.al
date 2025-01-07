table 50009 "Imprest Line"
{
    Caption = 'Imprest Line';

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
            TableRelation = "Imprest Header"."No.";
        }
        field(3;"Document Type";Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender";
        }
        field(4;"Imprest Code";Code[50])
        {
            Caption = 'Imprest Code';
            TableRelation = IF ("Imprest Types"=FILTER("General Imprest"|Safari),
                                Type=CONST(Imprest)) "Funds Transaction Code"."Transaction Code" WHERE ("Transaction Type"=CONST(Imprest),
                                                                                                        "Account Type"=FILTER("G/L Account"))
                                                                                                        ELSE IF ("Imprest Types"=FILTER(Pettycash),
                                                                                                                 Type=CONST(Imprest)) "Funds Transaction Code"."Transaction Code" WHERE ("Transaction Type"=CONST(Imprest),
                                                                                                                                                                                         "Account Type"=FILTER("Bank Account"))
                                                                                                                                                                                         ELSE IF ("Imprest Types"=CONST(Pettycash),
                                                                                                                                                                                                  Type=CONST("Petty Cash")) "Funds Transaction Code"."Transaction Code" WHERE ("Transaction Type"=CONST(Imprest),
                                                                                                                                                                                                                                                                               "Account Type"=CONST("G/L Account"));

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                "Account Type":="Account Type"::"G/L Account";
                "Account No.":='';
                "Posting Group":='';
                "Imprest Code Description":='';

                FundsTransactionCodes.Reset;
                FundsTransactionCodes.SetRange(FundsTransactionCodes."Transaction Code","Imprest Code");
                if FundsTransactionCodes.FindFirst then begin
                  "Account Type":=FundsTransactionCodes."Account Type";
                  "Account No.":=FundsTransactionCodes."Account No.";
                  "Account Name":=FundsTransactionCodes."Account Name";
                  "Posting Group":=FundsTransactionCodes."Posting Group";
                  "Imprest Code Description":=FundsTransactionCodes.Description;

                end;

                Validate("Account No.");
                Validate(City);
            end;
        }
        field(5;"Imprest Code Description";Text[100])
        {
            Caption = 'Imprest Code Description';
            Editable = false;
        }
        field(6;"Account Type";Option)
        {
            Caption = 'Account Type';
            Editable = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee,Item';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Item;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(7;"Account No.";Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type"=CONST("G/L Account")) "G/L Account"."No." WHERE ("Direct Posting"=CONST(true))
                            ELSE IF ("Account Type"=CONST(Customer)) Customer."No."
                            ELSE IF ("Account Type"=CONST(Vendor)) Vendor."No."
                            ELSE IF ("Account Type"=CONST(Employee)) Employee."No."
                            ELSE IF ("Account Type"=CONST("Bank Account")) "Bank Account Ledger Entry"."Bank Account No.";

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);

                "Account Name":='';
                if "Account Type"="Account Type"::"G/L Account" then begin
                  if "G/LAccount".Get("Account No.") then begin
                    "Account Name":="G/LAccount".Name;
                  end;
                end;

                if "Account Type"="Account Type"::Customer then begin
                  if Customer.Get("Account No.") then begin
                    "Account Name":=Customer.Name;
                  end;
                end;

                if "Account Type"="Account Type"::Vendor then begin
                  if Vendor.Get("Account No.") then begin
                    "Account Name":=Vendor.Name;
                  end;
                end;

                if "Account Type"="Account Type"::Employee then begin
                  if Employee.Get("Account No.") then begin
                    "Account Name":=Employee."First Name"+' '+Employee."Middle Name"+' '+Employee."Last Name";
                  end;
                end;


                if "Account Type"="Account Type"::"Fixed Asset" then begin
                  if FixedAsset.Get("Account No.") then begin
                    "Account Name":=FixedAsset.Description;
                     end;
                     DepreciationBook.Reset;
                     DepreciationBook.SetRange(DepreciationBook."FA No.","Account No.");
                     if DepreciationBook.FindFirst then begin
                       "FA Depreciation Book":=DepreciationBook."Depreciation Book Code";
                       end;
                end;
            end;
        }
        field(8;"Account Name";Text[100])
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

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(10;Description;Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(20;"Posting Date";Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                Validate("Gross Amount");
            end;
        }
        field(21;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(22;"Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
        }
        field(23;"Gross Amount";Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            var
                FundsTaxCode: Record "Funds Tax Code";
            begin
                TestStatusOpen(true);

                "Tax Amount":=0;
                "Net Amount":=0;
                FundsTransactionCodes.Reset;
                FundsTransactionCodes.SetRange(FundsTransactionCodes."Transaction Code","Imprest Code");
                if FundsTransactionCodes.FindFirst then begin
                 if "Gross Amount">FundsTransactionCodes."Minimum Non Taxable Amount" then
                   if FundsTransactionCodes."Include Withholding Tax" then begin
                     FundsTransactionCodes.TestField("Withholding Tax Code");
                     FundsTaxCode.Get(FundsTransactionCodes."Withholding Tax Code");
                      "Tax Amount":=(FundsTaxCode.Percentage*"Gross Amount")/100;


                    end

                end;
                 "Net Amount":="Gross Amount"-"Tax Amount";
                if "Currency Code"<>'' then begin
                  "Gross Amount(LCY)":= Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date","Currency Code","Gross Amount","Currency Factor"));
                end else begin
                  "Gross Amount(LCY)":="Gross Amount";
                end;
            end;
        }
        field(24;"Gross Amount(LCY)";Decimal)
        {
            Caption = 'Amount(LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(25;Quantity;Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Gross Amount":="Unit Amount"*Quantity;
                Validate("Gross Amount");
            end;
        }
        field(26;"Tax Amount";Decimal)
        {
            Caption = 'Tax Amount';
            Editable = false;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(27;"Net Amount";Decimal)
        {
            Caption = 'Net Amount';
            Editable = false;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(28;"Unit Amount";Decimal)
        {
            Caption = 'Unit Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                "Gross Amount":="Unit Amount"*Quantity;
                Validate("Gross Amount");

                BalanceAmt:= 0;
                Amount:= 0;

                BankAccount.Reset;
                BankAccount.SetRange("No.","Account No.");
                if BankAccount.FindSet then begin
                  BankAccount.CalcFields(BankAccount.Balance);
                 if "Account Type" = "Account Type"::"Bank Account" then begin
                  Float:=BankAccount."Float Amount";
                  BalanceAmt:= BankAccount.Balance;
                  Amount:= Float-BalanceAmt;
                  //MESSAGE('You Cannot request more than your remaining float amount %1 balanceAmt %2 Amount %3',Float,BalanceAmt,Amount);
                end;
                end;
            end;
        }
        field(39;"Budget Committed";Boolean)
        {
            Caption = 'Committed';
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
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);
            end;
        }
        field(51;"Global Dimension 2 Code";Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);
            end;
        }
        field(52;"Shortcut Dimension 3 Code";Code[50])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);
            end;
        }
        field(53;"Shortcut Dimension 4 Code";Code[50])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);
            end;
        }
        field(54;"Shortcut Dimension 5 Code";Code[50])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(55;"Shortcut Dimension 6 Code";Code[50])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(56;"Shortcut Dimension 7 Code";Code[50])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(57;"Shortcut Dimension 8 Code";Code[50])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(58;"Responsibility Center";Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center".Code;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(70;Status;Option)
        {
            Caption = 'Status';
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
        field(79;"FA Depreciation Book";Code[30])
        {
        }
        field(100;"Activity Date";Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Imprest Code":='';
                "Imprest Code Description":='';
                //Amount:=0;
                "Gross Amount(LCY)":=0;
                "From City":='';
                "To City":='';
                City:='';
                "Account No.":='';
                "Account Name":='';
            end;
        }
        field(101;"From City";Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Lookup Values".Code WHERE (Type=CONST(City));
        }
        field(102;"To City";Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Lookup Values".Code WHERE (Type=CONST(City));

            trigger OnValidate()
            begin
                City:='';
                TestField("From City");
                if "To City"="From City" then begin
                  Error(Error001);
                end;

                AlowanceMatrix.Reset;
                AlowanceMatrix.SetRange(AlowanceMatrix."Allowance Code","Imprest Code");
                AlowanceMatrix.SetRange(AlowanceMatrix.From,"From City");
                AlowanceMatrix.SetRange(AlowanceMatrix.Tos,"To City");
                if AlowanceMatrix.FindFirst then begin
                  "Gross Amount":=AlowanceMatrix.Amount;
                  "Gross Amount(LCY)":="Gross Amount";
                end;
            end;
        }
        field(103;"HR Job Grade";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale";
        }
        field(104;City;Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Lookup Values".Code WHERE (Type=CONST(City));

            trigger OnValidate()
            begin
                "From City":='';
                "To City":='';
                Validate("Gross Amount",0);
                CityCodes.Reset;
                CityCodes.SetRange(CityCodes.Code,City);
                if CityCodes.FindFirst then begin
                  AlowanceMatrix.Reset;
                  AlowanceMatrix.SetRange(AlowanceMatrix."Job Group","HR Job Grade");
                  AlowanceMatrix.SetRange(AlowanceMatrix."Allowance Code","Imprest Code");
                  AlowanceMatrix.SetRange(AlowanceMatrix.Tos,CityCodes.Code);
                  if AlowanceMatrix.FindFirst then begin
                     "Unit Amount":=AlowanceMatrix.Amount;
                    "Gross Amount":="Unit Amount"*Quantity;
                    Validate("Gross Amount");
                  end;
                end;
            end;
        }
        field(105;"Imprest Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Normal,DSA';
            OptionMembers = Normal,DSA;
        }
        field(106;"Employee No";Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then
                begin
                  "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                  "Telephone No." := Employee."Mobile Phone No.";
                  "HR Job Grade" :=Employee."Salary Scale";
                  "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                  "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                end;
            end;
        }
        field(107;"Bank Name";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(108;"Bank Branch";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(109;"Bank A/C No.";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(110;"Hourly rate";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(111;"Overtime Date";Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Daytype: Option "Normal Day","Off Day",Holiday;
            begin
                ImprestHeader.Reset;
                ImprestHeader.SetRange(ImprestHeader."No.","Document No.");
                if ImprestHeader.FindFirst then;
                ImprestHeader.TestField("Employee No.");
                Employee.Get(ImprestHeader."Employee No.");
                PayrollSetup.Get(Employee."Payroll Code");
                PayrollSetup.TestField("Weekend OT Rate");
                PayrollSetup.TestField("Normal OT Rate");
                PayrollSetup.TestField("Holiday OT Rate");
                PayrollSetup.TestField("Standard Hours");
                PayrollSetup.TestField("Basic Pay E/D Code");


                "Basic Pay":=Employee."Fixed Pay";

                PayrollEntry.Reset;
                PayrollEntry.SetRange("Employee No.", ImprestHeader."Employee No.");
                PayrollEntry.SetRange("ED Code", PayrollSetup."Basic Pay E/D Code");
                if PayrollEntry.FindLast then
                  "Basic Pay":=PayrollEntry.Amount;

                "Hourly rate":=Round("Basic Pay"/PayrollSetup."Standard Hours",1);
                Daytype:=GetDayType("Overtime Date");
                if Daytype=Daytype::Holiday then
                "Overtime Rate":=PayrollSetup."Holiday OT Rate"
                else if Daytype=Daytype::"Off Day" then
                "Overtime Rate":=PayrollSetup."Weekend OT Rate"
                else
                "Overtime Rate":=PayrollSetup."Normal OT Rate";
                "Unit Amount":="Overtime Rate"*"Hourly rate";

                Validate(Quantity);
                Validate("Gross Amount");
            end;
        }
        field(112;"Overtime Rate";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(113;"Basic Pay";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(114;"Reference No.";Code[100])
        {
            Caption = 'Reference No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);
                /*
                ImprestHeader.RESET;
                ImprestHeader.SETRANGE(ImprestHeader."Reference No.","Reference No.");
                IF ImprestHeader.FINDSET THEN BEGIN
                  REPEAT
                    IF ImprestHeader."No."<>"No." THEN
                      ERROR("ErrorUsedReferenceNo.",ImprestHeader."No.");
                  UNTIL ImprestHeader.NEXT=0;
                END;
                */

            end;
        }
        field(115;"Telephone No.";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(116;"Employee Name";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(117;"Work Done on Standby";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(118;"Date Paid";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(119;"ID No.";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(120;"Daily Rate";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(121;"Day 1";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(122;"Day 2";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(123;"Day 3";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(124;"Day 4";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(125;"Day 5";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(126;"Day 6";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(127;"Day 7";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(128;"Total Days";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(129;Names;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(130;"Casual Payment";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(131;"No of Meters/Others";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50243;"Imprest Types";Option)
        {
            CalcFormula = Lookup("Imprest Header"."Imprest Type" WHERE ("No."=FIELD("Document No.")));
            FieldClass = FlowField;
            OptionCaption = 'General Imprest,Pettycash,Safari';
            OptionMembers = "General Imprest",Pettycash,Safari;
        }
        field(50244;Type;Option)
        {
            CalcFormula = Lookup("Imprest Header".Type WHERE ("No."=FIELD("Document No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Imprest,Petty Cash,Board Allowance,Overtime,Casuals Payment,Casual Daily Worksheet,Standing Imprest';
            OptionMembers = " ",Imprest,"Petty Cash","Board Allowance",Overtime,"Casuals Payment","Casual Daily Worksheet","Standing Imprest";
        }
        field(50245;Committed;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50246;"Item Budget Gl";Code[10])
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
        TestStatusOpen(true);
    end;

    trigger OnInsert()
    begin
        ImprestHeader.Reset;
        ImprestHeader.SetRange(ImprestHeader."No.","Document No.");
        if ImprestHeader.FindFirst then begin
          ImprestHeader.TestField("Date From");
          ImprestHeader.TestField("Date To");
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
          "Employee Name" := ImprestHeader."Employee Name";
          Quantity:=ImprestHeader."Date To"-ImprestHeader."Date From";
          if Quantity=0 then
            Quantity:=1;
          if ImprestHeader.Type = ImprestHeader.Type::Overtime then Quantity := 1;

        end;
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
        PayrollSetup: Record "Payroll Setups";
        PayrollEntry: Record "Payroll Entry";
        ImprestHeader2: Record "Imprest Header";
        PayrollHeader: Record "Payroll Header";
        Float: Decimal;
        BalanceAmt: Decimal;
        Amount: Decimal;

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

    local procedure GetDayType(DayDate: Date): Integer
    var
        Holidays: Record "HR Base Calendar Change";
        Daytype: Option "Normal Day","Off Day",Holiday;
    begin
        Holidays.Reset;
        Holidays.SetRange(Date,DayDate);
        Holidays.SetRange(Nonworking,true);
        if Holidays.FindFirst then
          exit(Daytype::Holiday)
        else begin

         if GetDayName(DayDate)=7 then
            exit(Daytype::"Off Day")
          else
            exit(Daytype::"Normal Day")
        end
    end;

    procedure GetDayName(Date: Date): Integer
    var
        DateTable: Record Date;
    begin
          DateTable.SetRange("Period Type",DateTable."Period Type"::Date);
          DateTable.SetRange("Period Start",Date);
          if DateTable.FindFirst then
            exit(DateTable."Period No.");
    end;

    local procedure GetAllAmount(EmpNO: Code[20];EdCode: Code[20];PeriodFilter: Code[10]) AllAmt: Decimal
    begin
        //get house allowance
        Employee.SetRange("No.",EmpNO);
        Employee.SetFilter("Period Filter",PeriodFilter);
        Employee.SetFilter("ED Code Filter",EdCode);
        Employee.CalcFields(Amount);
        AllAmt:=Employee.Amount;
    end;
}

