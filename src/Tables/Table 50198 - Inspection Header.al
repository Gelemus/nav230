table 50198 "Inspection Header"
{

    fields
    {
        field(1; "Inspection No"; Code[20])
        {
            Editable = true;
        }
        field(2; "Order No"; Code[20])
        {
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = CONST(Order),
                                                           Status = CONST(Released));

            trigger OnValidate()
            begin
                PurchLines.Reset;
                PurchLines.SetRange(PurchLines."Document Type", PurchLines."Document Type"::Order);
                PurchLines.SetRange(PurchLines."Document No.", "Order No");
                if PurchLines.Find('-') then begin
                    repeat
                        InspectLines.Init;
                        InspectLines."Inspection No" := "Inspection No";
                        InspectLines."Line No" := PurchLines."Line No." + 1000;
                        InspectLines."Item No" := PurchLines."No.";
                        InspectLines.Description := PurchLines.Description;
                        InspectLines."Unit of Measure" := PurchLines."Unit of Measure Code";
                        InspectLines."Quantity Ordered" := PurchLines.Quantity;
                        InspectLines."Quantity Received" := PurchLines."Qty. Received (Base)";
                        if not InspectLines.Get(InspectLines."Inspection No", InspectLines."Line No") then
                            InspectLines.Insert;
                    until PurchLines.Next = 0;
                end;

                if PO.Get(PO."Document Type"::Order, "Order No") then begin
                    PO.CalcFields(PO."Amount Including VAT");
                    "Supplier Name" := PO."Buy-from Vendor Name";
                    "Value of contract" := PO."Amount Including VAT";
                    "Date of Contract" := PO."Document Date";
                    "Contract Delivery Due Date" := PO."Due Date";
                    "Contract Title" := PO."Posting Description";
                    "Patriculars of the Invoice" := PO."Vendor Invoice No.";
                    "Delivery No" := PO."Delivery Note No.";
                    "Requisition No" := PO."Purchase Requisition";
                end;
                PurchaseRequisitions.Reset;
                PurchaseRequisitions.SetRange(PurchaseRequisitions."No.", PO."Purchase Requisition");
                if PurchaseRequisitions.FindSet then begin
                    "Procuring Department" := PurchaseRequisitions."Global Dimension 1 Code";
                    "Procuring Department Name" := PurchaseRequisitions."Global Dimension 2 Code";
                    "Requisitioned By" := PurchaseRequisitions."Employee No.";
                    "Requisitioned By Name" := PurchaseRequisitions."Employee Name";
                    "Ref No" := PurchaseRequisitions."Reference Document No.";
                end;
            end;
        }
        field(3; "Commitee Appointment No"; Code[20])
        {
            TableRelation = "Tender Commitee Appointment";

            trigger OnValidate()
            begin

                Comm.Reset;
                Comm.SetRange(Comm."Appointment No", "Commitee Appointment No");
                Comm.SetRange(Comm.Chair, true);
                if Comm.Find('-') then begin
                    repeat
                        "Chair Employee ID" := Comm."Employee No";
                    until Comm.Next = 0;
                end
                else
                    "Chair Employee ID" := '';


                UserRec.Reset;
                UserRec.SetRange(UserRec."Employee No", "Chair Employee ID");
                if UserRec.Find('-') then
                    "Chair E-mail" := UserRec."E-Mail"
                else
                    "Chair E-mail" := ''
            end;
        }
        field(4; "Inspection Date"; Date)
        {
        }
        field(5; "Supplier Name"; Text[80])
        {
        }
        field(6; "No. Series"; Code[20])
        {
        }
        field(7; Status; Option)
        {
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Rejected,Payment Processing';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected,"Payment Processing";
        }
        field(8; Amount; Decimal)
        {
            CalcFormula = Sum("Purchase Line".Amount WHERE("Document Type" = CONST(Order),
                                                            "Document No." = FIELD("Order No")));
            Editable = true;
            FieldClass = FlowField;
        }
        field(9; "Amount Invoiced"; Decimal)
        {
            CalcFormula = Sum("Purch. Inv. Line".Amount WHERE("Document No." = FIELD("Order No")));
            FieldClass = FlowField;
        }
        field(10; "Temp Amount"; Decimal)
        {
        }
        field(11; "Chair Employee ID"; Text[20])
        {
        }
        field(12; "Chair E-mail"; Text[40])
        {
        }
        field(13; "Rejection Reason"; Text[250])
        {
        }
        field(14; Accepted; Boolean)
        {
        }
        field(15; Rejected; Boolean)
        {
        }
        field(16; "Delivery No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Value of contract"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Procuring Department"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Requisitioned By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Requisitioned By Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Ref No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Ref No From Appointment Letter"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Date of Appointment Letter"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Date of Contract"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Contract Delivery Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Actual Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Contract Title"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Patriculars of the Invoice"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Requisition No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Procuring Department Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Prepared by"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "End User Approval"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Committee,Ict,Accounts,HRM,OM,secretary,CM,Transport,HRM ICT,HRM Transport,HRM Secretary';
            OptionMembers = " ",Committee,Ict,Accounts,HRM,OM,secretary,CM,Transport,"HRM ICT","HRM Transport","HRM Secretary";
        }
        field(33; "Approval Status"; Option)
        {
            CalcFormula = Lookup("Approval Entry".Status WHERE("Document No." = FIELD("Inspection No")));
            FieldClass = FlowField;
            OptionCaption = 'Created,Open,Canceled,Rejected,Approved';
            OptionMembers = Created,Open,Canceled,Rejected,Approved;
        }
        field(34; "Tender No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Tender Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(36; Conclusion; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Inspection No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        if Status <> Status::Open then
            Error('You are not allowed to Delete')
    end;

    trigger OnInsert()
    begin
        PurchSetup.Get;
        PurchSetup.TestField(PurchSetup."Inspection Nos");
        NoSeriesMgt.InitSeries(PurchSetup."Inspection Nos", xRec."No. Series", 0D, "Inspection No", "No. Series");
        "Prepared by" := UserId;
    end;

    trigger OnModify()
    begin
        /*
        IF Status <> Status :: Open THEN
          ERROR('You are not allowed to Modify')
          */

    end;

    trigger OnRename()
    begin
        /*
        IF Status <> Status :: Open THEN
          ERROR('You are not allowed to Rename')
          */

    end;

    var
        PurchLines: Record "Purchase Line";
        InspectLines: Record "Inspection Line";
        PO: Record "Purchase Header";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Comm: Record "Commitee Members";
        UserRec: Record "User Setup";
        PurchaseRequisitions: Record "Purchase Requisitions";
}

