report 50612 "Handover Notes"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Handover Notes.rdl';

    dataset
    {
        dataitem("Transport Request"; "Transport Request")
        {
            column(Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(Address2; CompanyInfo."Address 2")
            {
            }
            column(PostalCode; CompanyInfo."Post Code")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Phone; CompanyInfo."Phone No.")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(HomePage; CompanyInfo."Home Page")
            {
            }
            column(Make_TransportRequest; "Transport Request".Make)
            {
            }
            column(VehicleDescription_TransportRequest; "Transport Request"."Vehicle Description")
            {
            }
            column(EngineOil_TransportRequest; "Transport Request"."Engine Oil")
            {
            }
            column(WNO_TransportRequest; "Transport Request"."Vehicle Name")
            {
            }
            column(Mileage_TransportRequest; "Transport Request".Mileage)
            {
            }
            column(LastFuelingLts_TransportRequest; "Transport Request"."Last Fueling (Lts)")
            {
            }
            column(IssueVoucher_TransportRequest; "Transport Request"."Issue Voucher")
            {
            }
            column(LastServiceKMS_TransportRequest; "Transport Request"."Last Service KMS:")
            {
            }
            column(NextServiceat_TransportRequest; "Transport Request"."Next Service at:")
            {
            }
            column(GlobalDimension1Code_TransportRequest; "Transport Request"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_TransportRequest; "Transport Request"."Global Dimension 2 Code")
            {
            }
            column(Battery_TransportRequest; "Transport Request".Battery)
            {
            }
            column(BatteryComment_TransportRequest; "Transport Request"."Battery Comment")
            {
            }
            column(Jack_TransportRequest; "Transport Request".Jack)
            {
            }
            column(JackComments_TransportRequest; "Transport Request"."Jack Comments")
            {
            }
            column(WheelSpanner_TransportRequest; "Transport Request"."Wheel Spanner")
            {
            }
            column(WheelSpannerComments_TransportRequest; "Transport Request"."Wheel Spanner Comments")
            {
            }
            column(FireExtinguisher_TransportRequest; "Transport Request"."Fire Extinguisher")
            {
            }
            column(FireExtinguisherComments_TransportRequest; "Transport Request"."Fire Extinguisher Comments")
            {
            }
            column(FirstAidKit_TransportRequest; "Transport Request"."First Aid Kit")
            {
            }
            column(FirstAidKitCooments_TransportRequest; "Transport Request"."First Aid Kit Cooments")
            {
            }
            column(RadioCassette_TransportRequest; "Transport Request"."Radio/Cassette")
            {
            }
            column(RadioCassetteComments_TransportRequest; "Transport Request"."Radio/Cassette Comments")
            {
            }
            column(FuelGauge_TransportRequest; "Transport Request"."Fuel Gauge")
            {
            }
            column(FuelGaugeComments_TransportRequest; "Transport Request"."Fuel Gauge Comments")
            {
            }
            column(SpeedoMeterCable_TransportRequest; "Transport Request"."Speedo Meter Cable")
            {
            }
            column(SpeedoMeterCableComments_TransportRequest; "Transport Request"."Speedo Meter Cable Comments")
            {
            }
            column(Headlights_TransportRequest; "Transport Request".Headlights)
            {
            }
            column(HeadlightsComments_TransportRequest; "Transport Request"."Headlights Comments")
            {
            }
            column(Indicator_TransportRequest; "Transport Request".Indicator)
            {
            }
            column(IndicatorComments_TransportRequest; "Transport Request"."Indicator Comments")
            {
            }
            column(HazardLights_TransportRequest; "Transport Request"."Hazard Lights")
            {
            }
            column(HazardLightsComments_TransportRequest; "Transport Request"."Hazard Lights Comments")
            {
            }
            column(HandBreak_TransportRequest; "Transport Request"."Hand Break")
            {
            }
            column(HandBreakComments_TransportRequest; "Transport Request"."Hand Break Comments")
            {
            }
            column(TyresType_TransportRequest; "Transport Request"."Tyres Type")
            {
            }
            column(FrontLight_TransportRequest; "Transport Request"."Front Right")
            {
            }
            column(FrontLeft_TransportRequest; "Transport Request"."Front Left")
            {
            }
            column(RearLight_TransportRequest; "Transport Request"."Rear Right")
            {
            }
            column(RearLeft_TransportRequest; "Transport Request"."Rear Left")
            {
            }
            column(SpareWheelNos_TransportRequest; "Transport Request"."Spare Wheel Nos")
            {
            }
            column(MechanicalProblem_TransportRequest; "Transport Request"."Mechanical Problem")
            {
            }
            column(Dents_TransportRequest; "Transport Request".Dents)
            {
            }
            column(DrivingMirrors_TransportRequest; "Transport Request"."Driving Mirrors")
            {
            }
            column(Scratches_TransportRequest; "Transport Request".Scratches)
            {
            }
            column(HandingOverByNo_TransportRequest; "Transport Request"."Handing Over By No")
            {
            }
            column(HandingOverBy_TransportRequest; "Transport Request"."Handing Over By")
            {
            }
            column(HandingOverDesignation_TransportRequest; "Transport Request"."Handing Over Designation")
            {
            }
            column(TakingOverByNo_TransportRequest; "Transport Request"."Taking Over By No")
            {
            }
            column(TakingOverBy_TransportRequest; "Transport Request"."Taking Over By")
            {
            }
            column(TakingOverDesignation_TransportRequest; "Transport Request"."Taking Over Designation")
            {
            }
            column(WitnessedBy_TransportRequest; "Transport Request"."Witnessed By No")
            {
            }
            column(WitnessedByName_TransportRequest; "Transport Request"."Witnessed By Name")
            {
            }
            column(DateWitnessed_TransportRequest; "Transport Request"."Date Witnessed")
            {
            }
            column(TimeWitnessed_TransportRequest; "Transport Request".TimeWitnessed)
            {
            }
            column(HandingoverDate_TransportRequest; "Transport Request"."Handing over Date")
            {
            }
            column(HandingoverTime_TransportRequest; "Transport Request"."Handing over Time")
            {
            }
            column(TakingOverDate_TransportRequest; "Transport Request"."Taking Over Date")
            {
            }
            column(TakingOverTime_TransportRequest; "Transport Request"."Taking Over Time")
            {
            }
            column(RequestNo_TransportRequest; "Transport Request"."Request No.")
            {
            }
            column(RequestDate_TransportRequest; "Transport Request"."Request Date")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
            end;
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

    var
        CompanyInfo: Record "Company Information";
}

