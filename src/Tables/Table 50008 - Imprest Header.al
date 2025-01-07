table 50008 "Imprest Header"
{
    Caption = 'Imprest Header';
    DrillDownPageID = "Imprest Listing";
    LookupPageID = "Imprest Listing";

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
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender,Petty Cash,Board Allowance,Casuals Payment,Casual Daily Worksheet,Memo';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender","Petty Cash","Board Allowance","Casuals Payment","Casual Daily Worksheet",Memo;
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
                //TestStatusOpen(TRUE);
            end;
        }
        field(5; "Payment Mode"; Option)
        {
            Caption = 'Payment Mode';
            Editable = true;
            OptionCaption = ' ,Cheque,EFT,RTGS,MPESA,Cash,Online Banking';
            OptionMembers = " ",Cheque,EFT,RTGS,MPESA,Cash,"Online Banking";

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);
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
                //TestStatusOpen(TRUE);

                BankAccount.Reset;
                BankAccount.SetRange("No.", "Bank Account No.");
                if BankAccount.FindFirst then begin
                    "Bank Account Name" := BankAccount.Name;
                    "Currency Code" := BankAccount."Currency Code";
                    BankAccount.CalcFields(BankAccount.Balance);
                    "Bank Account Balance" := BankAccount.Balance;
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
        field(11; "Reference No."; Code[100])
        {
            Caption = 'Reference No.';

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);

                ImprestHeader.Reset;
                ImprestHeader.SetRange(ImprestHeader."Reference No.", "Reference No.");
                if ImprestHeader.FindSet then begin
                    repeat
                        if ImprestHeader."No." <> "No." then
                            Error("ErrorUsedReferenceNo.", ImprestHeader."No.");
                    until ImprestHeader.Next = 0;
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
                //TestStatusOpen(TRUE);

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
            CalcFormula = Sum("Imprest Line"."Net Amount" WHERE("Document No." = FIELD("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Amount(LCY)"; Decimal)
        {
            CalcFormula = Sum("Imprest Line"."Gross Amount(LCY)" WHERE("Document No." = FIELD("No.")));
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
            OptionCaption = ' ,Imprest,Petty Cash,Board Allowance,Overtime,Casuals Payment,Casual Daily Worksheet,Standing Imprest,Memo';
            OptionMembers = " ",Imprest,"Petty Cash","Board Allowance",Overtime,"Casuals Payment","Casual Daily Worksheet","Standing Imprest",Memo;
        }
        field(40; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            // Editable = false;
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
                    position := Employee.Position;

                    "Position Title" := Employee."Position Title";
                    //updated on 19/07/2021
                    HOD := Employee.HOD;
                    "Area Manager" := Employee.Supervisor;
                    MD := Employee.MD;
                    CIS := Employee.CIS;
                    Driver := Employee.Driver;
                    Secretary := Employee.Secretary;
                    "User ID" := Employee."User ID";
                    //updated on 03/12/2024
                    Designation := Employee."Job Title";
                end;
                //check imprest
                if Type = Type::Imprest then begin
                    CheckImprestNotSurrendered("Employee No.");
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
        field(49; Description; Text[500])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                Description := UpperCase(Description);
            end;
        }
        field(50; "Global Dimension 1 Code"; Code[50])
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

                ImprestLine.Reset;
                ImprestLine.SetRange(ImprestLine."Document No.", "No.");
                if ImprestLine.FindSet then begin
                    repeat
                        // ImprestLine."Global Dimension 2 Code":='';
                        //ImprestLine."Shortcut Dimension 3 Code":='';
                        ImprestLine."Shortcut Dimension 4 Code" := '';
                        ImprestLine."Shortcut Dimension 5 Code" := '';
                        ImprestLine."Shortcut Dimension 6 Code" := '';
                        ImprestLine."Shortcut Dimension 7 Code" := '';
                        ImprestLine."Shortcut Dimension 8 Code" := '';
                        ImprestLine.Modify;
                    until ImprestLine.Next = 0;
                end;
                //End delete the previous dimensions

                ImprestLine.Reset;
                ImprestLine.SetRange(ImprestLine."Document No.", "No.");
                if ImprestLine.FindSet then begin
                    repeat
                        ImprestLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        ImprestLine.Modify;
                    until ImprestLine.Next = 0;
                end;
            end;
        }
        field(51; "Global Dimension 2 Code"; Code[50])
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
        field(52; "Shortcut Dimension 3 Code"; Code[50])
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
        field(53; "Shortcut Dimension 4 Code"; Code[50])
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
        field(54; "Shortcut Dimension 5 Code"; Code[50])
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
        field(55; "Shortcut Dimension 6 Code"; Code[50])
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
        field(56; "Shortcut Dimension 7 Code"; Code[50])
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
        field(57; "Shortcut Dimension 8 Code"; Code[50])
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
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted,Reversed,Cancelled';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted,Reversed,Cancelled;
        }
        field(71; Posted; Boolean)
        {
            Caption = 'Posted';
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
            Editable = true;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                UserSetup.Reset;
                UserSetup.SetRange(UserSetup."User ID", "User ID");
                if UserSetup.FindFirst then begin
                    //UserSetup.TESTFIELD(UserSetup."Global Dimension 1 Code");
                    //UserSetup.TESTFIELD(UserSetup."Global Dimension 2 Code");
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
        field(106; "Document Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(107; "Pending Approver"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Approval Entry"."Approver ID" WHERE("Document No." = FIELD("No."),
                                                                  Status = FILTER(Open));
        }
        field(108; position; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee.Position;
        }
        field(109; "Position Title"; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."Position Title";
        }
        field(110; "Purchase Requisition No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(112; "Cancelled By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(113; "Time Cancelled"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(114; "Date Cancelled"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(115; "Reason for Cancellation"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(116; "Document Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(117; "Transferred to Payroll"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(118; "Payroll Period"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(119; "Date transferred"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(120; "Transferred By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(121; "Created By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                /*  IF Employee.GET("Created By") THEN BEGIN
                    IF (Employee.Responsibilty = Employee.Responsibilty::" ") AND (Rec.Type = Rec.Type::Overtime) THEN BEGIN
                      ERROR('You are not Allowed to Make this Request. Contact Section Head for Assistance.');
                      EXIT;
                    END;
                  END;*/

            end;
        }
        field(122; "Casual Requisition No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(123; CIS; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'CIS';
            Editable = false;
        }
        field(124; Driver; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Driver';
            Editable = false;

        }
        field(50224; Secretary; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50225; HOD; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50226; "Area Manager"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50227; "Project No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;

            trigger OnValidate()
            begin
                if JobRec.Get("Project No") then begin
                    "Project Name" := JobRec.Description;
                end;
            end;
        }
        field(50228; "Project Name"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(50229; MD; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50230; "Transport request"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transport Request"."Request No.";
        }
        field(50231; "Casual Requisition"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employee Requisitions"."No." WHERE("Employee No" = FIELD("Employee No."),
                                                                    Status = FILTER(Released));

            trigger OnValidate()
            begin
                HREmployeeRequisitions.Reset;
                HREmployeeRequisitions.SetRange("No.", "Casual Requisition");
                if HREmployeeRequisitions.FindSet then begin
                    Description := HREmployeeRequisitions."Reason for engagement";
                    "Job Specifications" := HREmployeeRequisitions."Reason for engagement";
                    "Date From" := HREmployeeRequisitions."Start Date";
                    "Date To" := HREmployeeRequisitions."End Date";
                    if Status = Status::Posted then begin
                        HREmployeeRequisitions.Status := HREmployeeRequisitions.Status::Closed;
                    end;
                    HREmployeeRequisitions.Modify;
                end;
            end;
        }
        field(50232; "Casual Payment Paid"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50233; "Payment Voucher No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Header"."No." WHERE(Status = FILTER(Posted));
        }
        field(50234; "Reference No"; Code[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50235; "Job Specifications"; Text[250])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Description := "Job Specifications";
            end;
        }
        field(50236; "Supervisor Report"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50237; "Any Remaining Work"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50238; "Report by Head of Section"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50239; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50240; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Imprest Line"."Net Amount" WHERE("Document No." = FIELD("No."),
                                                                 "Casual Payment" = FILTER(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50241; "Report by Head of Department"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50242; "Standing Imprest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50243; "Imprest Type"; Option)
        {
            DataClassification = ToBeClassified;

            OptionCaption = 'General Imprest,Branch Imprest,Safari';
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
        field(50244; Voted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50245; "Passed Budget"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50246; "Low Value"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50247; "Approving Department"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approving Department';
            OptionCaption = ' ,Technical,Commercial,Managing Director';
            OptionMembers = " ",Technical,Commercial,"Managing Director";

        }
        field(50248; To; text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50249; Details; text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50250; Designation; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50251; Through; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50252; "More Details"; text[2048])
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
        fieldgroup(DropDown; "No.", "Posting Date", "Employee No.", "Employee Name", Description)
        {
        }
    }

    trigger OnDelete()
    begin
        TestField(Status, Status::Open);
        ImprestLine.Reset;
        ImprestLine.SetRange(ImprestLine."Document No.", "No.");
        if ImprestLine.FindSet then
            ImprestLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            FundsSetup.Get;
            if Type = Type::Imprest then begin
                FundsSetup.TestField(FundsSetup."Imprest Nos.");
                NoSeriesMgt.InitSeries(FundsSetup."Imprest Nos.", xRec."No. Series", 0D, "No.", "No. Series");
                "Document Type" := "Document Type"::Imprest;

            end else if Type = Type::"Petty Cash" then begin
                FundsSetup.TestField("Petty Cash Nos");
                NoSeriesMgt.InitSeries(FundsSetup."Petty Cash Nos", xRec."No. Series", 0D, "No.", "No. Series");
                "Document Type" := "Document Type"::"Petty Cash";
                //END;
                //added on 15/04/2020
            end
            else if Type = Type::Overtime then begin
                FundsSetup.Get;
                FundsSetup.TestField(FundsSetup."Overtime Nos");
                NoSeriesMgt.InitSeries(FundsSetup."Overtime Nos", xRec."No. Series", 0D, "No.", "No. Series");

            end

            else if Type = Type::"Board Allowance" then begin
                FundsSetup.TestField("Board Member Allowance Nos");
                NoSeriesMgt.InitSeries(FundsSetup."Board Member Allowance Nos", xRec."No. Series", 0D, "No.", "No. Series");
                "Document Type" := "Document Type"::"Board Allowance";
            end

            //added on 08/12/2021
            else if Type = Type::"Casuals Payment" then begin
                FundsSetup.TestField("Casual Payment Nos");
                NoSeriesMgt.InitSeries(FundsSetup."Casual Payment Nos", xRec."No. Series", 0D, "No.", "No. Series");
                "Document Type" := "Document Type"::"Casuals Payment";
            end
            //added on 21/10/2022
            else if Type = Type::"Casual Daily Worksheet" then begin
                FundsSetup.TestField("Casual Payment Nos");
                NoSeriesMgt.InitSeries(FundsSetup."Casual Daily Wk  Nos", xRec."No. Series", 0D, "No.", "No. Series");
                "Document Type" := "Document Type"::"Casual Daily Worksheet";
            end
            //added on 03/12/2024
            else if Type = Type::Memo then begin
                FundsSetup.TestField("Memo Nos");
                NoSeriesMgt.InitSeries(FundsSetup."Memo Nos", xRec."No. Series", 0D, "No.", "No. Series");
                "Document Type" := "Document Type"::Memo;
            end;
        end;
        "Document Date" := Today;
        "User ID" := USERID;
        "Posting Date" := Today;
        Validate("User ID");
        Validate("Purchase Requisition No");
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
        ImprestHeader: Record "Imprest Header";
        ImprestLine: Record "Imprest Line";
        CurrExchRate: Record "Currency Exchange Rate";
        Employee: Record Employee;
        "ErrorUsedReferenceNo.": Label 'The Reference Number has been used in Document No:%1';
        HumanResourcesSetup: Record "Human Resources Setup";
        UserSetup: Record Employee;
        UserSetupRec: Record "User Setup";
        JobRec: Record Job;
        HREmployeeRequisitions: Record "HR Employee Requisitions";

    local procedure TestStatusOpen(AllowApproverEdit: Boolean)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        if ImprestHeader.Get("No.") then begin
            if AllowApproverEdit then begin
                ApprovalEntry.Reset;
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", ImprestHeader."No.");
                ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
                ApprovalEntry.SetRange(ApprovalEntry."Approver ID", UserId);
                if not ApprovalEntry.FindFirst then begin
                    ImprestHeader.TestField(Status, ImprestHeader.Status::Open);
                end;
            end else begin
                ;
                //ImprestHeader.TESTFIELD(Status,ImprestHeader.Status::Open);
            end;
        end;
    end;

    procedure CheckImprestNotSurrendered("EmployeeNo.": Code[20])
    var
        ImprestNotSurrendered: Boolean;
    begin
        //ERROR('Type '+ FORMAT("EmployeeNo."));
        Employee.Get("EmployeeNo.");


        if Employee."Emplymt. Contract Code" = 'BOARD' then
            exit;
        Employee.TestField("User ID");
        UserSetupRec.Get(Employee."User ID");
        FundsSetup.Get;


        if not UserSetupRec."Allow Multiple Imprest Request" then begin
            //check for two unprocessed Imprest
            // B.V 03.08.2023
            ImprestHeader.Reset;
            ImprestHeader.SetRange(ImprestHeader."Employee No.", "EmployeeNo.");
            ImprestHeader.SetRange(Type, ImprestHeader.Type::Imprest);
            if ImprestHeader.FindLast then begin
                if ImprestHeader."Surrender status" = ImprestHeader."Surrender status"::"Not Surrendered" then
                    Error('Imprest Request No. %1 yet to be surrendered', ImprestHeader."No.");
                ImprestNotSurrendered := true;
            end;
            // B.V 03.08.2023 end
            /*ImprestNotSurrendered:=FALSE;
            ImprestHeader.RESET;
            ImprestHeader.SETRANGE(ImprestHeader."Employee No.","EmployeeNo.");
            ImprestHeader.SETRANGE(Status,ImprestHeader.Status::Posted);
           // ImprestHeader.SETRANGE(Surrendered,TRUE);
            ImprestHeader.SETRANGE("Document Type",ImprestHeader."Document Type"::Imprest);
            ImprestHeader.SETRANGE(Surrendered,FALSE);
            IF ImprestHeader.FINDFIRST THEN
              BEGIN
                IF ImprestHeader."Surrender status"= ImprestHeader."Surrender status"::"Not Surrendered"  THEN
                ERROR('Imprest Request No. %1 yet to be surrendered',ImprestHeader."No.");
                ImprestNotSurrendered:=TRUE;
            END;*/
        end else begin
            ImprestHeader.Reset;
            ImprestHeader.SetRange(ImprestHeader."Employee No.", "EmployeeNo.");
            ImprestHeader.SetRange(Status, ImprestHeader.Status::Posted);
            ImprestHeader.SetRange(Surrendered, false);

            if FundsSetup."Maximum Imprest Requests" < ImprestHeader.Count then
                Error('You have exceeded the limit %1  of unsurrendered requests ', FundsSetup."Maximum Imprest Requests");

        end;

    end;

    [Scope('Personalization')]
    procedure AssistEdit(): Boolean
    begin
        /*FundsSetup.GET;
        FundsSetup.TESTFIELD("Payment Voucher Reference Nos.");
        IF NoSeriesMgt.SelectSeries(FundsSetup."Payment Voucher Reference Nos.",xRec."No. Series","No. Series") THEN BEGIN
          NoSeriesMgt.SetSeries("No.");
          EXIT(TRUE);
        END;*/

    end;
}

