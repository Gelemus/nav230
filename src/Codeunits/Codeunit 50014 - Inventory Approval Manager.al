codeunit 50014 "Inventory Approval Manager"
{

    trigger OnRun()
    begin
    end;

    procedure ReleaseStoreRequisitionHeader(var "Store Requisition Header": Record "Store Requisition Header")
    var
        StoreRequisitionHeader: Record "Store Requisition Header";
    begin
        StoreRequisitionHeader.Reset;
        StoreRequisitionHeader.SetRange(StoreRequisitionHeader."No.","Store Requisition Header"."No.");
        if StoreRequisitionHeader.FindFirst then begin
          StoreRequisitionHeader.Status:=StoreRequisitionHeader.Status::Approved;
          StoreRequisitionHeader.Validate(StoreRequisitionHeader.Status);
          StoreRequisitionHeader.Modify;
        end;
    end;

    procedure ReOpenStoreRequisitionHeader(var "Store Requisition Header": Record "Store Requisition Header")
    var
        StoreRequisitionHeader: Record "Store Requisition Header";
    begin
        StoreRequisitionHeader.Reset;
        StoreRequisitionHeader.SetRange(StoreRequisitionHeader."No.","Store Requisition Header"."No.");
        if StoreRequisitionHeader.FindFirst then begin
          StoreRequisitionHeader.Status:=StoreRequisitionHeader.Status::Open;
          StoreRequisitionHeader.Validate(StoreRequisitionHeader.Status);
          StoreRequisitionHeader.Modify;
        end;
    end;

    procedure ReOpenTransferHeader("Transfer Header": Record "Transfer Header")
    var
        TransferHeader: Record "Transfer Header";
    begin
        TransferHeader.Reset;
        TransferHeader.SetRange("No.","Transfer Header"."No.");
        if TransferHeader.FindFirst then begin
          TransferHeader.Status:=TransferHeader.Status::Open;
          TransferHeader.Validate(Status);
          TransferHeader.Modify;
        end;
    end;

    procedure ReleaseTransferHeader(var "Transfer Header": Record "Transfer Header")
    var
        TransferHeader: Record "Transfer Header";
    begin
        TransferHeader.Reset;
        TransferHeader.SetRange("No.","Transfer Header"."No.");
        if TransferHeader.FindFirst then begin
          TransferHeader.Status:=TransferHeader.Status::Released;
          TransferHeader.Validate(Status);
          TransferHeader.Modify;
        end;
    end;
}

