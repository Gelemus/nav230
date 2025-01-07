report 50210 "Work Ticket"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Work Ticket.rdl';

    dataset
    {
        dataitem("Vehicle Filling"; "Work Ticket")
        {
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(FillingNo_VehicleFilling; "Vehicle Filling"."Ticket No")
            {
            }
            column(No_VehicleFilling; "Vehicle Filling"."Vehicle No")
            {
            }
            column(FillingDate_VehicleFilling; "Vehicle Filling".Date)
            {
            }
            column(OilDrawnLitres_VehicleFilling; "Vehicle Filling"."Oil Drawn (Litres)")
            {
            }
            column(FuelFilled_VehicleFilling; "Vehicle Filling"."Fuel Drawn (Litres)")
            {
            }
            column(VoucherNo_VehicleFilling; "Vehicle Filling"."Issue Voucher No.")
            {
            }
            column(CurrentMileageReading_VehicleFilling; "Vehicle Filling"."Start Speedometer Reading")
            {
            }
            column(KmsCovered_VehicleFilling; "Vehicle Filling"."Kms Covered")
            {
            }
            column(NoSeries_VehicleFilling; "Vehicle Filling"."No. Series")
            {
            }
            column(DriverNo_VehicleFilling; "Vehicle Filling"."Driver No")
            {
            }
            column(DriverName_VehicleFilling; "Vehicle Filling"."Driver Name")
            {
            }
            column(Description_VehicleFilling; "Vehicle Filling".Description)
            {
            }
            column(RegistrationNo_VehicleFilling; "Vehicle Filling"."Registration No")
            {
            }
            column(CostperLitre_VehicleFilling; "Vehicle Filling"."Cost per Litre")
            {
            }
            column(Amount_VehicleFilling; "Vehicle Filling".Amount)
            {
            }
            column(LastMileageReading_VehicleFilling; "Vehicle Filling"."Last Mileage Reading")
            {
            }
            column(LastFuelFilled_VehicleFilling; "Vehicle Filling"."Last Fuel Filled")
            {
            }
            column(EstimatedLitresPerKm_VehicleFilling; "Vehicle Filling"."Estimated Litres Per Km")
            {
            }
            column(JourneryDate_VehicleFilling; "Vehicle Filling"."Journery Date")
            {
            }
            column(JourneyDetails_VehicleFilling; "Vehicle Filling"."Journey Details")
            {
            }
            column(LastReadingDate_VehicleFilling; "Vehicle Filling"."Last Reading Date")
            {
            }
            column(SuperLitres_VehicleFilling; "Vehicle Filling"."Super (Litres)")
            {
            }
            column(DieselLitres_VehicleFilling; "Vehicle Filling"."Diesel (Litres)")
            {
            }
            column(OtherLitres_VehicleFilling; "Vehicle Filling"."Other(Litres)")
            {
            }
            column(StartTime_VehicleFilling; "Vehicle Filling"."Start Time")
            {
            }
            column(ReturnTIme_VehicleFilling; "Vehicle Filling"."Return TIme")
            {
            }
            column(InspectionRemarks_VehicleFilling; "Vehicle Filling"."Inspection Remarks")
            {
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

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        ;
    end;

    var
        CompanyInfo: Record "Company Information";
}

