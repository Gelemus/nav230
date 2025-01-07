report 50226 "Invoiced Purchases Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Invoiced Purchases Report.rdl';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = ORDER(Ascending);
            RequestFilterFields = "Buy-from Vendor No.";
            column(PurchaseRequisition_PurchInvHeader; "Purch. Inv. Header"."Purchase Requisition")
            {
            }
            column(InspectionNo_PurchInvHeader; "Purch. Inv. Header"."Inspection No")
            {
            }
            column(DeliveryNoteNo_PurchInvHeader; "Purch. Inv. Header"."Delivery Note No.")
            {
            }
            column(Posted_Invoice_No; "Purch. Inv. Header"."No.")
            {
            }
            column(Vendor_No; "Purch. Inv. Header"."Pay-to Vendor No.")
            {
            }
            column(Vendor_Name; "Purch. Inv. Header"."Pay-to Name")
            {
            }
            column(Posting_Date; "Purch. Inv. Header"."Posting Date")
            {
            }
            column(LPO_No; "Purch. Inv. Header"."Order No.")
            {
            }
            column(Vendor_Invoice_No; "Purch. Inv. Header"."Vendor Invoice No.")
            {
            }
            column(Amount_Inclusive_Vat; "Purch. Inv. Header"."Amount Including VAT")
            {
            }
            column(Posting_Description; "Purch. Inv. Header"."Posting Description")
            {
            }
            column(CName; CompanyInfo.Name)
            {
            }
            column(CAddress; CompanyInfo.Address)
            {
            }
            column(CAddress2; CompanyInfo."Address 2")
            {
            }
            column(CCity; CompanyInfo.City)
            {
            }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(CEmail; CompanyInfo."E-Mail")
            {
            }
            column(CPhone; CompanyInfo."Phone No.")
            {
            }
            column(Description_PurchaseRequisitions; "Purch. Inv. Header"."Source Code")
            {
            }
            column(UserID_PurchaseRequisitionHeader; "Purch. Inv. Header"."User ID")
            {
            }
            column(PrintDate; PrintDate)
            {
            }
            column(PrintTime; PrintTime)
            {
            }
            column(Start_Date; StartDate)
            {
            }
            column(End_Date; EndDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                StartDate := "Purch. Inv. Header".GetRangeMin("Posting Date");
                EndDate := "Purch. Inv. Header".GetRangeMax("Posting Date");
                if "Purch. Inv. Header"."Posting Date" < StartDate then
                    CurrReport.Skip;
            end;
        }
        dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
        {
            column(ItemNo; "Purch. Inv. Line"."No.")
            {
            }
            column(Description; "Purch. Inv. Line".Description)
            {
            }
            column(UnitofMeasure; "Purch. Inv. Line"."Unit of Measure")
            {
            }
            column(Quantity; "Purch. Inv. Line".Quantity)
            {
            }
            column(EstimatedUnitCost; "Purch. Inv. Line"."Direct Unit Cost")
            {
            }
            column(EstimatedTotalCost; "Purch. Inv. Line"."Line Amount")
            {
            }
            column(ActualCost; "Purch. Inv. Line".Amount)
            {
            }
            column(TenderQuotationRef; "Purch. Inv. Line"."Document No.")
            {
            }
            column(RequisitionCode_PurchaseRequisitionLine; "Purch. Inv. Line"."Location Code")
            {
            }
            column(RequisitionType_PurchaseRequisitionLine; "Purch. Inv. Line"."Item Reference Type")
            {
            }
            column(UnitofMeasure_PurchaseRequisitionLine; "Purch. Inv. Line"."Unit of Measure")
            {
            }
            column(Inventory_PurchaseRequisitionLine; "Purch. Inv. Line".Quantity)
            {
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = FILTER(Approved));
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
                column(ShowPreparedBy_; ShowPreparedBy)
                {
                }
                column(ApprovedByCaption_; ApprovedByCaption)
                {
                }
                column(PreparedByDesignation; PreparedByDesignation)
                {
                }
                column(PreparedByCaption_; PreparedByCaption)
                {
                }
                column(PreparedDate; PreparedDate)
                {
                }
                column(UserSetupRec_SignatureI_; TenantMedia.Content)
                {
                }
                column(UserSetupRec_Signature_; TenantMedia.Content)
                {
                }
                dataitem(Employee2; Employee)
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(FirstName_Employee; Employee2."First Name")
                    {
                    }
                    column(MiddleName_Employee; Employee2."Middle Name")
                    {
                    }
                    column(LastName_Employee; Employee2."Last Name")
                    {
                    }
                    column(EmployeeSignature; Employee2."Employee Signature")
                    {
                    }
                    column(PositionTitle_Employee2; Employee2."Position Title")
                    {
                    }
                    column(Position_Employee2; Employee2.Position)
                    {
                    }
                    column(JobTitle_Employee2; Employee2."Job Title")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    i := i + 1;
                    if i = 1 then begin
                        ShowPreparedBy := true;
                        PreparedDate := "Approval Entry"."Date-Time Sent for Approval";
                        EmployeeRecI.Reset;
                        EmployeeRecI.SetRange("User ID", "Approval Entry"."Sender ID");
                        if EmployeeRecI.FindFirst then begin
                            PreparedByCaption := 'Requested By: ' + ' ' + EmployeeRecI."First Name" + ' ' + EmployeeRecI."Last Name";
                            PreparedByDesignation := EmployeeRecI."Job Title";
                        end;
                        UserSetupRec.Reset;

                        UserSetupRecI.SetRange("User ID", "Approval Entry"."Sender ID");
                        if UserSetupRecI.FindFirst then
                            UserSetupRecI.CalcFields(Signature);

                        ApprovedByCaption := 'Checked By:';

                        UserSetupRec.Reset;

                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);

                    end
                    else
                        ShowPreparedBy := false;
                    if i = 2 then begin
                        ApprovedByCaption := 'Verified By:';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end
                    else if i = 3 then begin
                        ApprovedByCaption := 'Authorised By: ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end;
                end;
            }
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        PrintDate := Today;
        PrintTime := Time;
    end;

    var
        CompanyInfo: Record "Company Information";
        PrintDate: Date;
        PrintTime: Time;
        Approver1: Code[20];
        i: Integer;
        ShowPreparedBy: Boolean;
        PreparedByCaption: Text;
        ApprovedByCaption: Text;
        UserSetupRec: Record "User Setup";
        UserSetupRecI: Record "User Setup";
        PreparedDate: DateTime;
        EmployeeRecI: Record Employee;
        TenantMedia: Record "Tenant Media";
        PreparedByDesignation: Text[50];
        HREmployee: Record Employee;
        HrEmployeeName: Text;
        StartDate: Date;
        EndDate: Date;
        GRNNo: Code[250];
        PurchaseReceipts: Record "Purch. Rcpt. Header";
}

