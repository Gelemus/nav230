table 51157 "Payroll Posting Setup"
{

    fields
    {
        field(1;"Posting Group";Code[20])
        {
            TableRelation = "Employee Posting Groups";
        }
        field(2;"ED Posting Group";Code[20])
        {
            TableRelation = "ED Posting Group";
        }
        field(3;"Debit Account";Code[20])
        {
            TableRelation = IF ("Account Type Debit"=CONST("G/L Account")) "G/L Account" WHERE ("Account Type"=CONST(Posting),
                                                                                                Blocked=CONST(false))
                                                                                                ELSE IF ("Account Type Debit"=CONST(Customer)) Customer
                                                                                                ELSE IF ("Account Type Debit"=CONST(Vendor)) Vendor
                                                                                                ELSE IF ("Account Type Debit"=CONST("Bank Account")) "Bank Account"
                                                                                                ELSE IF ("Account Type Debit"=CONST("Fixed Asset")) "Fixed Asset"
                                                                                                ELSE IF ("Account Type Debit"=CONST("IC Partner")) "IC Partner"
                                                                                                ELSE IF ("Account Type Debit"=CONST(Employee)) Employee;
        }
        field(4;"Credit Account";Code[20])
        {
            TableRelation = IF ("Account Type Credit"=CONST("G/L Account")) "G/L Account" WHERE ("Account Type"=CONST(Posting),
                                                                                                 Blocked=CONST(false))
                                                                                                 ELSE IF ("Account Type Credit"=CONST(Customer)) Customer
                                                                                                 ELSE IF ("Account Type Credit"=CONST(Vendor)) Vendor
                                                                                                 ELSE IF ("Account Type Credit"=CONST("Bank Account")) "Bank Account"
                                                                                                 ELSE IF ("Account Type Credit"=CONST("Fixed Asset")) "Fixed Asset"
                                                                                                 ELSE IF ("Account Type Credit"=CONST("IC Partner")) "IC Partner"
                                                                                                 ELSE IF ("Account Type Credit"=CONST(Employee)) Employee;
        }
        field(5;"Employee Posting Group";Text[40])
        {
            CalcFormula = Lookup("Employee Posting Groups".Description WHERE ("Posting Group"=FIELD("Posting Group")));
            FieldClass = FlowField;
        }
        field(6;"E/D Posting Group";Text[40])
        {
            CalcFormula = Lookup("ED Posting Group".Description WHERE ("ED Posting Group Code"=FIELD("ED Posting Group")));
            FieldClass = FlowField;
        }
        field(7;"Debit Account Name";Text[60])
        {
            CalcFormula = Lookup("G/L Account".Name WHERE ("No."=FIELD("Debit Account")));
            FieldClass = FlowField;
        }
        field(8;"Credit Account Name";Text[60])
        {
            CalcFormula = Lookup("G/L Account".Name WHERE ("No."=FIELD("Credit Account")));
            FieldClass = FlowField;
        }
        field(9;"Include Dedit Dimension Codes";Boolean)
        {
        }
        field(10;"Include Credit Dimension Codes";Boolean)
        {
        }
        field(11;"Payroll Code";Code[10])
        {
            TableRelation = Payroll;
        }
        field(12;"Account Type Debit";Option)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;

            trigger OnValidate()
            begin
                /*IF ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Fixed Asset",
                                       "Account Type"::"IC Partner","Account Type"::Employee]) AND
                   ("Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Fixed Asset",
                                            "Bal. Account Type"::"IC Partner","Bal. Account Type"::Employee])
                THEN
                  ERROR(
                    Text000,
                    FIELDCAPTION("Account Type"),FIELDCAPTION("Bal. Account Type"));
                
                IF ("Account Type" = "Account Type"::Employee) AND ("Currency Code" <> '') THEN
                  ERROR(OnlyLocalCurrencyForEmployeeErr);
                
                VALIDATE("Account No.",'');
                VALIDATE(Description,'');
                
                IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account","Account Type"::Employee] THEN BEGIN
                
                END ELSE
                  IF "Bal. Account Type" IN [
                                             "Bal. Account Type"::"G/L Account","Account Type"::"Bank Account","Bal. Account Type"::"Fixed Asset"]
                  THEN
                
                //UpdateSource;
                
                IF ("Account Type" <> "Account Type"::"Fixed Asset") AND
                   ("Bal. Account Type" <> "Bal. Account Type"::"Fixed Asset")
                THEN BEGIN
                  "Depreciation Book Code" := '';
                  VALIDATE("FA Posting Type","FA Posting Type"::" ");
                END;
                IF xRec."Account Type" IN
                   [xRec."Account Type"::Customer,xRec."Account Type"::Vendor]
                THEN BEGIN
                
                END;
                */

            end;
        }
        field(13;"Account Type Credit";Option)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;

            trigger OnValidate()
            begin
                /*IF ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Fixed Asset",
                                       "Account Type"::"IC Partner","Account Type"::Employee]) AND
                   ("Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Fixed Asset",
                                            "Bal. Account Type"::"IC Partner","Bal. Account Type"::Employee])
                THEN
                  ERROR(
                    Text000,
                    FIELDCAPTION("Account Type"),FIELDCAPTION("Bal. Account Type"));
                
                IF ("Account Type" = "Account Type"::Employee) AND ("Currency Code" <> '') THEN
                  ERROR(OnlyLocalCurrencyForEmployeeErr);
                
                VALIDATE("Account No.",'');
                VALIDATE(Description,'');
                
                IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account","Account Type"::Employee] THEN BEGIN
                
                END ELSE
                  IF "Bal. Account Type" IN [
                                             "Bal. Account Type"::"G/L Account","Account Type"::"Bank Account","Bal. Account Type"::"Fixed Asset"]
                  THEN
                
                //UpdateSource;
                
                IF ("Account Type" <> "Account Type"::"Fixed Asset") AND
                   ("Bal. Account Type" <> "Bal. Account Type"::"Fixed Asset")
                THEN BEGIN
                  "Depreciation Book Code" := '';
                  VALIDATE("FA Posting Type","FA Posting Type"::" ");
                END;
                IF xRec."Account Type" IN
                   [xRec."Account Type"::Customer,xRec."Account Type"::Vendor]
                THEN BEGIN
                
                END;
                */

            end;
        }
    }

    keys
    {
        key(Key1;"Posting Group","ED Posting Group")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //"Payroll Code":='IGS';
    end;
}

