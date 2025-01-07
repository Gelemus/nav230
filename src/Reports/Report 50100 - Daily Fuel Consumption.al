report 50100 "DailyFuelConsumption"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Daily Fuel Consumption.rdl';

    dataset
    {
        dataitem("Vehicle Filling"; "Vehicle Filling")
        {
            RequestFilterFields =

             "Filling Date", "Registration No", "Global Dimension 2 Code", "Transport Type";
            column(FillingNo_VehicleFilling; "Vehicle Filling"."Filling No")
            {
            }
            column(No_VehicleFilling; "Vehicle Filling"."No.")
            {
            }
            column(FillingDate_VehicleFilling; "Vehicle Filling"."Filling Date")
            {
            }
            column(OilDrawnLitres_VehicleFilling; "Vehicle Filling"."Oil Drawn (Litres)")
            {
            }
            column(FuelDrawnLitres_VehicleFilling; "Vehicle Filling"."Fuel Drawn (Litres)")
            {
            }
            column(VoucherNo_VehicleFilling; "Vehicle Filling"."Voucher No.")
            {
            }
            column(SpeedReadingonRef_VehicleFilling; "Vehicle Filling"."Current Speed")
            {
            }
            column(KmsCovered_VehicleFilling; "Vehicle Filling"."Kms Covered")
            {
            }
            column(NoSeries_VehicleFilling; "Vehicle Filling"."No. Series")
            {
            }
            column(DriverNo_VehicleFilling; "Vehicle Filling"."Employee No")
            {
            }
            column(DriverName_VehicleFilling; "Vehicle Filling"."Employee Name")
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
            column(OthersAmount_VehicleFilling; "Vehicle Filling"."Others Amount")
            {
            }
            column(SubmittedBy_VehicleFilling; "Vehicle Filling"."Submitted By")
            {
            }
            column(OtherServices_VehicleFilling; "Vehicle Filling"."Other Services")
            {
            }
            column(FuelType_VehicleFilling; "Vehicle Filling"."Fuel Type")
            {
            }
            column(TotalAmount_VehicleFilling; "Vehicle Filling"."Total Amount")
            {
            }
            column(DateSubmitted_VehicleFilling; "Vehicle Filling"."Date Submitted")
            {
            }
            column(TimeSubmitted_VehicleFilling; "Vehicle Filling"."Time Submitted")
            {
            }
            column(Submitted_VehicleFilling; "Vehicle Filling".Submitted)
            {
            }
            column(GlobalDimension1Code_VehicleFilling; "Vehicle Filling"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_VehicleFilling; "Vehicle Filling"."Shortcut Dimension 3 Code")
            {
            }
            column(Type_VehicleFilling; "Vehicle Filling"."Transport Type")
            {
            }
            column(Remarks_VehicleFilling; "Vehicle Filling".Remarks)
            {
            }
            column(Pic; companyinfo.Picture)
            {
            }
            column(DescriptionCard; Description)
            {
            }
            column(CardNo; CardNo)
            {
            }
            column(BF; BF)
            {
            }
            column(CF; BF + AmountLoaded)
            {
            }
            column(AmountLoaded; AmountLoaded)
            {
            }
            column(DEMO; DEMO)
            {
            }
            column(End_Date; EndDate)
            {
            }
            column(Start_Date; StartDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if DEMO = DEMO::"KCG 858S" then begin
                    CardNo := 157364;
                end else if DEMO = DEMO::"NAWASCO GEN" then begin
                    CardNo := 157362;
                end;
                SetFilter("Filling Date", '%1..%2', StartDate, EndDate);
                StartDate := "Vehicle Filling".GetRangeMin("Filling Date");
                EndDate := "Vehicle Filling".GetRangeMax("Filling Date");
                if "Vehicle Filling"."Filling Date" < StartDate then
                    CurrReport.Skip;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {
                }
                field("End Date"; EndDate)
                {
                }
            }
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
        companyinfo.Get;
        companyinfo.CalcFields(Picture);
    end;

    var
        companyinfo: Record "Company Information";
        CardNo: Option " ","157364","157362";
        BF: Decimal;
        CF: Decimal;
        AmountLoaded: Decimal;
        DEMO: Option " ","NAWASCO GEN","KCG 858S";
        StartDate: Date;
        EndDate: Date;
}

