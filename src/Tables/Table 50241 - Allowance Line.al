table 50241 "Allowance Line"
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
            TableRelation = "Allowance Header"."No.";
        }
        field(3;"Document Type";Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender,Allowance';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender",Allowance;
        }
        field(4;"Allowance Code";Code[50])
        {
            Caption = 'Allowance Code';
            TableRelation = "Funds Transaction Code"."Transaction Code" WHERE ("Transaction Type"=CONST(Allowance));

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                "Account Type":="Account Type"::"G/L Account";
                "Account No.":='';
                "Posting Group":='';
                "Allowance Code Description":='';

                FundsTransactionCodes.Reset;
                FundsTransactionCodes.SetRange(FundsTransactionCodes."Transaction Code","Allowance Code");
                if FundsTransactionCodes.FindFirst then begin
                  "Account Type":=FundsTransactionCodes."Account Type";
                  "Account No.":=FundsTransactionCodes."Account No.";
                  "Posting Group":=FundsTransactionCodes."Posting Group";
                  "Allowance Code Description":=FundsTransactionCodes.Description;

                end;

                Validate("Account No.");
                Validate(City);

                //Get Hourly Pay
                BasicAmount:=0;
                AnnualHours:=0;
                HourlyPay:=0;
                Lines.Reset;
                Lines.SetRange("Employee No.","Employee No");
                Lines.SetRange(Lines."ED Code",'BASIC');
                if Lines.FindLast then begin
                BasicAmount:=Lines.Amount;
                AnnualBasic:= BasicAmount*12;
                AnnualHours:= 40*52;
                HourlyPay:= AnnualBasic/AnnualHours;
                end;
                if "Allowance Code" = 'NORMAL OVERTIME' then
                  begin
                  "Unit Amount":=HourlyPay*1.5;
                  end
                  else if "Allowance Code" = 'WEEKEND OVERTIME' then
                    begin
                    "Unit Amount":=HourlyPay*2;
                    end
                    else if "Allowance Code" = 'TASK TEAM' then
                      begin
                        "Unit Amount":=500;
                      end
                      else if "Allowance Code" = 'PERSONAL GUIDE' then
                        begin
                          "Unit Amount":=BasicAmount*0.5;
                        end
                        else if "Allowance Code" = 'HEALTH RISK' then
                        begin
                          "Unit Amount":=0;
                        end
                        else if "Allowance Code" = 'BAGGAGE' then
                        begin
                          "Unit Amount":=BasicAmount*1;
                        end else
                    HourlyPay:=0;
            end;
        }
        field(5;"Allowance Code Description";Text[100])
        {
            Caption = 'Allowance Code Description';
            Editable = false;
        }
        field(6;"Account Type";Option)
        {
            Caption = 'Account Type';
            Editable = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;

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
                            ELSE IF ("Account Type"=CONST(Employee)) Employee."No.";

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
                FundsTransactionCodes.SetRange(FundsTransactionCodes."Transaction Code","Allowance Code");
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
                //Get Basic Pay
                BasicAmount:=0;
                AnnualHours:=0;
                HourlyPay:=0;
                Lines.Reset;
                Lines.SetRange("Employee No.","Employee No");
                //Lines.SETRANGE("Payroll ID","Start Period");
                //Lines.SETRANGE("Payroll Code","Payroll Code");
                //Lines.SETRANGE(Lines."ED Code",PayrollSetupRec."Basic Pay E/D Code");
                Lines.SetRange(Lines."ED Code",'BASIC');
                if Lines.FindLast then begin
                BasicAmount:=Lines.Amount;
                AnnualBasic:= BasicAmount*12;
                AnnualHours:= 40*52;
                HourlyPay:= AnnualBasic/AnnualHours;
                end;
                if "Allowance Code" = 'NORMAL OVERTIME' then begin
                  "Unit Amount":=HourlyPay*1.5;
                  end else if "Allowance Code" = 'WEEKEND OVERTIME' then begin
                    "Unit Amount":=HourlyPay*2;
                    end else
                    HourlyPay:=0;
                "Gross Amount":="Unit Amount"*Quantity;
                Validate("Gross Amount");
                if Quantity>40 then
                  Error('Maximum number of hours cannot exceed the recommended Hours');
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
        field(50;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(51;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(52;"Shortcut Dimension 3 Code";Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(53;"Shortcut Dimension 4 Code";Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(54;"Shortcut Dimension 5 Code";Code[20])
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
        field(55;"Shortcut Dimension 6 Code";Code[20])
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
        field(56;"Shortcut Dimension 7 Code";Code[20])
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
        field(57;"Shortcut Dimension 8 Code";Code[20])
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
                "Allowance Code":='';
                "Allowance Code Description":='';
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
                AlowanceMatrix.SetRange(AlowanceMatrix."Allowance Code","Allowance Code");
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
                  AlowanceMatrix.SetRange(AlowanceMatrix."Allowance Code","Allowance Code");
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
        AllowanceHeader.Reset;
        AllowanceHeader.SetRange(AllowanceHeader."No.","Document No.");
        if AllowanceHeader.FindFirst then begin
          AllowanceHeader.TestField("Date From");
          AllowanceHeader.TestField("Date To");
          Description:=AllowanceHeader.Description;
          "Document Type":="Document Type"::Allowance;
          "Posting Date":=AllowanceHeader."Posting Date";
          "Currency Code":=AllowanceHeader."Currency Code";
          "Currency Factor":=AllowanceHeader."Currency Factor";
          "Global Dimension 1 Code":=AllowanceHeader."Global Dimension 1 Code";
          "Global Dimension 2 Code":=AllowanceHeader."Global Dimension 2 Code";
          "Shortcut Dimension 3 Code":=AllowanceHeader."Shortcut Dimension 3 Code";
          "Shortcut Dimension 4 Code":=AllowanceHeader."Shortcut Dimension 4 Code";
          "Shortcut Dimension 5 Code":=AllowanceHeader."Shortcut Dimension 5 Code";
          "Shortcut Dimension 6 Code":=AllowanceHeader."Shortcut Dimension 6 Code";
          "Shortcut Dimension 7 Code":=AllowanceHeader."Shortcut Dimension 7 Code";
          "Shortcut Dimension 8 Code":=AllowanceHeader."Shortcut Dimension 8 Code";
          "HR Job Grade":=AllowanceHeader."HR Job Grade";
          "Employee No":=AllowanceHeader."Employee No.";
          Quantity:=AllowanceHeader."Date To"-AllowanceHeader."Date From";
          if Quantity=0 then
            Quantity:=1;

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
        AllowanceHeader: Record "Allowance Header";
        AllowanceLine: Record "Allowance Line";
        CurrExchRate: Record "Currency Exchange Rate";
        DepreciationBook: Record "FA Depreciation Book";
        AlowanceMatrix: Record "Allowance Matrix";
        CityCodes: Record "Procurement Lookup Values";
        Error001: Label 'From City must be Inserted';
        Error002: Label 'Imprest code exists for this date. Cannot be twice on the same day';
        LoanTypes: Record "Loan Types";
        PayrollSetupRec: Record "Payroll Setups";
        Period: Record Periods;
        Lines: Record "Payroll Lines";
        Periods: Record Periods;
        Name: Text[92];
        TitleText: Text[60];
        PeriodCode: Code[10];
        BasicAmount: Decimal;
        TotalNetPay: Decimal;
        SkipZeroAmountEDs: Boolean;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        TotalGrossPay: Decimal;
        TotalDeduction: Decimal;
        Lines2: Record "Payroll Lines";
        PayrollLines: Record "Payroll Lines";
        LoansAdvances: Record "Loans/Advances";
        SalaryAdvanceRc: Record "Salary Advance";
        LoansAdvanceRec: Record "Loans/Advances";
        AnnualBasic: Decimal;
        AnnualHours: Decimal;
        HourlyPay: Decimal;

    local procedure TestStatusOpen(AllowApproverEdit: Boolean)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        AllowanceHeader.Get("Document No.");
        if AllowApproverEdit then begin
          ApprovalEntry.Reset;
          ApprovalEntry.SetRange(ApprovalEntry."Document No.",AllowanceHeader."No.");
          ApprovalEntry.SetRange(ApprovalEntry.Status,ApprovalEntry.Status::Open);
          ApprovalEntry.SetRange(ApprovalEntry."Approver ID",UserId);
          if not ApprovalEntry.FindFirst then begin
            AllowanceHeader.TestField(Status,AllowanceHeader.Status::Open);
          end;
        end else begin
          AllowanceHeader.TestField(Status,AllowanceHeader.Status::Open);
        end;
    end;
}

