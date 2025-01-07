table 50027 "Funds Transaction Code"
{
    Caption = 'Funds Transaction Code';

    fields
    {
        field(1;"Transaction Code";Code[50])
        {
            Caption = 'Transaction Code';
        }
        field(2;Description;Text[100])
        {
            Caption = 'Description';
        }
        field(3;"Transaction Type";Option)
        {
            Caption = 'Transaction Type';
            OptionCaption = 'Payment,Receipt,Imprest,Refund,Allowance';
            OptionMembers = Payment,Receipt,Imprest,Refund,Allowance;
        }
        field(4;"Account Type";Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;

            trigger OnValidate()
            begin
                "Account No.":='';
                "Account Name":='';
            end;
        }
        field(5;"Account No.";Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type"=CONST("G/L Account")) "G/L Account" WHERE ("Account Type"=CONST(Posting),
                                                                                          Blocked=CONST(false))
                                                                                          ELSE IF ("Account Type"=CONST(Customer)) Customer
                                                                                          ELSE IF ("Account Type"=CONST(Vendor)) Vendor
                                                                                          ELSE IF ("Account Type"=CONST("Bank Account")) "Bank Account"
                                                                                          ELSE IF ("Account Type"=CONST("Fixed Asset")) "Fixed Asset"
                                                                                          ELSE IF ("Account Type"=CONST("IC Partner")) "IC Partner"
                                                                                          ELSE IF ("Account Type"=CONST(Employee)) Employee;

            trigger OnValidate()
            begin
                "Account Name":='';
                if "Account Type"="Account Type"::"G/L Account" then begin
                  if "G/L Account".Get("Account No.") then begin
                    "Account Name":="G/L Account".Name;
                  end;
                end;

                if "Account Type"="Account Type"::"Bank Account" then begin
                  if BankAccount.Get("Account No.") then begin
                    "Account Name":=BankAccount.Name;
                  end;
                end;


                if "Account Type"="Account Type"::Customer then begin
                  if Customer.Get("Account No.") then begin
                    "Account Name":=Customer.Name;
                  end;
                end;

                if "Account Type"="Account Type"::"Fixed Asset" then begin
                  if FA.Get("Account No.") then begin
                    "Account Name":=FA.Description;
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
            end;
        }
        field(6;"Account Name";Text[100])
        {
            Caption = 'Account Name';
            Editable = false;
        }
        field(7;"Posting Group";Code[20])
        {
            Caption = 'Posting Group';
            TableRelation = IF ("Account Type"=CONST(Customer)) "Customer Posting Group".Code
                            ELSE IF ("Account Type"=CONST(Vendor)) "Vendor Posting Group".Code
                            ELSE IF ("Account Type"=CONST("Bank Account")) "Bank Account Posting Group".Code
                            ELSE IF ("Account Type"=CONST(Employee)) "Employee Posting Group".Code;
        }
        field(8;"Include VAT";Boolean)
        {
            Caption = 'Include VAT';
        }
        field(9;"VAT Code";Code[10])
        {
            Caption = 'VAT Code';
            TableRelation = "Funds Tax Code"."Tax Code" WHERE (Type=CONST(VAT));
        }
        field(10;"Include Withholding Tax";Boolean)
        {
            Caption = 'Include Withholding Tax';
        }
        field(11;"Withholding Tax Code";Code[10])
        {
            Caption = 'Withholding Tax Code';
            TableRelation = "Funds Tax Code"."Tax Code" WHERE (Type=CONST("W/TAX"));
        }
        field(12;"Include Withholding VAT";Boolean)
        {
            Caption = 'Include Withholding VAT';
        }
        field(13;"Withholding VAT Code";Code[10])
        {
            Caption = 'Withholding VAT Code';
            TableRelation = "Funds Tax Code"."Tax Code" WHERE (Type=CONST("W/VAT"));
        }
        field(20;"Funds Claim Code";Boolean)
        {
        }
        field(21;"Document Type";Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Petty Cash,Imprest,Casual Payment';
            OptionMembers = " ","Petty Cash",Imprest,"Casual Payment";
        }
        field(50;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(51;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(50243;"Imprest Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'General Imprest,Pettycash,Safari';
            OptionMembers = "General Imprest",Pettycash,Safari;

            trigger OnValidate()
            begin
                //updated on 28/07/2023
                /*VALIDATE("Purchase Requisition No");
                IF ("Imprest Type" = "Imprest Type"::"General Imprest") AND ("Purchase Requisition No" = ' ') THEN
                ERROR ('Kindly create a purchase requision first');
                */

            end;
        }
        field(52137023;"Employee Transaction Type";Option)
        {
            Caption = 'Employee Transaction Type';
            OptionCaption = ' ,Salary,Imprest,Advance';
            OptionMembers = " ",Salary,Imprest,Advance;

            trigger OnValidate()
            begin
                TestField("Account Type","Account Type"::Employee);
            end;
        }
        field(52137123;"Payroll Taxable";Boolean)
        {
            Caption = 'Payroll Taxable';
        }
        field(52137124;"Payroll Allowance Code";Code[50])
        {
            Caption = 'Payroll Allowance Code';
        }
        field(52137125;"Payroll Deduction Code";Code[50])
        {
            Caption = 'Payroll Deduction Code';
        }
        field(52137130;"Loan Transaction Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Staff Loan,Investment Loan';
            OptionMembers = " ","Staff Loan","Investment Loan";
        }
        field(52137131;"Minimum Non Taxable Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Transaction Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        "G/L Account": Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        Employee: Record Employee;
        FA: Record "Fixed Asset";
        BankAccount: Record "Bank Account";
}

