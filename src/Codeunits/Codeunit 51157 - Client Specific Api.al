codeunit 51157 "Client Specific Api"
{

    trigger OnRun()
    begin
        //SendStoreRequisitionApprovalRequest('S-REQ0313')

        //ESSAGE(GetItemNo('4.0'));//
        //PostReturnToStore('R-MRN00105');
    end;

    var
        Item: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        StoreRequisition: Record "Store Requisition Header";
        StoreRequisitionLine: Record "Store Requisition Line";
        InventorySetup: Record "Inventory Setup";
        InventoryUserSetup: Record "Inventory User Setup";
        Employee: Record Employee;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        InventoryApprovalManager: Codeunit "Inventory Approval Manager";
        Text_0001: Label 'The inventory is insufficient';
        StoreRequisition2: Record "Store Requisition Header";
        ApprovalEntry: Record "Approval Entry";
        Attendance: Record "Risk  Register";
        MeterSize: Decimal;
        InventoryManagement: Codeunit "Inventory Management";
        JTemplate: Code[10];
        JBatch: Code[10];
        StoreRequisitionLineII: Record "Store Requisition Line";

    [Scope('Personalization')]
    procedure GetItemNo("Serial No.": Text) ItemNo: Code[20]
    begin
        ItemNo:='';

        Evaluate(MeterSize,"Serial No.");
        Item.Reset;
        Item.SetRange("Meter Size (Inches)", MeterSize);
        if Item.FindFirst then
          ItemNo:=Item."No.";
    end;

    [Scope('Personalization')]
    procedure CreateReturnToStoreRequest("EmployeeNo.": Code[20];Description: Text[100];StoreRequestionNo: Code[20];ItemNo: Code[20];Quantity: Decimal) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
    begin
        //mewass
        ReturnValue:='';

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        InventorySetup.Reset;
        InventorySetup.Get;

        "DocNo.":=NoSeriesMgt.GetNextNo(InventorySetup."Return Store Requisition Nos.",0D,true);
        if "DocNo."<>'' then begin
          StoreRequisition.Init;
          StoreRequisition."No.":="DocNo.";
          StoreRequisition."Document Date":=Today;
          StoreRequisition."Employee No.":="EmployeeNo.";
          StoreRequisition.Validate(StoreRequisition."Employee No.");
          StoreRequisition."User ID":=Employee."User ID";
          StoreRequisition."Requester ID":=Employee."User ID";
          StoreRequisition."Required Date":=Today;
          StoreRequisition.Description:=Description;
          StoreRequisition."Return to store" := true;
          StoreRequisition."Store Requistion No" := StoreRequestionNo;
          StoreRequisition."Posting Date" := Today;

            StoreRequisition."Global Dimension 1 Code":=Employee."Global Dimension 1 Code";
            StoreRequisition."Global Dimension 2 Code":=Employee."Global Dimension 2 Code";
            StoreRequisition."Shortcut Dimension 3 Code":=Employee."Shortcut Dimension 3 Code";

         if StoreRequisition.Insert then begin
            //StoreRequisitionLineCreated:='';
            Item.Get(ItemNo);
            Item.CalcFields(Inventory);


            StoreRequisition.Reset;
            StoreRequisition.Get(StoreRequisition."No.");

        StoreRequisitionLineII.Reset;
        StoreRequisitionLineII.SetRange("Document No.",StoreRequisition."No.");
        //ERROR('Error Occured while posting'+);
        //IF StoreRequisitionLineII.FINDFIRST THEN BEGIN
            StoreRequisitionLine.Init;
            StoreRequisitionLine."Line No.":=0;
            StoreRequisitionLine."Document No.":=StoreRequisition."No.";
            StoreRequisitionLine.Type:=StoreRequisitionLine.Type::Item;

            StoreRequisitionLineII.Reset;
        StoreRequisitionLineII.SetRange("Document No.",StoreRequestionNo);
        //ERROR('Error Occured while posting'+);
        if StoreRequisitionLineII.FindFirst then
            StoreRequisitionLine."Item No.":=StoreRequisitionLineII."Item No.";

        //StoreRequisitionLine."Item No.":='888/1/56-3';
            StoreRequisitionLine.Validate(StoreRequisitionLine."Item No.");
            StoreRequisitionLine.Validate(Quantity,Quantity);
            StoreRequisitionLine."Line Amount":=StoreRequisitionLine.Quantity*StoreRequisitionLine."Unit Cost";
            StoreRequisitionLine."Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
            StoreRequisitionLine."Gen. Bus. Posting Group" := 'LOCAL';
            StoreRequisitionLine."Location Code" := StoreRequisitionLineII."Location Code";
            if StoreRequisitionLine.Insert then begin
              ReturnValue:='200: Store Requisition Line Successfully Created';
              if PostReturnToStore(StoreRequisition."No.") then begin
                ReturnValue:='200: Store Return created and posted successfully';
                StoreRequisition.Status:=StoreRequisition.Status::Posted;
                StoreRequisition."Posting Date":=Today;
                StoreRequisition."Posted By":=Employee."User ID";
                StoreRequisition.Validate(StoreRequisition.Status);
                StoreRequisition.Modify;
              end else
                ReturnValue:='400: Error Occured while posting';
            end else
            ReturnValue:='200: '+GetLastErrorCode+'-'+GetLastErrorText;
            //END;
          end
          else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
        end;
    end;

    procedure PostReturnToStore("ReturnToStoreRequestNo.": Code[20]) StoreRequisitionOpened: Boolean
    begin
        //mewass
        StoreRequisition.Reset;
        StoreRequisitionOpened :=false;
        if StoreRequisition.Get("ReturnToStoreRequestNo.") then begin
        if InventoryUserSetup.Get(StoreRequisition."User ID") then begin
          InventoryUserSetup.TestField(InventoryUserSetup."Item Journal Template");
          InventoryUserSetup.TestField(InventoryUserSetup."Item Journal Batch");
          JTemplate:=InventoryUserSetup."Item Journal Template";JBatch:=InventoryUserSetup."Item Journal Batch";
          InventoryManagement.PostStoreRequisitionReturnPortal(StoreRequisition,JTemplate,JBatch);
          StoreRequisitionOpened:= true;
        end else begin
          Error('User not allowed to post');
        end;

        end else
        Error('400: Record was not found');
    end;

    [Scope('Personalization')]
    procedure GetStoreRequisitionsToInvoice(var StoreRequisitionExport: XMLport "Store Requisition Export")
    begin
        StoreRequisition2.Reset;
        StoreRequisition2.SetRange("Customer Invoice Status",StoreRequisition2."Customer Invoice Status"::"Awaiting Invoicing");
        StoreRequisition2.SetRange("Create Customer Invoice",true);
        StoreRequisition2.CalcFields("Cost Amount");
        StoreRequisition2.CalcFields("Total Sale Amount");
        if StoreRequisition2.FindFirst then;
         StoreRequisitionExport.SetTableView(StoreRequisition2);
    end;

    [Scope('Personalization')]
    procedure UpdateStoreRequestInvoiceStatus(StoreRequestNo: Code[20];Status: Option "Awaiting Invoicing","Invoicing In Progress","Invoicing Completed","Invoicing Failed";Response: Text) StoreRequisitionOpened: Boolean
    begin
        //mathira
        StoreRequisition.Reset;
        if StoreRequisition.Get(StoreRequestNo) then begin
          StoreRequisition."Integration Response" := Response;
          StoreRequisition."Customer Invoice Status" := Status;
          StoreRequisition.Modify;
        end else
        Error('400: Record was not found');
    end;

    [Scope('Personalization')]
    procedure GetReturnToStoreToAdjust(var StoreRequisitionExport: XMLport "Store Requisition Export")
    begin
        StoreRequisition2.Reset;
        StoreRequisition2.SetRange("Adjustment Status",StoreRequisition2."Adjustment Status"::"Awaiting Adjustment");
        StoreRequisition2.SetRange("Return to store",true);
        StoreRequisition2.SetRange("Make Adjustment to Customer",true);
        StoreRequisition2.CalcFields("Cost Amount");
        StoreRequisition2.CalcFields("Total Sale Amount");
        if StoreRequisition2.FindFirst then;
         StoreRequisitionExport.SetTableView(StoreRequisition2);
    end;

    [Scope('Personalization')]
    procedure UpdateReturnToStoreAdjustmentStatus(StoreRequestNo: Code[20];Status: Option "Awaiting Adjustment","Adjustment In Progress","Adjustment Completed","Adjustment Failed";Response: Text) StoreRequisitionOpened: Boolean
    begin
        //mathira
        StoreRequisition.Reset;
        if StoreRequisition.Get(StoreRequestNo) then begin
          StoreRequisition."Integration Response" := Response;
          StoreRequisition."Adjustment Status" := Status;
          StoreRequisition.Modify;
        end else
        Error('400: Record was not found');
    end;
}

