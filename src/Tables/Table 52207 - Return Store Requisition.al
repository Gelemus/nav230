table 52207 "Return Store Requisition"
{

    fields
    {
        field(1;"No.";Code[20])
        {
            Editable = false;
        }
        field(2;"Document Date";Date)
        {
        }
        field(3;"Posting Date";Date)
        {
        }
        field(4;"Location Code";Code[10])
        {
            TableRelation = Location;
        }
        field(5;"Required Date";Date)
        {
        }
        field(6;"Requester ID";Code[50])
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
        field(10;Amount;Decimal)
        {
            CalcFormula = Sum("Store Requisition Line"."Line Amount" WHERE ("Document No."=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(49;Description;Text[150])
        {
        }
        field(50;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(51;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(52;"Shortcut Dimension 3 Code";Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
        }
        field(53;"Shortcut Dimension 4 Code";Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
        }
        field(54;"Shortcut Dimension 5 Code";Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
        }
        field(55;"Shortcut Dimension 6 Code";Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
        }
        field(56;"Shortcut Dimension 7 Code";Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
        }
        field(57;"Shortcut Dimension 8 Code";Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false),
                                                          test=FIELD("Global Dimension 1 Code"));
        }
        field(58;"Responsibility Center";Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center".Code;
        }
        field(70;Status;Option)
        {
            Caption = 'Status';
            Editable = true;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted,Partially Posted';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted,"Partially Posted";

            trigger OnValidate()
            begin
                StoreRequisitionLine.Reset;
                StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.","No.");
                if StoreRequisitionLine.FindSet then begin
                  repeat
                    StoreRequisitionLine.Status:=Status;
                    StoreRequisitionLine.Modify;
                  until StoreRequisitionLine.Next=0;
                end;
            end;
        }
        field(71;Posted;Boolean)
        {
            Caption = 'Posted';
        }
        field(72;"Posted By";Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(73;"Date Posted";Date)
        {
            Caption = 'Date Posted';
            Editable = false;
        }
        field(74;"Time Posted";Time)
        {
            Caption = 'Time Posted';
            Editable = false;
        }
        field(75;Reversed;Boolean)
        {
            Caption = 'Reversed';
            Editable = false;
        }
        field(76;"Reversed By";Code[50])
        {
            Caption = 'Reversed By';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(77;"Reversal Date";Date)
        {
            Caption = 'Reversal Date';
            Editable = false;
        }
        field(78;"Reversal Time";Time)
        {
            Caption = 'Reversal Time';
            Editable = false;
        }
        field(99;"User ID";Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                UserSetup.Reset;
                UserSetup.SetRange(UserSetup."User ID","User ID");
                if UserSetup.FindFirst then begin
                  UserSetup.TestField(UserSetup."Global Dimension 1 Code");
                  UserSetup.TestField(UserSetup."Global Dimension 2 Code");
                  "Global Dimension 1 Code":=UserSetup."Global Dimension 1 Code";
                  "Global Dimension 2 Code":=UserSetup."Global Dimension 2 Code";
                  "Shortcut Dimension 3 Code":=UserSetup."Shortcut Dimension 3 Code";
                  "Shortcut Dimension 4 Code":=UserSetup."Shortcut Dimension 4 Code";
                  "Shortcut Dimension 5 Code":=UserSetup."Shortcut Dimension 5 Code";
                  "Shortcut Dimension 6 Code":=UserSetup."Shortcut Dimension 6 Code";
                  "Shortcut Dimension 7 Code":=UserSetup."Shortcut Dimension 7 Code";
                  "Shortcut Dimension 8 Code":=UserSetup."Shortcut Dimension 8 Code";
                end;

                Employee.Reset;
                Employee.SetRange(Employee."User ID","User ID");
                if Employee.FindFirst then
                begin
                  "User ID":=Employee."User ID";
                  "Employee No." := Employee."No.";
                  "Global Dimension 1 Code":=Employee."Global Dimension 1 Code";
                  "Global Dimension 2 Code":=Employee."Global Dimension 2 Code";
                end;
            end;
        }
        field(100;"No. Series";Code[20])
        {
            Caption = 'No. Series';
        }
        field(101;"No. Printed";Integer)
        {
            Caption = 'No. Printed';
        }
        field(102;"Incoming Document Entry No.";Integer)
        {
            Caption = 'Incoming Document Entry No.';
        }
        field(103;Returned;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52137023;"Employee No.";Code[20])
        {
            Editable = false;
            TableRelation = Employee."No.";
        }
        field(52137024;"Document Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
          if Status<>Status::Open then
             Error(Text002)
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
          InventorySetup.Get();
          InventorySetup.TestField(InventorySetup."Stores Requisition Nos.");
          NoSeriesMgt.InitSeries(InventorySetup."Stores Requisition Nos.",xRec."No. Series",0D,"No.","No. Series");
        end;

        if "No." = '' then begin
          InventorySetup.Get();
          InventorySetup.TestField(InventorySetup."Return Store Requisition Nos.");
          NoSeriesMgt.InitSeries(InventorySetup."Return Store Requisition Nos.",xRec."No. Series",0D,"No.","No. Series");
        end;
        "Document Date":=Today;
        "Posting Date":=Today;
        "Requester ID":=UserId;
        "User ID":=UserId;
        Validate("User ID");

        Employee.Reset;
        Employee.SetRange(Employee."User ID","User ID");
        if Employee.FindFirst then
        begin
          "User ID":=Employee."User ID";
          "Employee No." := Employee."No.";
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
}

