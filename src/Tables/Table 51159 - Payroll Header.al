table 51159 "Payroll Header"
{
    //LookupPageID = 52021089;
    Permissions = TableData "Payroll Header" = rimd,
                  TableData "Payroll Lines" = rimd,
                  TableData "Payroll Entry" = rimd;

    fields
    {
        field(1; "Payroll ID"; Code[10])
        {
            NotBlank = true;
            TableRelation = Periods."Period ID";
        }
        field(2; "Payroll Month"; Integer)
        {
        }
        field(3; "Payroll Year"; Integer)
        {
        }
        field(4; "Employee no."; Code[20])
        {
            NotBlank = true;
            TableRelation = Employee;
        }
        field(5; "A (LCY)"; Decimal)
        {
        }
        field(6; "B (LCY)"; Decimal)
        {
        }
        field(7; "C (LCY)"; Decimal)
        {
        }
        field(8; "D (LCY)"; Decimal)
        {
        }
        field(9; "E1 (LCY)"; Decimal)
        {
        }
        field(10; "E2 (LCY)"; Decimal)
        {
        }
        field(11; "E3 (LCY)"; Decimal)
        {
        }
        field(12; "F (LCY)"; Decimal)
        {
        }
        field(13; "G (LCY)"; Decimal)
        {
        }
        field(14; "H (LCY)"; Decimal)
        {
        }
        field(16; "J (LCY)"; Decimal)
        {
        }
        field(17; "K (LCY)"; Decimal)
        {
        }
        field(18; "L (LCY)"; Decimal)
        {
        }
        field(19; "M (LCY)"; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                if "M (LCY)" < 0 then
                    "M (LCY)" := 0;
            end;
        }
        field(20; Calculated; Boolean)
        {
        }
        field(21; "First Name"; Text[30])
        {
            CalcFormula = Lookup(Employee."First Name" WHERE("No." = FIELD("Employee no.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Last Name"; Text[30])
        {
            CalcFormula = Lookup(Employee."Last Name" WHERE("No." = FIELD("Employee no.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Payroll Period"; Text[30])
        {
            CalcFormula = Lookup(Periods.Description WHERE("Period ID" = FIELD("Payroll ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Total Payable (LCY)"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines"."Amount (LCY)" WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                                    "Employee No." = FIELD("Employee no."),
                                                                    "Calculation Group" = CONST(Payments),
                                                                    Rounding = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Total Benefit (LCY)"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines"."Amount (LCY)" WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                                    "Employee No." = FIELD("Employee no."),
                                                                    "Calculation Group" = CONST("Benefit non Cash")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Total Deduction (LCY)"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines"."Amount (LCY)" WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                                    "Employee No." = FIELD("Employee no."),
                                                                    "Calculation Group" = CONST(Deduction),
                                                                    Rounding = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; Posted; Boolean)
        {
            InitValue = false;
        }
        field(28; "Basic Pay"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Employee No." = FIELD("Employee no."),
                                                            "Payroll ID" = FIELD("Payroll ID"),
                                                            "ED Code" = CONST('BASIC'),
                                                            "Payroll Code" = FIELD("Payroll Code")));
            FieldClass = FlowField;
        }
        field(29; "Hour Rate"; Decimal)
        {
        }
        field(30; "Day Rate"; Decimal)
        {
        }
        field(330; "Mid Month Advance Code"; Code[10])
        {
        }
        field(331; "Total Other (LCY)"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines"."Amount (LCY)" WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                                    "Employee No." = FIELD("Employee no."),
                                                                    "Calculation Group" = CONST(None)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(332; "Advance (LCY)"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines"."Amount (LCY)" WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                                    "Employee No." = FIELD("Employee no."),
                                                                    "Calculation Group" = CONST(Deduction),
                                                                    "ED Code" = FIELD("Mid Month Advance Code")));
            FieldClass = FlowField;
        }
        field(333; "NHIF Code"; Code[20])
        {
            CalcFormula = Lookup("Payroll Setups"."NHIF ED Code");
            FieldClass = FlowField;
        }
        field(334; "NHIF Amount (LCY)"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines"."Amount (LCY)" WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                                    "Employee No." = FIELD("Employee no."),
                                                                    "Calculation Group" = CONST(Deduction),
                                                                    "ED Code" = FIELD("NHIF Code")));
            FieldClass = FlowField;
        }
        field(335; "NSSF Code"; Code[20])
        {
            CalcFormula = Lookup("Payroll Setups"."NSSF ED Code");
            FieldClass = FlowField;
        }
        field(336; "NSSF Amount (LCY)"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines"."Amount (LCY)" WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                                    "Employee No." = FIELD("Employee no."),
                                                                    "Calculation Group" = CONST(Deduction),
                                                                    "ED Code" = FIELD("NSSF Code")));
            FieldClass = FlowField;
        }
        field(337; "Total Rounding Pmts (LCY)"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines"."Amount (LCY)" WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                                    "Employee No." = FIELD("Employee no."),
                                                                    "Calculation Group" = CONST(Payments),
                                                                    Rounding = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(338; "Total Rounding Ded (LCY)"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines"."Amount (LCY)" WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                                    "Employee No." = FIELD("Employee no."),
                                                                    "Calculation Group" = CONST(Deduction),
                                                                    Rounding = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(339; "Manually Imported"; Boolean)
        {
            Editable = false;
        }
        field(340; "Payroll Code"; Code[10])
        {
            TableRelation = Payroll;

            trigger OnValidate()
            begin
                //ERROR('Manual Edits not allowed.');
            end;
        }
        field(341; "Basic Pay Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(342; "Basic Pay Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(343; "Basic Pay (LCY)"; Decimal)
        {
        }
        field(344; "Hour Rate (LCY)"; Decimal)
        {
        }
        field(345; "Day Rate (LCY)"; Decimal)
        {
        }
        field(346; PAYE; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('NET PAYE')));
            FieldClass = FlowField;
        }
        field(347; "Business Loan"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('BLOAN')));
            FieldClass = FlowField;
        }
        field(348; Savings; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('SAVINGS')));
            FieldClass = FlowField;
        }
        field(349; "School Fees Loan"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('SFEE')));
            FieldClass = FlowField;
        }
        field(350; "Product Loan"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('PROD')));
            FieldClass = FlowField;
        }
        field(351; "Golden Loan"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('GOLDEN')));
            FieldClass = FlowField;
        }
        field(353; "Epress Loan"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('EXPRESS')));
            FieldClass = FlowField;
        }
        field(354; "House Allowance"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Payments),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('HOUSE ALLOWANCE')));
            FieldClass = FlowField;
        }
        field(356; "Emergency Loan"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('EMER')));
            FieldClass = FlowField;
        }
        field(357; "Dividend Loan"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('DIVIDEND')));
            FieldClass = FlowField;
        }
        field(358; "Salary Advance"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('ADVANCE')));
            FieldClass = FlowField;
        }
        field(359; "Development Loan"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('DEV')));
            FieldClass = FlowField;
        }
        field(360; Loan; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('LOAN')));
            FieldClass = FlowField;
        }
        field(361; Bonus; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Payments),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('BONUS')));
            FieldClass = FlowField;
        }
        field(362; HELB; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('HELB')));
            FieldClass = FlowField;
        }
        field(363; "Defaulter Loan"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('DEFAULTER')));
            FieldClass = FlowField;
        }
        field(364; "Spot Loan"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('SPOT')));
            FieldClass = FlowField;
        }
        field(365; "Transport Allowance"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Payments),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('TALLOWANCE')));
            FieldClass = FlowField;
        }
        field(366; "Leave Allowance"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Payments),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('LEAVE')));
            FieldClass = FlowField;
        }
        field(367; "Absent Deduction"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('ABSENT')));
            FieldClass = FlowField;
        }
        field(368; "Mothly Relief"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(None),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('TAXRELEIF')));
            FieldClass = FlowField;
        }
        field(369; Damages; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('DAMAGES')));
            FieldClass = FlowField;
        }
        field(370; Medical; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Calculation Group" = CONST(Deduction),
                                                            Rounding = CONST(false),
                                                            "ED Code" = CONST('MEDICAL')));
            FieldClass = FlowField;
        }
        field(371; PensionEmp; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("ED Code" = CONST('PENSIONEMP'),
                                                            "Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Payroll Code" = FIELD("Payroll Code")));
            FieldClass = FlowField;
        }
        field(372; SupernuationEmp; Decimal)
        {
            FieldClass = Normal;
        }
        field(373; NSSFEmp; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Payroll ID" = FIELD("Payroll ID"),
                                                            "Employee No." = FIELD("Employee no."),
                                                            "Payroll Code" = FIELD("Payroll Code"),
                                                            "ED Code" = CONST('NSSF')));
            FieldClass = FlowField;
        }
        field(374; "Pay Leave"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(375; "Middle Name"; Text[50])
        {
            CalcFormula = Lookup(Employee."Middle Name" WHERE("No." = FIELD("Employee no.")));
            FieldClass = FlowField;
        }
        field(50019; "Mode of Payment"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Mode of Payment";
        }
    }

    keys
    {
        key(Key1; "Payroll ID", "Employee no.")
        {
        }
        key(Key2; "Payroll Month")
        {
            SumIndexFields = "A (LCY)", "B (LCY)", "C (LCY)", "D (LCY)", "E1 (LCY)", "E2 (LCY)", "E3 (LCY)", "F (LCY)", "G (LCY)", "H (LCY)", "J (LCY)", "K (LCY)", "L (LCY)", "M (LCY)";
        }
        key(Key3; Posted)
        {
        }
        key(Key4; "Employee no.", "Payroll Year")
        {
            SumIndexFields = "A (LCY)", "B (LCY)", "C (LCY)", "D (LCY)", "E1 (LCY)", "E2 (LCY)", "E3 (LCY)", "F (LCY)", "G (LCY)", "H (LCY)", "J (LCY)", "K (LCY)", "L (LCY)", "M (LCY)";
        }
        key(Key5; "Employee no.", "Payroll Year", "Payroll Month")
        {
        }
        key(Key6; "Employee no.", "Payroll Year", "Payroll Code")
        {
            SumIndexFields = "A (LCY)", "B (LCY)", "C (LCY)", "D (LCY)", "E1 (LCY)", "E2 (LCY)", "E3 (LCY)", "F (LCY)", "G (LCY)", "H (LCY)", "J (LCY)", "K (LCY)", "L (LCY)", "M (LCY)";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Posted, false);

        PayrollEntry.SetRange("Payroll ID", "Payroll ID");
        PayrollEntry.SetRange("Employee No.", "Employee no.");
        PayrollEntry.DeleteAll;

        PayrollLines.SetRange("Payroll ID", "Payroll ID");
        PayrollLines.SetRange("Employee No.", "Employee no.");
        PayrollLines.DeleteAll;

        PayrollUtilities.sDeleteDefaultEmpDims(Rec); //skm310506 Advanced Dimensions
    end;

    trigger OnInsert()
    begin
        if "Payroll Code" = '' then "Payroll Code" := PayrollUtilities.gsAssignPayrollCode; //SNG 130611 payroll data segregation

        PayrollUtilities.sGetDefaultEmpDims(Rec); //skm310506 Advanced Dimensions
    end;

    trigger OnRename()
    begin
        PayrollUtilities.sDeleteDefaultEmpDims(Rec); //skm310506 Advanced Dimensions
        PayrollUtilities.sGetDefaultEmpDims(Rec); //skm310506 Advanced Dimensions
    end;

    var
        PayrollSetup: Record "Payroll Setups";
        PayrollLines: Record "Payroll Lines";
        PayrollEntry: Record "Payroll Entry";
        DimMgt: Codeunit DimensionManagement;
        PayrollUtilities: Codeunit "Payroll Posting";

    procedure ShowPayrollDim()
    var
        PayrollDim: Record "Payroll Dimension";
        PayrollDims: Page "Payroll Dimensions";
    begin
        PayrollDim.SetRange("Table ID", DATABASE::"Payroll Header");
        PayrollDim.SetRange("Payroll ID", "Payroll ID");
        PayrollDim.SetRange("Employee No", "Employee no.");
        PayrollDim.SetRange("Payroll Code", "Payroll Code");
        PayrollDim.SetRange("Entry No", 0);
        PayrollDims.SetTableView(PayrollDim);
        PayrollDims.RunModal;
        Get("Payroll ID", "Employee no.");
    end;
}

