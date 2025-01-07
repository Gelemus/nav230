table 50075 "Employee Loan Accounts"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(4; "Employee Name"; Text[90])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "HR Branch"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "HR Department"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Employee Age"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Retirement Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Retirement Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Loan Product Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Table50363;
        }
        field(11; "Loan Product Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Repayment Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Daily,Monthly,Quarterly,Annually';
            OptionMembers = " ",Daily,Monthly,Quarterly,Annually;
        }
        field(13; "Applied Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Entitled Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Repayment Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Repayment Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Repayment End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "No. of Installments"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Job Grade"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "HR Job Grades"."Job Grade";
        }
        field(20; "Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Disbursed Amount"; Decimal)
        {
            // CalcFormula = Sum("G/L Entry".Amount WHERE("Investment Account No." = FIELD("No."),
            //                                             Amount = FILTER(> 0),
            //                                             "G/L Account No." = FIELD("Disbursement Account No.")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(25; "Repayment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Account Created"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Loan Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "Disbursement Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Account Balance"; Decimal)
        {
            // CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE (Field52137650=FIELD("No."),
            //                                                              "Customer No."=FIELD("Employee No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(49; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(50; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(51; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(52; "Shortcut Dimension 3 Code"; Code[50])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(53; "Shortcut Dimension 4 Code"; Code[50])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(54; "Shortcut Dimension 5 Code"; Code[50])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(55; "Shortcut Dimension 6 Code"; Code[50])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(56; "Shortcut Dimension 7 Code"; Code[50])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(57; "Shortcut Dimension 8 Code"; Code[50])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(58; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            //TableRelation = "Supplier Category".Field1;
        }
        field(60; "Principal Arrears"; Decimal)
        {
            Caption = 'Principal Arrears';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(61; "Principal Arrears(LCY)"; Decimal)
        {
            Caption = 'Principal Arrears(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(62; "Interest Arrears"; Decimal)
        {
            Caption = 'Interest Arrears';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(63; "Interest Arrears(LCY)"; Decimal)
        {
            Caption = 'Interest Arrears(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(64; "Penalty Interest Arrears"; Decimal)
        {
            Caption = 'Penalty Interest Arrears';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(65; "Penalty Interest Arrears(LCY)"; Decimal)
        {
            Caption = 'Penalty Interest Arrears(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(66; "Loan Fee Arrears"; Decimal)
        {
            Caption = 'Loan Fee Arrears';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(67; "Loan Fee Arrears(LCY)"; Decimal)
        {
            Caption = 'Loan Fee Arrears(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(75; "Date Filter"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Time Created"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(99; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(100; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(101; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            DataClassification = ToBeClassified;
        }
        field(102; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            DataClassification = ToBeClassified;
        }
        field(200; "Approval User ID"; Code[50])
        {
            Caption = 'Approval User ID';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(300; "1-3 yrs"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(301; "3-6 yrs"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(302; "6-8 yrs"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(400; "Documents Verified"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(401; "Loan Officer Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(402; "Approval Recommendation"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Approve Loan,Reject Loan';
            OptionMembers = " ","Approve Loan","Reject Loan";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Employee No.", "Employee Name")
        {
        }
    }

    var
        InvestmentGeneralSetup: Record "Funds General Setup";
        "NoSeriesMgt.": Codeunit NoSeriesManagement;
        Employee: Record Employee;
        HRLoanProducts: Record "Employee Loan Products";
        "HRLoanMgt.": Codeunit "HR Loan Management";
        RetirementPeriod: DateFormula;
        RepaymentPeriod: DateFormula;
        LoanProductGrades: Record "Loan Product Grades";
        EmployeeSalary: Record "Cover Letter";
        RepaymentAmount: Decimal;
        Dates: Codeunit Dates;
}

