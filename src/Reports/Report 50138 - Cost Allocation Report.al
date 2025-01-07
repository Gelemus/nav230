report 50138 "Cost Allocation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Cost Allocation Report.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
            column(CompanyInfo_Name; "Payment Terms".Code)
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
            column(NoSeries_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(CreatedBy_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(CreationDate_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(CreationTime_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(Status_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(Posted_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(PostedBy_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(PostingDate_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(AllocateFrom_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(AllocateTo_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(ChargeCode_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(ChargeName_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(AllocationType_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(MeterReadingFrom_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(MeterReadingTo_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(MeterRate_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(MeterNo_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(PlateGlassArea_PropertyCostAllocation; "Payment Terms".Code)
            {
            }
            column(PlateGlassRate_PropertyCostAllocation; "Payment Terms".Code)
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
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                // DataItemLink = "Document No."=FIELD(Field19);
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(SequenceNo; "Approval Entry"."Sequence No.")
                {
                }
                column(LastDateTimeModified; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(ApproverID; "Approval Entry"."Approver ID")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(SenderID; "Approval Entry"."Sender ID")
                {
                }
                dataitem(Employee; Employee)
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(EmployeeFirstName; Employee."First Name")
                    {
                    }
                    column(EmployeeMiddleName; Employee."Middle Name")
                    {
                    }
                    column(EmployeeLastName; Employee."Last Name")
                    {
                    }
                    column(EmployeeSignature; Employee."Employee Signature")
                    {
                    }
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

