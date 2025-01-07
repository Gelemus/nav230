report 50133 "Property Units Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Property Units Report.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
            //RequestFilterFields = Field10,Field11,Field16,Field22;
            column(PropertyNo_PropertyUnits; "Payment Terms".Code)
            {
            }
            column(FloorCode_PropertyUnits; "Payment Terms".Code)
            {
            }
            column(UnitCode_PropertyUnits; "Payment Terms".Code)
            {
            }
            column(UnitName_PropertyUnits; "Payment Terms".Code)
            {
            }
            column(UnitType_PropertyUnits; "Payment Terms".Code)
            {
            }
            column(UnitTypeName_PropertyUnits; "Payment Terms".Code)
            {
            }
            column(UnitStatus_PropertyUnits; "Payment Terms".Code)
            {
            }
            column(LettableAreaSqFtUnit_PropertyUnits; "Payment Terms".Code)
            {
            }
            column(Occupied_PropertyUnits; "Payment Terms".Code)
            {
            }
            column(WaterMeterNo_PropertyUnits; "Payment Terms".Code)
            {
            }
            column(ElectricityMeterNo_PropertyUnits; "Payment Terms".Code)
            {
            }
            column(UnderMaintenance_PropertyUnits; "Payment Terms".Code)
            {
            }
            column(BlockCode_PropertyUnits; "Payment Terms".Code)
            {
            }
            column(Tenant_PropertyUnits; "Payment Terms".Code)
            {
            }
            column(TenantName_PropertyUnits; "Payment Terms".Code)
            {
            }
            column(LeaseNo_PropertyUnits; "Payment Terms".Code)
            {
            }
            column(FloorAreaSqFtUnits_PropertyUnits; "Payment Terms".Code)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(pic; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_Web; CompanyInfo."Home Page")
            {
            }
            dataitem(Currency; Currency)
            {
                //DataItemLink = "Invoice Rounding Precision"=FIELD(Field25);
                column(No_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(Description_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(FloorNo_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(UnitNo_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(TenantNo_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(TenantName_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(NoSeries_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(Blocked_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(Commenced_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(InvoiceFrequency_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(CommenceDate_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(ExpiryDate_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(Status_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(LastInvoicingDate_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(NextInvoicingDate_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(CurrencyCode_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(CurrencyFactor_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(UserID_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(DateCreated_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(TimeCreated_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(TenantApplicationNo_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(TenantApplicationName_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(Expired_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(InActive_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(LastReviewDate_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(NextReviewDate_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(LeaseReviewFrequency_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(TotalAreaSqFtUnit_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(RatePerAreaSqFtUnit_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(LeaseClass_PropertyLeaseHeader; "Payment Terms".Code)
                {
                }
                column(LeaseCategory_PropertyLeaseHeader; "Payment Terms".Code)
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

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
}

