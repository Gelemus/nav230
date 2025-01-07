report 50101 "WeeklyFuelConsumption"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Weekly Fuel Consumption.rdl';

    dataset
    {
        dataitem("Vehicle Filling"; "Vehicle Filling")
        {
            DataItemTableView = WHERE(Submitted = FILTER(false), Status = CONST(Released));
            RequestFilterFields = "Transport Type";
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
            column(OtherServices_VehicleFilling; "Vehicle Filling"."Other Services")
            {
            }
            column(OthersAmount_VehicleFilling; "Vehicle Filling"."Others Amount")
            {
            }
            column(Amount_VehicleFilling; "Vehicle Filling".Amount)
            {
            }
            column(FuelType_VehicleFilling; "Vehicle Filling"."Fuel Type")
            {
            }
            column(SubmittedBy_VehicleFilling; "Vehicle Filling"."Submitted By")
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
            column(pic; CompanyInformation.Picture)
            {
            }
            column(Start_Date; StartDate)
            {
            }
            column(End_Date; EndDate)
            {
            }
            column(Card_Description; "Vehicle Filling"."Card Description")
            {
            }
            column(Card_No; "Vehicle Filling"."Card No")
            {
            }
            column(BF; "Vehicle Filling"."Balance BF")
            {
            }
            column(Amount_Loaded; "Vehicle Filling"."Amount Loaded")
            {
            }
            column(CF; "Vehicle Filling"."Balance CF")
            {
            }
            column(TotalAmount_VehicleFilling; "Vehicle Filling"."Total Amount")
            {
            }

            trigger OnAfterGetRecord()
            begin
                SetFilter("Filling Date", '%1..%2', StartDate, EndDate);
                StartDate := "Vehicle Filling".GetRangeMin("Filling Date");
                EndDate := "Vehicle Filling".GetRangeMax("Filling Date");
                /*
                IF "Card Description" = "Vehicle Filling"."Card Description"::"2" THEN BEGIN
                  "Vehicle Filling"."Card No" := 157364;
                END ELSE IF "Vehicle Filling"."Card Description" = "Vehicle Filling"."Card Description"::"2" THEN  BEGIN
                  "Vehicle Filling"."Card No" := 157362;
                END;*/
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
                field("START DATE"; StartDate)
                {
                }
                field("END DATE"; EndDate)
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
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
        DEMO: Option " ","NAWASCO GEN","KCG 858S";
}

