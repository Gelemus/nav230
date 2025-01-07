report 50134 "Meter Readings Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Meter Readings Report.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
            column(No_ElectricityMeterReadings; "Payment Terms".Code)
            {
            }
            column(Property_ElectricityMeterReadings; "Payment Terms".Code)
            {
            }
            column(PropertyDescription_ElectricityMeterReadings; "Payment Terms".Code)
            {
            }
            column(ElectricityMeterNo_ElectricityMeterReadings; "Payment Terms".Code)
            {
            }
            column(UserID_ElectricityMeterReadings; "Payment Terms".Code)
            {
            }
            column(ReadingDate_ElectricityMeterReadings; "Payment Terms".Code)
            {
            }
            column(Remarks_ElectricityMeterReadings; "Payment Terms".Code)
            {
            }
            column(DocumentDate_ElectricityMeterReadings; "Payment Terms".Code)
            {
            }
            column(PreviousReading_ElectricityMeterReadings; "Payment Terms".Code)
            {
            }
            column(CurrentReading_ElectricityMeterReadings; "Payment Terms".Code)
            {
            }
            column(Posted_ElectricityMeterReadings; "Payment Terms".Code)
            {
            }
            column(PostedBy_ElectricityMeterReadings; "Payment Terms".Code)
            {
            }
            column(PostingDate_ElectricityMeterReadings; "Payment Terms".Code)
            {
            }
            column(Status_ElectricityMeterReadings; "Payment Terms".Code)
            {
            }
            column(NoSeries_ElectricityMeterReadings; "Payment Terms".Code)
            {
            }
            column(BlockCode_ElectricityMeterReadings; "Payment Terms".Code)
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
                //DataItemLink = Field11=FIELD(Field10);
                column(ReadingNo_ElectricityMeterReadingLine; "Payment Terms".Code)
                {
                }
                column(PropertyNo_ElectricityMeterReadingLine; "Payment Terms".Code)
                {
                }
                column(FloorNo_ElectricityMeterReadingLine; "Payment Terms".Code)
                {
                }
                column(FloorMeterNo_ElectricityMeterReadingLine; "Payment Terms".Code)
                {
                }
                column(PreviousMeterReading_ElectricityMeterReadingLine; "Payment Terms".Code)
                {
                }
                column(CurrentMeterReading_ElectricityMeterReadingLine; "Payment Terms".Code)
                {
                }
                column(ReadingDate_ElectricityMeterReadingLine; "Payment Terms".Code)
                {
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                //DataItemLink = "Document No."=FIELD(Field10);
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

