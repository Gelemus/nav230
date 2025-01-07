table 51178 "Loan Types"
{
    LookupPageID = "Loan types";

    fields
    {
        field(1;"Code";Code[20])
        {
            NotBlank = true;
        }
        field(2;Description;Text[50])
        {
        }
        field(3;"Loan Account";Code[20])
        {
            TableRelation = IF ("Loan Accounts Type"=CONST("G/L Account")) "G/L Account"
                            ELSE IF ("Loan Accounts Type"=CONST(Vendor)) Vendor
                            ELSE IF ("Loan Accounts Type"=CONST(Customer)) Customer;
        }
        field(4;"Loan Interest Account";Code[20])
        {
            TableRelation = IF ("Loan Interest Account Type"=CONST("G/L Account")) "G/L Account"
                            ELSE IF ("Loan Interest Account Type"=CONST(Vendor)) Vendor
                            ELSE IF ("Loan Interest Account Type"=CONST(Customer)) Customer;
        }
        field(5;"Loan Losses Account";Code[20])
        {
            TableRelation = IF ("Loan Accounts Type"=CONST("G/L Account")) "G/L Account"
                            ELSE IF ("Loan Accounts Type"=CONST(Vendor)) Vendor
                            ELSE IF ("Loan Accounts Type"=CONST(Customer)) Customer;
        }
        field(6;"Loan E/D Code";Code[20])
        {
            TableRelation = "ED Definitions"."ED Code" WHERE ("Calculation Group"=CONST(Deduction));
        }
        field(8;"Loan Account Name";Text[50])
        {
            CalcFormula = Lookup("G/L Account".Name WHERE ("No."=FIELD("Loan Account")));
            FieldClass = FlowField;
        }
        field(9;"Losses Account Name";Text[50])
        {
            CalcFormula = Lookup("G/L Account".Name WHERE ("No."=FIELD("Loan Losses Account")));
            FieldClass = FlowField;
        }
        field(10;"Loan E/D Name";Text[50])
        {
            CalcFormula = Lookup("ED Definitions".Description WHERE ("ED Code"=FIELD("Loan E/D Code")));
            FieldClass = FlowField;
        }
        field(12;Rounding;Option)
        {
            OptionMembers = Nearest,Down,Up;
        }
        field(13;"Rounding Precision";Decimal)
        {
            InitValue = 1;
            MaxValue = 1;
            MinValue = 0.1;
        }
        field(14;Type;Option)
        {
            OptionMembers = Annuity,Serial,Advance;
        }
        field(15;"Calculate Interest Benefit";Boolean)
        {
            InitValue = false;
        }
        field(16;"Loan Accounts Type";Option)
        {
            Description = 'IGS 06/03/00 Allow GL, Customer, Vendor accounts';
            OptionCaption = 'G/L Account,Customer,Vendor,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,Employee;

            trigger OnValidate()
            begin
                if "Loan Accounts Type" <> xRec."Loan Accounts Type" then begin
                  "Loan Account" := '';
                  "Loan Interest Account" := '';
                  "Loan Losses Account" := '';
                  Modify
                end;
            end;
        }
        field(17;"Payroll Code";Code[10])
        {
            TableRelation = Payroll;

            trigger OnValidate()
            begin
                //ERROR('Manual Edits not allowed.');
            end;
        }
        field(18;"Finance Source";Option)
        {
            OptionMembers = Company,External;
        }
        field(19;"Loan Interest Account Type";Option)
        {
            Description = 'IGS 06/03/00 Allow GL, Customer, Vendor accounts';
            OptionMembers = "G/L Account",Customer,Vendor;

            trigger OnValidate()
            begin
                if "Loan Interest Account Type" <> xRec."Loan Interest Account Type" then begin
                  "Loan Interest Account" := '';
                  Modify
                end;
            end;
        }
        field(20;"Loan Interest E/D Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ED Definitions"."ED Code" WHERE ("Calculation Group"=CONST(Deduction));
        }
        field(21;"Advance Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Laptop Advance,Phone Advance,Salary Advance';
            OptionMembers = " ","Laptop Advance","Phone Advance","Salary Advance";
        }
    }

    keys
    {
        key(Key1;"Code","Payroll Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Payroll Code" = '' then "Payroll Code" := gvPayrollUtilities.gsAssignPayrollCode; //SNG 130611 payroll data segregation
    end;

    var
        gvPayrollUtilities: Codeunit "Payroll Posting";
}

