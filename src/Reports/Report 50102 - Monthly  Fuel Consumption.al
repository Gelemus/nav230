report 50102 "MonthlyFuelConsumption"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Monthly  Fuel Consumption.rdl';

    dataset
    {
        dataitem("Vehicle Filling"; "Vehicle Filling")
        {
            DataItemTableView = WHERE(Submitted = FILTER(false), Status = CONST(Released));
            RequestFilterFields = "Filling No", "Registration No", Type;
            column(VoucherNo_VehicleFilling; "Vehicle Filling"."Voucher No.")
            {
            }
            column(InvoiceNo_VehicleFilling; "Vehicle Filling"."Invoice No")
            {
            }
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
            column(FuelType_VehicleFilling; "Vehicle Filling"."Fuel Type")
            {
            }
            column(Othersdescription_VehicleFilling; "Vehicle Filling"."Others description")
            {
            }
            column(OthersAmount_VehicleFilling; "Vehicle Filling"."Others Amount")
            {
            }
            column(CostperLitre_VehicleFilling; "Vehicle Filling"."Cost per Litre")
            {
            }
            column(OtherServices_VehicleFilling; "Vehicle Filling"."Other Services")
            {
            }
            column(Amount_VehicleFilling; "Vehicle Filling".Amount)
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
            column(Type_VehicleFilling; VehicleFilling."Transport Type")
            {
            }
            column(Remarks_VehicleFilling; "Vehicle Filling".Remarks)
            {
            }
            column(pic; CompanyInformation.Picture)
            {
            }
            column(Name; CompanyInformation.Name)
            {
            }
            column(Start_Date; StartDate)
            {
            }
            column(End_Date; EndDate)
            {
            }
            column(Card_Description; VehicleFilling."Card Description")
            {
            }
            column(Card_No; VehicleFilling."Card No")
            {
            }
            column(BF; VehicleFilling."Balance BF")
            {
            }
            column(Amount_Loaded; VehicleFilling."Amount Loaded")
            {
            }
            column(CF; VehicleFilling."Balance CF")
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
                if "Vehicle Filling"."Filling Date" < StartDate then
                    CurrReport.Skip;
                /*
                VehicleFilling.RESET;
                //VehicleFilling.SETRANGE("No.","Vehicle Filling"."No.");
                VehicleFilling.SETFILTER("Filling Date",'%1..%2',StartDate,EndDate);
                IF VehicleFilling.FINDSET THEN
                IF VehicleFilling."Oil Drawn (Litres)" > 0 THEN
                BEGIN
                  //IF VehicleFilling."Oil Drawn (Litres)" > 0 THEN BEGIN
                  REPEAT
                    TotalOil := TotalOil + VehicleFilling.Amount;
                  UNTIL VehicleFilling.NEXT=0;
                  //END;
                END;
                */
                //"Vehicle Filling".GET("Oil Drawn (Litres)");
                //"Vehicle Filling".SETRANGE("No.","Vehicle Filling"."No.");
                //TotalOil :=0;
                //IF "Vehicle Filling".FIND('-') THEN
                /*IF "Vehicle Filling"."Oil Drawn (Litres)" <> 0 THEN BEGIN
                  REPEAT
                    TotalOil += "Vehicle Filling".Amount;
                  UNTIL "Vehicle Filling".NEXT= 0;
                END;*/
                //MESSAGE('%1',TotalOil);

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
        TotalOil: Decimal;
        VehicleFilling: Record "Vehicle Filling";
}

