table 51160 "Payroll Lines"
{
    DrillDownPageID = "Payroll Lines LookUp";

    fields
    {
        field(1;"Entry No.";Integer)
        {
        }
        field(2;"Payroll ID";Code[10])
        {
            TableRelation = Periods."Period ID";
        }
        field(3;"Employee No.";Code[20])
        {
            TableRelation = Employee;
        }
        field(4;"ED Code";Code[20])
        {
            TableRelation = "ED Definitions";
        }
        field(5;Text;Text[50])
        {
        }
        field(6;Amount;Decimal)
        {
        }
        field(7;"Calculation Group";Option)
        {
            OptionMembers = "None",Payments,"Benefit non Cash",Deduction;
        }
        field(8;Quantity;Decimal)
        {
        }
        field(9;Rate;Decimal)
        {
        }
        field(10;"Loan Entry";Boolean)
        {
            InitValue = false;
        }
        field(11;"Loan Entry No";Integer)
        {
        }
        field(12;"Loan ID";BigInteger)
        {
            TableRelation = "Loans/Advances";
        }
        field(13;Interest;Decimal)
        {
        }
        field(14;Repayment;Decimal)
        {
        }
        field(15;"Remaining Debt";Decimal)
        {
        }
        field(16;Paid;Decimal)
        {
        }
        field(17;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin

                ValidateShortcutDimCode(1,"Global Dimension 1 Code");
                Modify;
            end;
        }
        field(18;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin

                ValidateShortcutDimCode(2,"Global Dimension 2 Code");
                Modify;
            end;
        }
        field(19;"Posting Group";Code[20])
        {
            TableRelation = "Employee Posting Groups";
        }
        field(20;Rounding;Boolean)
        {
        }
        field(21;"Manually Imported";Boolean)
        {
            Editable = false;
        }
        field(22;"LumpSum Line";Boolean)
        {
            Description = 'Indicates a Line Inserted from Lump Sum Payment';
            Editable = false;
        }
        field(23;"GE PA Lump Sum";Decimal)
        {
            Description = 'Gross Earnings PA for the year Lump Sum Payment was paid';
        }
        field(24;"PAYE Earlier Paid Lump Sum";Decimal)
        {
            Description = 'PAYE Deduction for year Lum Sum Payment was paid';
        }
        field(25;"Payroll Code";Code[10])
        {
            TableRelation = Payroll;

            trigger OnValidate()
            begin
                //ERROR('Manual Edits not allowed.');
            end;
        }
        field(26;"Posting Date";Date)
        {
            NotBlank = true;
        }
        field(27;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(28;"Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0:15;
            Editable = false;
            MinValue = 0;
        }
        field(29;"Rate (LCY)";Decimal)
        {
        }
        field(30;"Amount (LCY)";Decimal)
        {

            trigger OnValidate()
            var
                lvAllowedPayrolls: Record "Allowed Payrolls";
                lvPayrollSetupRec: Record "Payroll Setups";
            begin
            end;
        }
        field(31;"Interest (LCY)";Decimal)
        {
        }
        field(32;"Repayment (LCY)";Decimal)
        {
        }
        field(33;"Remaining Debt (LCY)";Decimal)
        {
        }
        field(34;"Paid (LCY)";Decimal)
        {
        }
        field(50004;"Staff Vendor Entry";Code[20])
        {
            TableRelation = Vendor;
        }
        field(50011;"Bank Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee Bank Account";

            trigger OnValidate()
            var
                rEmpBankAccount: Record "Employee Bank Account";
            begin
                //IGS The code below was commented out.. dont know why, so i uncommented it
                //rEmpBankAccount.GET("Bank Code");
                //"Bank Name" :=  rEmpBankAccount.Name;
                //IGS END
            end;
        }
        field(50012;"Bank Account No";Code[30])
        {
            DataClassification = ToBeClassified;
            Numeric = true;
        }
        field(50013;"Bank Name";Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50014;"Bank Branch Name";Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50016;"Job Title";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50017;"Job Position";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(50018;"Salary Scale";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50019;"Mode of Payment";Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Mode of Payment";
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
        }
        key(Key2;"Payroll ID","Employee No.","ED Code","Global Dimension 1 Code","Global Dimension 2 Code")
        {
            SumIndexFields = Amount,"Amount (LCY)";
        }
        key(Key3;"Payroll ID","Employee No.","Calculation Group","ED Code",Rounding)
        {
            SumIndexFields = Amount,"Amount (LCY)";
        }
        key(Key4;"Payroll ID","Employee No.","ED Code","Posting Date")
        {
            SumIndexFields = Amount,"Amount (LCY)";
        }
        key(Key5;"ED Code")
        {
            SumIndexFields = Amount,"Amount (LCY)";
        }
        key(Key6;"ED Code","Employee No.","Payroll Code","Payroll ID")
        {
            SumIndexFields = Amount,"Amount (LCY)";
        }
        key(Key7;"Payroll ID","ED Code")
        {
            SumIndexFields = Amount,"Amount (LCY)";
        }
        key(Key8;"Payroll ID","ED Code","Global Dimension 1 Code")
        {
        }
        key(Key9;"Payroll ID","Employee No.","Global Dimension 1 Code","Global Dimension 2 Code")
        {
        }
        key(Key10;"ED Code","Employee No.","Posting Date")
        {
            SumIndexFields = Amount,"Amount (LCY)";
        }
        key(Key11;"Payroll ID","ED Code","Payroll Code")
        {
            SumIndexFields = Amount,"Amount (LCY)";
        }
        key(Key12;"Payroll ID","Global Dimension 1 Code","Global Dimension 2 Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        PayrollUtilities.sDeletePayrollLineDims(Rec)
    end;

    trigger OnInsert()
    begin
        if "Payroll Code" = '' then "Payroll Code" := PayrollUtilities.gsAssignPayrollCode; //SNG 130611 payroll data segregation
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        PayrollUtilities: Codeunit "Payroll Posting";

    procedure ValidateShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
    begin

        DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Employee,"Payroll ID",FieldNumber,ShortcutDimCode);
        Modify;
    end;
}

