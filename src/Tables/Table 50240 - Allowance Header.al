table 50240 "Allowance Header"
{
    Caption = 'Allowance Header';
    DrillDownPageID = "Allowance List";
    LookupPageID = "Allowance List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender,Allowance';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender",Allowance;
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Editable = false;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(5; "Payment Mode"; Option)
        {
            Caption = 'Payment Mode';
            Editable = true;
            OptionCaption = ' ,Cheque,EFT,RTGS,MPESA,Cash';
            OptionMembers = " ",Cheque,EFT,RTGS,MPESA,Cash;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(6; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            Editable = false;
            OptionCaption = 'Normal,Petty Cash,Express,Cash Purchase,Mobile';
            OptionMembers = Normal,"Petty Cash",Express,"Cash Purchase",Mobile;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(7; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                BankAccount.Reset;
                BankAccount.SetRange("No.", "Bank Account No.");
                if BankAccount.FindFirst then begin
                    "Bank Account Name" := BankAccount.Name;
                    "Currency Code" := BankAccount."Currency Code";
                    Validate("Currency Code");
                end;
            end;
        }
        field(8; "Bank Account Name"; Text[100])
        {
            Caption = 'Bank Account Name';
            Editable = false;
        }
        field(9; "Bank Account Balance"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FIELD("Bank Account No.")));
            Caption = 'Bank Account Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Cheque Type"; Option)
        {
            Caption = 'Cheque Type';
            OptionCaption = ' ,Computer Cheque,Manual Cheque';
            OptionMembers = " ","Computer Cheque","Manual Cheque";

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(11; "Reference No."; Code[20])
        {
            Caption = 'Reference No.';

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                TransferAllowanceHeader.Reset;
                TransferAllowanceHeader.SetRange(TransferAllowanceHeader."Reference No.", "Reference No.");
                if TransferAllowanceHeader.FindSet then begin
                    repeat
                        if TransferAllowanceHeader."No." <> "No." then
                            Error("ErrorUsedReferenceNo.", TransferAllowanceHeader."No.");
                    until TransferAllowanceHeader.Next = 0;
                end;
            end;
        }
        field(15; "On Behalf Of"; Text[100])
        {
            Caption = 'On Behalf Of';
        }
        field(16; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                if "Currency Code" <> '' then begin
                    if BankAccount.Get("Bank Account No.") then begin
                        BankAccount.TestField(BankAccount."Currency Code", "Currency Code");
                        "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                    end;
                end else begin
                    if BankAccount.Get("Bank Account No.") then begin
                        BankAccount.TestField(BankAccount."Currency Code", '');
                    end;
                end;
            end;
        }
        field(17; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
        }
        field(18; Amount; Decimal)
        {
            CalcFormula = Sum("Allowance Line"."Net Amount" WHERE("Document No." = FIELD("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Amount(LCY)"; Decimal)
        {
            CalcFormula = Sum("Allowance Line"."Gross Amount(LCY)" WHERE("Document No." = FIELD("No.")));
            Caption = 'Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Imprest Remaining Amount"; Decimal)
        {
            Editable = false;
        }
        field(21; "Imprest Remaining Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(22; "Date From"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Date To"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Imprest,Petty Cash,Allowance';
            OptionMembers = " ",Imprest,"Petty Cash",Allowance;
        }
        field(40; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                "Employee Name" := '';
                "Employee Posting Group" := '';
                if Employee.Get("Employee No.") then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    Employee.TestField(Employee."Imprest Posting Group");
                    "Employee Posting Group" := Employee."Imprest Posting Group";
                    "HR Job Grade" := Employee."Salary Scale";
                    "Phone No." := Employee."Phone No.";
                end;
            end;
        }
        field(41; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(42; "Employee Posting Group"; Code[20])
        {
            Editable = false;
            TableRelation = "Employee Posting Group".Code;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(43; Surrendered; Boolean)
        {
            Caption = 'Surrendered';
        }
        field(44; "Imprest Surrender No."; Code[20])
        {
            Caption = 'Imprest Surrender No.';
            Editable = false;
            TableRelation = "Imprest Surrender Header"."No.";
        }
        field(49; Description; Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                Description := UpperCase(Description);
            end;
        }
        field(50; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
                //Delete the previous dimensions
                //"Global Dimension 2 Code":='';
                //"Shortcut Dimension 3 Code":='';
                "Shortcut Dimension 4 Code" := '';
                "Shortcut Dimension 5 Code" := '';
                "Shortcut Dimension 6 Code" := '';
                "Shortcut Dimension 7 Code" := '';
                "Shortcut Dimension 8 Code" := '';

                TransferAllowanceLine.Reset;
                TransferAllowanceLine.SetRange(TransferAllowanceLine."Document No.", "No.");
                if TransferAllowanceLine.FindSet then begin
                    repeat
                        // TransferAllowanceLine."Global Dimension 2 Code":='';
                        //TransferAllowanceLine."Shortcut Dimension 3 Code":='';
                        TransferAllowanceLine."Shortcut Dimension 4 Code" := '';
                        TransferAllowanceLine."Shortcut Dimension 5 Code" := '';
                        TransferAllowanceLine."Shortcut Dimension 6 Code" := '';
                        TransferAllowanceLine."Shortcut Dimension 7 Code" := '';
                        TransferAllowanceLine."Shortcut Dimension 8 Code" := '';
                        TransferAllowanceLine.Modify;
                    until TransferAllowanceLine.Next = 0;
                end;
                //End delete the previous dimensions

                TransferAllowanceLine.Reset;
                TransferAllowanceLine.SetRange(TransferAllowanceLine."Document No.", "No.");
                if TransferAllowanceLine.FindSet then begin
                    repeat
                        TransferAllowanceLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        TransferAllowanceLine.Modify;
                    until TransferAllowanceLine.Next = 0;
                end;
            end;
        }
        field(51; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(52; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(53; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(54; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(55; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(56; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(57; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(58; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center".Code;
        }
        field(59; "Surrender status"; Option)
        {
            OptionCaption = 'Not Surrendered,Partially Surrendered,Fully surrendered';
            OptionMembers = "Not Surrendered","Partially Surrendered","Fully surrendered";
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted,Reversed';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
        }
        field(71; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(72; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(73; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            Editable = false;
        }
        field(74; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            Editable = false;
        }
        field(75; Reversed; Boolean)
        {
            Caption = 'Reversed';
            Editable = false;
        }
        field(76; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(77; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            Editable = false;
        }
        field(78; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            Editable = false;
        }
        field(80; "Reversal Posting Date"; Date)
        {
        }
        field(99; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                UserSetup.Reset;
                UserSetup.SetRange(UserSetup."User ID", "User ID");
                if UserSetup.FindFirst then begin
                    UserSetup.TestField(UserSetup."Global Dimension 1 Code");
                    UserSetup.TestField(UserSetup."Global Dimension 2 Code");
                    "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := UserSetup."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := UserSetup."Shortcut Dimension 4 Code";
                    "Shortcut Dimension 5 Code" := UserSetup."Shortcut Dimension 5 Code";
                    "Shortcut Dimension 6 Code" := UserSetup."Shortcut Dimension 6 Code";
                    "Shortcut Dimension 7 Code" := UserSetup."Shortcut Dimension 7 Code";
                    "Shortcut Dimension 8 Code" := UserSetup."Shortcut Dimension 8 Code";
                    "Employee No." := UserSetup."No.";
                    Validate("Employee No.");
                end;
            end;
        }
        field(100; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(101; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
        }
        field(102; "Incoming Document Entry No."; Integer)
        {
        }
        field(103; "Phone No."; Text[30])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(105; "HR Job Grade"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(106; "Attachment Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(116; "Document Path"; Text[250])
        {
            DataClassification = ToBeClassified;
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
        fieldgroup(DropDown; "No.", "Employee No.", "Employee Name", Description)
        {
        }
    }

    trigger OnDelete()
    begin
        TestField(Status, Status::Open);
        TransferAllowanceLine.Reset;
        TransferAllowanceLine.SetRange(TransferAllowanceLine."Document No.", "No.");
        if TransferAllowanceLine.FindSet then
            TransferAllowanceLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            FundsSetup.Get;
            FundsSetup.TestField(FundsSetup."Allowance Nos");
            NoSeriesMgt.InitSeries(FundsSetup."Allowance Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Document Type" := "Document Type"::Allowance;
        "Document Date" := Today;
        "User ID" := UserId;
        "Posting Date" := Today;
        Validate("User ID");
    end;

    var
        FundsSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        "G/LAccount": Record "G/L Account";
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
        TransferAllowanceHeader: Record "Allowance Header";
        TransferAllowanceLine: Record "Allowance Line";
        CurrExchRate: Record "Currency Exchange Rate";
        Employee: Record Employee;
        "ErrorUsedReferenceNo.": Label 'The Reference Number has been used in Document No:%1';
        HumanResourcesSetup: Record "Human Resources Setup";
        UserSetup: Record Employee;

    local procedure TestStatusOpen(AllowApproverEdit: Boolean)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        if TransferAllowanceHeader.Get("No.") then begin
            if AllowApproverEdit then begin
                ApprovalEntry.Reset;
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", TransferAllowanceHeader."No.");
                ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
                ApprovalEntry.SetRange(ApprovalEntry."Approver ID", UserId);
                if not ApprovalEntry.FindFirst then begin
                    TransferAllowanceHeader.TestField(Status, TransferAllowanceHeader.Status::Open);
                end;
            end else begin
                TransferAllowanceHeader.TestField(Status, TransferAllowanceHeader.Status::Open);
            end;
        end;
    end;
}

