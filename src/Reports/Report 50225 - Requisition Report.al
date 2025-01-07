report 50225 "Requisition Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Requisition Report.rdl';

    dataset
    {
        dataitem("Purchase Requisitions"; "Purchase Requisitions")
        {
            column(PRN_No; "Purchase Requisitions"."No.")
            {
            }
            column(Department; "Purchase Requisitions"."Global Dimension 1 Code")
            {
            }
            column(UnitCode; "Purchase Requisitions"."Global Dimension 2 Code")
            {
            }
            column(Date; "Purchase Requisitions"."Document Date")
            {
            }
            column(EmployeeNo; "Purchase Requisitions"."No.")
            {
            }
            column(EmployeeName; "Purchase Requisitions"."No.")
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
            column(Description_PurchaseRequisitions; "Purchase Requisitions".Description)
            {
            }
            column(UserID_PurchaseRequisitionHeader; "Purchase Requisitions"."User ID")
            {
            }
            column(PrintDate; PrintDate)
            {
            }
            column(PrintTime; PrintTime)
            {
            }
            dataitem("Purchase Requisition Line"; "Purchase Requisition Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(ItemNo; "Purchase Requisition Line"."No.")
                {
                }
                column(Document_No_; "Document No.")
                {

                }

                column(Description; "Purchase Requisition Line".Description)
                {
                }
                column(UnitofMeasure; "Purchase Requisition Line"."Unit of Measure")
                {
                }
                column(Quantity; "Purchase Requisition Line".Quantity)
                {
                }
                column(EstimatedUnitCost; "Purchase Requisition Line"."Unit Cost")
                {
                }
                column(EstimatedTotalCost; "Purchase Requisition Line"."Unit Cost" * "Purchase Requisition Line".Quantity)
                {
                }
                column(ActualCost; "Purchase Requisition Line"."Total Cost")
                {
                }
                column(TenderQuotationRef; "Purchase Requisition Line"."Document No.")
                {
                }
                column(RequisitionCode_PurchaseRequisitionLine; "Purchase Requisition Line"."Requisition Code")
                {
                }
                column(RequisitionType_PurchaseRequisitionLine; "Purchase Requisition Line"."Requisition Type")
                {
                }
                column(UnitofMeasure_PurchaseRequisitionLine; "Purchase Requisition Line"."Unit of Measure")
                {
                }
                column(Inventory_PurchaseRequisitionLine; "Purchase Requisition Line".Inventory)
                {
                }
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
}

