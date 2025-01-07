report 50139 "Allocation Report II"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Allocation Report II.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
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
                //DataItemLink = Field11=FIELD(Field10);
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

                trigger OnPreDataItem()
                begin
                    //IF GETFILTER(Table50284."Date Filter") <> '' THEN
                    //Table50284.SETFILTER(Table50284."From Date", GETFILTER(Table50284."Date Filter"));
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
}

