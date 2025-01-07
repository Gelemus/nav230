codeunit 50058 "Property Approval Manager"
{

    trigger OnRun()
    begin
    end;

    procedure ReleasePropertyHeader(var PropertyHeader: Record "Payment Terms")
    var
        PropertyHeaders: Record "Payment Terms";
    begin
        /*PropertyHeaders.RESET;
        PropertyHeaders.SETRANGE(PropertyHeaders."No.",PropertyHeader."No.");
        IF PropertyHeaders.FINDFIRST THEN BEGIN
          PropertyHeaders.Status:=PropertyHeaders.Status::"2";
          PropertyHeaders.VALIDATE(PropertyHeaders.Status);
          PropertyHeaders.MODIFY;
        END;*/

    end;

    procedure ReOpenPropertyHeader(var PropertyHeader: Record "Payment Terms")
    var
        PropertyHeaders: Record "Payment Terms";
    begin
        /*PropertyHeaders.RESET;
        PropertyHeaders.SETRANGE(PropertyHeaders."No.",PropertyHeader."No.");
        IF PropertyHeaders.FINDFIRST THEN BEGIN
          PropertyHeaders.Status:=PropertyHeaders.Status::"0";
          PropertyHeaders.VALIDATE(PropertyHeaders.Status);
          PropertyHeaders.MODIFY;
        END;*/

    end;

    procedure ReleaseTenantApplication(var TenantApplication: Record "Payment Terms")
    var
        TenantApplications: Record "Payment Terms";
    begin
        /*TenantApplications.RESET;
        TenantApplications.SETRANGE(TenantApplications."Application No.",TenantApplication."Application No.");
        IF TenantApplications.FINDFIRST THEN BEGIN
          TenantApplications.Status:=TenantApplications.Status::"2";
          TenantApplications.VALIDATE(TenantApplications.Status);
          TenantApplications.MODIFY;
        END;*/

    end;

    procedure ReOpenTenantApplication(var TenantApplication: Record "Payment Terms")
    var
        TenantApplications: Record "Payment Terms";
    begin
        /*TenantApplications.RESET;
        TenantApplications.SETRANGE(TenantApplications."Application No.",TenantApplication."Application No.");
        IF TenantApplications.FINDFIRST THEN BEGIN
          TenantApplications.Status:=TenantApplications.Status::"0";
          TenantApplications.VALIDATE(TenantApplications.Status);
          TenantApplications.MODIFY;
        END;*/

    end;

    procedure ReleaseMaintenanceHeader(var MaintenanceHeader: Record "Payment Terms")
    var
        MaintenanceHeaders: Record "Payment Terms";
    begin
        /*MaintenanceHeaders.RESET;
        MaintenanceHeaders.SETRANGE(MaintenanceHeaders.No,MaintenanceHeader.No);
        IF MaintenanceHeaders.FINDFIRST THEN BEGIN
          MaintenanceHeaders.Status:=MaintenanceHeaders.Status::"2";
          MaintenanceHeaders.VALIDATE(MaintenanceHeaders.Status);
          MaintenanceHeaders.MODIFY;
        END;*/

    end;

    procedure ReOpenMaintenanceHeader(var MaintenanceHeader: Record "Payment Terms")
    var
        MaintenanceHeaders: Record "Payment Terms";
    begin
        /*MaintenanceHeaders.RESET;
        MaintenanceHeaders.SETRANGE(MaintenanceHeaders.No,MaintenanceHeader.No);
        IF MaintenanceHeaders.FINDFIRST THEN BEGIN
          MaintenanceHeaders.Status:=MaintenanceHeaders.Status::"0";
          MaintenanceHeaders.VALIDATE(MaintenanceHeaders.Status);
          MaintenanceHeaders.MODIFY;
        END;*/

    end;

    procedure ReleasePropertyActivityHeader(PropertyActivityHeader: Record "Payment Terms")
    var
        PropertyActivityHeaders: Record "Payment Terms";
    begin
        /*PropertyActivityHeaders.RESET;
        PropertyActivityHeaders.SETRANGE(PropertyActivityHeaders."Application No.",PropertyActivityHeader."Application No.");
        IF PropertyActivityHeaders.FINDFIRST THEN BEGIN
          PropertyActivityHeaders.Status:=PropertyActivityHeaders.Status::"2";
          PropertyActivityHeaders.VALIDATE(PropertyActivityHeaders.Status);
          PropertyActivityHeaders.MODIFY;
        END;*/

    end;

    procedure ReOpenPropertyActivityHeader(PropertyActivityHeader: Record "Payment Terms")
    var
        PropertyActivityHeaders: Record "Payment Terms";
    begin
        /*PropertyActivityHeaders.RESET;
        PropertyActivityHeaders.SETRANGE(PropertyActivityHeaders."Application No.",PropertyActivityHeader."Application No.");
        IF PropertyActivityHeaders.FINDFIRST THEN BEGIN
          PropertyActivityHeaders.Status:=PropertyActivityHeaders.Status::"0";
          PropertyActivityHeaders.VALIDATE(PropertyActivityHeaders.Status);
          PropertyActivityHeaders.MODIFY;
        END;*/

    end;

    procedure ReleaseElectricityMeterReading(ElectricityMeterReading: Record "Payment Terms")
    var
        ElectricityMeterReadings: Record "Payment Terms";
    begin
        /*ElectricityMeterReadings.RESET;
        ElectricityMeterReadings.SETRANGE(ElectricityMeterReadings."No.",ElectricityMeterReading."No.");
        IF ElectricityMeterReadings.FINDFIRST THEN BEGIN
          ElectricityMeterReadings.Status:=ElectricityMeterReadings.Status::"2";
          ElectricityMeterReadings.VALIDATE(ElectricityMeterReadings.Status);
          ElectricityMeterReadings.MODIFY;
        END;*/

    end;

    procedure ReOpenElectricityMeterReading(ElectricityMeterReading: Record "Payment Terms")
    var
        ElectricityMeterReadings: Record "Payment Terms";
    begin
        /*ElectricityMeterReadings.RESET;
        ElectricityMeterReadings.SETRANGE(ElectricityMeterReadings."No.",ElectricityMeterReading."No.");
        IF ElectricityMeterReadings.FINDFIRST THEN BEGIN
          ElectricityMeterReadings.Status:=ElectricityMeterReadings.Status::"0";
          ElectricityMeterReadings.VALIDATE(ElectricityMeterReadings.Status);
          ElectricityMeterReadings.MODIFY;
        END;*/

    end;

    procedure ReleaseCostAllocation(PropertyCostAllocation: Record "Payment Terms")
    var
        PropertyCostAllocations: Record "Payment Terms";
    begin
        /*PropertyCostAllocations.RESET;
        PropertyCostAllocations.SETRANGE(PropertyCostAllocations.No,PropertyCostAllocation.No);
        IF PropertyCostAllocations.FINDFIRST THEN BEGIN
          PropertyCostAllocations.Status:=PropertyCostAllocations.Status::"2";
          PropertyCostAllocations.VALIDATE(PropertyCostAllocations.Status);
          PropertyCostAllocations.MODIFY;
        END;*/

    end;

    procedure ReOpenCostAllocation(PropertyCostAllocation: Record "Payment Terms")
    var
        PropertyCostAllocations: Record "Payment Terms";
    begin
        /*PropertyCostAllocations.RESET;
        PropertyCostAllocations.SETRANGE(PropertyCostAllocations.No,PropertyCostAllocation.No);
        IF PropertyCostAllocations.FINDFIRST THEN BEGIN
          PropertyCostAllocations.Status:=PropertyCostAllocations.Status::"0";
          PropertyCostAllocations.VALIDATE(PropertyCostAllocations.Status);
          PropertyCostAllocations.MODIFY;
        END;*/

    end;

    procedure ReleasePropertyLease(PropertyLeaseHeader: Record "Payment Terms")
    var
        PropertyLeaseHeaders: Record "Payment Terms";
    begin
        /*PropertyLeaseHeaders.RESET;
        PropertyLeaseHeaders.SETRANGE(PropertyLeaseHeaders."No.",PropertyLeaseHeader."No.");
        IF PropertyLeaseHeaders.FINDFIRST THEN BEGIN
          PropertyLeaseHeaders.Status:=PropertyLeaseHeaders.Status::"2";
          PropertyLeaseHeaders.VALIDATE(PropertyLeaseHeaders.Status);
          PropertyLeaseHeaders.MODIFY;
        END;*/

    end;

    procedure ReOpenPropertyLease(PropertyLeaseHeader: Record "Payment Terms")
    var
        PropertyLeaseHeaders: Record "Payment Terms";
    begin
        /*PropertyLeaseHeaders.RESET;
        PropertyLeaseHeaders.SETRANGE(PropertyLeaseHeaders."No.",PropertyLeaseHeader."No.");
        IF PropertyLeaseHeaders.FINDFIRST THEN BEGIN
          PropertyLeaseHeaders.Status:=PropertyLeaseHeaders.Status::"0";
          PropertyLeaseHeaders.VALIDATE(PropertyLeaseHeaders.Status);
          PropertyLeaseHeaders.MODIFY;
        END;*/

    end;
}

