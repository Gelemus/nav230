report 50195 "Store Requisition/Delivery Rep"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Store RequisitionDelivery Rep.rdl';

    dataset
    {
        dataitem("Store Requisition Header"; "Store Requisition Header")
        {
            column(StoreIssueNote_StoreRequisitionHeader; "Store Requisition Header"."Store Issue Note")
            {
            }
            column(IssuedByName_StoreRequisitionHeader; "Store Requisition Header"."Issued By Name")
            {
            }
            column(No_StoreRequisitionHeader; "Store Requisition Header"."No.")
            {
            }
            column(Requestdate_StoreRequisitionHeader; "Store Requisition Header"."Document Date")
            {
            }
            column(PostingDate_StoreRequisitionHeader; "Store Requisition Header"."Posting Date")
            {
            }
            column(RequiredDate_StoreRequisitionHeader; "Store Requisition Header"."Required Date")
            {
            }
            column(RequesterID_StoreRequisitionHeader; "Store Requisition Header"."Requester ID")
            {
            }
            column(TotalLineAmount_StoreRequisitionHeader; "Store Requisition Header"."Cost Amount")
            {
            }
            column(Description_StoreRequisitionHeader; "Store Requisition Header".Description)
            {
            }
            column(GlobalDimension1Code_StoreRequisitionHeader; "Store Requisition Header"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_StoreRequisitionHeader; "Store Requisition Header"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_StoreRequisitionHeader; "Store Requisition Header"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_StoreRequisitionHeader; "Store Requisition Header"."Shortcut Dimension 4 Code")
            {
            }
            column(ShortcutDimension5Code_StoreRequisitionHeader; "Store Requisition Header"."Shortcut Dimension 5 Code")
            {
            }
            column(ShortcutDimension6Code_StoreRequisitionHeader; "Store Requisition Header"."Shortcut Dimension 6 Code")
            {
            }
            column(Posted_StoreRequisitionHeader; "Store Requisition Header".Posted)
            {
            }
            column(Issued_By; "Store Requisition Header"."Issued By")
            {
            }
            column(HrEmployeeName; HrEmployeeName)
            {
            }
            column(DatePosted_StoreRequisitionHeader; "Store Requisition Header"."Posting Date")
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
            column(PostedBy_StoreRequisitionHeader; PostedByName)
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
            column(PostedBySignature1; UserSetupRec1.Signature)
            {
            }
            column(EmployeeSignature1; UserSetupRec.Signature)
            {
            }
            column(IssuedBySignature1; UserSetupRec3.Signature)
            {
            }
            column(PostedBySignature; TenantMedia1.Content)
            {
            }
            column(EmployeeSignature; TenantMedia.Content)
            {
            }
            column(IssuedBySignature; TenantMedia.Content)
            {
            }
            dataitem("Store Requisition Line"; "Store Requisition Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(LineNo_StoreRequisitionLine; "Store Requisition Line"."Line No.")
                {
                }
                column(DocumentNo_StoreRequisitionLine; "Store Requisition Line"."Document No.")
                {
                }
                column(ItemNo_StoreRequisitionLine; "Store Requisition Line"."Item No.")
                {
                }
                column(LocationCode_StoreRequisitionLine; "Store Requisition Line"."Location Code")
                {
                }
                column(Inventory_StoreRequisitionLine; "Store Requisition Line".Inventory)
                {
                }
                column(Quantity_StoreRequisitionLine; "Store Requisition Line".Quantity)
                {
                }
                column(UnitofMeasureCode_StoreRequisitionLine; "Store Requisition Line"."Unit of Measure Code")
                {
                }
                column(Quantitytoissue_StoreRequisitionLine; "Store Requisition Line"."Quantity to issue")
                {
                }
                column(Description_StoreRequisitionLine; "Store Requisition Line".Description)
                {
                }
                column(ItemDescription_StoreRequisitionLine; "Store Requisition Line"."Item Description")
                {
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
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
                column(ApproverName; ApproverName)
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                }
                column(ApproverSignature1; UserSetupRecI.Signature)
                {
                }
                dataitem(Employee; Employee)
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(ApproverSignature; Employee."Employee Signature")
                    {
                    }
                    column(FirstName_Employee; Employee."First Name")
                    {
                    }
                    column(MiddleName_Employee; Employee."Middle Name")
                    {
                    }
                    column(LastName_Employee; Employee."Last Name")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    HREmployee.Reset;
                    HREmployee.SetRange(HREmployee."User ID", "Approval Entry"."Approver ID");
                    if HREmployee.FindFirst then begin
                        ApproverName := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";

                        UserSetupRecI.Reset;
                        UserSetupRecI.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRecI.FindFirst then
                            UserSetupRecI.CalcFields(Signature);
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*HREmployee.RESET;
                HREmployee.SETRANGE(HREmployee."User ID","Store Requisition Header"."User ID");
                IF HREmployee.FINDFIRST THEN BEGIN
                  HrEmployeeName:=HREmployee."First Name"+' '+HREmployee."Middle Name"+' '+HREmployee."Last Name";
                
                  UserSetupRec.RESET;
                  UserSetupRec.SETRANGE("User ID","Store Requisition Header"."User ID");
                  IF UserSetupRec.FINDFIRST THEN
                  UserSetupRec.CALCFIELDS(Signature);
                END;
                    TenantMedia.RESET;
                     IF HREmployee."Employee Signature".HASVALUE THEN BEGIN
                       TenantMedia.GET(HREmployee."Employee Signature".MEDIAID);
                       TenantMedia.CALCFIELDS(Content);
                      END;
                IF "Store Requisition Header".Posted = TRUE THEN
                BEGIN
                  HREmployee.RESET;
                  HREmployee.SETRANGE(HREmployee."User ID","Store Requisition Header"."Posted By");
                  IF HREmployee.FINDFIRST THEN BEGIN
                    PostedByName:=HREmployee."First Name"+' '+HREmployee."Middle Name"+' '+HREmployee."Last Name";
                     TenantMedia1.RESET;
                      IF HREmployee."Employee Signature".HASVALUE THEN BEGIN
                        TenantMedia1.GET(HREmployee."Employee Signature".MEDIAID);
                        TenantMedia1.CALCFIELDS(Content);
                      END;
                    UserSetupRec1.RESET;
                    UserSetupRec1.SETRANGE("User ID","Store Requisition Header"."Posted By");
                    IF UserSetupRec1.FINDFIRST THEN
                    UserSetupRec1.CALCFIELDS(Signature);
                  END;
                END;*/
                //Requested by Signature
                HREmployee.SetRange(HREmployee."User ID", "Store Requisition Header"."User ID");
                if HREmployee.FindFirst then begin
                    HrEmployeeName := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                    TenantMedia.Reset;
                    if HREmployee."Employee Signature".HasValue then begin
                        TenantMedia.Get(HREmployee."Employee Signature".MediaId);
                        TenantMedia.CalcFields(Content);
                    end;
                end;
                // Issued by Signature
                HREmployeeRec.Reset;
                HREmployeeRec.SetRange(HREmployeeRec."User ID", "Store Requisition Header"."Posted By");
                if HREmployeeRec.FindFirst then begin
                    PostedByName := HREmployeeRec."First Name" + ' ' + HREmployeeRec."Middle Name" + ' ' + HREmployeeRec."Last Name";

                    TenantMedia1.Reset;
                    if HREmployeeRec."Employee Signature".HasValue then begin
                        TenantMedia1.Get(HREmployeeRec."Employee Signature".MediaId);
                        TenantMedia1.CalcFields(Content);
                    end;
                end;

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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        HREmployee: Record Employee;
        HrEmployeeName: Text;
        ApproverName: Text;
        PostedByName: Text;
        UserSetupRec: Record "User Setup";
        UserSetupRecI: Record "User Setup";
        UserSetupRec1: Record "User Setup";
        UserSetupRec3: Record "User Setup";
        TenantMedia: Record "Tenant Media";
        TenantMedia1: Record "Tenant Media";
        HREmployeeRec: Record Employee;
}

