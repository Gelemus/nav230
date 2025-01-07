table 50064 "Procurement Planning Line"
{

    fields
    {
        field(10;"Document No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Line No.";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(12;Type;Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset";

            trigger OnValidate()
            var
                TempPurchLine: Record "Purchase Line" temporary;
            begin
            end;
        }
        field(13;"No.";Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type=CONST("G/L Account")) "G/L Account"
                            ELSE IF (Type=CONST(Item)) Item
                            ELSE IF (Type=CONST("Fixed Asset")) "Fixed Asset";

            trigger OnValidate()
            var
                TempPurchLine: Record "Purchase Line" temporary;
                FindRecordMgt: Codeunit "Find Record Management";
            begin
                case Type of
                  Type::"G/L Account":
                  begin
                    GLAcc.Get("No.");
                    Description := GLAcc.Name;
                  end;
                  Type::Item:
                  begin
                    Item.Get("No.");
                    "Unit of Measure":=Item."Base Unit of Measure";
                    "Estimated cost":=Item."Market Price";
                    Description:=Item.Description;
                  end;
                  Type::"Fixed Asset":
                  begin
                    FA.Get("No.");
                    Description:=FA.Description;
                  end;
                end;
            end;
        }
        field(14;Description;Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon-Increased Text Length';

            trigger OnValidate()
            var
                Item: Record Item;
                ApplicationAreaSetup: Record "Application Area Setup";
                FindRecordMgt: Codeunit "Find Record Management";
                ReturnValue: Text[50];
                DescriptionIsNo: Boolean;
            begin
            end;
        }
        field(15;"Description 2";Text[250])
        {
            Caption = 'Description 2';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon-Increased Text Length';
        }
        field(16;"Unit of Measure";Text[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type=CONST(Item),
                                "No."=FILTER(<>'')) "Item Unit of Measure".Code WHERE ("Item No."=FIELD("No."))
                                ELSE "Unit of Measure";
        }
        field(17;Quantity;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18;"Procurement Method";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Direct Procurement,Force,Force Account,Frame Work Agreement,Open Tender,Request for Quotation,Request for Proposal,To Registered Suppliers';
            OptionMembers = ,"Direct Procurement",Force,"Force Account","Frame Work Agreement","Open Tender","Request for Quotation","Request for Proposal","To Registered Suppliers";
        }
        field(19;"Source of Funds";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Budget,GOK,Donor';
            OptionMembers = " ",Budget,GOK,Donor;
        }
        field(20;"Estimated cost";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21;"Time Process";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22;"Invite/Advertise Tender";Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                "Open Tender Date":=0D;
                "Evaluate Tender Date":=0D;
                "Committee Award Approval Date":=0D;
                "Notification of Award Date":=0D;
                "Contract Signing Date":=0D;
                "Evaluate Tender Days":=0;
                "Committee Award Approval Days":=0;
                "Notification of Award Days":=0;
                "Contract Signing Days":=0;
                "Notification of Award Days":=0;


                if "Invite/Advertise Tender" < Today then
                  Error(ERROR101);
            end;
        }
        field(23;"Open Tender Date";Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Open Tender Days":=0;
                TestField("Invite/Advertise Tender");

                if "Open Tender Date"<"Invite/Advertise Tender" then
                  Error(ERROR102);

                "Open Tender Days":="Open Tender Date"-"Invite/Advertise Tender";
            end;
        }
        field(24;"Evaluate Tender Date";Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Evaluate Tender Days":=0;
                TestField("Open Tender Date");
                "Evaluate Tender Days":="Evaluate Tender Date"-"Open Tender Date";
            end;
        }
        field(25;"Committee Award Approval Date";Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Committee Award Approval Days":=0;
                TestField("Evaluate Tender Date");
                "Committee Award Approval Days":="Committee Award Approval Date"-"Evaluate Tender Date";
            end;
        }
        field(26;"Notification of Award Date";Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Notification of Award Days":=0;
                TestField("Committee Award Approval Date");
                "Notification of Award Days":="Notification of Award Date"-"Committee Award Approval Date";
            end;
        }
        field(27;"Contract Signing Date";Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Contract Signing Days":=0;
                TestField("Notification of Award Date");
                "Contract Signing Days":="Contract Signing Date"-"Notification of Award Date";
            end;
        }
        field(28;"Total time to Contract sign";DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(29;"Time of Completion of Contract";DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(30;"Procurement Plan No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(35;"Open Tender Days";Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36;"Evaluate Tender Days";Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(37;"Committee Award Approval Days";Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(38;"Notification of Award Days";Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39;"Contract Signing Days";Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(80;"Global Dimension 1 Code";Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(81;"Global Dimension 2 Code";Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(82;"Shortcut Dimension 3 Code";Code[50])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(83;"Shortcut Dimension 4 Code";Code[50])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(84;"Shortcut Dimension 5 Code";Code[50])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(85;"Shortcut Dimension 6 Code";Code[50])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(86;"Shortcut Dimension 7 Code";Code[50])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(87;"Shortcut Dimension 8 Code";Code[50])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(88;"Responsibility Center";Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
        }
        field(89;"Type (Attributes)";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Purchase Requisition,LPO,Procurement Planning';
            OptionMembers = "Purchase Requisition",LPO,"Procurement Planning";
        }
        field(90;Budget;Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Document No.","Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        ProcurementPlanningHeader.Reset;
        ProcurementPlanningHeader.SetRange(ProcurementPlanningHeader."No.","Document No.");
        if ProcurementPlanningHeader.FindFirst then begin
          ProcurementPlanningHeader.TestField(ProcurementPlanningHeader.Budget);
          ProcurementPlanningHeader.TestField(ProcurementPlanningHeader."Procurement Plan No.");
          "Procurement Plan No.":=ProcurementPlanningHeader."Procurement Plan No.";
          Budget:=ProcurementPlanningHeader.Budget;
        end;

        "Type (Attributes)":="Type (Attributes)"::"Procurement Planning";
    end;

    var
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FA: Record "Fixed Asset";
        ProcurementPlanningHeader: Record "Procurement Planning Header";
        ERROR101: Label 'The date must not be before today''s date';
        ERROR102: Label 'The date must not be before Invite/Advertisement date';
}

