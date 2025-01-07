xmlport 50077 "Fuel Requisition  Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(FuelRequisitionRoot)
        {
            tableelement("Vehicle Filling";"Vehicle Filling")
            {
                XmlName = 'FuelRequisition';
                fieldelement(FillingNo;"Vehicle Filling"."Filling No")
                {
                }
                fieldelement(VehicleNo;"Vehicle Filling"."No.")
                {
                }
                fieldelement(FillingDate;"Vehicle Filling"."Filling Date")
                {
                }
                fieldelement(OilDrawn;"Vehicle Filling"."Oil Drawn (Litres)")
                {
                }
                fieldelement(FuelDrawn;"Vehicle Filling"."Fuel Drawn (Litres)")
                {
                }
                fieldelement(VoucherNo;"Vehicle Filling"."Voucher No.")
                {
                }
                fieldelement(SpeedReading;"Vehicle Filling"."Current Speed")
                {
                }
                fieldelement(KmsCovered;"Vehicle Filling"."Kms Covered")
                {
                }
                fieldelement(EmployeeNo;"Vehicle Filling"."Employee No")
                {
                }
                fieldelement(EmployeeName;"Vehicle Filling"."Employee Name")
                {
                }
                fieldelement(Description;"Vehicle Filling".Description)
                {
                }
                fieldelement(RegistrationNo;"Vehicle Filling"."Registration No")
                {
                }
                fieldelement(CostPerLitre;"Vehicle Filling"."Cost per Litre")
                {
                }
                fieldelement(Amount;"Vehicle Filling".Amount)
                {
                }
                fieldelement(Department;"Vehicle Filling"."Global Dimension 1 Code")
                {
                }
                fieldelement(Station;"Vehicle Filling"."Global Dimension 2 Code")
                {
                }
                fieldelement(Section;"Vehicle Filling"."Shortcut Dimension 3 Code")
                {
                }
                fieldelement(Type;"Vehicle Filling".Type)
                {
                }
                fieldelement(Make;"Vehicle Filling".Make)
                {
                }
                fieldelement(PreviousKms;"Vehicle Filling"."Previoust Kms")
                {
                }
                fieldelement(TransportType;"Vehicle Filling"."Transport Type")
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

