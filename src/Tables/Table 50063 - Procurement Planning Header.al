table 50063 "Procurement Planning Header"
{

    fields
    {
        field(10;"No.";Code[20])
        {
        }
        field(11;Name;Text[100])
        {
        }
        field(12;"Financial Year";Text[100])
        {
            Editable = false;
        }
        field(25;"Document Date";Date)
        {
        }
        field(26;Budget;Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name";

            trigger OnValidate()
            begin
                "Budget Description":='';
                "Financial Year":='';
                "Procurement Plan No.":='';

                if Budgets.Get(Budget) then begin
                  "Budget Description":=Budgets.Description;
                  "Financial Year":=Budgets.Description;
                  "Procurement Plan No.":=Budgets."Procurement Plan No.";
                end;
            end;
        }
        field(27;"Budget Description";Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28;"Procurement Plan No.";Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30;"User ID";Code[50])
        {
        }
        field(31;"No. Series";Code[20])
        {
        }
        field(32;"From Date";Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "To Date":=0D;

                //IF "From Date"<TODAY THEN
                //  ERROR(Error100);
            end;
        }
        field(33;"To Date";Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("From Date");
                if "To Date" < "From Date" then
                  Error(Error101);
            end;
        }
        field(34;"G/L Budget Line A/C";Code[30])
        {
            Editable = false;
            TableRelation = "G/L Account"."No." WHERE ("Account Type"=CONST(Posting));
        }
        field(35;"Budget Amount";Decimal)
        {
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE ("Budget Name"=FIELD(Budget),
                                                               "G/L Account No."=FIELD("G/L Budget Line A/C")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(40;Status;Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(41;"Procurement Plan Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Items,Service,Fixed Asset';
            OptionMembers = Items,Service,"Fixed Asset";

            trigger OnValidate()
            begin
                TestField(Status,Status::Open);
                "G/L Budget Line A/C":='';
                "Procurement Plan No.":='';
            end;
        }
        field(42;"Procurement Plan Grouping";Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Procurement Plan Type"=FILTER(Items)) "Inventory Posting Group".Code
                            ELSE IF ("Procurement Plan Type"=FILTER(Service)) "Purchase Requisition Codes"."Requisition Code"
                            ELSE IF ("Procurement Plan Type"=FILTER("Fixed Asset")) "FA Posting Group".Code;

            trigger OnValidate()
            begin
                TestField(Status,Status::Open);

                "G/L Budget Line A/C":='';

                ProcurementPlanningLine.Reset;
                ProcurementPlanningLine.SetRange(ProcurementPlanningLine."Document No.","No.");
                if ProcurementPlanningLine.FindLast then begin
                  //ProcurementPlanningLine.DELETEALL;
                  LineNo:=ProcurementPlanningLine."Line No.";
                end;

                if "Procurement Plan Type"="Procurement Plan Type"::Items then begin
                  InventoryPostingGroup.Reset;
                  InventoryPostingGroup.SetRange(InventoryPostingGroup.Code,"Procurement Plan Grouping");
                  if InventoryPostingGroup.FindFirst then begin
                    "G/L Budget Line A/C":=InventoryPostingGroup."Budget G/L Account";
                    Validate("G/L Budget Line A/C");
                    ItemList.Reset;
                    ItemList.SetRange(ItemList."Inventory Posting Group",InventoryPostingGroup.Code);
                    if ItemList.FindSet then begin
                      repeat
                        LineNo:=LineNo+1;
                    ProcurementPlanningLine.Init;
                    ProcurementPlanningLine."Line No.":=LineNo;
                    ProcurementPlanningLine."Document No.":="No.";
                    ProcurementPlanningLine.Budget:=Budget;
                    ProcurementPlanningLine."Source of Funds":=ProcurementPlanningLine."Source of Funds"::Budget;
                    ProcurementPlanningLine."Procurement Plan No.":="Procurement Plan No.";
                    ProcurementPlanningLine.Type:=ProcurementPlanningLine.Type::Item;
                    ProcurementPlanningLine."No.":=ItemList."No.";
                    ProcurementPlanningLine.Validate(ProcurementPlanningLine."No.");
                    ProcurementPlanningLine.Description:=ItemList.Description;
                    ProcurementPlanningLine."Description 2":=Name;
                    ProcurementPlanningLine.Insert

                    until ItemList.Next=0;
                   end;
                  end;
                end;

                if "Procurement Plan Type"="Procurement Plan Type"::Service then begin
                  PurchaseRequisitionCodes.Reset;
                  PurchaseRequisitionCodes.SetRange(PurchaseRequisitionCodes."Requisition Code","Procurement Plan Grouping");
                  if PurchaseRequisitionCodes.FindFirst then begin
                    "G/L Budget Line A/C":=PurchaseRequisitionCodes."No.";
                    Validate("G/L Budget Line A/C");
                  end;
                end;

                if "Procurement Plan Type"="Procurement Plan Type"::Items then begin
                  FAPostingGroup.Reset;
                  FAPostingGroup.SetRange(FAPostingGroup.Code,"Procurement Plan Grouping");
                  if FAPostingGroup.FindFirst then begin
                    "G/L Budget Line A/C":=FAPostingGroup."Acquisition Cost Account";
                    Validate("G/L Budget Line A/C");
                  end;
                end;
            end;
        }
        field(50;"Global Dimension 1 Code";Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(51;"Global Dimension 2 Code";Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(52;"Shortcut Dimension 3 Code";Code[50])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(53;"Shortcut Dimension 4 Code";Code[50])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(54;"Shortcut Dimension 5 Code";Code[50])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(55;"Shortcut Dimension 6 Code";Code[50])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(56;"Shortcut Dimension 7 Code";Code[50])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(57;"Shortcut Dimension 8 Code";Code[50])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
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

    trigger OnInsert()
    begin
        if "No." = '' then begin
          PurchSetup.Get();
          PurchSetup.TestField(PurchSetup."Procurement Plan Nos");
          NoSeriesMgt.InitSeries(PurchSetup."Procurement Plan Nos",xRec."No. Series",0D,"No.","No. Series");
        end;

        "Document Date":=Today;
        "User ID":=UserId;
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Budgets: Record "G/L Budget Name";
        GLBudgetEntry: Record "G/L Budget Entry";
        FAPostingGroup: Record "FA Posting Group";
        InventoryPostingGroup: Record "Inventory Posting Group";
        PurchaseRequisitionCodes: Record "Purchase Requisition Codes";
        ProcurementPlanningLine: Record "Procurement Planning Line";
        ItemList: Record Item;
        Error100: Label 'The date must not be before today''s date';
        Error101: Label 'The date must not be before the From Date';
        LineNo: Integer;
}

