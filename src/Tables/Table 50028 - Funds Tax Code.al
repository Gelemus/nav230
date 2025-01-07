table 50028 "Funds Tax Code"
{
    Caption = 'Funds Tax Code';

    fields
    {
        field(1; "Tax Code"; Code[10])
        {
            Caption = 'Tax Code';
        }
        field(2; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,VAT,W/TAX,W/VAT,PAYE,AHL';
            OptionMembers = " ",VAT,"W/TAX","W/VAT",PAYE,AHL;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(5; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE IF ("Account Type" = CONST(Customer)) Customer
            ELSE IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE IF ("Account Type" = CONST(Employee)) Employee;

            trigger OnValidate()
            begin
                "Account Name" := '';
                if "Account Type" = "Account Type"::"G/L Account" then begin
                    if "G/LAccount".Get("Account No.") then begin
                        "Account Name" := "G/LAccount".Name;
                    end;
                end;

                if "Account Type" = "Account Type"::Customer then begin
                    if Customer.Get("Account No.") then begin
                        "Account Name" := Customer.Name;
                    end;
                end;

                if "Account Type" = "Account Type"::Vendor then begin
                    if Vendor.Get("Account No.") then begin
                        "Account Name" := Vendor.Name;
                    end;
                end;

                if "Account Type" = "Account Type"::Employee then begin
                    if Employee.Get("Account No.") then begin
                        "Account Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    end;
                end;
            end;
        }
        field(6; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
            Editable = false;
        }
        field(7; Percentage; Decimal)
        {
            Caption = 'Percentage';
            MaxValue = 100;
            MinValue = 0;
        }
        field(8; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Posting Group".Code
            ELSE IF ("Account Type" = CONST(Vendor)) "Vendor Posting Group".Code
            ELSE IF ("Account Type" = CONST(Employee)) "Employee Posting Group".Code;
        }
    }

    keys
    {
        key(Key1; "Tax Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        "G/LAccount": Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        Employee: Record Employee;
}

