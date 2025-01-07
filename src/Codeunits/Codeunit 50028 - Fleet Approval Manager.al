codeunit 50028 "Fleet Approval Manager"
{

    trigger OnRun()
    begin
    end;

    procedure ReleaseFuelRequisition(var "Fuel Requisition Header": Record "Vehicle Filling")
    var
        FuelRequisitionHeader: Record "Vehicle Filling";
    begin
        FuelRequisitionHeader.Reset;
        FuelRequisitionHeader.SetRange(FuelRequisitionHeader."Filling No","Fuel Requisition Header"."Filling No");
        if FuelRequisitionHeader.FindFirst then begin
          FuelRequisitionHeader.Status:=FuelRequisitionHeader.Status::Released;
         // FuelRequisitionHeader.VALIDATE(FuelRequisitionHeader.Status);
          FuelRequisitionHeader.Modify;
        end;
    end;

    procedure ReOpenFuelRequisition(var "Fuel Requisition Header": Record "Vehicle Filling")
    var
        FuelRequisitionHeader: Record "Vehicle Filling";
    begin
        FuelRequisitionHeader.Reset;
        FuelRequisitionHeader.SetRange(FuelRequisitionHeader."Filling No","Fuel Requisition Header"."Filling No");
        if FuelRequisitionHeader.FindFirst then begin
          FuelRequisitionHeader.Status:=FuelRequisitionHeader.Status::Open;
          //FuelRequisitionHeader.VALIDATE(FuelRequisitionHeader.Status);
          FuelRequisitionHeader.Modify;
        end;
    end;

    procedure ReOpenTranportRequisition("Transport Header": Record "Vehicle Requisition Header")
    var
        TransportHeader: Record "Vehicle Requisition Header";
    begin
        TransportHeader.Reset;
        TransportHeader.SetRange("No.","Transport Header"."No.");
        if TransportHeader.FindFirst then begin
          TransportHeader.Status:=TransportHeader.Status::Open;
          TransportHeader.Modify;
        end;
    end;

    procedure ReleaseTransportRequisition(var "Transport Header": Record "Vehicle Requisition Header")
    var
        TransportHeader: Record "Vehicle Requisition Header";
    begin
        TransportHeader.Reset;
        TransportHeader.SetRange("No.","Transport Header"."No.");
        if TransportHeader.FindFirst then begin
          TransportHeader.TestField("Assigned Vehicle No.");
          TransportHeader.TestField("Assigned Driver No.");
          TransportHeader.Status:=TransportHeader.Status::Approved;
          TransportHeader.Modify;
        end;
    end;

    procedure ReOpenWorkTicketRequisition(var WorkTicket: Record "Work Ticket")
    var
        WorkTicketRec: Record "Work Ticket";
    begin
        WorkTicketRec.Reset;
        WorkTicketRec.SetRange(WorkTicketRec."Ticket No",WorkTicket."Ticket No");
        if WorkTicketRec.FindFirst then begin
          WorkTicketRec.Status:=WorkTicketRec.Status::Open;
          WorkTicketRec.Modify;
        end;
    end;

    procedure ReleaseWorkTicketRequisition(var WorkTicket: Record "Work Ticket")
    var
        WorkTicketRec: Record "Work Ticket";
    begin
        WorkTicketRec.Reset;
        WorkTicketRec.SetRange("Ticket No",WorkTicket."Ticket No");
        if WorkTicketRec.FindFirst then begin
          WorkTicketRec.Status:=WorkTicketRec.Status::Approved;
          WorkTicketRec.Modify;
        end;
    end;

    procedure ReOpenVehicleFIlling(var VehicleFilling: Record "Vehicle Filling")
    var
        VehicleFillingRec: Record "Vehicle Filling";
    begin


        VehicleFillingRec.Reset;
        VehicleFillingRec.SetRange(VehicleFillingRec."No.",VehicleFilling."No.");
        if VehicleFillingRec.FindFirst then begin
          VehicleFillingRec.Status:=VehicleFillingRec.Status::Open;
          VehicleFillingRec.Modify;
        end;
    end;

    procedure ReleaseVehicleFilling(var VehicleFilling: Record "Vehicle Filling")
    var
        VehicleFillingRec: Record "Vehicle Filling";
    begin
        VehicleFillingRec.Reset;
        VehicleFillingRec.SetRange("No.",VehicleFilling."No.");
        if VehicleFillingRec.FindFirst then begin
          VehicleFillingRec.Status:=VehicleFillingRec.Status::Released;
         // VehicleFillingRec.VALIDATE(VehicleFillingRec.Status);
          VehicleFillingRec.Modify;
        end;
    end;
}

