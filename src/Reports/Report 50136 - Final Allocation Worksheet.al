report 50136 "Final Allocation Worksheet"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Final Allocation Worksheet.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
            column(No_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(PropertyNo_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(PropertyDescription_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(TotalAreaSqFtUnit_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(AmountToAllocate_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(AllocationDescription_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            dataitem(Currency; Currency)
            {
                //DataItemLink = Field11=FIELD(Field10);
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
                column(TotalAreaSqFtUnit_PropertyCostAllocationLines; "Payment Terms".Code)
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
}

