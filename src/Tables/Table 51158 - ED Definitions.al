table 51158 "ED Definitions"
{
    DrillDownPageID = "ED Definitions List";
    LookupPageID = "ED Definitions List";

    fields
    {
        field(1;"ED Code";Code[20])
        {
            NotBlank = true;
        }
        field(3;Description;Text[50])
        {
        }
        field(4;"Payroll Text";Text[50])
        {
        }
        field(5;"Copy to next";Boolean)
        {
        }
        field(6;"Reset Amount";Boolean)
        {
        }
        field(7;"Calculation Group";Option)
        {
            OptionCaption = 'None,Payments,Benefit non cash,Deduction,Employer Contributions';
            OptionMembers = "None",Payments,"Benefit non cash",Deduction,"Employer Contributions";
        }
        field(8;Rate;Code[20])
        {
        }
        field(9;"Posting type";Option)
        {
            OptionMembers = "None","G/L Account",Direct,Customer,Vendor;
        }
        field(10;"ED Posting Group";Code[20])
        {
            TableRelation = "ED Posting Group";
        }
        field(11;"Account No";Code[20])
        {
            TableRelation = IF ("Posting type"=CONST("G/L Account")) "G/L Account"
                            ELSE IF ("Posting type"=CONST(Direct)) "G/L Account"
                            ELSE IF ("Posting type"=CONST(Customer)) Customer
                            ELSE IF ("Posting type"=CONST(Vendor)) Vendor;
        }
        field(12;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3));
        }
        field(13;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2));
        }
        field(14;"Debit/Credit";Option)
        {
            InitValue = Credit;
            OptionMembers = Debit,Credit;
        }
        field(15;Editable;Boolean)
        {
            InitValue = true;
        }
        field(16;"System Created";Boolean)
        {
            InitValue = false;
        }
        field(17;"Sum Payroll Entries";Boolean)
        {
            InitValue = true;
        }
        field(18;"Membership No. Name";Text[30])
        {
        }
        field(19;Cumulative;Boolean)
        {
        }
        field(20;"Overtime ED";Boolean)
        {
        }
        field(21;"Overtime ED Weight";Decimal)
        {
            InitValue = 1;
        }
        field(22;"Rounding ED";Boolean)
        {
        }
        field(23;"Payroll Code";Code[10])
        {
            TableRelation = Payroll;
        }
        field(50001;Priority;Integer)
        {
        }
        field(50002;"Special Allowance";Boolean)
        {
        }
        field(50003;"Special Payment";Boolean)
        {
        }
        field(50004;"Employer ED Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ED Definitions";
        }
        field(50005;"Pension ED";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006;"Employee Rate";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007;"Employer Rate";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008;"Institution Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Institution;
        }
        field(50009;"Gratuity ED";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010;"OT1 ED";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011;"OT2 ED";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012;"Third Rule";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013;"Leave Allowance Code";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50014;"Affordable Housing Levy";Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"ED Code")
        {
        }
        key(Key2;Rate)
        {
        }
        key(Key3;"Calculation Group",Priority)
        {
        }
    }

    fieldgroups
    {
    }

    var
        DimMgt: Codeunit DimensionManagement;
        gvPayrollUtilities: Codeunit "Payroll Posting";

    procedure ValidateShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
    begin
    end;
}

