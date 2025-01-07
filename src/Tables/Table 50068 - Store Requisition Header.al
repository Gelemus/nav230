table 50068 "Store Requisition Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Document Date"; Date)
        {
        }
        field(3; "Posting Date"; Date)
        {
        }
        field(4; "Location Code"; Code[10])
        {
            TableRelation = Location;
        }
        field(5; "Required Date"; Date)
        {
        }
        field(6; "Requester ID"; Code[50])
        {
            Caption = 'Requester ID';
            Editable = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;

            trigger OnValidate()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;
        }
        field(10; "Cost Amount"; Decimal)
        {
            CalcFormula = Sum("Store Requisition Line"."Line Amount" WHERE("Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(49; Description; Text[300])
        {
        }
        field(50; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(51; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(52; "Shortcut Dimension 3 Code"; Code[50])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
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
                StoreRequisitionLine.Reset;
                StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", "No.");
                if StoreRequisitionLine.FindSet then begin
                    repeat
                        StoreRequisitionLine."Shortcut Dimension 4 Code" := "Shortcut Dimension 4 Code";
                        StoreRequisitionLine.Modify;
                    until StoreRequisitionLine.Next = 0;
                end;
            end;
        }
        field(54; "Shortcut Dimension 5 Code"; Code[50])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(55; "Shortcut Dimension 6 Code"; Code[50])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(56; "Shortcut Dimension 7 Code"; Code[50])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(57; "Shortcut Dimension 8 Code"; Code[50])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(58; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center".Code;
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            Editable = true;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted,Partially Posted,Cancelled,Converted';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted,"Partially Posted",Cancelled,Converted;

            trigger OnValidate()
            begin
                StoreRequisitionLine.Reset;
                StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", "No.");
                if StoreRequisitionLine.FindSet then begin
                    repeat
                        StoreRequisitionLine.Status := Status;
                        StoreRequisitionLine.Modify;
                    until StoreRequisitionLine.Next = 0;
                end;
            end;
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
                    Position := Employee.Position;
                    "Employee No." := UserSetup."No.";
                    "Employee Name" := UserSetup."Full Name";
                    "Position Title" := Employee."Position Title";
                    "Shortcut Dimension 3 Code" := Employee."Shortcut Dimension 3 Code";
                end;

                Employee.Reset;
                Employee.SetRange(Employee."No.", "Employee No.");
                if Employee.FindFirst then begin
                    "User ID" := Employee."User ID";
                    "Employee No." := Employee."No.";
                    "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := Employee."Shortcut Dimension 3 Code";
                    Position := Employee.Position;
                    "Position Title" := Employee."Position Title";
                    "Shortcut Dimension 3 Code" := Employee."Shortcut Dimension 3 Code";
                    "Employee No." := Employee."No.";
                    "Employee Name" := Employee."Full Name";
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
            Caption = 'Incoming Document Entry No.';
        }
        field(103; "Return to store"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(104; "Store Requistion No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Store Requisition Header"."No." WHERE(Status = CONST(Posted),
                                                                    "Return to store" = CONST(false));

            trigger OnValidate()
            begin
                //BV 01.02.2023 Update all details on the Return card
                StoreRequisitionHeader.Reset;
                StoreRequisitionHeader.SetRange(StoreRequisitionHeader."No.", StoreRequisitionHeader."No.");
                if StoreRequisitionHeader.FindFirst then begin
                    "Document Date" := StoreRequisitionHeader."Document Date";
                    "Required Date" := StoreRequisitionHeader."Required Date";
                    "Global Dimension 1 Code" := StoreRequisitionHeader."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := StoreRequisitionHeader."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := StoreRequisitionHeader."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := StoreRequisitionHeader."Shortcut Dimension 4 Code";
                    "Point Of Use" := StoreRequisitionHeader."Point Of Use";
                    Description := StoreRequisitionHeader.Description;
                    "Account No" := StoreRequisitionHeader."Account No";
                    "Customer No" := StoreRequisitionHeader."Customer No";
                    "Customer Name" := StoreRequisitionHeader."Customer Name";
                end;
            end;
        }
        field(105; Template; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,New Conection,Tertiary Connection,Cluster Connections,Stolen Meters';
            OptionMembers = " ","New Conection","Tertiary Connection","Cluster Connections","Stolen Meters";

            trigger OnValidate()
            begin

                //added on 14/07/2020 to select items that have been ticked depending on typee of connection
                if Status = Status::Open then begin
                    StoreRequisitionLine.Reset;
                    StoreRequisitionLine.SetRange("Document No.", "No.");
                    if StoreRequisitionLine.FindSet then
                        StoreRequisitionLine.DeleteAll;

                    InventorySetup.Get;

                    if Template = Template::"Cluster Connections" then begin
                        Items.Reset;
                        Items.SetCurrentKey("Sequence Cluster Connections");
                        Items.SetRange("CLUSTER CONNECTIONS", true);

                        if Items.FindSet then begin
                            repeat
                                StoreLines.Init;
                                StoreLines."Line No." := StoreLines."Line No." + 1;
                                StoreLines."Document No." := "No.";
                                StoreLines.Type := StoreLines.Type::Item;
                                StoreLines."Item No." := Items."No.";
                                StoreLines.Validate(StoreLines."Item No.");
                                StoreLines."Item Description" := Items.Description;
                                StoreLines."Unit of Measure Code" := Items."Base Unit of Measure";
                                StoreLines."Unit Cost" := Items."Unit Cost";
                                StoreLines."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                StoreLines."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                                StoreLines.Quantity := Items."Cluster Quantity";
                                StoreLines."Quantity to issue" := StoreLines.Quantity;
                                StoreLines."Line Amount" := StoreLines.Quantity * StoreLines."Unit Cost";
                                StoreLines."Unit Price" := Items."Unit Price";
                                StoreLines."Total Sale Amount" := StoreLines.Quantity * StoreLines."Total Sale Amount";
                                StoreLines."Location Code" := InventorySetup."Location Code for templates";
                                StoreLines.Validate(StoreLines."Location Code");
                                StoreLines."Gen. Bus. Posting Group" := Items."Gen. Prod. Posting Group";
                                StoreLines."Gen. Prod. Posting Group" := Items."Gen. Prod. Posting Group";
                                StoreLines.Insert(true);
                            until Items.Next = 0;
                        end;
                    end else
                        if Template = Template::"New Conection" then begin
                            Items.Reset;
                            Items.SetCurrentKey("Sequence New Connections");
                            Items.SetRange("NEW CONNECTIONS", true);
                            if Items.FindSet then begin
                                repeat
                                    //MESSAGE('in%1', Items."No.");
                                    StoreLines.Init;
                                    StoreLines."Line No." := StoreLines."Line No." + 1;
                                    StoreLines."Document No." := "No.";
                                    StoreLines.Type := StoreLines.Type::Item;
                                    StoreLines."Item No." := Items."No.";
                                    StoreLines.Validate(StoreLines."Item No.");
                                    StoreLines."Item Description" := Items.Description;
                                    StoreLines."Unit of Measure Code" := Items."Base Unit of Measure";
                                    StoreLines."Unit Cost" := Items."Unit Cost";
                                    StoreLines."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                    StoreLines."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                                    StoreLines.Quantity := Items."New Connection Quantity";
                                    StoreLines."Quantity to issue" := StoreLines.Quantity;
                                    StoreLines."Line Amount" := StoreLines.Quantity * StoreLines."Unit Cost";
                                    StoreLines."Unit Price" := Items."Unit Price";
                                    StoreLines."Total Sale Amount" := StoreLines.Quantity * StoreLines."Total Sale Amount";
                                    StoreLines."Location Code" := InventorySetup."Location Code for templates";
                                    StoreLines.Validate(StoreLines."Location Code");
                                    StoreLines."Gen. Bus. Posting Group" := Items."Gen. Prod. Posting Group";
                                    StoreLines."Gen. Prod. Posting Group" := Items."Gen. Prod. Posting Group";
                                    StoreLines.Insert(true);
                                until Items.Next = 0;
                            end;
                        end else
                            if Template = Template::"Tertiary Connection" then begin
                                Items.Reset;
                                Items.SetCurrentKey("Sequence Tertiary Connections");
                                Items.SetRange(TERTIARY, true);
                                if Items.FindSet then begin
                                    repeat
                                        StoreLines.Init;
                                        StoreLines."Line No." := StoreLines."Line No." + 1;
                                        StoreLines."Document No." := "No.";
                                        StoreLines.Type := StoreLines.Type::Item;
                                        StoreLines."Item No." := Items."No.";
                                        StoreLines.Validate(StoreLines."Item No.");
                                        StoreLines."Item Description" := Items.Description;
                                        StoreLines."Unit of Measure Code" := Items."Base Unit of Measure";
                                        StoreLines."Unit Cost" := Items."Unit Cost";
                                        StoreLines."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                        StoreLines."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                                        StoreLines.Quantity := 1;
                                        StoreLines."Quantity to issue" := StoreLines.Quantity;
                                        StoreLines."Line Amount" := StoreLines.Quantity * StoreLines."Unit Cost";
                                        StoreLines."Unit Price" := Items."Unit Price";
                                        StoreLines."Total Sale Amount" := StoreLines.Quantity * StoreLines."Total Sale Amount";
                                        StoreLines."Location Code" := InventorySetup."Location Code for templates";
                                        StoreLines.Validate(StoreLines."Location Code");
                                        StoreLines."Gen. Bus. Posting Group" := Items."Gen. Prod. Posting Group";
                                        StoreLines."Gen. Prod. Posting Group" := Items."Gen. Prod. Posting Group";
                                        StoreLines.Insert(true);
                                    until Items.Next = 0;
                                end;
                            end;
                    if Template = Template::"Stolen Meters" then begin
                        Items.Reset;
                        Items.SetCurrentKey("Sequence Stolen Meter");
                        Items.SetRange("STOLEN METER", true);
                        if Items.FindSet then begin
                            repeat
                                StoreLines.Init;
                                StoreLines."Line No." := StoreLines."Line No." + 1;
                                StoreLines."Document No." := "No.";
                                StoreLines.Type := StoreLines.Type::Item;
                                StoreLines."Item No." := Items."No.";
                                StoreLines.Validate(StoreLines."Item No.");
                                StoreLines."Item Description" := Items.Description;
                                StoreLines."Unit of Measure Code" := Items."Base Unit of Measure";
                                StoreLines."Unit Cost" := Items."Unit Cost";
                                StoreLines."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                StoreLines."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                                StoreLines.Quantity := 1;
                                StoreLines."Quantity to issue" := StoreLines.Quantity;
                                StoreLines."Line Amount" := StoreLines.Quantity * StoreLines."Unit Cost";
                                StoreLines."Unit Price" := Items."Unit Price";
                                StoreLines."Total Sale Amount" := StoreLines.Quantity * StoreLines."Total Sale Amount";
                                StoreLines."Location Code" := InventorySetup."Location Code for templates";
                                StoreLines.Validate(StoreLines."Location Code");
                                StoreLines."Gen. Bus. Posting Group" := Items."Gen. Prod. Posting Group";
                                StoreLines."Gen. Prod. Posting Group" := Items."Gen. Prod. Posting Group";
                                StoreLines.Insert(true);
                            until Items.Next = 0;
                        end;
                    end;
                end;
            end;
        }
        field(106; "Employee Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(107; "Issued By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                if Status <> Status::Approved then
                    Error('The requisition has to be approved to be able to be issued');

                Employee.Reset;
                Employee.SetRange("User ID", "Issued By");
                if Employee.FindSet then begin
                    "Issued By Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                end;
            end;
        }
        field(108; "Issued By Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(109; "Bottled Water"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(110; "Store Issue Note"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(111; "Store Issue Note No Series"; Code[20])
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
        field(116; Donation; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(117; "Driver No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                if Status = Status::Approved then begin
                    Employee.Reset;
                    Employee.SetRange(Employee."No.", "Driver No");
                    if Employee.FindSet then begin

                        "Driver Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";

                    end;

                end else
                    Message('The requisition in not fully apprived');
            end;
        }
        field(118; "Driver Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(119; " Re Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Name';
        }
        field(120; "Customer ID No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(121; "Customer Phone No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(122; "Returnable Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Issued,Returned;
            OptionCaption = '" ",Issued,Returned';
            Editable = false;

        }
        field(123; "Returnable Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50000; "Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; Position; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee.Position;
        }
        field(50002; "Position Title"; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."Position Title";
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
        field(50228; "Project Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50229; MD; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50230; "Point Of Use"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50231; "Purchase requisition Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50232; "Purchase Req Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50233; "Purchase Req Time Created"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50234; "Purchase Req Created By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50235; "Total Sale Amount"; Decimal)
        {
            CalcFormula = Sum("Store Requisition Line"."Total Sale Amount" WHERE("Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50236; "Loose Tools"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50237; "Create Customer Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Invoiced By" := UserId;
            end;
        }
        field(50238; "Customer No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if CustomerRec.Get("Customer No") then begin
                    "Customer Name" := CustomerRec.Name;
                    "Account No" := CustomerRec."Account No.";
                    "Point Of Use" := CustomerRec."Account No.";
                end;
            end;
        }
        field(50239; "Customer Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50240; "Invoiced By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50241; "Reference No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50242; "Invoice Account"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Account,O&M Fittings';
            OptionMembers = Account,"O&M Fittings";
        }
        field(50243; "Labour Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(500008; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender,Allowance,Store Req,Purchase Req,Salary Advance,Returnable';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender",Allowance,"Store Req","Purchase Req","Salary Advance","Returnable";
        }
        field(52137023; "Employee No."; Code[20])
        {
            Editable = true;
            TableRelation = Employee."No.";
        }
        field(52137024; "Document Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(52137025; "Cancellation comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(52137026; "Customer Invoice Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Awaiting Invoicing,Invoicing In Progress,Invoicing Completed,Invoicing Failed';
            OptionMembers = "Awaiting Invoicing","Invoicing In Progress","Invoicing Completed","Invoicing Failed";
        }
        field(52137027; "Integration Response"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52137028; "Make Adjustment to Customer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52137029; "Adjustment Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Awaiting Adjustment,Adjustment In Progress,Adjustment Completed,Adjustment Failed';
            OptionMembers = "Awaiting Adjustment","Adjustment In Progress","Adjustment Completed","Adjustment Failed";
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

    trigger OnDelete()
    begin
        /* IF Status<>Status::Open THEN
            ERROR(Text002)*/

    end;

    trigger OnInsert()
    begin
        if ("No." = '') and ("Returnable Item" = false) and ("Return to store" = false) and ("Bottled Water" = false) and (Donation = false) and ("Loose Tools" = false) then begin
            InventorySetup.Get();
            InventorySetup.TestField(InventorySetup."Stores Requisition Nos.");
            NoSeriesMgt.InitSeries(InventorySetup."Stores Requisition Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        if ("No." = '') and ("Returnable Item" = false) and ("Return to store" = true) and ("Bottled Water" = false) and (Donation = false) and ("Loose Tools" = false) then begin
            InventorySetup.Get();
            InventorySetup.TestField(InventorySetup."Return Store Requisition Nos.");
            NoSeriesMgt.InitSeries(InventorySetup."Return Store Requisition Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        if ("No." = '') and ("Returnable Item" = false) and ("Bottled Water" = true) and ("Return to store" = false) and (Donation = false) and ("Loose Tools" = false) then begin
            InventorySetup.Get();
            InventorySetup.TestField(InventorySetup."Bottled Water Nos.");
            NoSeriesMgt.InitSeries(InventorySetup."Bottled Water Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        if ("No." = '') and ("Returnable Item" = false) and (Donation = true) and ("Return to store" = false) and ("Bottled Water" = false) and ("Loose Tools" = false) then begin
            InventorySetup.Get();
            InventorySetup.TestField(InventorySetup."Donation Nos.");
            NoSeriesMgt.InitSeries(InventorySetup."Donation Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        if ("No." = '') and ("Returnable Item" = false) and ("Loose Tools" = true) and ("Return to store" = false) and ("Bottled Water" = false) and (Donation = false) then begin
            InventorySetup.Get();
            InventorySetup.TestField(InventorySetup."Loose Tools");
            NoSeriesMgt.InitSeries(InventorySetup."Loose Tools", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        if ("No." = '') and ("Returnable Item" = true) and ("Return to store" = false) and ("Bottled Water" = false) and (Donation = false) then begin
            InventorySetup.Get();
            InventorySetup.TestField(InventorySetup.Returnable);
            NoSeriesMgt.InitSeries(InventorySetup.Returnable, xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Document Date" := Today;
        "Posting Date" := Today;
        "Requester ID" := UserId;
        "User ID" := UserId;
        Validate("User ID");

        Employee.Reset;
        Employee.SetRange(Employee."No.", "Employee No.");
        if Employee.FindSet then begin
            "User ID" := Employee."User ID";
            "Employee No." := Employee."No.";
            "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            "Shortcut Dimension 3 Code" := Employee."Shortcut Dimension 3 Code";
            "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
            "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
            HOD := Employee.HOD;
            "Area Manager" := Employee.Supervisor;
            MD := Employee.MD;
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;

        InventorySetup: Record "Inventory Setup";
        Text001: Label 'Your identification is set up to process from %1 %2 only.';
        StoreRequisitionLine: Record "Store Requisition Line";
        Employee: Record Employee;
        Text002: Label 'You Cannot DELETE an already released Requisition';
        UserSetup: Record Employee;
        StoreLines: Record "Store Requisition Line";
        Items: Record Item;
        JobRec: Record Job;
        CustomerRec: Record Customer;
        StoreRequisitionHeader: Record "Store Requisition Header";
}

