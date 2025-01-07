report 50143 "Allocation Report-Tenant"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Allocation Report-Tenant.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
            //RequestFilterFields = Field10;
            column(No_PropertyLeaseHeader; "Payment Terms".Code)
            {
            }
            column(Description_PropertyLeaseHeader; "Payment Terms".Code)
            {
            }
            column(PropertyNo_PropertyLeaseHeader; "Payment Terms".Code)
            {
            }
            column(PropertyName_PropertyLeaseHeader; "Payment Terms".Code)
            {
            }
            column(LandLordNo_PropertyLeaseHeader; "Payment Terms".Code)
            {
            }
            column(LandLordName_PropertyLeaseHeader; "Payment Terms".Code)
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
            column(AmountExclVAT_PropertyLeaseHeader; "Payment Terms".Code)
            {
            }
            column(AmountExclVATLCY_PropertyLeaseHeader; "Payment Terms".Code)
            {
            }
            column(VATAmount_PropertyLeaseHeader; "Payment Terms".Code)
            {
            }
            column(VATAmountLCY_PropertyLeaseHeader; "Payment Terms".Code)
            {
            }
            column(AmountInclVAT_PropertyLeaseHeader; "Payment Terms".Code)
            {
            }
            column(AmountInclVATLCY_PropertyLeaseHeader; "Payment Terms".Code)
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
                // DataItemLink = "Customer Shipped Not Invoiced"=FIELD(Field10);
                RequestFilterFields = "Realized G/L Gains Account";
                column(LineNo_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(DocumentNo_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(PropertyNo_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(BlockCode_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(FloorCode_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(UnitCode_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(UnitAreaSqFtUnit_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(AccountType_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(AccountNo_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(AccountName_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(Description_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(Amount_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(AllocatedAmount_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(Allocation_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(TenantNo_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(TenantName_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(LeaseNo_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(AssignedtoInvoice_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(ChargeCode_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(ChargeName_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(FloorAreaSqFtUnit_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(FromDate_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(ToDate_PropertyCostAllocationLines; "Payment Terms".Code)
                {
                }
                column(Proportion; "Payment Terms".Code)
                {
                }

                trigger OnPreDataItem()
                begin
                    //IF GETFILTER(Table50284."Date Filter") <> '' THEN
                    // Table50284.SETFILTER(Table50284."From Date", GETFILTER(Table50284."Date Filter"));
                end;
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
        Proportion: Decimal;
}

