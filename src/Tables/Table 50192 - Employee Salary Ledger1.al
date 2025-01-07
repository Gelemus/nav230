table 50192 "Employee Salary Ledger1"
{
    // DrillDownPageID = 52137140;
    // LookupPageID = 52137140;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Editable = false;
            TableRelation = Employee."No.";
        }
        field(2; "Payroll Group Code"; Code[50])
        {
            Editable = false;
            //TableRelation = Table52137378.Field1;
        }
        field(3; "Transaction Code"; Code[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                /*PayrollTransactionCode.RESET;
                IF PayrollTransactionCode.GET("Transaction Code") THEN BEGIN
                  IF PayrollTransactionCode."Employee Posting Group"<>'' THEN
                    "Employee Posting Group":=PayrollTransactionCode."Employee Posting Group";
                END;*/

            end;
        }
        field(4; "Entry Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,BPAY,ALLOWANCE,GPAY,DEFCON,TPAY,STATUTORY,DEDUCTION,NPAY';
            OptionMembers = " ",BPAY,ALLOWANCE,GPAY,DEFCON,TPAY,STATUTORY,DEDUCTION,NPAY;
        }
        field(5; "Payroll Period"; Date)
        {
            Editable = false;
            // TableRelation = Table52137369.Field2;
        }
        field(6; "Payroll Month"; Integer)
        {
            Editable = false;
        }
        field(7; "Payroll Year"; Integer)
        {
            Editable = false;
        }
        field(8; "Transaction Group"; Integer)
        {
            Editable = false;
        }
        field(9; "Transaction SubGroup"; Integer)
        {
        }
        field(10; "Employee PIN No."; Code[20])
        {
        }
        field(20; "Currency Code"; Code[10])
        {
            Editable = false;
            TableRelation = Currency;
        }
        field(21; "Currency Factory"; Decimal)
        {
            Editable = false;
        }
        field(22; "Posting Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Debit,Credit';
            OptionMembers = " ",Debit,Credit;
        }
        field(23; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(24; "Account No."; Code[20])
        {
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false))
            ELSE IF ("Account Type" = CONST(Customer)) Customer
            ELSE IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE IF ("Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE IF ("Account Type" = CONST(Employee)) Employee;

            trigger OnValidate()
            begin
                if "Account Type" = "Account Type"::"G/L Account" then begin
                    "G/LAccount".Reset;
                    if "G/LAccount".Get("Account No.") then
                        "Account Name" := "G/LAccount".Name;
                end;

                if "Account Type" = "Account Type"::Employee then begin
                    Employee.Reset;
                    if Employee.Get("Account No.") then
                        "Account Name" := Employee."Full Name";
                end;

                if "Account Type" = "Account Type"::Vendor then begin
                    Vendor.Reset;
                    if Vendor.Get("Account No.") then
                        "Account Name" := Vendor.Name;
                end;

                if "Account Type" = "Account Type"::Customer then begin
                    Customer.Reset;
                    if Customer.Get("Account No.") then
                        "Account Name" := Customer.Name;
                end;
            end;
        }
        field(25; "Account Name"; Text[100])
        {
            Editable = false;
        }
        field(26; Amount; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Posting Type" = "Posting Type"::Debit then
                    "Posting Amount" := Amount;

                if "Posting Type" = "Posting Type"::Credit then
                    "Posting Amount" := Amount * -1;
            end;
        }
        field(27; "Amount(LCY)"; Decimal)
        {
        }
        field(28; "Reference No."; Code[20])
        {
        }
        field(29; Balance; Decimal)
        {
        }
        field(30; "Balance(LCY)"; Decimal)
        {
        }
        field(31; "Posting Amount"; Decimal)
        {
        }
        field(35; "Employee Posting Group"; Code[20])
        {
            Caption = 'Employee Posting Group';
            TableRelation = "Employee Posting Group".Code;
        }
        field(40; "Employee Deduction"; Integer)
        {
            MaxValue = 1;
            MinValue = 0;
        }
        field(49; Description; Text[250])
        {
        }
        field(50; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(51; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(52; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(53; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(54; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(55; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(56; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(57; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard));
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Payroll Group Code", "Payroll Period", "Transaction Code", "Transaction Group", "Transaction SubGroup", "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 6 Code", "Shortcut Dimension 7 Code", "Shortcut Dimension 8 Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        "G/LAccount": Record "G/L Account";
        Employee: Record Employee;
        Vendor: Record Vendor;
        Customer: Record Customer;
}

