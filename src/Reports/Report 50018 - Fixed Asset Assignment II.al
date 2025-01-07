report 50018 "Fixed Asset Assignment II"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Fixed Asset Assignment II.rdl';

    dataset
    {
        dataitem("HR Asset Transfer Header"; "HR Asset Transfer Header")
        {
            column(Name; Name)
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
            column(No_HRAssetTransferHeader; "HR Asset Transfer Header"."No.")
            {
            }
            column(DocumentDate_HRAssetTransferHeader; "HR Asset Transfer Header"."Document Date")
            {
            }
            column(DateRequested_HRAssetTransferHeader; "HR Asset Transfer Header"."Date Requested")
            {
            }
            column(TransferReason_HRAssetTransferHeader; "HR Asset Transfer Header"."Transfer Reason")
            {
            }
            column(Status_HRAssetTransferHeader; "HR Asset Transfer Header".Status)
            {
            }
            column(TransferEffected_HRAssetTransferHeader; "HR Asset Transfer Header"."Transfer Effected")
            {
            }
            column(DateTransfered_HRAssetTransferHeader; "HR Asset Transfer Header"."Date Transfered")
            {
            }
            column(TransferedBy_HRAssetTransferHeader; "HR Asset Transfer Header"."Transfered By")
            {
            }
            column(TimePosted_HRAssetTransferHeader; "HR Asset Transfer Header"."Time Posted")
            {
            }
            column(UserID_HRAssetTransferHeader; "HR Asset Transfer Header"."User ID")
            {
            }
            column(ResponsibilityCenter_HRAssetTransferHeader; "HR Asset Transfer Header"."Responsibility Center")
            {
            }
            column(NoSeries_HRAssetTransferHeader; "HR Asset Transfer Header"."No. Series")
            {
            }
            column(ActivityType_HRAssetTransferHeader; "HR Asset Transfer Header"."Activity Type")
            {
            }
            dataitem("HR Asset Transfer Lines"; "HR Asset Transfer Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(DocumentNo_HRAssetTransferLines; "HR Asset Transfer Lines"."Document No.")
                {
                }
                column(AssetNo_HRAssetTransferLines; "HR Asset Transfer Lines"."Asset No.")
                {
                }
                column(AssetTagNo_HRAssetTransferLines; "HR Asset Transfer Lines"."Asset Tag No.")
                {
                }
                column(AssetDescription_HRAssetTransferLines; "HR Asset Transfer Lines"."Asset Description")
                {
                }
                column(AssetSerialNo_HRAssetTransferLines; "HR Asset Transfer Lines"."Asset Serial No")
                {
                }
                column(FALocation_HRAssetTransferLines; "HR Asset Transfer Lines"."FA Location")
                {
                }
                column(NewAssetLocation_HRAssetTransferLines; "HR Asset Transfer Lines"."New Asset Location")
                {
                }
                column(ResponsibleEmployeeCode_HRAssetTransferLines; "HR Asset Transfer Lines"."Responsible Employee Code")
                {
                }
                column(ResponsibleEmployeeName_HRAssetTransferLines; "HR Asset Transfer Lines"."Responsible Employee Name")
                {
                }
                column(NewResponsibleEmployeeCode_HRAssetTransferLines; "HR Asset Transfer Lines"."New Responsible Employee Code")
                {
                }
                column(NewResponsibleEmployeeName_HRAssetTransferLines; "HR Asset Transfer Lines"."New Responsible Employee Name")
                {
                }
                column(ReasonforTransfer_HRAssetTransferLines; "HR Asset Transfer Lines"."Reason for Transfer")
                {
                }
                column(GlobalDimension1Code_HRAssetTransferLines; "HR Asset Transfer Lines"."Global Dimension 1 Code")
                {
                }
                column(NewGlobalDimension1Code_HRAssetTransferLines; "HR Asset Transfer Lines"."New Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_HRAssetTransferLines; "HR Asset Transfer Lines"."Global Dimension 2 Code")
                {
                }
                column(NewGlobalDimension2Code_HRAssetTransferLines; "HR Asset Transfer Lines"."New Global Dimension 2 Code")
                {
                }
                column(ShortcutDimension3Code_HRAssetTransferLines; "HR Asset Transfer Lines"."Shortcut Dimension 3 Code")
                {
                }
                column(NewShortcutDimension3Code_HRAssetTransferLines; "HR Asset Transfer Lines"."New Shortcut Dimension 3 Code")
                {
                }
                column(ShortcutDimension4Code_HRAssetTransferLines; "HR Asset Transfer Lines"."Shortcut Dimension 4 Code")
                {
                }
                column(NewShortcutDimension4Code_HRAssetTransferLines; "HR Asset Transfer Lines"."New Shortcut Dimension 4 Code")
                {
                }
                column(ShortcutDimension5Code_HRAssetTransferLines; "HR Asset Transfer Lines"."Shortcut Dimension 5 Code")
                {
                }
                column(NewShortcutDimension5Code_HRAssetTransferLines; "HR Asset Transfer Lines"."New Shortcut Dimension 5 Code")
                {
                }
                column(ShortcutDimension6Code_HRAssetTransferLines; "HR Asset Transfer Lines"."Shortcut Dimension 6 Code")
                {
                }
                column(NewShortcutDimension6Code_HRAssetTransferLines; "HR Asset Transfer Lines"."New Shortcut Dimension 6 Code")
                {
                }
            }
            dataitem(Employee; Employee)
            {
                DataItemLink = "User ID" = FIELD("User ID");
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
                column(FullName; Employee."Full Name")
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
            }

            trigger OnAfterGetRecord()
            begin
                //get the name of the employee
                Employee1.Reset;
                Employee1.SetRange("User ID", "HR Asset Transfer Header"."User ID");
                if Employee1.FindSet then begin
                    Name := Employee1."Full Name";
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
        Employee1: Record Employee;
        Name: Text[250];
}

