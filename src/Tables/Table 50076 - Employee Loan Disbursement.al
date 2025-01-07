table 50076 "Employee Loan Disbursement"
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
        field(3; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Table50356.Field1 WHERE (Field3=FIELD("Employee No."));

            trigger OnValidate()
            begin
                "Loan Product Code" := '';
                "Loan Product Description" := '';
                "Applied Amount" := 0;
                "Approved Amount" := 0;
                "Disbursed Amount" := 0;
                "Amount to Disburse" := 0;

                //get disbursed amounts
                /*EmployeeLoanDisbursement.RESET;
                EmployeeLoanDisbursement.SETRANGE("Loan No.","Loan No.");
                EmployeeLoanDisbursement.SETRANGE(Status,EmployeeLoanDisbursement.Status::Disbursed);
                EmployeeLoanDisbursement.CALCSUMS("Disbursed Amount");
                "Disbursed Amount":=EmployeeLoanDisbursement."Disbursed Amount";*/

                EmployeeLoanAccounts.Reset;
                if EmployeeLoanAccounts.Get("Loan No.") then begin
                    EmployeeLoanAccounts.CalcFields(EmployeeLoanAccounts."Disbursed Amount");
                    "Employee No." := EmployeeLoanAccounts."Employee No.";
                    "Employee Name" := EmployeeLoanAccounts."Employee Name";
                    "Loan Product Code" := EmployeeLoanAccounts."Loan Product Code";
                    "Loan Product Description" := EmployeeLoanAccounts."Loan Product Description";
                    Description := EmployeeLoanAccounts."Loan Product Description" + ' ' + "Loan No.";
                    "Disbursed Amount" := EmployeeLoanAccounts."Disbursed Amount";
                    "Applied Amount" := EmployeeLoanAccounts."Applied Amount";
                    "Approved Amount" := EmployeeLoanAccounts."Applied Amount";
                    "Remaining Amount" := EmployeeLoanAccounts."Applied Amount" - "Disbursed Amount";
                    "Amount to Disburse" := EmployeeLoanAccounts."Applied Amount" - "Disbursed Amount";
                    if "Disbursement Type" = "Disbursement Type"::"Full Disbursement" then begin
                        "Amount to Disburse" := "Approved Amount";
                        "Global Dimension 1 Code" := EmployeeLoanAccounts."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := EmployeeLoanAccounts."Global Dimension 2 Code";
                        "Shortcut Dimension 3 Code" := EmployeeLoanAccounts."Shortcut Dimension 3 Code";
                        "Shortcut Dimension 4 Code" := EmployeeLoanAccounts."Shortcut Dimension 4 Code";
                    end;
                end;

            end;
        }
        field(4; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.") then
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(5; "Employee Name"; Text[90])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Loan Product Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            // TableRelation = Table50363;
        }
        field(11; "Loan Product Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Applied Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Approved Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Disbursement Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Disbursement Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Full Disbursement,Partial Disbursement';
            OptionMembers = " ","Full Disbursement","Partial Disbursement";
        }
        field(22; "Disbursed Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Amount to Disburse"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Amount to Disburse" > ("Remaining Amount") then begin
                    Error(Text_0001);
                end;
            end;
        }
        field(24; "Remaining Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; Payee; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Payment Voucher Created"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(31; "Payment Voucher No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
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
            //  TableRelation = "Supplier Category".Field1;
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Disbursed';
            OptionMembers = Open,"Pending Approval",Released,Rejected,Disbursed;
        }
        field(71; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(72; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(73; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(74; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(75; Reversed; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(76; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(77; "Date Reversed"; Date)
        {
            Caption = 'Reversal Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(78; "Time Reversed"; Time)
        {
            Caption = 'Reversal Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(79; "Reversal Document No."; Code[20])
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
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            InvestmentGeneralSetup.Get;
            InvestmentGeneralSetup.TestField(InvestmentGeneralSetup."Funds Claim Nos.");
            "NoSeriesMgt.".InitSeries(InvestmentGeneralSetup."Funds Claim Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Document Date" := Today;
        "User ID" := UserId;
        "Date Created" := Today;
        "Time Created" := Time;
        "Approval User ID" := UserId;
        "Disbursement Date" := Today;
    end;

    var
        InvestmentGeneralSetup: Record "Funds General Setup";
        "NoSeriesMgt.": Codeunit NoSeriesManagement;
        Employee: Record Employee;
        EmployeeLoanProductDocs: Record "Employee Loan Products";
        "HRLoanMgt.": Codeunit "HR Loan Management";
        RetirementPeriod: DateFormula;
        RepaymentPeriod: DateFormula;
        EmployeeLoanAccounts: Record "Employee Loan Accounts";
        EmployeeLoanDisbursement: Record "Employee Loan Disbursement";
        Text_0001: Label 'The Amount to disburse cannot be higher than the remaining amount.';
}

