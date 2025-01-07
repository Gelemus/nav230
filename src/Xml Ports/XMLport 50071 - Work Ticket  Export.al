xmlport 50071 "Work Ticket  Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(WorkTicketRoot)
        {
            tableelement("Work Ticket";"Work Ticket")
            {
                XmlName = 'WorkTicket';
                fieldelement(HeaderNo;"Work Ticket"."Ticket No")
                {
                }
                fieldelement(DriverNo;"Work Ticket"."Driver No")
                {
                }
                fieldelement(DriverName;"Work Ticket"."Driver Name")
                {
                }
                fieldelement(TicketDate;"Work Ticket".Date)
                {
                }
                fieldelement(OliDrawn;"Work Ticket"."Oil Drawn (Litres)")
                {
                }
                fieldelement(FuelDrawn;"Work Ticket"."Fuel Drawn (Litres)")
                {
                }
                fieldelement(JourneyDetails;"Work Ticket"."Journey Details")
                {
                }
                fieldelement(DistanceCovered;"Work Ticket"."Kms Covered")
                {
                }
                fieldelement(StartTime;"Work Ticket"."Start Time")
                {
                }
                fieldelement(EndTime;"Work Ticket"."Return TIme")
                {
                }
                fieldelement(Status;"Work Ticket".Status)
                {
                }
                fieldelement(OdometerReadingBefore;"Work Ticket"."Start Speedometer Reading")
                {
                }
                fieldelement(OdometerReadingAfter;"Work Ticket"."Last Mileage Reading")
                {
                }
                fieldelement(WorkTicketVehicleNo;"Work Ticket"."Vehicle No")
                {
                }
                fieldelement(KmsCovered;"Work Ticket"."Kms Covered")
                {
                }
                fieldelement(DefectReport;"Work Ticket".DefectReport)
                {
                }
                fieldelement(Department;"Work Ticket".Department)
                {
                }
                fieldelement(ExternalTicketNo;"Work Ticket"."External Ticket No")
                {
                }
                fieldelement(PreviousTicketNo;"Work Ticket"."Previous Ticket No")
                {
                }
                fieldelement(VehicleType;"Work Ticket"."Vehicle Type")
                {
                }
                fieldelement(ReceiptNo;"Work Ticket"."Receipt No")
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

