xmlport 50051 "Transport requisition Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(TransRequisitionroot)
        {
            tableelement("Transport Request";"Transport Request")
            {
                XmlName = 'TransportRequest';
                fieldelement(HeaderNo;"Transport Request"."Request No.")
                {
                }
                fieldelement(EmployeeNo;"Transport Request"."Employee No.")
                {
                }
                fieldelement(EmployeeName;"Transport Request"."Employee Name")
                {
                }
                fieldelement(RequisitionDate;"Transport Request"."Request Date")
                {
                }
                fieldelement(StartDate;"Transport Request"."Trip Planned Start Date")
                {
                }
                fieldelement(EndDate;"Transport Request"."Trip Planned End Date")
                {
                }
                fieldelement(Destination;"Transport Request".Destination)
                {
                }
                fieldelement(TRavelDetails;"Transport Request"."Travel Details")
                {
                }
                fieldelement(NOofPersons;"Transport Request"."No. of Personnel")
                {
                }
                fieldelement(StartTime;"Transport Request"."Start Time")
                {
                }
                fieldelement(EndTime;"Transport Request"."Return Time")
                {
                }
                fieldelement(Status;"Transport Request".Status)
                {
                }
                fieldelement(Createdby;"Transport Request".Allocated)
                {
                }
                fieldelement(VehicleAllocated;"Transport Request"."Vehicle Allocated")
                {
                }
                fieldelement(VehicleDescription;"Transport Request"."Vehicle Description")
                {
                }
                fieldelement(DriverNO;"Transport Request".Driver)
                {
                }
                fieldelement(DriverName;"Transport Request"."Driver Name")
                {
                }
                fieldelement(OdometerReadingBefore;"Transport Request"."Odometer Reading Before")
                {
                }
                fieldelement(OdometerReadingAfter;"Transport Request"."Odometer Reading After")
                {
                }
                fieldelement(NoOfNonStaff;"Transport Request"."No. of Non Staff Employees")
                {
                }
                fieldelement(RequestType;"Transport Request"."Type of Request")
                {
                }
                fieldelement(VehicleNo;"Transport Request"."Vehicle No")
                {
                }
                fieldelement(Wno;"Transport Request"."Vehicle Name")
                {
                }
                fieldelement(RepairOrder;"Transport Request"."Repair Order")
                {
                }
                fieldelement(VehicleType;"Transport Request"."Motor Vehicle/Motor Cycle")
                {
                }
                fieldelement(SupplierNo;"Transport Request"."Supplier No")
                {
                }
                fieldelement(SupplierName;"Transport Request"."Supplier Name")
                {
                }
                fieldelement(TotalAmount;"Transport Request"."Total Amount")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

